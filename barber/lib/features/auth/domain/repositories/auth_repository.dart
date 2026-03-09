import '../../../../core/types/typedefs.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  FutureEither<UserEntity> login(String email, String password);
}
