import 'package:barber/core/errors/failures.dart';
import 'package:barber/features/landing/data/models/service_Item_model.dart';
import 'package:barber/features/landing/domain/entities/landing_content.dart';
import 'package:barber/features/landing/domain/repo/service_repository.dart';
import 'package:barber/features/landing/domain/useCases/get_barber_services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockServiceRepository extends Mock implements ServiceRepository {}

void main() {
  late ServiceRepository ServiceRepository;
  late GetBarberServices getBarberServices;

  setUp(() {
    ServiceRepository = MockServiceRepository();
    getBarberServices = GetBarberServices(ServiceRepository);

    registerFallbackValue(ServiceItemModel.empty());
  });

  group('GetBarberServices', () {
    test('success', () async {
      when(
        () => ServiceRepository.getBarberServices(any()),
      ).thenAnswer((_) async => Right([ServiceItemModel.empty()]));

      final result = await getBarberServices(ServiceItemModel.empty());

      expect(result, isA<Right>());
    });

    test('fail', () async {
      when(
        () => ServiceRepository.getBarberServices(any()),
      ).thenAnswer((_) async => Left(ServerFailure()));

      final result = await getBarberServices(ServiceItemModel.empty());

      expect(result, isA<Left>());
    });
  });
}
