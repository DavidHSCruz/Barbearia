import 'package:equatable/equatable.dart';

class AppointmentEntity extends Equatable {
  final int id;
  final String serviceName;
  final String status;
  final DateTime? date;
  final String? timeLabel;
  final String? clientName;
  final String? barberName;
  final double? price;

  const AppointmentEntity({
    required this.id,
    required this.serviceName,
    required this.status,
    this.date,
    this.timeLabel,
    this.clientName,
    this.barberName,
    this.price,
  });

  @override
  List<Object?> get props => [
        id,
        serviceName,
        status,
        date,
        timeLabel,
        clientName,
        barberName,
        price,
      ];
}
