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
  tibialisAnteriorLeft('tibialis_anterior_l'),
  tibialisAnteriorRight('tibialis_anterior_r'),
  extensorHallucisLongusLeft('extensor_hallucis_longus_l'),
  extensorHallucisLongusRight('extensor_hallucis_longus_r'),
  fibularisLongusLeft('fibularis_longus_l'),
  fibularisLongusRight('fibularis_longus_r'),
  extensorDigitorumLongusLeft('extensor_digitorum_longus_l'),
  extensorDigitorumLongusRight('extensor_digitorum_longus_r'),
  vastusLateralisLeft('vastus_lateralis_l'),
  vastusLateralisRight('vastus_lateralis_r'),
  vastusMedialisLeft('vastus_medialis_l'),
  vastusMedialisRight('vastus_medialis_r'),
  sartorisLeft('sartoris_l'),
  sartorisRight('sartoris_r'),
  gracilisLeft('gracilis_l'),
  gracilisRight('gracilis_r'),
  rectusFemorisLeft('rectus_femoris_l'),
  rectusFemorisRight('rectus_femoris_r'),

  // glutes
  gluteusMedius2Right('gluteus_medius_2_r'),
  gluteusMedius2Left('gluteus_medius_2_l'),
  gluteusMedius1Right('gluteus_medius_1_r'),
  gluteusMedius1Left('gluteus_medius_1_l'),
  gluteusMaximusRight('gluteus_maximus_r'),
  gluteusMaximusLeft('gluteus_maximus_l'),

  // trunk
  externalObliqueRight('external_oblique_r'),
  externalObliqueLeft('external_oblique_l'),
  externalOblique1Left('external_oblique_1_l'),
  externalOblique1Right('external_oblique_1_r'),
  externalOblique2Left('external_oblique_2_l'),
  externalOblique2Right('external_oblique_2_r'),
  externalOblique3Left('external_oblique_3_l'),
  externalOblique3Right('external_oblique_3_r'),
  externalOblique4Left('external_oblique_4_l'),
  externalOblique4Right('external_oblique_4_r'),
  externalOblique5Left('external_oblique_5_l'),
  externalOblique5Right('external_oblique_5_r'),
  externalOblique6Left('external_oblique_6_l'),
  externalOblique6Right('external_oblique_6_r'),
  externalOblique7Left('external_oblique_7_l'),
  externalOblique7Right('external_oblique_7_r'),
  externalOblique8Left('external_oblique_8_l'),
  externalOblique8Right('external_oblique_8_r'),
  rectusAbdominis1('rectus_abdominis_1'),
  rectusAbdominis2Left('rectus_abdominis_2_l'),
  rectusAbdominis2Right('rectus_abdominis_2_r'),
  rectusAbdominis3Left('rectus_abdominis_3_l'),
  rectusAbdominis3Right('rectus_abdominis_3_r'),
  rectusAbdominis4Left('rectus_abdominis_4_l'),
  rectusAbdominis4Right('rectus_abdominis_4_r'),

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
  flexorDigitorumSuperficialisLeft('flexor_digitorum_superficialis_l'),
  flexorDigitorumSuperficialisRight('flexor_digitorum_superficialis_r'),
  pronatorQuadratusLeft('pronator_quadratus_l'),
  pronatorQuadratusRight('pronator_quadratus_r'),
  extensorCarpiRadialisLongusLeft('extensor_carpi_radialis_longus_l'),
  extensorCarpiRadialisLongusRight('extensor_carpi_radialis_longus_r'),
  palmarisLongusLeft('palmaris_longus_l'),
  palmarisLongusRight('palmaris_longus_r'),
  flexorCarpiRadialisLeft('flexor_carpi_radialis_l'),
  flexorCarpiRadialisRight('flexor_carpi_radialis_r'),
  pronatorTeresLeft('pronator_teres_l'),
  pronatorTeresRight('pronator_teres_r'),
  bicepsBrachiiCaputBreveLeft('biceps_brachii_caput_breve_l'),
  bicepsBrachiiCaputBreveRight('biceps_brachii_caput_breve_r'),
  bicepsBrachiiCaputLongumLeft('biceps_brachii_caput_longum_l'),
  bicepsBrachiiCaputLongumRight('biceps_brachii_caput_longum_r'),

  // neck
  sternocleidomastoidRight('sternocleidomastoid_r'),
  sternocleidomastoidLeft('sternocleidomastoid_l'),
  platysma('platysma'),
  sternohyoid('sternohyoid'),

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
  trapeziusUpperRight('trapezius_upper_r'),
  anteriorDeltoidLeft('anterior_deltoid_l'),
  anteriorDeltoidRight('anterior_deltoid_r'),

  // chest
  pectoralisMajorLeft('pectoralis_major_l'),
  pectoralisMajorRight('pectoralis_major_r'),

  // adductors
  adductorMagnusLeft('adductor_magnus_l'),
  adductorMagnusRight('adductor_magnus_r'),
  adductorLongusLeft('adductor_longus_l'),
  adductorLongusRight('adductor_longus_r'),
  pectineusLeft('pectineus_l'),
  pectineusRight('pectineus_r')
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

  @override
  String toString() => name;
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
  shoulders('shoulders'),
  chest('chest')
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

  @override
  String toString() => id;
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

  @override
  String toString() {
    return '$muscle, $group';
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
    MuscleInfo(
      muscle: .tibialisAnteriorLeft,
      displayName: 'Tibialis Anterior — Left',
      group: .legs,
      side: .left,
      aliases: <String>['shin'],
    ),
    MuscleInfo(
      muscle: .tibialisAnteriorRight,
      displayName: 'Tibialis Anterior — Right',
      group: .legs,
      side: .right,
      aliases: <String>['shin'],
    ),
    MuscleInfo(
      muscle: .extensorHallucisLongusLeft,
      displayName: 'Extensor Hallucis Longus — Left',
      group: .legs,
      side: .left,
      aliases: <String>['shin extensor'],
    ),
    MuscleInfo(
      muscle: .extensorHallucisLongusRight,
      displayName: 'Extensor Hallucis Longus — Right',
      group: .legs,
      side: .right,
      aliases: <String>['shin extensor'],
    ),
    MuscleInfo(
      muscle: .fibularisLongusLeft,
      displayName: 'Fibularis Longus — Left',
      group: .legs,
      side: .left,
      aliases: <String>['peroneus longus'],
    ),
    MuscleInfo(
      muscle: .fibularisLongusRight,
      displayName: 'Fibularis Longus — Right',
      group: .legs,
      side: .right,
      aliases: <String>['peroneus longus'],
    ),
    MuscleInfo(
      muscle: .extensorDigitorumLongusLeft,
      displayName: 'Extensor Digitorum Longus — Left',
      group: .legs,
      side: .left,
      aliases: <String>['shin extensor'],
    ),
    MuscleInfo(
      muscle: .extensorDigitorumLongusRight,
      displayName: 'Extensor Digitorum Longus — Right',
      group: .legs,
      side: .right,
      aliases: <String>['shin extensor'],
    ),
    MuscleInfo(
      muscle: .vastusLateralisLeft,
      displayName: 'Vastus Lateralis — Left',
      group: .legs,
      side: .left,
      aliases: <String>['quad', 'quadriceps'],
    ),
    MuscleInfo(
      muscle: .vastusLateralisRight,
      displayName: 'Vastus Lateralis — Right',
      group: .legs,
      side: .right,
      aliases: <String>['quad', 'quadriceps'],
    ),
    MuscleInfo(
      muscle: .vastusMedialisLeft,
      displayName: 'Vastus Medialis — Left',
      group: .legs,
      side: .left,
      aliases: <String>['quad', 'quadriceps'],
    ),
    MuscleInfo(
      muscle: .vastusMedialisRight,
      displayName: 'Vastus Medialis — Right',
      group: .legs,
      side: .right,
      aliases: <String>['quad', 'quadriceps'],
    ),
    MuscleInfo(
      muscle: .sartorisLeft,
      displayName: 'Sartorius — Left',
      group: .legs,
      side: .left,
      aliases: <String>['sartorius'],
    ),
    MuscleInfo(
      muscle: .sartorisRight,
      displayName: 'Sartorius — Right',
      group: .legs,
      side: .right,
      aliases: <String>['sartorius'],
    ),
    MuscleInfo(
      muscle: .gracilisLeft,
      displayName: 'Gracilis — Left',
      group: .legs,
      side: .left,
      aliases: <String>['gracilis', 'inner thigh'],
    ),
    MuscleInfo(
      muscle: .gracilisRight,
      displayName: 'Gracilis — Right',
      group: .legs,
      side: .right,
      aliases: <String>['gracilis', 'inner thigh'],
    ),
    MuscleInfo(
      muscle: .rectusFemorisLeft,
      displayName: 'Rectus Femoris — Left',
      group: .legs,
      side: .left,
      aliases: <String>['quad', 'quadriceps'],
    ),
    MuscleInfo(
      muscle: .rectusFemorisRight,
      displayName: 'Rectus Femoris — Right',
      group: .legs,
      side: .right,
      aliases: <String>['quad', 'quadriceps'],
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
    MuscleInfo(
      muscle: .externalOblique1Left,
      displayName: 'External Oblique (1) — Left',
      group: .core,
      side: BodySide.left,
      aliases: <String>['oblique', 'abs'],
    ),
    MuscleInfo(
      muscle: .externalOblique1Right,
      displayName: 'External Oblique (1) — Right',
      group: .core,
      side: BodySide.right,
      aliases: <String>['oblique', 'abs'],
    ),
    MuscleInfo(
      muscle: .externalOblique2Left,
      displayName: 'External Oblique (2) — Left',
      group: .core,
      side: BodySide.left,
      aliases: <String>['oblique', 'abs'],
    ),
    MuscleInfo(
      muscle: .externalOblique2Right,
      displayName: 'External Oblique (2) — Right',
      group: .core,
      side: BodySide.right,
      aliases: <String>['oblique', 'abs'],
    ),
    MuscleInfo(
      muscle: .externalOblique3Left,
      displayName: 'External Oblique (3) — Left',
      group: .core,
      side: BodySide.left,
      aliases: <String>['oblique', 'abs'],
    ),
    MuscleInfo(
      muscle: .externalOblique3Right,
      displayName: 'External Oblique (3) — Right',
      group: .core,
      side: BodySide.right,
      aliases: <String>['oblique', 'abs'],
    ),
    MuscleInfo(
      muscle: .externalOblique4Left,
      displayName: 'External Oblique (4) — Left',
      group: .core,
      side: BodySide.left,
      aliases: <String>['oblique', 'abs'],
    ),
    MuscleInfo(
      muscle: .externalOblique4Right,
      displayName: 'External Oblique (4) — Right',
      group: .core,
      side: BodySide.right,
      aliases: <String>['oblique', 'abs'],
    ),
    MuscleInfo(
      muscle: .externalOblique5Left,
      displayName: 'External Oblique (5) — Left',
      group: .core,
      side: BodySide.left,
      aliases: <String>['oblique', 'abs'],
    ),
    MuscleInfo(
      muscle: .externalOblique5Right,
      displayName: 'External Oblique (5) — Right',
      group: .core,
      side: BodySide.right,
      aliases: <String>['oblique', 'abs'],
    ),
    MuscleInfo(
      muscle: .externalOblique6Left,
      displayName: 'External Oblique (6) — Left',
      group: .core,
      side: BodySide.left,
      aliases: <String>['oblique', 'abs'],
    ),
    MuscleInfo(
      muscle: .externalOblique6Right,
      displayName: 'External Oblique (6) — Right',
      group: .core,
      side: BodySide.right,
      aliases: <String>['oblique', 'abs'],
    ),
    MuscleInfo(
      muscle: .externalOblique7Left,
      displayName: 'External Oblique (7) — Left',
      group: .core,
      side: BodySide.left,
      aliases: <String>['oblique', 'abs'],
    ),
    MuscleInfo(
      muscle: .externalOblique7Right,
      displayName: 'External Oblique (7) — Right',
      group: .core,
      side: BodySide.right,
      aliases: <String>['oblique', 'abs'],
    ),
    MuscleInfo(
      muscle: .externalOblique8Left,
      displayName: 'External Oblique (8) — Left',
      group: .core,
      side: BodySide.left,
      aliases: <String>['oblique', 'abs'],
    ),
    MuscleInfo(
      muscle: .externalOblique8Right,
      displayName: 'External Oblique (8) — Right',
      group: .core,
      side: BodySide.right,
      aliases: <String>['oblique', 'abs'],
    ),
    MuscleInfo(
      muscle: .rectusAbdominis1,
      displayName: 'Rectus Abdominis (1)',
      group: .core,
      side: BodySide.none,
      aliases: <String>['abs', 'six pack'],
    ),
    MuscleInfo(
      muscle: .rectusAbdominis2Left,
      displayName: 'Rectus Abdominis (2) — Left',
      group: .core,
      side: BodySide.left,
      aliases: <String>['abs', 'six pack'],
    ),
    MuscleInfo(
      muscle: .rectusAbdominis2Right,
      displayName: 'Rectus Abdominis (2) — Right',
      group: .core,
      side: BodySide.right,
      aliases: <String>['abs', 'six pack'],
    ),
    MuscleInfo(
      muscle: .rectusAbdominis3Left,
      displayName: 'Rectus Abdominis (3) — Left',
      group: .core,
      side: BodySide.left,
      aliases: <String>['abs', 'six pack'],
    ),
    MuscleInfo(
      muscle: .rectusAbdominis3Right,
      displayName: 'Rectus Abdominis (3) — Right',
      group: .core,
      side: BodySide.right,
      aliases: <String>['abs', 'six pack'],
    ),
    MuscleInfo(
      muscle: .rectusAbdominis4Left,
      displayName: 'Rectus Abdominis (4) — Left',
      group: .core,
      side: BodySide.left,
      aliases: <String>['abs', 'six pack'],
    ),
    MuscleInfo(
      muscle: .rectusAbdominis4Right,
      displayName: 'Rectus Abdominis (4) — Right',
      group: .core,
      side: BodySide.right,
      aliases: <String>['abs', 'six pack'],
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
    MuscleInfo(
      muscle: .flexorDigitorumSuperficialisLeft,
      displayName: 'Flexor Digitorum Superficialis — Left',
      group: .arms,
      side: .left,
      aliases: <String>['forearm flexor'],
    ),
    MuscleInfo(
      muscle: .flexorDigitorumSuperficialisRight,
      displayName: 'Flexor Digitorum Superficialis — Right',
      group: .arms,
      side: .right,
      aliases: <String>['forearm flexor'],
    ),
    MuscleInfo(
      muscle: .pronatorQuadratusLeft,
      displayName: 'Pronator Quadratus — Left',
      group: .arms,
      side: .left,
      aliases: <String>['forearm pronator'],
    ),
    MuscleInfo(
      muscle: .pronatorQuadratusRight,
      displayName: 'Pronator Quadratus — Right',
      group: .arms,
      side: .right,
      aliases: <String>['forearm pronator'],
    ),
    MuscleInfo(
      muscle: .extensorCarpiRadialisLongusLeft,
      displayName: 'Extensor Carpi Radialis Longus — Left',
      group: .arms,
      side: .left,
      aliases: <String>['forearm extensor'],
    ),
    MuscleInfo(
      muscle: .extensorCarpiRadialisLongusRight,
      displayName: 'Extensor Carpi Radialis Longus — Right',
      group: .arms,
      side: .right,
      aliases: <String>['forearm extensor'],
    ),
    MuscleInfo(
      muscle: .palmarisLongusLeft,
      displayName: 'Palmaris Longus — Left',
      group: .arms,
      side: .left,
      aliases: <String>['forearm flexor'],
    ),
    MuscleInfo(
      muscle: .palmarisLongusRight,
      displayName: 'Palmaris Longus — Right',
      group: .arms,
      side: .right,
      aliases: <String>['forearm flexor'],
    ),
    MuscleInfo(
      muscle: .flexorCarpiRadialisLeft,
      displayName: 'Flexor Carpi Radialis — Left',
      group: .arms,
      side: .left,
      aliases: <String>['forearm flexor'],
    ),
    MuscleInfo(
      muscle: .flexorCarpiRadialisRight,
      displayName: 'Flexor Carpi Radialis — Right',
      group: .arms,
      side: .right,
      aliases: <String>['forearm flexor'],
    ),
    MuscleInfo(
      muscle: .pronatorTeresLeft,
      displayName: 'Pronator Teres — Left',
      group: .arms,
      side: .left,
      aliases: <String>['forearm pronator'],
    ),
    MuscleInfo(
      muscle: .pronatorTeresRight,
      displayName: 'Pronator Teres — Right',
      group: .arms,
      side: .right,
      aliases: <String>['forearm pronator'],
    ),
    MuscleInfo(
      muscle: .bicepsBrachiiCaputBreveLeft,
      displayName: 'Biceps (Short Head) — Left',
      group: .arms,
      side: .left,
      aliases: <String>['biceps'],
    ),
    MuscleInfo(
      muscle: .bicepsBrachiiCaputBreveRight,
      displayName: 'Biceps (Short Head) — Right',
      group: .arms,
      side: .right,
      aliases: <String>['biceps'],
    ),
    MuscleInfo(
      muscle: .bicepsBrachiiCaputLongumLeft,
      displayName: 'Biceps (Short Head) — Left',
      group: .arms,
      side: .left,
      aliases: <String>['biceps'],
    ),
    MuscleInfo(
      muscle: .bicepsBrachiiCaputLongumRight,
      displayName: 'Biceps (Short Head) — Right',
      group: .arms,
      side: .right,
      aliases: <String>['biceps'],
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
    MuscleInfo(
      muscle: .platysma,
      displayName: 'Platysma',
      group: .neck,
      side: .none,
      aliases: <String>['neck'],
    ),
    MuscleInfo(
      muscle: .sternohyoid,
      displayName: 'Sternohyoid',
      group: .neck,
      side: .none,
      aliases: <String>['neck'],
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
    MuscleInfo(
      muscle: .anteriorDeltoidLeft,
      displayName: 'Anterior Deltoid — Left',
      group: .shoulders,
      side: .left,
      aliases: <String>['front delt', 'deltoid'],
    ),
    MuscleInfo(
      muscle: .anteriorDeltoidRight,
      displayName: 'Anterior Deltoid — Right',
      group: .shoulders,
      side: .right,
      aliases: <String>['front delt', 'deltoid'],
    ),
  ];

  static const chest = <MuscleInfo>[
    MuscleInfo(
      muscle: .pectoralisMajorLeft,
      displayName: 'Pectoralis Major — Left',
      group: .chest,
      side: .left,
      aliases: <String>['pecs', 'chest'],
    ),
    MuscleInfo(
      muscle: .pectoralisMajorRight,
      displayName: 'Pectoralis Major — Right',
      group: .chest,
      side: .right,
      aliases: <String>['pecs', 'chest'],
    ),
  ];

  static const adductors = <MuscleInfo>[
    MuscleInfo(
      muscle: .adductorMagnusLeft,
      displayName: 'Adductor Magnus — Left',
      group: .adductors,
      side: .left,
      aliases: <String>[
        'adductor magnus',
        'adductors',
        'inner thigh',
      ],
    ),
    MuscleInfo(
      muscle: .adductorMagnusRight,
      displayName: 'Adductor Magnus — Right',
      group: .adductors,
      side: .right,
      aliases: <String>[
        'adductor magnus',
        'adductors',
        'inner thigh',
      ],
    ),
    MuscleInfo(
      muscle: .adductorLongusLeft,
      displayName: 'Adductor Longus — Left',
      group: .adductors,
      side: .left,
      aliases: <String>[
        'adductor longus',
        'adductors',
        'inner thigh',
      ],
    ),
    MuscleInfo(
      muscle: .adductorLongusRight,
      displayName: 'Adductor Longus — Right',
      group: .adductors,
      side: .right,
      aliases: <String>[
        'adductor longus',
        'adductors',
        'inner thigh',
      ],
    ),
    MuscleInfo(
      muscle: .pectineusLeft,
      displayName: 'Pectineus — Left',
      group: .adductors,
      side: .left,
      aliases: <String>[
        'pectineus',
        'adductors',
        'inner thigh',
      ],
    ),
    MuscleInfo(
      muscle: .pectineusRight,
      displayName: 'Pectineus — Right',
      group: .adductors,
      side: .right,
      aliases: <String>[
        'pectineus',
        'adductors',
        'inner thigh',
      ],
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
    ...chest,
    ...adductors,
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
