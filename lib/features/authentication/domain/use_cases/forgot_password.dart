import 'package:foode/core/use_cases/use_cases.dart';
import 'package:foode/core/utils/typedefs.dart';
import 'package:foode/features/authentication/domain/repository/auth_repository.dart';

class ForgotPassword extends UseCaseWithParams<void, String> {
  ForgotPassword(this._authRepository);

  final AuthRepository _authRepository;

  @override
  ResultFuture<void> call(String params) =>
      _authRepository.forgotPassword(email:  params);
}
