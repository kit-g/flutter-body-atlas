import 'dart:io';

import 'package:flutter_body_atlas/flutter_body_atlas.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xml/xml.dart';

void main() {
  // The muscle data itself is tested in packages/body_atlas; this checks it against the artwork.
  group('Muscle parts', () {
    test('Every part is drawn by at least one layer', () async {
      final drawn = <String>{};
      for (final asset in AtlasAsset.values) {
        final svg = XmlDocument.parse(File(asset.path).readAsStringSync());
        drawn.addAll(svg.findAllElements('path').map((e) => e.getAttribute('id')).nonNulls);
      }

      final orphans = <String>[];
      for (final m in Muscle.values) {
        for (final part in m.parts) {
          if (!drawn.contains(part)) orphans.add('${m.id} -> $part');
        }
      }

      expect(
        orphans,
        isEmpty,
        reason:
            'Muscles whose parts have no path in either SVG (they highlight nothing): '
            '${orphans.join(', ')}',
      );
    });
  });
}
