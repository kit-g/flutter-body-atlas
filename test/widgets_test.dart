import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_body_atlas/flutter_body_atlas.dart';
import 'package:flutter_body_atlas/src/assets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BodyAtlasView', () {
    testWidgets('renders front view without throwing', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BodyAtlasView<MuscleInfo>(
              view: AtlasAsset.musclesFront,
              resolver: MuscleResolver(),
            ),
          ),
        ),
      );

      // Let the FutureBuilder run at least once.
      await tester.pump();

      expect(find.byType(BodyAtlasView<MuscleInfo>), findsOneWidget);
    });

    testWidgets('renders back view without throwing', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BodyAtlasView<MuscleInfo>(
              view: AtlasAsset.musclesBack,
              resolver: MuscleResolver(),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(BodyAtlasView<MuscleInfo>), findsOneWidget);
    });

    testWidgets('highlighting an aggregate colors every path it covers', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BodyAtlasView<MuscleInfo>(
              view: AtlasAsset.musclesFront,
              resolver: const MuscleResolver(),
              colorMapping: {
                MuscleCatalog.byIdOrThrow('external_oblique_l'): Colors.orange,
                MuscleCatalog.byIdOrThrow('rectus_abdominis_1'): Colors.blue,
              },
            ),
          ),
        ),
      );

      await tester.pump();

      final svg = tester.widget<SvgAsset>(find.byType(SvgAsset));

      // the aggregate paints its eight digitations, not its own id
      expect(svg.highlightedColors.keys, isNot(contains('external_oblique_l')));
      for (var i = 1; i <= 8; i++) {
        expect(
          svg.highlightedColors['external_oblique_${i}_l'],
          Colors.orange,
          reason: 'external_oblique_${i}_l should be highlighted via the aggregate',
        );
      }

      // an ordinary muscle still paints exactly itself
      expect(svg.highlightedColors['rectus_abdominis_1'], Colors.blue);
    });

    testWidgets('hovering an aggregate covers every path it covers', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BodyAtlasView<MuscleInfo>(
              view: AtlasAsset.musclesFront,
              resolver: const MuscleResolver(),
              hoveredOver: MuscleCatalog.byIdOrThrow('external_oblique_r'),
              hoverColor: (original) => original.withValues(alpha: 0.5),
            ),
          ),
        ),
      );

      await tester.pump();

      final svg = tester.widget<SvgAsset>(find.byType(SvgAsset));

      expect(svg.hoveredIds, hasLength(8));
      expect(svg.hoveredIds, contains('external_oblique_4_r'));
      expect(svg.hoveredIds, isNot(contains('external_oblique_r')));
    });
  });

  group('BodyAtlasView semantics', () {
    final pectoralLeft = MuscleCatalog.byIdOrThrow('pectoralis_major_l');
    final pectoralRight = MuscleCatalog.byIdOrThrow('pectoralis_major_r');
    final obliqueLeft = MuscleCatalog.byIdOrThrow('external_oblique_l');

    // rootBundle caches the SVG load; one started by a test that never let it finish would stall here
    setUp(rootBundle.clear);

    testWidgets('the view carries its whole-view label', (tester) async {
      final handle = tester.ensureSemantics();
      await _pumpAtlas(
        tester,
        const BodyAtlasView<MuscleInfo>(
          view: AtlasAsset.musclesFront,
          resolver: MuscleResolver(),
          semanticLabel: 'Muscles trained this week',
        ),
      );

      final view = tester.getSemantics(find.bySemanticsLabel('Muscles trained this week'));
      expect(view.flagsCollection.isImage, isTrue);
      handle.dispose();
    });

    testWidgets('a heat map exposes only its colored elements, as plain labels', (tester) async {
      final handle = tester.ensureSemantics();
      await _pumpAtlas(
        tester,
        BodyAtlasView<MuscleInfo>(
          view: AtlasAsset.musclesFront,
          resolver: const MuscleResolver(),
          colorMapping: {pectoralLeft: Colors.red, obliqueLeft: Colors.orange, pectoralRight: null},
        ),
      );

      final pectoral = find.semantics.byLabel(pectoralLeft.displayName).evaluate().single;
      expect(pectoral.flagsCollection.isButton, isFalse);
      expect(pectoral.getSemanticsData().hasAction(SemanticsAction.tap), isFalse);
      // a null color is no highlight, so nothing to announce
      expect(find.semantics.byLabel(pectoralRight.displayName), findsNothing);
      // the aggregate is one node, not eight digitations
      expect(find.semantics.byLabel(obliqueLeft.displayName), findsOne);
      expect(find.semantics.byLabel(RegExp(r'External Oblique \(\d\)')), findsNothing);
      handle.dispose();
    });

    testWidgets('elementSemanticLabel replaces the display name', (tester) async {
      final handle = tester.ensureSemantics();
      await _pumpAtlas(
        tester,
        BodyAtlasView<MuscleInfo>(
          view: AtlasAsset.musclesFront,
          resolver: const MuscleResolver(),
          colorMapping: {pectoralLeft: Colors.red},
          elementSemanticLabel: (m) => '${m.displayName}: 12 sets',
        ),
      );

      expect(find.semantics.byLabel('Pectoralis Major — Left: 12 sets'), findsOne);
      handle.dispose();
    });

    testWidgets('elements a layer does not draw are skipped', (tester) async {
      final handle = tester.ensureSemantics();
      await _pumpAtlas(
        tester,
        BodyAtlasView<MuscleInfo>(
          view: AtlasAsset.musclesBack,
          resolver: const MuscleResolver(),
          colorMapping: {pectoralLeft: Colors.red},
        ),
      );

      expect(find.semantics.byLabel(pectoralLeft.displayName), findsNothing);
      handle.dispose();
    });

    testWidgets('tappable elements are buttons that report themselves', (tester) async {
      final handle = tester.ensureSemantics();
      final tapped = <MuscleInfo>[];
      await _pumpAtlas(
        tester,
        BodyAtlasView<MuscleInfo>(
          view: AtlasAsset.musclesFront,
          resolver: const MuscleResolver(),
          colorMapping: {obliqueLeft: Colors.orange},
          onTapElement: tapped.add,
        ),
      );

      // uncolored elements are reachable too, once the view is tappable
      final pectoral = find.semantics.byLabel(pectoralRight.displayName).evaluate().single;
      expect(pectoral.flagsCollection.isButton, isTrue);
      expect(pectoral.getSemanticsData().hasAction(SemanticsAction.tap), isTrue);
      tester.semantics.tap(find.semantics.byLabel(pectoralRight.displayName));
      expect(tapped, [pectoralRight]);

      // a colored aggregate still stands in for its pieces
      expect(find.semantics.byLabel(RegExp(r'External Oblique \(\d\) — Left')), findsNothing);
      tester.semantics.tap(find.semantics.byLabel(obliqueLeft.displayName));
      expect(tapped.last, obliqueLeft);
      handle.dispose();
    });

    testWidgets('an element node sits over its own path', (tester) async {
      final handle = tester.ensureSemantics();
      final tapped = <MuscleInfo>[];
      await _pumpAtlas(
        tester,
        BodyAtlasView<MuscleInfo>(
          view: AtlasAsset.musclesFront,
          resolver: const MuscleResolver(),
          onTapElement: tapped.add,
        ),
      );

      // a real tap at the node's center hits the very element it describes
      final node = find.semantics.byLabel(pectoralLeft.displayName).evaluate().single;
      final center = tester.getTopLeft(find.byType(BodyAtlasView<MuscleInfo>)) + node.rect.center;
      await tester.tapAt(center);
      expect(tapped, [pectoralLeft]);
      handle.dispose();
    });
  });
}

/// Pumps [atlas] and lets its SVG load for real, so hit testing and element
/// semantics exist.
Future<void> _pumpAtlas(WidgetTester tester, Widget atlas) async {
  await tester.pumpWidget(MaterialApp(home: Scaffold(body: atlas)));

  // loading is real IO, outside fake async: give it real time until the semantics painter shows up
  final loaded = find.descendant(
    of: find.byWidgetPredicate((w) => w is BodyAtlasView),
    matching: find.byWidgetPredicate((w) => w is CustomPaint && w.foregroundPainter != null),
  );
  for (var i = 0; i < 50 && loaded.evaluate().isEmpty; i++) {
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 20)));
    await tester.pump();
  }
  expect(loaded, findsOne, reason: 'the atlas never finished loading');
}
