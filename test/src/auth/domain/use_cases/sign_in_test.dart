import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foode/features/authentication/domain/entity/user.dart';
import 'package:foode/features/authentication/domain/use_cases/sign_in.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late SignIn useCase;
  const tEmail = 'Test email';
  const tPassword = 'Test password';
  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = SignIn(mockAuthRepository);
  });

  const tUser = LocalUser.empty();

  test('should return [LocalUser] from [AuthRepository]', () async {
    when(
      () => mockAuthRepository.signIn(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => const Right(tUser));
    final result = await useCase(
      const SignInParams(email: tEmail, password: tPassword),
    );
    expect(result, const Right<void, LocalUser>(tUser));
    verify(
      () => mockAuthRepository.signIn(email: tEmail, password: tPassword),
    ).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
