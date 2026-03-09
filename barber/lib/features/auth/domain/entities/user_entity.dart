import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String userType; // 'client' or 'barber'
  final String token;
  final String? phone;
  final String? photoUrl;
  final String? bio;
  final List<String>? specialties;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.userType,
    required this.token,
    this.phone,
    this.photoUrl,
    this.bio,
    this.specialties,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        userType,
        token,
        phone,
        photoUrl,
        bio,
        specialties,
      ];
}
