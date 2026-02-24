import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_body_atlas/flutter_body_atlas.dart';

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
  });
}
