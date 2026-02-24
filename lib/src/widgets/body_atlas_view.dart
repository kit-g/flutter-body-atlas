part of 'widgets.dart';

/// An interactive SVG-based body atlas widget that displays anatomical elements
/// (muscles, organs, bones, skin) and supports tap and hover interactions.
///
/// This widget renders an SVG asset and provides hit-testing capabilities to
/// detect user interactions with individual anatomical elements. It supports
/// custom coloring for selected or highlighted elements and optional hover
/// effects on desktop/web platforms.
///
/// Type parameter [I] represents the specific type of anatomical element info
/// (e.g., [MuscleInfo], [OrganInfo]) that extends [AtlasElementInfo].
///
/// Example usage:
/// ```dart
/// BodyAtlasView<MuscleInfo>(
///   view: AtlasAsset.musclesFront,
///   resolver: const MuscleResolver(),
///   colorMapping: {muscle1: Colors.red, muscle2: Colors.blue},
///   hoveredOver: currentMuscle,
///   hoverColor: (color) => color.withValues(alpha: 0.5),
///   onTapElement: (muscle) => print('Tapped: ${muscle.displayName}'),
///   onHoverOverElement: (muscle) => setState(() => hovered = muscle),
/// )
/// ```
class BodyAtlasView<I extends AtlasElementInfo> extends StatefulWidget {
  /// The SVG asset containing the anatomical diagram to display.
  ///
  /// This asset should contain SVG path elements with IDs that match
  /// the element IDs in the resolver.
  final AtlasAsset view;

  /// Injected mapping from SVG id -> domain element info (muscle/organ/bone/skin).
  ///
  /// The resolver is used to convert SVG element IDs from the asset into
  /// strongly-typed element info objects of type [I].
  final AtlasResolver<I> resolver;

  /// Explicit color mapping by element info (e.g., selection/engagement).
  ///
  /// Maps specific element info objects to their desired colors. This is
  /// typically used to highlight selected or engaged elements. Colors in
  /// this mapping take precedence over hover colors.
  ///
  /// A null color value will use the original SVG color for that element.
  final Map<I, Color?>? colorMapping;

  /// Optional hover styling (desktop/web).
  ///
  /// The element info object that is currently being hovered over.
  /// When non-null and [hoverColor] is provided, this element will be
  /// rendered with the hover color styling.
  final I? hoveredOver;

  /// Function to compute hover color from the original element color.
  ///
  /// Called when an element is hovered (specified by [hoveredOver]).
  /// Receives the original color of the SVG element and should return
  /// the desired hover color, or null to keep the original color.
  ///
  /// Example: `(color) => color.withValues(alpha: 0.5)`
  final Color? Function(Color)? hoverColor;

  /// Callback invoked when a user taps on an anatomical element.
  ///
  /// The callback receives the [AtlasElementInfo] object corresponding
  /// to the tapped SVG element. This is typically used to handle element
  /// selection or navigation.
  final ValueChanged<I>? onTapElement;

  /// Callback invoked when the hover state changes (desktop/web only).
  ///
  /// The callback receives the [AtlasElementInfo] object being hovered over,
  /// or null when the hover exits. This is only active on desktop and web
  /// platforms and requires a non-null value to enable hover tracking.
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
    final ThemeData(:platform, :colorScheme) = Theme.of(context);
    final isDesktop = kIsWeb || <TargetPlatform>[.windows, .linux, .macOS].contains(platform);

    return LayoutBuilder(
      builder: (context, constraints) {
        return FutureBuilder<_AtlasHitTester>(
          future: _hitTester,
          builder: (context, snapshot) {
            final tester = snapshot.data;

            final svg = SvgAsset(
              path: widget.view.path,
              colorMapper: (id, color) {
                final hoverColor = widget.hoverColor?.call(color) ?? colorScheme.secondary;
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
              behavior: .opaque,
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
