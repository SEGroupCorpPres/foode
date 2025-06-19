import 'package:bloc/bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationState().init()) {
    on<InitEvent>(_init);
  }

  Future<void> _init(InitEvent event, Emitter<AuthenticationState> emit) async {
    emit(state.clone());
  }
}
