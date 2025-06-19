
import 'package:equatable/equatable.dart';
import 'package:foode/core/use_cases/use_cases.dart';
import 'package:foode/core/utils/typedefs.dart';
import 'package:foode/features/authentication/domain/repository/auth_repository.dart';

class SignUp extends UseCaseWithParams<void, SignUpParams> {
  SignUp(this._authRepository);

  final AuthRepository _authRepository;

  @override
  ResultFuture<void> call(SignUpParams params) => _authRepository.signUp(
    email: params.email,
    password: params.password,
    fullName: params.fullName,
  );
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.email,
    required this.password,
    required this.fullName,
  });

  const SignUpParams.empty() : this(email: '', password: '', fullName: '');
  final String email;
  final String password;
  final String fullName;

  @override
  List<Object?> get props => [email, password, fullName];
}
