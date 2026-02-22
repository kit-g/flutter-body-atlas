part of 'widgets.dart';

class BodyAtlasView extends StatefulWidget {
  final AtlasAsset view;
  final Map<MuscleInfo, Color?>? highlightedMuscles;
  final ValueChanged<MuscleInfo>? onMuscleTap;
  final ValueChanged<MuscleInfo?>? onMuscleHover;

  const BodyAtlasView({
    super.key,
    required this.view,
    this.highlightedMuscles,
    this.onMuscleTap,
    this.onMuscleHover,
  });

  @override
  State<BodyAtlasView> createState() => _BodyAtlasViewState();
}

class _BodyAtlasViewState extends State<BodyAtlasView> {
  final _interactionKey = GlobalKey();
  late Future<_AtlasHitTester> _hitTester;
  String? _hoveredId;

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
      _hoveredId = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = kIsWeb || <TargetPlatform>[.windows, .linux, .macOS].contains(Theme.of(context).platform);

    return LayoutBuilder(
      builder: (context, constraints) {
        return FutureBuilder<_AtlasHitTester>(
          future: _hitTester,
          builder: (context, snapshot) {
            final tester = snapshot.data;

            final svg = SvgAsset(
              path: widget.view.path,
              colorMapper: (id) {
                if (id == null) return null;
                return widget.highlightedMuscles?[MuscleCatalog.tryById(id)];
              },
            );

            Widget interactiveChild = GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: switch ((widget.onMuscleTap, tester)) {
                (ValueChanged<MuscleInfo> onTap, _AtlasHitTester tester) => (details) {
                  final box = _interactionKey.box;
                  if (box == null || !box.hasSize) return;
                  final local = box.globalToLocal(details.globalPosition);
                  final id = tester.hitTest(local, box.size);
                  if (id == null) return;
                  final info = MuscleCatalog.tryById(id);
                  if (info == null) return;
                  onTap(info);
                },
                _ => null,
              },
              child: svg,
            );

            if (isDesktop && tester != null && widget.onMuscleHover != null) {
              interactiveChild = MouseRegion(
                hitTestBehavior: HitTestBehavior.opaque,
                cursor: SystemMouseCursors.click,
                onExit: (_) => _emit(null),
                onHover: (event) {
                  final box = _interactionKey.box;
                  if (box == null || !box.hasSize) return;
                  final local = box.globalToLocal(event.position);
                  final id = tester.hitTest(local, box.size);
                  _emit(id);
                },
                child: interactiveChild,
              );
            }

            // key lives on a stable box that both hover & tap use for size + coordinate transforms.
            return SizedBox.expand(
              key: _interactionKey,
              child: interactiveChild,
            );
          },
        );
      },
    );
  }

  void _emit(String? id) {
    if (_hoveredId == id) return;
    _hoveredId = id;

    final callback = widget.onMuscleHover;
    if (callback == null) return;
    callback(id == null ? null : MuscleCatalog.tryById(id));
  }
}

extension on GlobalKey {
  RenderBox? get box {
    return currentContext?.findRenderObject() as RenderBox?;
  }
}
