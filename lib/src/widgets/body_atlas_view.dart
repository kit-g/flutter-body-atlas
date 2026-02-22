part of 'widgets.dart';

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
    return FutureBuilder<_AtlasHitTester>(
      future: _hitTester,
      builder: (context, snapshot) {
        final tester = snapshot.data;

        return GestureDetector(
          behavior: .opaque,
          onTapDown: switch ((widget.onMuscleTap, tester)) {
            (ValueChanged<MuscleInfo> onTap, _AtlasHitTester tester) => (details) {
              final box = context.findRenderObject() as RenderBox?;
              if (box == null) return;

              final local = details.localPosition;
              final id = tester.hitTest(local, box.size);
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
  }
}

