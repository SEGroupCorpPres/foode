
import 'package:equatable/equatable.dart';
import 'package:foode/core/enums/update_user.dart';
import 'package:foode/core/use_cases/use_cases.dart';
import 'package:foode/core/utils/typedefs.dart';
import 'package:foode/features/authentication/domain/repository/auth_repository.dart';

class UpdateUser extends UseCaseWithParams<void, UpdateUserParams> {
  UpdateUser(this._authRepository);

  final AuthRepository _authRepository;

  @override
  ResultFuture<void> call(UpdateUserParams params) => _authRepository
      .updateUser(action: params.action, userdata: params.userData);
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({required this.action, required this.userData});

  const UpdateUserParams.empty()
    : this(action: UpdateUserAction.displayName, userData: '');

  final UpdateUserAction action;
  final dynamic userData;

  @override
  List<Object?> get props => [action, userData];
}
