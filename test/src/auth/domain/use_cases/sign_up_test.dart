import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foode/features/authentication/domain/entity/user.dart';
import 'package:foode/features/authentication/domain/use_cases/sign_up.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late SignUp useCase;
  const tEmail = 'Test Email';
  const tPassword = 'Test password';
  const tFullName = 'Test full name';

  const tUser = LocalUser.empty();

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = SignUp(mockAuthRepository);
  });

  test('should call the [AuthRepo.signUp]', () async {
    when(
      () => mockAuthRepository.signUp(
        email: any(named: 'email'),
        fullName: any(named: 'fullName'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => const Right(tUser));
    final result = await useCase(
      const SignUpParams(
        email: tEmail,
        fullName: tFullName,
        password: tPassword,
      ),
    );
    expect(result, const Right<dynamic, LocalUser>(tUser));
    verify(
      () => mockAuthRepository.signUp(
        email: tEmail,
        fullName: tFullName,
        password: tPassword,
      ),
    ).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
