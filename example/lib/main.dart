import 'package:flutter/material.dart';
import 'package:flutter_body_atlas/flutter_body_atlas.dart';

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
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
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
  final _selected = <MuscleInfo>{};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggle(MuscleInfo item) {
    setState(() {
      if (_selected.contains(item)) {
        _selected.remove(item);
      } else {
        _selected.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const .all(8),
        child: Row(
          children: [
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
                  Expanded(
                    child: ValueListenableBuilder<TextEditingValue>(
                      valueListenable: _searchController,
                      builder: (_, v, _) {
                        final found = MuscleCatalog.search(v.text.trim());
                        return ListView(
                          children: found.map(
                            (item) {
                              final selected = _selected.contains(item);
                              return ListTile(
                                selected: selected,
                                title: Text(item.displayName),
                                onTap: () => _toggle(item),
                              );
                            },
                          ).toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(
                    child: BodyAtlasView(
                      view: .musclesFront,
                      onMuscleTap: _toggle,
                      highlightedMuscles: Map<MuscleInfo, Color?>.fromIterables(
                        _selected,
                        List.generate(
                          _selected.length,
                          (index) {
                            final muscle = _selected.toList()[index];
                            return switch (muscle.group) {
                              .legs => Colors.purple[500],
                              .adductors => Colors.orange[500],
                              .hamstrings => Colors.green[500],
                              .glutes => Colors.teal[500],
                              .arms => Colors.blue[500],
                              .neck => Colors.red[500],
                              .back => Colors.pink[500],
                              .core => Colors.yellow[500],
                              .shoulders => Colors.brown[500],
                            };
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: BodyAtlasView(
                      view: .musclesBack,
                      onMuscleTap: _toggle,
                      // ignore: avoid_print
                      onMuscleHover: (m) => print(m?.muscle),
                      highlightedMuscles: Map<MuscleInfo, Color?>.fromIterables(
                        _selected,
                        List.generate(
                          _selected.length,
                          (index) {
                            final muscle = _selected.toList()[index];
                            return switch (muscle.group) {
                              .legs => Colors.purple[500],
                              .adductors => Colors.orange[500],
                              .hamstrings => Colors.green[500],
                              .glutes => Colors.teal[500],
                              .arms => Colors.blue[500],
                              .neck => Colors.red[500],
                              .back => Colors.pink[500],
                              .core => Colors.yellow[500],
                              .shoulders => Colors.brown[500],
                            };
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
