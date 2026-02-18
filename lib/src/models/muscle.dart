enum Muscle {
  // legs / hamstrings
  semimembranosus2Right('semimembranosus_2_r'),
  semimembranosus2Left('semimembranosus_2_l'),
  semimembranosus1Right('semimembranosus_1_r'),
  semimembranosus1Left('semimembranosus_1_l'),
  semitendinosusRight('semitendinosus_r'),
  semitendinosusLeft('semitendinosus_l'),
  bicepsFemorisLeft('biceps_femoris_l'),
  bicepsFemorisRight('biceps_femoris_r'),
  iliotibialTractRight('iliotibial_tract_r'),
  iliotibialTractLeft('iliotibial_tract_l'),
  gastrocnemiusRight('gastrocnemius_r'),
  gastrocnemiusLeft('gastrocnemius_l'),
  gluteusMaximusRight('gluteus_maximus_r'),
  gluteusMaximusLeft('gluteus_maximus_l'),

  // glutes
  gluteusMedius2Right('gluteus_medius_2_r'),
  gluteusMedius2Left('gluteus_medius_2_l'),
  gluteusMedius1Right('gluteus_medius_1_r'),
  gluteusMedius1Left('gluteus_medius_1_l'),

  // trunk
  externalObliqueRight('external_oblique_r'),
  externalObliqueLeft('external_oblique_l'),

  // arms
  extensorDigitorumRight('extensor_digitorum_r'),
  extensorDigitorumLeft('extensor_digitorum_l'),
  brachioradialisRight('brachioradialis_r'),
  brachioradialisLeft('brachioradialis_l'),
  extensorCarpiUlnarisRight('extensor_carpi_ulnaris_r'),
  extensorCarpiUlnarisLeft('extensor_carpi_ulnaris_l'),
  anconeusRight('anconeus_r'),
  anconeusLeft('anconeus_l'),
  flexorCarpiUlnarisRight('flexor_carpi_ulnaris_r'),
  flexorCarpiUlnarisLeft('flexor_carpi_ulnaris_l'),
  tricepsBrachiiCaputLateraleRight('triceps_brachii_caput_laterale_r'),
  tricepsBrachiiCaputLongumRight('triceps_brachii_caput_longum_r'),
  tricepsBrachiiCaputMedialeRight('triceps_brachii_caput_mediale_r'),
  tricepsBrachiiCaputLateraleLeft('triceps_brachii_caput_laterale_l'),
  tricepsBrachiiCaputLongumLeft('triceps_brachii_caput_longum_l'),
  tricepsBrachiiCaputMedialeLeft('triceps_brachii_caput_mediale_l'),

  // neck
  sternocleidomastoidRight('sternocleidomastoid_r'),
  sternocleidomastoidLeft('sternocleidomastoid_l'),

  // back
  infraspinatusRight('infraspinatus_r'),
  infraspinatusLeft('infraspinatus_l'),
  latissimusDorsiRight('latissimus_dorsi_r'),
  latissimusDorsiLeft('latissimus_dorsi_l'),

  // shoulders / traps / delts
  lateralDeltoidRight('lateral_deltoid_r'),
  lateralDeltoidLeft('lateral_deltoid_l'),
  posteriorDeltoidLeft('posterior_deltoid_l'),
  posteriorDeltoidRight('posterior_deltoid_r'),
  trapeziusMiddleRight('trapezius_middle_r'),
  trapeziusMiddleLeft('trapezius_middle_l'),
  trapeziusLowerLeft('trapezius_lower_l'),
  trapeziusLowerRight('trapezius_lower_r'),
  trapeziusUpperLeft('trapezius_upper_l'),
  trapeziusUpperRight('trapezius_upper_r')
  ;

  const Muscle(this.id);

  final String id;

  static final Map<String, Muscle> _byId = {for (final m in values) m.id: m};

  static Muscle? tryFromString(String id) => _byId[id];

  static Muscle fromString(String id) {
    final m = tryFromString(id);
    if (m == null) throw ArgumentError.value(id, 'id', 'Unknown Muscle id');
    return m;
  }
}

enum MuscleGroup {
  legs('legs'),
  adductors('adductors'),
  hamstrings('hamstrings'),
  glutes('glutes'),
  arms('arms'),
  neck('neck'),
  back('back'),
  core('core'),
  shoulders('shoulders')
  ;

  const MuscleGroup(this.id);

  final String id;

  static final _byId = {for (final g in values) g.id: g};

  static MuscleGroup? tryFromString(String id) => _byId[id];

  static MuscleGroup fromString(String id) {
    final g = tryFromString(id);
    if (g == null) {
      throw ArgumentError.value(id, 'id', 'Unknown MuscleGroup id');
    }
    return g;
  }
}

enum BodySide {
  left('left'),
  right('right'),
  none('none')
  ;

  const BodySide(this.id);

  final String id;
}

final class MuscleInfo {
  const MuscleInfo({
    required this.muscle,
    required this.displayName,
    required this.group,
    this.side = .none,
    this.aliases = const <String>[],
  });

  final Muscle muscle;
  final String displayName;
  final MuscleGroup group;
  final BodySide side;
  final List<String> aliases;

  /// Stable ID (the one that appears in the SVG).
  String get id => muscle.id;

  Iterable<String> get searchTokens sync* {
    yield displayName;
    yield id;
    for (final a in aliases) {
      yield a;
    }
  }
}

abstract final class MuscleCatalog {
  static const hamstrings = <MuscleInfo>[
    MuscleInfo(
      muscle: .semimembranosus2Right,
      displayName: 'Semimembranosus (2) — Right',
      group: .hamstrings,
      side: .right,
      aliases: <String>['semimembranosus', 'hamstring'],
    ),
    MuscleInfo(
      muscle: .semimembranosus2Left,
      displayName: 'Semimembranosus (2) — Left',
      group: .hamstrings,
      side: .left,
      aliases: <String>['semimembranosus', 'hamstring'],
    ),
    MuscleInfo(
      muscle: .semimembranosus1Right,
      displayName: 'Semimembranosus (1) — Right',
      group: .hamstrings,
      side: .right,
      aliases: <String>['semimembranosus', 'hamstring'],
    ),
    MuscleInfo(
      muscle: .semimembranosus1Left,
      displayName: 'Semimembranosus (1) — Left',
      group: .hamstrings,
      side: .left,
      aliases: <String>['semimembranosus', 'hamstring'],
    ),
    MuscleInfo(
      muscle: .semitendinosusRight,
      displayName: 'Semitendinosus — Right',
      group: .hamstrings,
      side: .right,
      aliases: <String>['semitendinosus', 'hamstring'],
    ),
    MuscleInfo(
      muscle: .semitendinosusLeft,
      displayName: 'Semitendinosus — Left',
      group: .hamstrings,
      side: .left,
      aliases: <String>['semitendinosus', 'hamstring'],
    ),
    MuscleInfo(
      muscle: .bicepsFemorisRight,
      displayName: 'Biceps Femoris — Right',
      group: .hamstrings,
      side: .right,
      aliases: <String>['biceps femoris', 'hamstring'],
    ),
    MuscleInfo(
      muscle: .bicepsFemorisLeft,
      displayName: 'Biceps Femoris — Left',
      group: .hamstrings,
      side: .left,
      aliases: <String>['biceps femoris', 'hamstring'],
    ),
  ];

  static const legs = <MuscleInfo>[
    MuscleInfo(
      muscle: .iliotibialTractRight,
      displayName: 'Iliotibial Tract — Right',
      group: .legs,
      side: .right,
      aliases: <String>['IT band', 'iliotibial band'],
    ),
    MuscleInfo(
      muscle: .iliotibialTractLeft,
      displayName: 'Iliotibial Tract — Left',
      group: .legs,
      side: .left,
      aliases: <String>['IT band', 'iliotibial band'],
    ),
    MuscleInfo(
      muscle: .gastrocnemiusRight,
      displayName: 'Gastrocnemius — Right',
      group: .legs,
      side: .right,
      aliases: <String>['calf'],
    ),
    MuscleInfo(
      muscle: .gastrocnemiusLeft,
      displayName: 'Gastrocnemius — Left',
      group: .legs,
      side: .left,
      aliases: <String>['calf'],
    ),
  ];

  static const glutes = <MuscleInfo>[
    MuscleInfo(
      muscle: .gluteusMaximusRight,
      displayName: 'Gluteus Maximus — Right',
      group: .glutes,
      side: .right,
      aliases: <String>['glute max', 'glute'],
    ),
    MuscleInfo(
      muscle: .gluteusMaximusLeft,
      displayName: 'Gluteus Maximus — Left',
      group: .glutes,
      side: .left,
      aliases: <String>['glute max', 'glute'],
    ),
    MuscleInfo(
      muscle: .gluteusMedius2Right,
      displayName: 'Gluteus Medius (2) — Right',
      group: .glutes,
      side: .right,
      aliases: <String>['glute med', 'glute'],
    ),
    MuscleInfo(
      muscle: .gluteusMedius2Left,
      displayName: 'Gluteus Medius (2) — Left',
      group: .glutes,
      side: .left,
      aliases: <String>['glute med', 'glute'],
    ),
    MuscleInfo(
      muscle: .gluteusMedius1Right,
      displayName: 'Gluteus Medius (1) — Right',
      group: .glutes,
      side: .right,
      aliases: <String>['glute med', 'glute'],
    ),
    MuscleInfo(
      muscle: .gluteusMedius1Left,
      displayName: 'Gluteus Medius (1) — Left',
      group: .glutes,
      side: .left,
      aliases: <String>['glute med', 'glute'],
    ),
  ];

  static const core = <MuscleInfo>[
    MuscleInfo(
      muscle: .externalObliqueRight,
      displayName: 'External Oblique — Right',
      group: .core,
      // POC:  as back-ish “trunk”; adjust later if you add a Trunk group.
      side: BodySide.right,
      aliases: <String>['oblique', 'abs'],
    ),
    MuscleInfo(
      muscle: .externalObliqueLeft,
      displayName: 'External Oblique — Left',
      group: .core,
      // see  above
      side: BodySide.left,
      aliases: <String>['oblique', 'abs'],
    ),
  ];

  static const arms = <MuscleInfo>[
    MuscleInfo(
      muscle: .extensorDigitorumRight,
      displayName: 'Extensor Digitorum — Right',
      group: .arms,
      side: .right,
      aliases: <String>['forearm extensor'],
    ),
    MuscleInfo(
      muscle: .extensorDigitorumLeft,
      displayName: 'Extensor Digitorum — Left',
      group: .arms,
      side: .left,
      aliases: <String>['forearm extensor'],
    ),
    MuscleInfo(
      muscle: .brachioradialisRight,
      displayName: 'Brachioradialis — Right',
      group: .arms,
      side: .right,
      aliases: <String>['forearm'],
    ),
    MuscleInfo(
      muscle: .brachioradialisLeft,
      displayName: 'Brachioradialis — Left',
      group: .arms,
      side: .left,
      aliases: <String>['forearm'],
    ),
    MuscleInfo(
      muscle: .extensorCarpiUlnarisRight,
      displayName: 'Extensor Carpi Ulnaris — Right',
      group: .arms,
      side: .right,
      aliases: <String>['forearm extensor'],
    ),
    MuscleInfo(
      muscle: .extensorCarpiUlnarisLeft,
      displayName: 'Extensor Carpi Ulnaris — Left',
      group: .arms,
      side: .left,
      aliases: <String>['forearm extensor'],
    ),
    MuscleInfo(
      muscle: .anconeusRight,
      displayName: 'Anconeus — Right',
      group: .arms,
      side: .right,
      aliases: <String>['elbow'],
    ),
    MuscleInfo(
      muscle: .anconeusLeft,
      displayName: 'Anconeus — Left',
      group: .arms,
      side: .left,
      aliases: <String>['elbow'],
    ),
    MuscleInfo(
      muscle: .flexorCarpiUlnarisRight,
      displayName: 'Flexor Carpi Ulnaris — Right',
      group: .arms,
      side: .right,
      aliases: <String>['forearm flexor'],
    ),
    MuscleInfo(
      muscle: .flexorCarpiUlnarisLeft,
      displayName: 'Flexor Carpi Ulnaris — Left',
      group: .arms,
      side: .left,
      aliases: <String>['forearm flexor'],
    ),
    MuscleInfo(
      muscle: .tricepsBrachiiCaputLateraleRight,
      displayName: 'Triceps (Lateral Head) — Right',
      group: .arms,
      side: .right,
      aliases: <String>['triceps'],
    ),
    MuscleInfo(
      muscle: .tricepsBrachiiCaputLateraleLeft,
      displayName: 'Triceps (Lateral Head) — Left',
      group: .arms,
      side: .left,
      aliases: <String>['triceps'],
    ),
    MuscleInfo(
      muscle: .tricepsBrachiiCaputLongumRight,
      displayName: 'Triceps (Long Head) — Right',
      group: .arms,
      side: .right,
      aliases: <String>['triceps'],
    ),
    MuscleInfo(
      muscle: .tricepsBrachiiCaputLongumLeft,
      displayName: 'Triceps (Long Head) — Left',
      group: .arms,
      side: .left,
      aliases: <String>['triceps'],
    ),
    MuscleInfo(
      muscle: .tricepsBrachiiCaputMedialeRight,
      displayName: 'Triceps (Medial Head) — Right',
      group: .arms,
      side: .right,
      aliases: <String>['triceps'],
    ),
    MuscleInfo(
      muscle: .tricepsBrachiiCaputMedialeLeft,
      displayName: 'Triceps (Medial Head) — Left',
      group: .arms,
      side: .left,
      aliases: <String>['triceps'],
    ),
  ];

  static const neck = <MuscleInfo>[
    MuscleInfo(
      muscle: .sternocleidomastoidRight,
      displayName: 'Sternocleidomastoid — Right',
      group: .neck,
      side: .right,
      aliases: <String>['SCM'],
    ),
    MuscleInfo(
      muscle: .sternocleidomastoidLeft,
      displayName: 'Sternocleidomastoid — Left',
      group: .neck,
      side: .left,
      aliases: <String>['SCM'],
    ),
  ];

  static const back = <MuscleInfo>[
    MuscleInfo(
      muscle: .infraspinatusRight,
      displayName: 'Infraspinatus — Right',
      group: .back,
      side: .right,
      aliases: <String>['rotator cuff'],
    ),
    MuscleInfo(
      muscle: .infraspinatusLeft,
      displayName: 'Infraspinatus — Left',
      group: .back,
      side: .left,
      aliases: <String>['rotator cuff'],
    ),
    MuscleInfo(
      muscle: .latissimusDorsiRight,
      displayName: 'Latissimus Dorsi — Right',
      group: .back,
      side: .right,
      aliases: <String>['lats', 'lat'],
    ),
    MuscleInfo(
      muscle: .latissimusDorsiLeft,
      displayName: 'Latissimus Dorsi — Left',
      group: .back,
      side: .left,
      aliases: <String>['lats', 'lat'],
    ),
  ];

  static const shoulders = <MuscleInfo>[
    MuscleInfo(
      muscle: .lateralDeltoidRight,
      displayName: 'Lateral Deltoid — Right',
      group: .shoulders,
      side: .right,
      aliases: <String>['side delt', 'deltoid'],
    ),
    MuscleInfo(
      muscle: .lateralDeltoidLeft,
      displayName: 'Lateral Deltoid — Left',
      group: .shoulders,
      side: .left,
      aliases: <String>['side delt', 'deltoid'],
    ),
    MuscleInfo(
      muscle: .posteriorDeltoidRight,
      displayName: 'Posterior Deltoid — Right',
      group: .shoulders,
      side: .right,
      aliases: <String>['rear delt', 'deltoid'],
    ),
    MuscleInfo(
      muscle: .posteriorDeltoidLeft,
      displayName: 'Posterior Deltoid — Left',
      group: .shoulders,
      side: .left,
      aliases: <String>['rear delt', 'deltoid'],
    ),
    MuscleInfo(
      muscle: .trapeziusUpperRight,
      displayName: 'Trapezius (Upper) — Right',
      group: .shoulders,
      side: .right,
      aliases: <String>['traps', 'trapezius'],
    ),
    MuscleInfo(
      muscle: .trapeziusUpperLeft,
      displayName: 'Trapezius (Upper) — Left',
      group: .shoulders,
      side: .left,
      aliases: <String>['traps', 'trapezius'],
    ),
    MuscleInfo(
      muscle: .trapeziusMiddleRight,
      displayName: 'Trapezius (Middle) — Right',
      group: .shoulders,
      side: .right,
      aliases: <String>['traps', 'trapezius'],
    ),
    MuscleInfo(
      muscle: .trapeziusMiddleLeft,
      displayName: 'Trapezius (Middle) — Left',
      group: .shoulders,
      side: .left,
      aliases: <String>['traps', 'trapezius'],
    ),
    MuscleInfo(
      muscle: .trapeziusLowerRight,
      displayName: 'Trapezius (Lower) — Right',
      group: .shoulders,
      side: .right,
      aliases: <String>['traps', 'trapezius'],
    ),
    MuscleInfo(
      muscle: .trapeziusLowerLeft,
      displayName: 'Trapezius (Lower) — Left',
      group: .shoulders,
      side: .left,
      aliases: <String>['traps', 'trapezius'],
    ),
  ];

  static const all = <MuscleInfo>[
    ...hamstrings,
    ...legs,
    ...glutes,
    ...core,
    ...arms,
    ...neck,
    ...back,
    ...shoulders,
  ];

  static final byId = <String, MuscleInfo>{for (final info in all) info.id: info};

  static final byMuscle = <Muscle, MuscleInfo>{for (final info in all) info.muscle: info};

  static MuscleInfo? tryById(String id) => byId[id];

  static MuscleInfo byIdOrThrow(String id) {
    final info = tryById(id);
    if (info == null) {
      throw ArgumentError.value(id, 'id', 'Unknown muscle id (no metadata)');
    }
    return info;
  }

  /// Simple contains-based search suitable for MVP.
  ///
  /// - Case-insensitive
  /// - Matches id, displayName and aliases
  static List<MuscleInfo> search(String query, {int limit = 20}) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return const <MuscleInfo>[];
    bool contains(MuscleInfo each) => each.searchTokens.any((t) => t.toLowerCase().contains(q));
    return all.where(contains).take(limit).toList();
  }
}

extension MuscleMetadata on Muscle {
  /// Returns packaged metadata if present (it should be, for all enum values).
  MuscleInfo? get info => MuscleCatalog.byMuscle[this];
}
