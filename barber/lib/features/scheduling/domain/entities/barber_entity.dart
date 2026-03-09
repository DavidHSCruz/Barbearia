import 'package:equatable/equatable.dart';

class BarberEntity extends Equatable {
  final int id;
  final String name;
  final List<String> specialties;

  const BarberEntity({
    required this.id,
    required this.name,
    required this.specialties,
  });

  @override
  List<Object?> get props => [id, name, specialties];
}
