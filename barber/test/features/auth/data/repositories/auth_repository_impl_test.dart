import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:barber/core/errors/failures.dart';
import 'package:barber/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:barber/features/auth/data/models/user_model.dart';
import 'package:barber/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:barber/features/auth/domain/entities/user_entity.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(mockRemoteDataSource);
  });

  const tUserModel = UserModel(
    id: '1',
    name: 'Test User',
    email: 'test@example.com',
    userType: 'client',
    token: 'mock_token',
    phone: '123456789',
    photoUrl: 'http://example.com/photo.jpg',
    bio: 'Test bio',
    specialties: ['Cut'],
  );

  const tUserEntity = tUserModel as UserEntity;

  const tEmail = 'test@example.com';
  const tPassword = 'password';

  group('login', () {
    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(() => mockRemoteDataSource.login(any(), any()))
            .thenAnswer((_) async => tUserModel);
        // act
        final result = await repository.login(tEmail, tPassword);
        // assert
        verify(() => mockRemoteDataSource.login(tEmail, tPassword));
        expect(result, equals(const Right(tUserEntity)));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(() => mockRemoteDataSource.login(any(), any()))
            .thenThrow(DioException(
              requestOptions: RequestOptions(path: ''),
              response: Response(
                requestOptions: RequestOptions(path: ''),
                data: {'message': 'Server Error'},
                statusCode: 500,
              ),
            ));
        // act
        final result = await repository.login(tEmail, tPassword);
        // assert
        verify(() => mockRemoteDataSource.login(tEmail, tPassword));
        expect(result, equals(Left(ServerFailure('Server Error'))));
      },
    );

    test(
      'should return server failure when the call to remote data source throws generic exception',
      () async {
        // arrange
        when(() => mockRemoteDataSource.login(any(), any()))
            .thenThrow(Exception('Generic Error'));
        // act
        final result = await repository.login(tEmail, tPassword);
        // assert
        verify(() => mockRemoteDataSource.login(tEmail, tPassword));
        expect(result, equals(Left(ServerFailure('Exception: Generic Error'))));
      },
    );
  });
}
