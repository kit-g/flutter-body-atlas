import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum AtlasAsset {
  musclesBack('assets/svg/muscle_layer_back.svg'),
  musclesFront('assets/svg/muscle_layer_front.svg'),
  ;

  final String path;

  const AtlasAsset(this.path);

  static const package = 'flutter_body_atlas';
}

class SvgAsset extends StatelessWidget {
  final String path;
  final Color? Function(String? id) colorMapper;

  const SvgAsset({
    super.key,
    required this.path,
    required this.colorMapper,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      package: AtlasAsset.package,
      colorMapper: _ColorMapper(colorMapper),
    );
  }
}

class _ColorMapper extends ColorMapper {
  final Color? Function(String? id) colorMapper;

  const _ColorMapper(this.colorMapper);

  @override
  Color substitute(String? id, String elementName, String attributeName, Color color) {
    return colorMapper(id) ?? color;
  }
}
