## 0.1.5

* Fix blank atlas rendering in iOS/Android **release** builds.
  `BodyAtlasView` no longer uses `flutter_svg` `SvgPicture`/`ColorMapper`
  (which runs `SvgLoader` via `compute` and can fail when `hoverColor` or
  other closures are involved). The atlas is now painted with `CustomPaint`
  from the same parsed SVG paths used for hit-testing.
* Remove unused `flutter_svg` dependency.

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