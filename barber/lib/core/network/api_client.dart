import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'dart:convert';

class ApiClient {
  final Dio dio;
  late final DioAdapter dioAdapter;

  ApiClient({Dio? dioInstance}) : dio = dioInstance ?? Dio() {
    dio.options.baseUrl = 'https://api.barbeariaclassica.com';
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 3);

    // Configurar o MockAdapter
    dioAdapter = DioAdapter(dio: dio);

    // Interceptor para auxiliar no Mock (diferenciar login por email)
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Normalizar o path para verificação
          final path = options.path;
          if (path.contains('/auth/login') && options.data != null) {
            String? email;
            try {
              if (options.data is Map) {
                email = options.data['email'];
              } else if (options.data is String) {
                final map = jsonDecode(options.data);
                email = map['email'];
              }
            } catch (e) {
              debugPrint('Error parsing login data: $e');
            }

            if (email != null) {
              if (email == 'barbeiro@email.com') {
                options.headers['x-mock-role'] = 'barber';
                debugPrint('Role detected: barber');
              } else if (email == 'cliente@email.com') {
                options.headers['x-mock-role'] = 'client';
                debugPrint('Role detected: client');
              }
            }
          }
          return handler.next(options);
        },
      ),
    );

    _setupMocks();
  }

  void _setupMocks() {
    // Mock Login Failure (Default - Definido primeiro para ser sobrescrito pelos específicos - LIFO check means this must be added FIRST if we want it checked LAST? Wait.
    // HttpMockAdapter documentation says: "The last defined adapter is the one that is used."
    // So if we define Generic LAST, it overrides everything.
    // So we must define Generic FIRST, so it is overridden by Specifics defined LATER.

    dioAdapter.onPost(
      '/auth/login',
      (server) => server.reply(401, {
        'message': 'Credenciais inválidas ou usuário não encontrado',
      }, delay: const Duration(seconds: 1)),
      data: Matchers.any,
    );

    // Mock Login Cliente
    dioAdapter.onPost(
      '/auth/login',
      (server) => server.reply(200, {
        'token': 'fake_jwt_token',
        'user': {
          'id': 1,
          'name': 'Cliente Exemplo',
          'email': 'cliente@email.com',
          'role': 'client',
          'phone': '(11) 99999-9999',
          'photoUrl': null,
        },
      }, delay: const Duration(seconds: 1)),
      data: Matchers.any,
      headers: {'x-mock-role': 'client'},
    );

    // Mock Login Barbeiro
    dioAdapter.onPost(
      '/auth/login',
      (server) => server.reply(200, {
        'token': 'fake_jwt_token_barber',
        'user': {
          'id': 2,
          'name': 'Barbeiro Exemplo',
          'email': 'barbeiro@email.com',
          'role': 'barber',
          'phone': '(11) 98888-8888',
          'photoUrl': null,
          'bio': 'Barbeiro com 10 anos de experiência.',
          'specialties': ['Corte Clássico', 'Barba', 'Degradê'],
        },
      }, delay: const Duration(seconds: 1)),
      data: Matchers.any,
      headers: {'x-mock-role': 'barber'},
    );

    // Mock Agendamentos do Cliente
    dioAdapter.onGet(
      '/appointments',
      (server) => server.reply(200, [
        {
          'id': 101,
          'service': 'Corte Clássico',
          'barber': 'João Barbeiro',
          'date': '2024-03-20T14:00:00Z',
          'status': 'confirmed',
          'price': 50.0,
        },
        {
          'id': 102,
          'service': 'Barba',
          'barber': 'Pedro Santos',
          'date': '2024-03-25T16:00:00Z',
          'status': 'pending',
          'price': 30.0,
        },
      ], delay: const Duration(seconds: 1)),
    );

    // Mock Serviços Disponíveis
    dioAdapter.onGet(
      '/services',
      (server) => server.reply(200, [
        {
          'id': 1,
          'name': 'Corte Clássico',
          'price': 50.0,
          'duration': 45,
          'description': 'Tesoura e máquina com acabamento impecável.',
        },
        {
          'id': 2,
          'name': 'Barba Tradicional',
          'price': 30.0,
          'duration': 30,
          'description': 'Toalha quente e navalha para um barbear perfeito.',
        },
        {
          'id': 3,
          'name': 'Pacote Completo',
          'price': 75.0,
          'duration': 60,
          'description': 'Corte de cabelo e barba com massagem capilar.',
        },
        {
          'id': 4,
          'name': 'Pezinho',
          'price': 15.0,
          'duration': 15,
          'description': 'Acabamento nas laterais e nuca.',
        },
      ], delay: const Duration(milliseconds: 500)),
    );

    // Mock Barbeiros Disponíveis
    dioAdapter.onGet(
      '/barbers',
      (server) => server.reply(200, [
        {
          'id': 1,
          'name': 'João Silva',
          'specialties': ['Corte', 'Barba'],
        },
        {
          'id': 2,
          'name': 'Pedro Santos',
          'specialties': ['Barba', 'Coloração'],
        },
        {
          'id': 3,
          'name': 'Carlos Oliveira',
          'specialties': ['Corte Clássico'],
        },
      ], delay: const Duration(milliseconds: 500)),
    );

    // Mock Agendamentos do Barbeiro
    dioAdapter.onGet(
      '/barber/appointments',
      (server) => server.reply(200, [
        {
          'id': 201,
          'clientName': 'João Silva',
          'service': 'Corte de Cabelo',
          'time': '14:00',
          'status': 'confirmed',
        },
        {
          'id': 202,
          'clientName': 'Pedro Santos',
          'service': 'Barba',
          'time': '15:30',
          'status': 'pending',
        },
        {
          'id': 203,
          'clientName': 'Lucas Oliveira',
          'service': 'Completo',
          'time': '16:45',
          'status': 'cancelled',
        },
      ], delay: const Duration(seconds: 1)),
    );
  }
}
