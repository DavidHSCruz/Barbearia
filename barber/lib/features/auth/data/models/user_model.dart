import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.userType,
    required super.token,
    super.phone,
    super.photoUrl,
    super.bio,
    super.specialties,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    return UserModel(
      id: user['id'].toString(),
      name: user['name'],
      email: user['email'],
      userType: user['role'],
      token: json['token'],
      phone: user['phone'],
      photoUrl: user['photoUrl'],
      bio: user['bio'],
      specialties: (user['specialties'] as List?)?.map((e) => e.toString()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': {
        'id': id,
        'name': name,
        'email': email,
        'role': userType,
        'phone': phone,
        'photoUrl': photoUrl,
        'bio': bio,
        'specialties': specialties,
      },
    };
  }
}
