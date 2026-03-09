import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:barber/core/network/api_client.dart';
import 'package:barber/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:barber/features/auth/data/models/user_model.dart';

class MockApiClient extends Mock implements ApiClient {}
class MockDio extends Mock implements Dio {}
class MockResponse<T> extends Mock implements Response<T> {}

void main() {
  late AuthRemoteDataSourceImpl dataSource;
  late MockApiClient mockApiClient;
  late MockDio mockDio;

  setUp(() {
    mockApiClient = MockApiClient();
    mockDio = MockDio();
    when(() => mockApiClient.dio).thenReturn(mockDio);
    dataSource = AuthRemoteDataSourceImpl(mockApiClient);
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password';
  final tUserModel = UserModel(
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

  group('login', () {
    test(
      'should perform a POST request on a URL with email and password endpoint and with application/json header',
      () async {
        // arrange
        final responsePayload = {
          'token': 'mock_token',
          'user': {
            'id': '1',
            'name': 'Test User',
            'email': 'test@example.com',
            'role': 'client',
            'phone': '123456789',
            'photoUrl': 'http://example.com/photo.jpg',
            'bio': 'Test bio',
            'specialties': ['Cut']
          }
        };

        when(() => mockDio.post(
              any(),
              data: any(named: 'data'),
            )).thenAnswer((_) async => Response(
              data: responsePayload,
              statusCode: 200,
              requestOptions: RequestOptions(path: '/auth/login'),
            ));

        // act
        final result = await dataSource.login(tEmail, tPassword);

        // assert
        verify(() => mockDio.post(
              '/auth/login',
              data: {'email': tEmail, 'password': tPassword},
            ));
        expect(result, equals(tUserModel));
      },
    );

    test(
      'should throw a DioException when the response code is 404 or other',
      () async {
        // arrange
        when(() => mockDio.post(
              any(),
              data: any(named: 'data'),
            )).thenAnswer((_) async => Response(
              data: 'Something went wrong',
              statusCode: 404,
              requestOptions: RequestOptions(path: '/auth/login'),
            ));

        // act
        final call = dataSource.login;

        // assert
        expect(() => call(tEmail, tPassword), throwsA(isA<DioException>()));
      },
    );
  });
}
