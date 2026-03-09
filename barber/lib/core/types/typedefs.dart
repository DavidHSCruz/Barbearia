import 'package:fpdart/fpdart.dart';
import '../errors/failures.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
