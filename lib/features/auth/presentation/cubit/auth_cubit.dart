import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial());
  bool isFirst = true;
  Future<void> checkBiometrics() async {
    if (isFirst) {
      await Future.delayed(const Duration(seconds: 2));
      isFirst = false;
    }
    emit(AuthLoading());
    try {
      final isSupported = await _authRepository.isDeviceSupported();
      if (!isSupported) {
        emit(const AuthError('Biometrics not supported on this device'));
        return;
      }
      authenticate();
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> authenticate() async {
    emit(AuthLoading());
    try {
      final authenticated = await _authRepository.authenticate();
      if (authenticated) {
        emit(AuthAuthenticated());
      } else {
        emit(const AuthUnauthenticated('Authentication failed or cancelled'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
