import 'package:flutter/services.dart';

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
