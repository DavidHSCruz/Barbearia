import 'package:fpdart/fpdart.dart';
import '../errors/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultNow<T> = Either<Failure, T>;

typedef ResultVoid = Future<Either<Failure, void>>;

typedef DataMap = Map<String, dynamic>;
