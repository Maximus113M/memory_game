// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserSettingsModelCollection on Isar {
  IsarCollection<UserSettingsModel> get userSettingsModels => this.collection();
}

const UserSettingsModelSchema = CollectionSchema(
  name: r'UserSettingsModel',
  id: 1840420974923084997,
  properties: {
    r'gameMode': PropertySchema(
      id: 0,
      name: r'gameMode',
      type: IsarType.byte,
      enumMap: _UserSettingsModelgameModeEnumValueMap,
    ),
    r'isCloudEnabled': PropertySchema(
      id: 1,
      name: r'isCloudEnabled',
      type: IsarType.bool,
    ),
    r'isCloudNotificationEnabled': PropertySchema(
      id: 2,
      name: r'isCloudNotificationEnabled',
      type: IsarType.bool,
    ),
    r'isGameSoundsEnabled': PropertySchema(
      id: 3,
      name: r'isGameSoundsEnabled',
      type: IsarType.bool,
    ),
    r'isInGameMusicEnabled': PropertySchema(
      id: 4,
      name: r'isInGameMusicEnabled',
      type: IsarType.bool,
    ),
    r'memorizingTime': PropertySchema(
      id: 5,
      name: r'memorizingTime',
      type: IsarType.long,
    ),
    r'userId': PropertySchema(
      id: 6,
      name: r'userId',
      type: IsarType.string,
    )
  },
  estimateSize: _userSettingsModelEstimateSize,
  serialize: _userSettingsModelSerialize,
  deserialize: _userSettingsModelDeserialize,
  deserializeProp: _userSettingsModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _userSettingsModelGetId,
  getLinks: _userSettingsModelGetLinks,
  attach: _userSettingsModelAttach,
  version: '3.1.0+1',
);

int _userSettingsModelEstimateSize(
  UserSettingsModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.userId.length * 3;
  return bytesCount;
}

void _userSettingsModelSerialize(
  UserSettingsModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.gameMode.index);
  writer.writeBool(offsets[1], object.isCloudEnabled);
  writer.writeBool(offsets[2], object.isCloudNotificationEnabled);
  writer.writeBool(offsets[3], object.isGameSoundsEnabled);
  writer.writeBool(offsets[4], object.isInGameMusicEnabled);
  writer.writeLong(offsets[5], object.memorizingTime);
  writer.writeString(offsets[6], object.userId);
}

UserSettingsModel _userSettingsModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserSettingsModel(
    gameMode: _UserSettingsModelgameModeValueEnumMap[
            reader.readByteOrNull(offsets[0])] ??
        GameDifficulty.easy,
    isCloudEnabled: reader.readBoolOrNull(offsets[1]) ?? false,
    isCloudNotificationEnabled: reader.readBoolOrNull(offsets[2]) ?? true,
    isGameSoundsEnabled: reader.readBoolOrNull(offsets[3]) ?? true,
    isInGameMusicEnabled: reader.readBoolOrNull(offsets[4]) ?? true,
    memorizingTime: reader.readLongOrNull(offsets[5]) ?? 5,
    userId: reader.readString(offsets[6]),
  );
  object.id = id;
  return object;
}

P _userSettingsModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_UserSettingsModelgameModeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          GameDifficulty.easy) as P;
    case 1:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 2:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 3:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 4:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 5:
      return (reader.readLongOrNull(offset) ?? 5) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _UserSettingsModelgameModeEnumValueMap = {
  'easy': 0,
  'medium': 1,
  'hard': 2,
};
const _UserSettingsModelgameModeValueEnumMap = {
  0: GameDifficulty.easy,
  1: GameDifficulty.medium,
  2: GameDifficulty.hard,
};

Id _userSettingsModelGetId(UserSettingsModel object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _userSettingsModelGetLinks(
    UserSettingsModel object) {
  return [];
}

void _userSettingsModelAttach(
    IsarCollection<dynamic> col, Id id, UserSettingsModel object) {
  object.id = id;
}

extension UserSettingsModelQueryWhereSort
    on QueryBuilder<UserSettingsModel, UserSettingsModel, QWhere> {
  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension UserSettingsModelQueryWhere
    on QueryBuilder<UserSettingsModel, UserSettingsModel, QWhereClause> {
  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserSettingsModelQueryFilter
    on QueryBuilder<UserSettingsModel, UserSettingsModel, QFilterCondition> {
  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterFilterCondition>
      gameModeEqualTo(GameDifficulty value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gameMode',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterFilterCondition>
      gameModeGreaterThan(
    GameDifficulty value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gameMode',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterFilterCondition>
      gameModeLessThan(
    GameDifficulty value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gameMode',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterFilterCondition>
      gameModeBetween(
    GameDifficulty lower,
    GameDifficulty upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gameMode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterFilterCondition>
      idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterFilterCondition>
      idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterFilterCondition>
      idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterFilterCondition>
      idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterFilterCondition>
      isCloudEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCloudEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterFilterCondition>
      isCloudNotificationEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCloudNotificationEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterFilterCondition>
      isGameSoundsEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isGameSoundsEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterFilterCondition>
      isInGameMusicEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isInGameMusicEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterFilterCondition>
      memorizingTimeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memorizingTime',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterFilterCondition>
      memorizingTimeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'memorizingTime',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterFilterCondition>
      memorizingTimeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'memorizingTime',
        value: value,
      ));
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterFilterCondition>
      memorizingTimeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'memorizingTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterFilterCondition>
      userIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterFilterCondition>
      userIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterFilterCondition>
      userIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterFilterCondition>
      userIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterFilterCondition>
      userIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterFilterCondition>
      userIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterFilterCondition>
      userIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterFilterCondition>
      userIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterFilterCondition>
      userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: '',
      ));
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterFilterCondition>
      userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userId',
        value: '',
      ));
    });
  }
}

extension UserSettingsModelQueryObject
    on QueryBuilder<UserSettingsModel, UserSettingsModel, QFilterCondition> {}

extension UserSettingsModelQueryLinks
    on QueryBuilder<UserSettingsModel, UserSettingsModel, QFilterCondition> {}

extension UserSettingsModelQuerySortBy
    on QueryBuilder<UserSettingsModel, UserSettingsModel, QSortBy> {
  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      sortByGameMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gameMode', Sort.asc);
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      sortByGameModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gameMode', Sort.desc);
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      sortByIsCloudEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCloudEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      sortByIsCloudEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCloudEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      sortByIsCloudNotificationEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCloudNotificationEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      sortByIsCloudNotificationEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCloudNotificationEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      sortByIsGameSoundsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGameSoundsEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      sortByIsGameSoundsEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGameSoundsEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      sortByIsInGameMusicEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isInGameMusicEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      sortByIsInGameMusicEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isInGameMusicEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      sortByMemorizingTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memorizingTime', Sort.asc);
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      sortByMemorizingTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memorizingTime', Sort.desc);
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension UserSettingsModelQuerySortThenBy
    on QueryBuilder<UserSettingsModel, UserSettingsModel, QSortThenBy> {
  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      thenByGameMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gameMode', Sort.asc);
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      thenByGameModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gameMode', Sort.desc);
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      thenByIsCloudEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCloudEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      thenByIsCloudEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCloudEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      thenByIsCloudNotificationEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCloudNotificationEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      thenByIsCloudNotificationEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCloudNotificationEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      thenByIsGameSoundsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGameSoundsEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      thenByIsGameSoundsEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isGameSoundsEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      thenByIsInGameMusicEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isInGameMusicEnabled', Sort.asc);
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      thenByIsInGameMusicEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isInGameMusicEnabled', Sort.desc);
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      thenByMemorizingTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memorizingTime', Sort.asc);
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      thenByMemorizingTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memorizingTime', Sort.desc);
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QAfterSortBy>
      thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension UserSettingsModelQueryWhereDistinct
    on QueryBuilder<UserSettingsModel, UserSettingsModel, QDistinct> {
  QueryBuilder<UserSettingsModel, UserSettingsModel, QDistinct>
      distinctByGameMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gameMode');
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QDistinct>
      distinctByIsCloudEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCloudEnabled');
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QDistinct>
      distinctByIsCloudNotificationEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCloudNotificationEnabled');
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QDistinct>
      distinctByIsGameSoundsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isGameSoundsEnabled');
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QDistinct>
      distinctByIsInGameMusicEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isInGameMusicEnabled');
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QDistinct>
      distinctByMemorizingTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'memorizingTime');
    });
  }

  QueryBuilder<UserSettingsModel, UserSettingsModel, QDistinct>
      distinctByUserId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId', caseSensitive: caseSensitive);
    });
  }
}

extension UserSettingsModelQueryProperty
    on QueryBuilder<UserSettingsModel, UserSettingsModel, QQueryProperty> {
  QueryBuilder<UserSettingsModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserSettingsModel, GameDifficulty, QQueryOperations>
      gameModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gameMode');
    });
  }

  QueryBuilder<UserSettingsModel, bool, QQueryOperations>
      isCloudEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCloudEnabled');
    });
  }

  QueryBuilder<UserSettingsModel, bool, QQueryOperations>
      isCloudNotificationEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCloudNotificationEnabled');
    });
  }

  QueryBuilder<UserSettingsModel, bool, QQueryOperations>
      isGameSoundsEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isGameSoundsEnabled');
    });
  }

  QueryBuilder<UserSettingsModel, bool, QQueryOperations>
      isInGameMusicEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isInGameMusicEnabled');
    });
  }

  QueryBuilder<UserSettingsModel, int, QQueryOperations>
      memorizingTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'memorizingTime');
    });
  }

  QueryBuilder<UserSettingsModel, String, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
