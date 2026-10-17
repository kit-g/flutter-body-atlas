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

typedef _IdPath = ({String id, Path path});

final class _AtlasHitTester {
  const _AtlasHitTester({
    required this.viewBox,
    required this.pathsInPaintOrder,
  });

  final Rect viewBox;

  /// Paths in paint order (first painted → last painted).
  /// For hit testing we usually iterate in reverse (top-most first).
  final List<_IdPath> pathsInPaintOrder;

  static _IdPath? fromXmlElement(XmlElement element) {
    final id = element.getAttribute('id');
    final d = element.getAttribute('d');
    if (id == null || id.isEmpty) return null;
    if (d == null || d.isEmpty) return null;
    final path = parseSvgPathData(d);
    return (id: id, path: path);
  }

  static Future<_AtlasHitTester> load(AtlasAsset asset) async {
    final svgText = await asset.loadSvg();
    final doc = XmlDocument.parse(svgText);

    final svg = doc.findAllElements('svg').first;
    final viewBoxAttr = svg.getAttribute('viewBox');
    final viewBox = (viewBoxAttr ?? '').toViewBox();

    final paths = doc.findAllElements('path').map(fromXmlElement).nonNulls.toList();

    return _AtlasHitTester(viewBox: viewBox, pathsInPaintOrder: paths);
  }

  /// Bounds, in viewBox coordinates, of every path among [ids], or null when
  /// this layer draws none of them.
  Rect? boundsOf(Iterable<String> ids) {
    final wanted = ids.toSet();
    Rect? bounds;
    for (final item in pathsInPaintOrder) {
      if (!wanted.contains(item.id)) continue;
      final rect = item.path.getBounds();
      bounds = bounds?.expandToInclude(rect) ?? rect;
    }
    return bounds;
  }

  /// Returns the SVG element id that contains the tap point, or null.
  String? hitTest(Offset localPoint, Size widgetSize) {
    final toViewBox = viewBox.inverse(widgetSize);

    // Map tap point into viewBox coordinates.
    final p = MatrixUtils.transformPoint(toViewBox, localPoint);

    // Top-most path should win: check in reverse paint order.
    for (var i = pathsInPaintOrder.length - 1; i >= 0; i--) {
      final item = pathsInPaintOrder[i];
      if (item.path.contains(p)) return item.id;
    }
    return null;
  }
}

extension on Rect {
  /// Matches `SvgPicture`’s default behavior closely enough:
  /// `fit: BoxFit.contain`, centered.
  ///
  /// Returns a matrix that converts widget-local coordinates -> viewBox coordinates.
  Matrix4 inverse(Size size) {
    final forward = this.forward(size);

    // inverse: widget -> viewBox
    final inverse = Matrix4.identity();
    final det = inverse.copyInverse(forward);

    // not invertible (shouldn't happen unless size/viewBox are degenerate)
    if (det == 0.0) return Matrix4.identity();

    return inverse;
  }

  /// Returns a matrix that converts viewBox coordinates -> widget-local coordinates.
  Matrix4 forward(Size size) {
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
    return Matrix4.identity()
      ..translateByDouble(dx, dy, 0.0, 1.0)
      ..scaleByDouble(scale, scale, 1.0, 1.0)
      ..translateByDouble(-left, -top, 0.0, 1.0);
  }
}

typedef _ElementSemantics = ({Rect bounds, String label, VoidCallback? onTap});

/// Paints nothing; describes each element to assistive tech, positioned over
/// the path(s) it covers so a screen reader can walk the atlas by touch.
final class _AtlasSemanticsPainter extends CustomPainter {
  const _AtlasSemanticsPainter({
    required this.viewBox,
    required this.elements,
    required this.textDirection,
  });

  final Rect viewBox;

  /// Bounds are in viewBox coordinates.
  final List<_ElementSemantics> elements;
  final TextDirection textDirection;

  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(covariant _AtlasSemanticsPainter oldDelegate) => false;

  @override
  SemanticsBuilderCallback get semanticsBuilder {
    return (size) {
      final toWidget = viewBox.forward(size);
      return [
        for (final element in elements)
          CustomPainterSemantics(
            rect: MatrixUtils.transformRect(toWidget, element.bounds),
            properties: SemanticsProperties(
              label: element.label,
              textDirection: textDirection,
              button: element.onTap != null,
              onTap: element.onTap,
            ),
          ),
      ];
    };
  }

  @override
  bool shouldRebuildSemantics(covariant _AtlasSemanticsPainter oldDelegate) {
    return oldDelegate.viewBox != viewBox ||
        oldDelegate.textDirection != textDirection ||
        !listEquals(oldDelegate.elements, elements);
  }
}
