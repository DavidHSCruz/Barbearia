import 'package:flutter_test/flutter_test.dart';
import 'package:barber/features/auth/data/models/user_model.dart';
import 'package:barber/features/auth/domain/entities/user_entity.dart';

void main() {
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

  test('should be a subclass of UserEntity', () async {
    expect(tUserModel, isA<UserEntity>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is valid', () async {
      final Map<String, dynamic> jsonMap = {
        'token': 'mock_token',
        'user': {
          'id': '1',
          'name': 'Test User',
          'email': 'test@example.com',
          'role': 'client',
          'phone': '123456789',
          'photoUrl': 'http://example.com/photo.jpg',
          'bio': 'Test bio',
          'specialties': ['Cut'],
        },
      };

      final result = UserModel.fromJson(jsonMap);
      expect(result, tUserModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      final result = tUserModel.toJson();
      final expectedMap = {
        'token': 'mock_token',
        'user': {
          'id': '1',
          'name': 'Test User',
          'email': 'test@example.com',
          'role': 'client',
          'phone': '123456789',
          'photoUrl': 'http://example.com/photo.jpg',
          'bio': 'Test bio',
          'specialties': ['Cut'],
        },
      };
      expect(result, expectedMap);
    });
  });
}
