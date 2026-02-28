import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_body_atlas/flutter_body_atlas.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Body Atlas Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.indigo),
      ),
      home: const BodyAtlasDemo(),
    );
  }
}

class BodyAtlasDemo extends StatefulWidget {
  const BodyAtlasDemo({super.key});

  @override
  State<BodyAtlasDemo> createState() => _BodyAtlasDemoState();
}

class _BodyAtlasDemoState extends State<BodyAtlasDemo> {
  final _searchController = TextEditingController();
  final _selected = <AtlasElementInfo>{};
  AtlasElementInfo? _hoveredOver;

  final _localizer = const MuscleLocalizerEn();
  late final AtlasSearch<MuscleInfo> _search = MuscleSearch(localizer: _localizer);

  final _defaultColors = UnmodifiableMapView(<MuscleGroup, Color?>{
    .adductors: Colors.orange[500],
    .arms: Colors.blue[500],
    .back: Colors.pink[500],
    .chest: Colors.amber,
    .core: Colors.yellow[500],
    .glutes: Colors.teal[500],
    .hamstrings: Colors.green[500],
    .legs: Colors.purple[500],
    .neck: Colors.red[500],
    .shoulders: Colors.brown[500],
  });

  late final _colorsByMuscleGroup = Map.of(_defaultColors);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const .all(8),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Expanded(
                    child: _view(.musclesFront),
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: _view(.musclesBack),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 300,
              child: Column(
                children: [
                  Padding(
                    padding: const .all(8.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Try searching, e.g., "triceps"',
                      ),
                      controller: _searchController,
                    ),
                  ),
                  Align(
                    alignment: .centerRight,
                    child: TextButton(
                      onPressed: _toggleAll,
                      child: Text(_selected.length == MuscleCatalog.all.toSet().length ? 'Deselect all' : 'Select all'),
                    ),
                  ),
                  Expanded(
                    child: ValueListenableBuilder<TextEditingValue>(
                      valueListenable: _searchController,
                      builder: (_, v, _) {
                        final found = _search.search(v.text.trim());
                        return ListView(
                          children: found.map(
                            (item) {
                              final selected = _selected.contains(item);
                              return ListTile(
                                selected: selected,
                                title: Text(item.displayName),
                                subtitle: Text('aka ${item.aliases.join(', ')}'),
                                onTap: () => _toggle(item),
                                leading: Checkbox.adaptive(
                                  value: _selected.contains(item),
                                  onChanged: (_) => _toggle(item),
                                ),
                              );
                            },
                          ).toList(),
                        );
                      },
                    ),
                  ),
                  Expanded(child: _colorPicker()),
                ],
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  Widget _view(AtlasAsset asset) {
    return Container(
      decoration: BoxDecoration(border: .all(width: .5), borderRadius: .circular(12)),
      child: InteractiveViewer(
        child: Padding(
          padding: const .symmetric(vertical: 8.0),
          child: BodyAtlasView(
            view: asset,
            resolver: const MuscleResolver(),
            onTapElement: _toggle,
            hoveredOver: _hoveredOver,
            onHoverOverElement: (m) {
              setState(() => _hoveredOver = m);
            },
            hoverColor: (color) => color.withValues(alpha: .5),
            colorMapping: Map<AtlasElementInfo, Color?>.fromIterables(
              _selected,
              List.generate(
                _selected.length,
                (index) {
                  final muscle = _selected.toList()[index];
                  if (muscle == _hoveredOver) {
                    return _colorOf(muscle)?.withValues(alpha: .5);
                  }

                  return _colorOf(muscle);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _colorPicker() {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: const .only(top: 8, bottom: 4, left: 12),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                'Select colors',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _colorsByMuscleGroup
                      ..clear()
                      ..addAll(_defaultColors);
                  });
                },
                child: Text('To defaults'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: _colorsByMuscleGroup.entries.map(
              (entry) {
                final MapEntry(key: muscleGroup, value: color) = entry;
                return ListTile(
                  title: Text(muscleGroup.name),
                  trailing: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(color: color, borderRadius: .circular(6)),
                  ),
                  onTap: () {
                    final original = color;
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Pick a color!'),
                          content: SingleChildScrollView(
                            child: ColorPicker(
                              pickerColor: color!,
                              onColorChanged: (picked) {
                                setState(() {
                                  _colorsByMuscleGroup[muscleGroup] = picked;
                                });
                              },
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () {
                                setState(() {
                                  _colorsByMuscleGroup[muscleGroup] = original;
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Select'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }

  Color? _colorOf(AtlasElementInfo element) {
    return switch (element) {
      MuscleInfo muscle => _colorsByMuscleGroup[muscle.group],
      AtlasElementInfo() => null,
    };
  }

  void _toggle(AtlasElementInfo item) {
    setState(() {
      if (_selected.contains(item)) {
        _selected.remove(item);
      } else {
        _selected.add(item);
      }
    });
  }

  void _toggleAll() {
    setState(() {
      if (_selected.length == MuscleCatalog.all.toSet().length) {
        _selected.clear();
      } else {
        _selected.addAll(MuscleCatalog.all);
      }
    });
  }
}
