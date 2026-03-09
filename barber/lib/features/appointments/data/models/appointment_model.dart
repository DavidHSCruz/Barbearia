import '../../domain/entities/appointment_entity.dart';

class AppointmentModel extends AppointmentEntity {
  const AppointmentModel({
    required super.id,
    required super.serviceName,
    required super.status,
    super.date,
    super.timeLabel,
    super.clientName,
    super.barberName,
    super.price,
  });

  factory AppointmentModel.fromJsonClient(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'],
      serviceName: json['service'],
      status: json['status'],
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      barberName: json['barber'],
      price: (json['price'] as num?)?.toDouble(),
    );
  }

  factory AppointmentModel.fromJsonBarber(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'],
      serviceName: json['service'],
      status: json['status'],
      timeLabel: json['time'],
      clientName: json['clientName'],
    );
  }
}
