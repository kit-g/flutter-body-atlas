# body_atlas

The data behind [flutter_body_atlas](https://pub.dev/packages/flutter_body_atlas), as a pure Dart package: stable
muscle ids, their groups, sides, display names and search. No Flutter dependency, so a server, CLI or build script can
use the exact ids the widget draws.

Flutter apps don't need this directly — `flutter_body_atlas` depends on it and re-exports everything below.

## Usage

```dart
import 'package:body_atlas/body_atlas.dart';

void main() {
  final info = MuscleCatalog.byIdOrThrow('latissimus_dorsi_r');
  print(info.displayName); // Latissimus Dorsi — Right
  print(info.group); // back

  // aggregates name a whole muscle the artwork draws in pieces
  print(Muscle.externalObliqueLeft.parts); // [external_oblique_1_l, …, external_oblique_8_l]

  print(MuscleSearch().search('hamstring').map((m) => m.id));
}
```

## ID Stability

Muscle ids (`trapezius_upper_l`, `external_oblique_l`) are a **stable public contract**, shared with the SVG artwork in
`flutter_body_atlas`. Store them in your database; they won't change across versions.

## API

- `Muscle`: every element id, including aggregates; `parts` lists the path ids an element covers.
- `MuscleGroup`: fitness-oriented grouping (`legs`, `back`, `core`, …).
- `MuscleInfo` / `MuscleCatalog`: display names, group, side and aliases for every `Muscle`.
- `MuscleResolver`, `MuscleLocalizerEn`, `MuscleSearch`: default implementations of the `Atlas*` contracts.
- `AtlasElement`, `AtlasGroup`, `AtlasElementInfo`, `AtlasResolver`, `AtlasLocalizer`, `AtlasSearch`: interfaces for
  plugging in your own data.

## License

BSD 3-Clause. The muscle ids follow the SVG artwork by **Ryan Graves** (CC BY 4.0), which ships with
`flutter_body_atlas`, not with this package.
