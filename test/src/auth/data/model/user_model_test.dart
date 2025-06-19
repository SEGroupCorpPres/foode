import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:foode/core/utils/typedefs.dart';
import 'package:foode/features/authentication/data/model/user_model.dart';
import 'package:foode/features/authentication/domain/entity/user.dart';

import '../../../../fixtures/fixtures_reader.dart';

void main() {
  const tLocalUserModel = LocalUserModel.empty();

  test(
    'should be a subclass of [LocalUser] entity',
    () => expect(tLocalUserModel, isA<LocalUser>()),
  );
  final tMap = jsonDecode(fixture('user.json')) as DataMap;
  group('fromMap', () {
    test('should return a valid model [LocalUserModel] from the map', () {
      // act
      final result = LocalUserModel.fromMap(tMap);
      // assert
      expect(result, isA<LocalUserModel>());
      expect(result, tLocalUserModel);
    });
    test('should throws an [Error] when the map is invalid', () {
      final map = DataMap.from(tMap)..remove('uid');
      const call = LocalUserModel.fromMap;
      expect(() => call(map), throwsA(isA<Error>()));
    });
  });
  group('toMap', () {
    test('should return a valid [DataMap] from the model', () {
      // act
      final result = tLocalUserModel.toMap();
      // assert
      expect(result, isA<DataMap>());
      expect(result, tMap);
    });
  });

  group('copyWith', () {
    test('should return a valid  [LocalUserModel] with update values', () {
      final result = tLocalUserModel.copyWith(uid: '2');
      expect(result.uid, '2');
    });
  });
}
