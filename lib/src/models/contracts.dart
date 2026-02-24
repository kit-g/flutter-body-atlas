/// A single interactive element of the SVG image.
abstract interface class AtlasElement {
  /// Stable element id that matches an SVG `<path id="...">`.
  String get id;
}

/// Optional grouping of [AtlasElement],
/// likely introduces with a `<g>` tag
abstract interface class AtlasGroup {
  /// Stable group id (for categorization / theming / filtering).
  String get id;
}

/// Minimal info the atlas needs at runtime.
/// Keep this free of UI strings so localization can be DI'ed.
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

/// Dependency-injected localization for element/group naming + search tokens.
///
/// Your app can provide different implementations per locale, per taxonomy,
/// or even per audience ("latissimus dorsi" vs "lats").
abstract interface class AtlasLocalizer<I extends AtlasElementInfo, G extends AtlasGroup> {
  String elementLabel(I element);

  String groupLabel(G group);

  /// Tokens used for search (already localized).
  ///
  /// Recommended to include:
  /// - localized label(s)
  /// - common synonyms
  /// - optionally the stable id (useful for debugging/power users)
  Iterable<String> elementSearchTokens(I element);
}

/// Dependency-injected search implementation.
abstract interface class AtlasSearch<I extends AtlasElementInfo> {
  List<I> search(String query, {int limit = 50});
}

/// Simple, locale-aware contains search.
final class SimpleAtlasSearch<I extends AtlasElementInfo> implements AtlasSearch<I> {
  final List<I> items;
  final Iterable<String> Function(I item) tokensOf;

  const SimpleAtlasSearch({
    required this.items,
    required this.tokensOf,
  });

  @override
  List<I> search(String query, {int limit = 50}) {
    final q = query.normalized();
    if (q.isEmpty) return const [];
    bool contains(String token) => token.normalized().contains(q);
    bool fits(I item) => tokensOf(item).any(contains);
    return items.where(fits).take(limit).toList();
  }
}

extension on String {
  String normalized() => trim().toLowerCase();
}
