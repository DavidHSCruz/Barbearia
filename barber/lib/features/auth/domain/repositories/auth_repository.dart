import '../../../../core/types/typedefs.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  ResultFuture<UserEntity> login(String email, String password);
}
