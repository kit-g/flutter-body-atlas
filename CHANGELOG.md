## 0.2.2

* Muscle data and the `Atlas*` contracts moved to [body_atlas](https://pub.dev/packages/body_atlas), a pure Dart
  package, so servers and CLIs can share the same ids without Flutter. Everything is re-exported from here: no import
  changes needed.
* `xml` accepts 6.x again alongside 7.x: 7.x needs Dart 3.11, so 0.2.1 couldn't resolve on Flutter 3.38.

## 0.2.1

* Dependency updates.

## 0.2.0

* `external_oblique_l` / `external_oblique_r` highlight again. The artwork draws the external oblique as eight
  digitations per side and no path carries the whole-muscle id, so highlighting either one silently painted nothing.
* Aggregate elements added: `AtlasElement.parts` lists the path ids an element paints — `[id]` for an ordinary element,
  the piece ids for an aggregate. Highlighting and hover both fan out over it.
* **Breaking**: `AtlasElement` implementations must now provide `parts`.

## 0.1.4

* Issue with rendering in mobile release mode fixed.

## 0.1.3

* Example app allows selecting a muscle group.
* Hovering over muscle group shows muscle names.

## 0.1.2

* Color picker in example app.
* All public muscle models exported.

## 0.1.1

* Description in pubspec.yaml updated.

## 0.1.0

* Initial Release