/// Small, stable interfaces for atlas layers (skin/muscles/organs/bones).
abstract interface class AtlasElement {
  /// Stable element id that matches an SVG `<path id="...">`.
  String get id;
}

abstract interface class AtlasGroup {
  /// Stable group id (for categorization / theming / filtering).
  String get id;
}

/// What the UI needs to know about a tappable/hoverable atlas element.
abstract interface class AtlasElementInfo {
  AtlasElement get element;

  AtlasGroup get group;

  String get displayName;

  /// Stable id.
  String get id;

  /// Used by search. Usually includes `displayName`, `id`, and aliases.
  Iterable<String> get searchTokens;
}

/// Dependency-injected lookup from SVG `id` -> element info.
abstract interface class AtlasResolver<I extends AtlasElementInfo> {
  I? tryById(String id);
}
