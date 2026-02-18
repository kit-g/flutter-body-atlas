import 'package:flutter_body_atlas/src/models/muscle.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Muscle enum integrity', () {
    test('Muscle.id values are unique', () {
      final ids = Muscle.values.map((m) => m.id).toList(growable: false);
      final unique = ids.toSet();

      expect(
        unique.length,
        ids.length,
        reason: 'Duplicate Muscle.id detected: ${_duplicates(ids).join(', ')}',
      );
    });

    for (final m in Muscle.values) {
      test('${m.name}.fromString/tryFromString round-trip for all values', () {
        expect(Muscle.tryFromString(m.id), m, reason: 'tryFromString failed for ${m.id}');
        expect(Muscle.fromString(m.id), m, reason: 'fromString failed for ${m.id}');
      });
    }

    test('Muscle.fromString throws for unknown ids', () {
      expect(Muscle.tryFromString('___definitely_not_a_real_id___'), isNull);
      expect(
        () => Muscle.fromString('___definitely_not_a_real_id___'),
        throwsA(isA<ArgumentError>()),
      );
    });
  });

  group('MuscleCatalog integrity', () {
    test('Catalog ids are unique', () {
      final ids = MuscleCatalog.all.map((i) => i.id).toList(growable: false);
      final unique = ids.toSet();

      expect(
        unique.length,
        ids.length,
        reason: 'Duplicate MuscleInfo.id detected: ${_duplicates(ids).join(', ')}',
      );
    });

    test('Catalog muscles are unique (no duplicate Muscle entries)', () {
      final muscles = MuscleCatalog.all.map((i) => i.muscle).toList(growable: false);
      final unique = muscles.toSet();

      expect(
        unique.length,
        muscles.length,
        reason: 'Duplicate MuscleInfo.muscle detected: ${_duplicates(muscles).join(', ')}',
      );
    });

    test('Catalog covers every Muscle value', () {
      final catalogMuscles = MuscleCatalog.all.map((i) => i.muscle).toSet();
      final enumMuscles = Muscle.values.toSet();

      final missing = enumMuscles.difference(catalogMuscles).toList()..sort(_muscleSort);
      final extra = catalogMuscles.difference(enumMuscles).toList()..sort(_muscleSort);

      expect(
        missing,
        isEmpty,
        reason: 'Muscles missing from catalog: ${missing.map((m) => m.id).join(', ')}',
      );
      expect(
        extra,
        isEmpty,
        reason: 'Catalog contains muscles not in enum: ${extra.map((m) => m.id).join(', ')}',
      );
    });

    test('byId and byMuscle maps are consistent with the catalog list', () {
      expect(MuscleCatalog.byId.length, MuscleCatalog.all.length);
      expect(MuscleCatalog.byMuscle.length, MuscleCatalog.all.length);

      for (final info in MuscleCatalog.all) {
        expect(MuscleCatalog.byId[info.id], same(info), reason: 'byId mismatch for ${info.id}');
        expect(
          MuscleCatalog.byMuscle[info.muscle],
          same(info),
          reason: 'byMuscle mismatch for ${info.muscle.id}',
        );
      }
    });

    test('Muscle.info extension is present for all enum values', () {
      final missing = <Muscle>[];
      for (final m in Muscle.values) {
        if (m.info == null) missing.add(m);
      }

      expect(
        missing,
        isEmpty,
        reason: 'Missing Muscle.info for: ${missing.map((m) => m.id).join(', ')}',
      );
    });

    test('BodySide matches id suffix (_l / _r) when applicable', () {
      for (final info in MuscleCatalog.all) {
        final id = info.id;

        if (id.endsWith('_l')) {
          expect(
            info.side,
            BodySide.left,
            reason: 'Expected BodySide.left for id=$id',
          );
        } else if (id.endsWith('_r')) {
          expect(
            info.side,
            BodySide.right,
            reason: 'Expected BodySide.right for id=$id',
          );
        } else {
          // if we add centerline muscles later (e.g., rectus_abdominis),
          // they should likely be BodySide.none.
          expect(
            info.side,
            BodySide.none,
            reason: 'Expected BodySide.none for id=$id (no _l/_r suffix)',
          );
        }
      }
    });

    test('Search hits by id, displayName, and aliases (case-insensitive)', () {
      // by id
      final byId = MuscleCatalog.search('flexor_carpi_ulnaris_r');
      expect(byId.map((e) => e.id), contains('flexor_carpi_ulnaris_r'));

      // by partial display name
      final byName = MuscleCatalog.search('gastro');
      expect(byName.any((e) => e.displayName.toLowerCase().contains('gastro')), isTrue);

      // by alias
      final byAlias = MuscleCatalog.search('triceps');
      expect(byAlias.any((e) => e.searchTokens.any((t) => t.toLowerCase().contains('triceps'))), isTrue);
    });

    test('Search limit is respected', () {
      final results = MuscleCatalog.search('e', limit: 3); // broad query
      expect(results.length, lessThanOrEqualTo(3));
    });
  });

  group('MuscleGroup integrity', () {
    test('MuscleGroup.id values are unique', () {
      final ids = MuscleGroup.values.map((g) => g.id).toList(growable: false);
      final unique = ids.toSet();

      expect(
        unique.length,
        ids.length,
        reason: 'Duplicate MuscleGroup.id detected: ${_duplicates(ids).join(', ')}',
      );
    });

    for (final g in MuscleGroup.values) {
      test('${g.id}.fromString/tryFromString round-trip for all values', () {
        expect(MuscleGroup.tryFromString(g.id), g, reason: 'tryFromString failed for ${g.id}');
        expect(MuscleGroup.fromString(g.id), g, reason: 'fromString failed for ${g.id}');
      });
    }
  });
}

List<T> _duplicates<T>(List<T> values) {
  final seen = <T>{};
  final dupes = <T>{};

  for (final v in values) {
    if (!seen.add(v)) dupes.add(v);
  }
  return dupes.toList();
}

int _muscleSort(Muscle a, Muscle b) => a.id.compareTo(b.id);
