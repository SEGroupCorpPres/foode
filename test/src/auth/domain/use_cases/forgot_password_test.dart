import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foode/features/authentication/domain/use_cases/forgot_password.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repository.mock.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late ForgotPassword useCase;
  const tEmail = 'test email';
  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = ForgotPassword(mockAuthRepository);
  });
  test('should call [AuthRepository.forgotPassword] when successful', () async {
    // arrange
    when(
      () => mockAuthRepository.forgotPassword(email: any(named: 'email')),
    ).thenAnswer((_) async => const Right(null));
    final result = await useCase(tEmail);
    expect(result, const Right<dynamic, dynamic>(null));
    verify(() => mockAuthRepository.forgotPassword(email: tEmail)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
