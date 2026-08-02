part of 'widgets.dart';

extension on String {
  Rect toViewBox() {
    // default to something sensible if missing
    if (trim().isEmpty) {
      return const Rect.fromLTWH(0, 0, 1, 1);
    }
    switch (trim().split(RegExp(r'[\s,]+')).where((e) => e.isNotEmpty).toList()) {
      case [String xs, String ys, String ws, String hs]:
        return Rect.fromLTWH(
          double.tryParse(xs) ?? 0,
          double.tryParse(ys) ?? 0,
          double.tryParse(ws) ?? 0,
          double.tryParse(hs) ?? 0,
        );
      default:
        return const Rect.fromLTWH(0, 0, 1, 1);
    }
  }
}

final class _AtlasPath {
  const _AtlasPath({
    required this.id,
    required this.path,
    required this.fill,
    required this.stroke,
    required this.strokeWidth,
    required this.strokeCap,
    required this.strokeJoin,
  });

  /// Null when the SVG path has no `id` (still painted, not hit-testable).
  final String? id;
  final Path path;
  final Color? fill;
  final Color? stroke;
  final double strokeWidth;
  final StrokeCap strokeCap;
  final StrokeJoin strokeJoin;

  bool get hasFill => fill != null;
  bool get hasStroke => stroke != null && strokeWidth > 0;
}

final class _AtlasGeometry {
  const _AtlasGeometry({
    required this.viewBox,
    required this.pathsInPaintOrder,
  });

  final Rect viewBox;

  /// Paths in paint order (first painted → last painted).
  /// For hit testing we usually iterate in reverse (top-most first).
  final List<_AtlasPath> pathsInPaintOrder;

  static _AtlasPath? fromXmlElement(XmlElement element) {
    final d = element.getAttribute('d');
    if (d == null || d.isEmpty) return null;

    final fill = _parseSvgColor(element.getAttribute('fill'));
    final stroke = _parseSvgColor(element.getAttribute('stroke'));
    if (fill == null && stroke == null) return null;

    final path = parseSvgPathData(d);
    if (element.getAttribute('fill-rule') == 'evenodd') {
      path.fillType = PathFillType.evenOdd;
    }

    final id = element.getAttribute('id');
    return _AtlasPath(
      id: (id == null || id.isEmpty) ? null : id,
      path: path,
      fill: fill,
      stroke: stroke,
      strokeWidth: double.tryParse(element.getAttribute('stroke-width') ?? '') ?? 1.0,
      strokeCap: _parseStrokeCap(element.getAttribute('stroke-linecap')),
      strokeJoin: _parseStrokeJoin(element.getAttribute('stroke-linejoin')),
    );
  }

  static Future<_AtlasGeometry> load(AtlasAsset asset) async {
    final svgText = await asset.loadSvg();
    final doc = XmlDocument.parse(svgText);

    final svg = doc.findAllElements('svg').first;
    final viewBoxAttr = svg.getAttribute('viewBox');
    final viewBox = (viewBoxAttr ?? '').toViewBox();

    final paths = doc.findAllElements('path').map(fromXmlElement).nonNulls.toList();

    return _AtlasGeometry(viewBox: viewBox, pathsInPaintOrder: paths);
  }

  /// Returns the SVG element id that contains the tap point, or null.
  String? hitTest(Offset localPoint, Size widgetSize) {
    final toViewBox = viewBox.inverse(widgetSize);

    // Map tap point into viewBox coordinates.
    final p = MatrixUtils.transformPoint(toViewBox, localPoint);

    // Top-most path should win: check in reverse paint order.
    for (var i = pathsInPaintOrder.length - 1; i >= 0; i--) {
      final item = pathsInPaintOrder[i];
      final id = item.id;
      // Stroke-only decorative paths are not interactive targets.
      if (id == null || !item.hasFill) continue;
      if (item.path.contains(p)) return id;
    }
    return null;
  }

  /// Forward transform: viewBox → widget local (BoxFit.contain, centered).
  Matrix4 forwardTransform(Size size) {
    final vb = Size(viewBox.width, viewBox.height);

    final sx = vb.width == 0 ? 1.0 : size.width / vb.width;
    final sy = vb.height == 0 ? 1.0 : size.height / vb.height;
    final scale = math.min(sx, sy);

    final drawn = Size(vb.width * scale, vb.height * scale);
    final dx = (size.width - drawn.width) / 2.0;
    final dy = (size.height - drawn.height) / 2.0;

    return Matrix4.identity()
      ..translateByDouble(dx, dy, 0.0, 1.0)
      ..scaleByDouble(scale, scale, 1.0, 1.0)
      ..translateByDouble(-viewBox.left, -viewBox.top, 0.0, 1.0);
  }
}

/// Parses simple SVG color values used by the atlas assets.
Color? _parseSvgColor(String? raw) {
  if (raw == null) return null;
  final value = raw.trim().toLowerCase();
  if (value.isEmpty || value == 'none') return null;

  switch (value) {
    case 'black':
      return const Color(0xFF000000);
    case 'white':
      return const Color(0xFFFFFFFF);
  }

  if (!value.startsWith('#')) return null;

  final hex = value.substring(1);
  if (hex.length == 3) {
    final r = int.tryParse('${hex[0]}${hex[0]}', radix: 16);
    final g = int.tryParse('${hex[1]}${hex[1]}', radix: 16);
    final b = int.tryParse('${hex[2]}${hex[2]}', radix: 16);
    if (r == null || g == null || b == null) return null;
    return Color.fromARGB(255, r, g, b);
  }
  if (hex.length == 6) {
    final rgb = int.tryParse(hex, radix: 16);
    if (rgb == null) return null;
    return Color(0xFF000000 | rgb);
  }
  if (hex.length == 8) {
    final argb = int.tryParse(hex, radix: 16);
    if (argb == null) return null;
    return Color(argb);
  }
  return null;
}

StrokeCap _parseStrokeCap(String? raw) {
  return switch (raw) {
    'round' => StrokeCap.round,
    'square' => StrokeCap.square,
    _ => StrokeCap.butt,
  };
}

StrokeJoin _parseStrokeJoin(String? raw) {
  return switch (raw) {
    'round' => StrokeJoin.round,
    'bevel' => StrokeJoin.bevel,
    _ => StrokeJoin.miter,
  };
}

final class _AtlasPainter extends CustomPainter {
  const _AtlasPainter({
    required this.geometry,
    required this.highlightedColors,
    required this.hoveredId,
    required this.defaultHoverColor,
    required this.onHoverColor,
  });

  final _AtlasGeometry geometry;
  final Map<String, Color> highlightedColors;
  final String? hoveredId;
  final Color defaultHoverColor;
  final Color? Function(Color)? onHoverColor;

  /// Hairline separators so adjacent same-fill muscles stay readable.
  /// Matches the visual “seams” users get from `SvgPicture` anti-aliasing.
  static const double _separatorStrokeWidth = 0.35;
  static const Color _separatorColor = Color(0x669E9E9E);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.transform(geometry.forwardTransform(size).storage);

    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;
    final separatorPaint = Paint()
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = _separatorStrokeWidth
      ..color = _separatorColor;

    for (final item in geometry.pathsInPaintOrder) {
      if (item.hasFill) {
        fillPaint.color = _colorFor(item);
        canvas.drawPath(item.path, fillPaint);

        // Keep muscle boundaries visible when neighboring fills match.
        if (item.id != null) {
          canvas.drawPath(item.path, separatorPaint);
        }
      }

      if (item.hasStroke) {
        strokePaint
          ..color = item.stroke!
          ..strokeWidth = item.strokeWidth
          ..strokeCap = item.strokeCap
          ..strokeJoin = item.strokeJoin;
        canvas.drawPath(item.path, strokePaint);
      }
    }

    canvas.restore();
  }

  Color _colorFor(_AtlasPath item) {
    final base = item.fill ?? const Color(0xFFBDBDBD);
    final id = item.id;
    if (id != null) {
      final highlighted = highlightedColors[id];
      if (highlighted != null) return highlighted;

      if (hoveredId != null && id == hoveredId) {
        return onHoverColor?.call(base) ?? defaultHoverColor;
      }
    }
    return base;
  }

  @override
  bool shouldRepaint(covariant _AtlasPainter oldDelegate) {
    return oldDelegate.geometry != geometry ||
        oldDelegate.hoveredId != hoveredId ||
        oldDelegate.defaultHoverColor != defaultHoverColor ||
        oldDelegate.onHoverColor != onHoverColor ||
        !_mapEquals(oldDelegate.highlightedColors, highlightedColors);
  }

  static bool _mapEquals(Map<String, Color> a, Map<String, Color> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (final entry in a.entries) {
      if (b[entry.key] != entry.value) return false;
    }
    return true;
  }
}

extension on Rect {
  /// Matches previous `SvgPicture` behavior closely enough:
  /// `fit: BoxFit.contain`, centered.
  ///
  /// Returns a matrix that converts widget-local coordinates -> viewBox coordinates.
  Matrix4 inverse(Size size) {
    final vb = Size(width, height);

    // avoid division by zero.
    final sx = vb.width == 0 ? 1.0 : size.width / vb.width;
    final sy = vb.height == 0 ? 1.0 : size.height / vb.height;

    // BoxFit.contain => uniform scale.
    final scale = math.min(sx, sy);

    // size of the drawn SVG on screen.
    final drawn = Size(vb.width * scale, vb.height * scale);

    // centered letterboxing.
    final dx = (size.width - drawn.width) / 2.0;
    final dy = (size.height - drawn.height) / 2.0;

    // Forward: viewBox -> widget
    // 1) translate by -viewBox.topLeft
    // 2) scale
    // 3) translate by (dx, dy)
    final forward = Matrix4.identity()
      ..translateByDouble(dx, dy, 0.0, 1.0)
      ..scaleByDouble(scale, scale, 1.0, 1.0)
      ..translateByDouble(-left, -top, 0.0, 1.0);

    // inverse: widget -> viewBox
    final inverse = Matrix4.identity();
    final det = inverse.copyInverse(forward);

    // not invertible (shouldn't happen unless size/viewBox are degenerate)
    if (det == 0.0) return Matrix4.identity();

    return inverse;
  }
}
