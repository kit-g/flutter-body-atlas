import 'package:flutter/material.dart';
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
}
