import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foode/core/enums/update_user.dart';
import 'package:foode/core/errors/failures.dart';
import 'package:foode/features/authentication/domain/use_cases/update_user.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late UpdateUser useCase;
  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = UpdateUser(mockAuthRepository);
    registerFallbackValue(UpdateUserAction.displayName);
  });

  const tUpdateUserParams = UpdateUserParams(
    action: UpdateUserAction.displayName,
    userData: 'testUserData',
  );
  test('should update user when provided valid params', () async {
    when(
      () => mockAuthRepository.updateUser(
        action: tUpdateUserParams.action,
        userdata: tUpdateUserParams.userData,
      ),
    ).thenAnswer((_) async => const Right<Failure, void>(null));
    final result = await useCase(tUpdateUserParams);
    expect(result, const Right<Failure, void>(null));
    verify(
      () => mockAuthRepository.updateUser(
        action: tUpdateUserParams.action,
        userdata: tUpdateUserParams.userData,
      ),
    ).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
