part of 'widgets.dart';

class BodyAtlasView<I extends AtlasElementInfo> extends StatefulWidget {
  final AtlasAsset view;

  /// Injected mapping from SVG id -> domain element info (muscle/organ/bone/skin).
  final AtlasResolver<I> resolver;

  /// Explicit color mapping by element info (e.g., selection/engagement).
  final Map<I, Color?>? colorMapping;

  /// Optional hover styling (desktop/web).
  final I? hoveredOver;
  final Color? hoverColor;

  final ValueChanged<I>? onTapElement;
  final ValueChanged<I?>? onHoverOverElement;

  const BodyAtlasView({
    super.key,
    required this.view,
    required this.resolver,
    this.colorMapping,
    this.hoveredOver,
    this.hoverColor,
    this.onTapElement,
    this.onHoverOverElement,
  });

  @override
  State<BodyAtlasView<I>> createState() => _BodyAtlasViewState<I>();
}

class _BodyAtlasViewState<I extends AtlasElementInfo> extends State<BodyAtlasView<I>> {
  final _interactionKey = GlobalKey();
  late Future<_AtlasHitTester> _hitTester;
  String? _hoveredId;

  @override
  void initState() {
    super.initState();
    _hitTester = _AtlasHitTester.load(widget.view);
  }

  @override
  void didUpdateWidget(covariant BodyAtlasView<I> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.view != widget.view) {
      _hitTester = _AtlasHitTester.load(widget.view);
      _hoveredId = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = kIsWeb || <TargetPlatform>[.windows, .linux, .macOS].contains(Theme.of(context).platform);
    final hoverColor = widget.hoverColor ?? Theme.of(context).colorScheme.secondary;

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

                final info = widget.resolver.tryById(id);
                if (info == null) return null;

                final highlighted = widget.colorMapping?[info];
                if (highlighted != null) return highlighted;

                final hovered = widget.hoveredOver;
                if (hovered != null && identical(info, hovered)) return hoverColor;

                return null;
              },
            );

            Widget interactiveChild = GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: switch ((widget.onTapElement, tester)) {
                (ValueChanged<I> onTap, _AtlasHitTester tester) => (details) {
                  final box = _interactionKey.box;
                  if (box == null || !box.hasSize) return;

                  final local = box.globalToLocal(details.globalPosition);
                  final id = tester.hitTest(local, box.size);
                  if (id == null) return;

                  final info = widget.resolver.tryById(id);
                  if (info == null) return;

                  onTap(info);
                },
                _ => null,
              },
              child: svg,
            );

            if (isDesktop && tester != null && widget.onHoverOverElement != null) {
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

    final cb = widget.onHoverOverElement;
    if (cb == null) return;

    cb(id == null ? null : widget.resolver.tryById(id));
  }
}

extension on GlobalKey {
  RenderBox? get box => currentContext?.findRenderObject() as RenderBox?;
}
