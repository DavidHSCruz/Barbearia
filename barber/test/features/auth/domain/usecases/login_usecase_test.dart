import 'package:fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:barber/features/auth/domain/entities/user_entity.dart';
import 'package:barber/features/auth/domain/repositories/auth_repository.dart';
import 'package:barber/features/auth/domain/usecases/login_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginUseCase usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = LoginUseCase(mockAuthRepository);
  });

  const tUser = UserEntity(
    id: '1',
    name: 'Test User',
    email: 'test@example.com',
    userType: 'client',
    token: 'mock_token',
  );

  const tEmail = 'test@example.com';
  const tPassword = 'password';

  test('should get user from the repository', () async {
    // arrange
    when(
      () => mockAuthRepository.login(any(), any()),
    ).thenAnswer((_) async => const Right(tUser));

    // act
    final result = await usecase(
      const LoginParams(email: tEmail, password: tPassword),
    );

    // assert
    expect(result, const Right(tUser));
    verify(() => mockAuthRepository.login(tEmail, tPassword));
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
