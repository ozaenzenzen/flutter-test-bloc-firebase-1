import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_bloc_1/data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthUnauthenticated()) {
    on<SignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.signIn(
          email: event.email,
          password: event.password,
        );
        emit(AuthAuthenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(AuthUnauthenticated());
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.signUp(
          email: event.email,
          password: event.password,
        );
        emit(AuthAuthenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(AuthUnauthenticated());
      }
    });

    on<GoogleSignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.signInWithGoogle();
        emit(AuthAuthenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(AuthUnauthenticated());
      }
    });

    on<SignOutRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.signOut();
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(AuthUnauthenticated());
      }
    });
  }
}
