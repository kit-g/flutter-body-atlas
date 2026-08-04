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