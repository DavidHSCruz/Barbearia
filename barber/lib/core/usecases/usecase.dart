import '../types/typedefs.dart';

abstract class UseCase<T, Params> {
  FutureEither<T> call(Params params);
}

class NoParams {}
