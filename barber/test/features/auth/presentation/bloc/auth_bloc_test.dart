import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart';
import 'package:barber/core/errors/failures.dart';
import 'package:barber/features/auth/domain/entities/user_entity.dart';
import 'package:barber/features/auth/domain/usecases/login_usecase.dart';
import 'package:barber/features/auth/presentation/bloc/auth_bloc.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  late AuthBloc authBloc;
  late MockLoginUseCase mockLoginUseCase;

  final tUser = const UserEntity(
    id: '1',
    name: 'Test User',
    email: 'test@example.com',
    userType: 'client',
    token: 'token',
  );

  const tEmail = 'test@example.com';
  const tPassword = 'password';
  final tLoginParams = LoginParams(email: tEmail, password: tPassword);

  setUp(() {
    registerFallbackValue(tLoginParams);
    mockLoginUseCase = MockLoginUseCase();
    authBloc = AuthBloc(loginUseCase: mockLoginUseCase);
  });

  tearDown(() {
    authBloc.close();
  });

  test('initial state should be AuthInitial', () {
    expect(authBloc.state, AuthInitial());
  });

  blocTest<AuthBloc, AuthState>(
    'emits [AuthLoading, AuthSuccess] when login is successful',
    build: () {
      when(() => mockLoginUseCase(any())).thenAnswer((_) async => Right(tUser));
      return authBloc;
    },
    act: (bloc) =>
        bloc.add(const AuthLoginRequested(email: tEmail, password: tPassword)),
    expect: () => [AuthLoading(), AuthSuccess(tUser)],
  );

  blocTest<AuthBloc, AuthState>(
    'emits [AuthLoading, AuthFailure] when login fails',
    build: () {
      when(
        () => mockLoginUseCase(any()),
      ).thenAnswer((_) async => Left(ServerFailure('Login failed')));
      return authBloc;
    },
    act: (bloc) =>
        bloc.add(const AuthLoginRequested(email: tEmail, password: tPassword)),
    expect: () => [AuthLoading(), const AuthFailure('Login failed')],
  );
}
