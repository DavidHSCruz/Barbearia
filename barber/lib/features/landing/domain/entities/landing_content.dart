import 'package:equatable/equatable.dart';

class ServiceItem extends Equatable {
  final String title;
  final String description;
  final String
  iconPath; // ou IconData se usarmos ícones do Flutter por enquanto

  const ServiceItem({
    required this.title,
    required this.description,
    required this.iconPath,
  });

  @override
  List<Object?> get props => [title, description, iconPath];
}

class BarberInfo extends Equatable {
  final String title;
  final String description;
  final String history;
  final String contactPhone;
  final String contactEmail;
  final String address;

  const BarberInfo({
    required this.title,
    required this.description,
    required this.history,
    required this.contactPhone,
    required this.contactEmail,
    required this.address,
  });

  @override
  List<Object?> get props => [
    title,
    description,
    history,
    contactPhone,
    contactEmail,
    address,
  ];
}
