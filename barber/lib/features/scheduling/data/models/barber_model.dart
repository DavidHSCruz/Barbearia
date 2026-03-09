import '../../domain/entities/barber_entity.dart';

class BarberModel extends BarberEntity {
  const BarberModel({
    required super.id,
    required super.name,
    required super.specialties,
  });

  factory BarberModel.fromJson(Map<String, dynamic> json) {
    return BarberModel(
      id: json['id'],
      name: json['name'],
      specialties: List<String>.from(json['specialties'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialties': specialties,
    };
  }
}
