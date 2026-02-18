import 'package:flutter/material.dart';

import 'assets.dart';
import 'models/muscle.dart';

class BodyAtlasView extends StatefulWidget {
  final AtlasAsset view;
  final Map<MuscleInfo, Color?>? highlightedMuscles;

  const BodyAtlasView({
    super.key,
    required this.view,
    this.highlightedMuscles,
  });

  @override
  State<BodyAtlasView> createState() => _BodyAtlasViewState();
}

class _BodyAtlasViewState extends State<BodyAtlasView> {
  @override
  Widget build(BuildContext context) {
    return SvgAsset(
      path: widget.view.path,
      colorMapper: (id) {
        if (id == null) return null;
        return widget.highlightedMuscles?[MuscleCatalog.tryById(id)];
      },
    );
  }
}
