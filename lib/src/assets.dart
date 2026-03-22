import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum AtlasAsset {
  musclesBack('assets/svg/muscle_layer_back.svg'),
  musclesFront('assets/svg/muscle_layer_front.svg'),
  ;

  final String path;

  const AtlasAsset(this.path);

  static const package = 'flutter_body_atlas';

  /// Loads the SVG content from the package assets.
  Future<String> loadSvg() {
    final key = 'packages/$package/$path';
    return rootBundle.loadString(key);
  }
}

class SvgAsset extends StatelessWidget {
  final String path;
  final Map<String, Color> highlightedColors;
  final String? hoveredId;
  final Color defaultHoverColor;
  final Color? Function(Color)? onHoverColor;

  const SvgAsset({
    super.key,
    required this.path,
    required this.highlightedColors,
    this.hoveredId,
    required this.defaultHoverColor,
    this.onHoverColor,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      fit: .contain,
      alignment: .center,
      package: AtlasAsset.package,
      colorMapper: _AtlasColorMapper(
        highlightedColors: highlightedColors,
        hoveredId: hoveredId,
        defaultHoverColor: defaultHoverColor,
        onHoverColor: onHoverColor,
      ),
    );
  }
}

class _AtlasColorMapper extends ColorMapper {
  final Map<String, Color> highlightedColors;
  final String? hoveredId;
  final Color defaultHoverColor;
  final Color? Function(Color)? onHoverColor;

  const _AtlasColorMapper({
    required this.highlightedColors,
    this.hoveredId,
    required this.defaultHoverColor,
    this.onHoverColor,
  });

  @override
  Color substitute(String? id, String elementName, String attributeName, Color color) {
    if (id == null) return color;

    final highlighted = highlightedColors[id];
    if (highlighted != null) return highlighted;

    if (hoveredId != null && id == hoveredId) {
      return onHoverColor?.call(color) ?? defaultHoverColor;
    }

    return color;
  }
}
