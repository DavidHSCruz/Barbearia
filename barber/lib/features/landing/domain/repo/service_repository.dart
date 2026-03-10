import 'package:barber/core/types/typedefs.dart';
import 'package:barber/features/landing/domain/entities/landing_content.dart';

abstract interface class ServiceRepository {
  ResultFuture<List<ServiceItem>> getBarberServices(ServiceItem serviceItem);
}
