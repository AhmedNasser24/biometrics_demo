import '../../domain/repositories/auth_repository.dart';
import '../datasources/local_auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final LocalAuthService _localAuthService;

  AuthRepositoryImpl(this._localAuthService);

  @override
  Future<bool> authenticate() async {
    return await _localAuthService.authenticate();
  }

  @override
  Future<bool> isDeviceSupported() async {
    return await _localAuthService.isDeviceSupported();
  }
}
