
import 'package:equatable/equatable.dart';
import 'package:foode/core/use_cases/use_cases.dart';
import 'package:foode/core/utils/typedefs.dart';
import 'package:foode/features/authentication/domain/repository/auth_repository.dart';

class SignIn extends UseCaseWithParams<void, SignInParams> {
  SignIn(this._authRepository);

  final AuthRepository _authRepository;

  @override
  ResultFuture<void> call(SignInParams params) =>
      _authRepository.signIn(email: params.email, password: params.password);
}

class SignInParams extends Equatable {
  const SignInParams({required this.email, required this.password});

  const SignInParams.empty() : this(email: '', password: '');

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
