import 'package:get_it/get_it.dart';
import '../../features/appointments/data/datasources/appointments_remote_data_source.dart';
import '../../features/appointments/data/repositories/appointments_repository_impl.dart';
import '../../features/appointments/domain/repositories/appointments_repository.dart';
import '../../features/appointments/domain/usecases/get_barber_appointments_usecase.dart';
import '../../features/appointments/domain/usecases/get_client_appointments_usecase.dart';
import '../../features/appointments/presentation/bloc/appointments_bloc.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/landing/presentation/bloc/landing_bloc.dart';
import '../../features/scheduling/data/datasources/scheduling_remote_data_source.dart';
import '../../features/scheduling/data/repositories/scheduling_repository_impl.dart';
import '../../features/scheduling/domain/repositories/scheduling_repository.dart';
import '../../features/scheduling/domain/usecases/get_barbers_usecase.dart';
import '../../features/scheduling/domain/usecases/get_services_usecase.dart';
import '../../features/scheduling/presentation/bloc/scheduling_bloc.dart';
import '../network/api_client.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => AuthBloc(loginUseCase: sl()));
  sl.registerFactory(() => LandingBloc(getServicesUseCase: sl()));
  sl.registerFactory(
    () => SchedulingBloc(getServicesUseCase: sl(), getBarbersUseCase: sl()),
  );
  sl.registerFactory(
    () => AppointmentsBloc(
      getClientAppointmentsUseCase: sl(),
      getBarberAppointmentsUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => GetServicesUseCase(sl()));
  sl.registerLazySingleton(() => GetBarbersUseCase(sl()));
  sl.registerLazySingleton(() => GetClientAppointmentsUseCase(sl()));
  sl.registerLazySingleton(() => GetBarberAppointmentsUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<SchedulingRepository>(
    () => SchedulingRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<AppointmentsRepository>(
    () => AppointmentsRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<SchedulingRemoteDataSource>(
    () => SchedulingRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AppointmentsRemoteDataSource>(
    () => AppointmentsRemoteDataSourceImpl(sl()),
  );

  // Core
  sl.registerLazySingleton(() => ApiClient());
}
