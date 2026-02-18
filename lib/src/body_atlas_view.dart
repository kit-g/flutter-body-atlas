import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:xml/xml.dart';

import 'assets.dart';
import 'models/muscle.dart';

class BodyAtlasView extends StatefulWidget {
  final AtlasAsset view;
  final Map<MuscleInfo, Color?>? highlightedMuscles;
  final ValueChanged<MuscleInfo>? onMuscleTap;

  const BodyAtlasView({
    super.key,
    required this.view,
    this.highlightedMuscles,
    this.onMuscleTap,
  });

  @override
  State<BodyAtlasView> createState() => _BodyAtlasViewState();
}

class _BodyAtlasViewState extends State<BodyAtlasView> {
  late Future<_AtlasHitTester> _hitTester;

  @override
  void initState() {
    super.initState();
    _hitTester = _AtlasHitTester.load(widget.view);
  }

  @override
  void didUpdateWidget(covariant BodyAtlasView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.view != widget.view) {
      _hitTester = _AtlasHitTester.load(widget.view);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);

        return FutureBuilder<_AtlasHitTester>(
          future: _hitTester,
          builder: (context, snapshot) {
            final tester = snapshot.data;

            return GestureDetector(
              behavior: .opaque,
              onTapDown: switch ((widget.onMuscleTap, tester)) {
                (ValueChanged<MuscleInfo> onTap, _AtlasHitTester tester) => (details) {
                  final local = details.localPosition;
                  final id = tester.hitTest(local, size);
                  if (id == null) return;

                  final info = MuscleCatalog.tryById(id);
                  if (info == null) return;

                  onTap(info);
                },
                _ => null,
              },
              child: SvgAsset(
                path: widget.view.path,
                colorMapper: (id) {
                  if (id == null) return null;
                  return widget.highlightedMuscles?[MuscleCatalog.tryById(id)];
                },
              ),
            );
          },
        );
      },
    );
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
    final viewBox = _parseViewBox(viewBoxAttr);

    final paths = doc.findAllElements('path').map(fromXmlElement).nonNulls.toList();

    return _AtlasHitTester(viewBox: viewBox, pathsInPaintOrder: paths);
  }

  /// Returns the SVG element id that contains the tap point, or null.
  String? hitTest(Offset localPoint, Size widgetSize) {
    final toViewBox = _inverseViewBoxTransform(viewBox: viewBox, size: widgetSize);

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

Rect _parseViewBox(String? viewBox) {
  // default to something sensible if missing
  if (viewBox == null || viewBox.trim().isEmpty) {
    return const Rect.fromLTWH(0, 0, 1, 1);
  }
  final parts = viewBox.trim().split(RegExp(r'[\s,]+')).where((e) => e.isNotEmpty).toList();

  if (parts.length != 4) return const Rect.fromLTWH(0, 0, 1, 1);

  final x = double.tryParse(parts[0]) ?? 0;
  final y = double.tryParse(parts[1]) ?? 0;
  final w = double.tryParse(parts[2]) ?? 1;
  final h = double.tryParse(parts[3]) ?? 1;
  return Rect.fromLTWH(x, y, w, h);
}

/// Matches `SvgPicture`’s default behavior closely enough:
/// `fit: BoxFit.contain`, centered.
///
/// Returns a matrix that converts widget-local coordinates -> viewBox coordinates.
Matrix4 _inverseViewBoxTransform({
  required Rect viewBox,
  required Size size,
}) {
  final vb = Size(viewBox.width, viewBox.height);

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
    ..translateByDouble(-viewBox.left, -viewBox.top, 0.0, 1.0);

  // inverse: widget -> viewBox
  final inverse = Matrix4.identity();
  final det = inverse.copyInverse(forward);

  // not invertible (shouldn't happen unless size/viewBox are degenerate)
  if (det == 0.0) return Matrix4.identity();

  return inverse;
}
