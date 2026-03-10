import 'package:barber/core/types/typedefs.dart';
import 'package:barber/features/landing/domain/entities/landing_content.dart';
import 'package:barber/features/landing/domain/repo/service_repository.dart';

class GetBarberServices {
  final ServiceRepository _repository;

  GetBarberServices(this._repository);

  ResultFuture<List<ServiceItem>> call(ServiceItem serviceItem) async {
    return _repository.getBarberServices(serviceItem);
  }
}
