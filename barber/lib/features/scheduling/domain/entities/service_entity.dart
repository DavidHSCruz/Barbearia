import 'package:equatable/equatable.dart';

class ServiceEntity extends Equatable {
  final int id;
  final String name;
  final double price;
  final int duration;
  final String description;

  const ServiceEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.duration,
    required this.description,
  });

  @override
  List<Object?> get props => [id, name, price, duration, description];
}
