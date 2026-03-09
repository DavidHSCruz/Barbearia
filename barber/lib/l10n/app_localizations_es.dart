// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Barbería Clásica';

  @override
  String get sinceYear => 'Desde 2024';

  @override
  String get bookCut => 'Agenda tu corte';

  @override
  String get services => 'Servicios';

  @override
  String get ourHistory => 'Nuestra Historia';

  @override
  String get contact => 'Contacto';

  @override
  String get login => 'Iniciar Sesión';

  @override
  String get email => 'Correo Electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get enter => 'Entrar';

  @override
  String get imBarber => 'Soy Barbero';

  @override
  String get bookWithoutRegister => 'Agendar sin registro';

  @override
  String get helloClient => 'Hola, Cliente';

  @override
  String get myPoints => 'Mis Puntos';

  @override
  String get subscriptionPlan => 'Plan de Suscripción';

  @override
  String get referAndEarn => 'Refiere y Gana';

  @override
  String get bookAppointment => 'Agendar Corte';

  @override
  String get barberArea => 'Área del Barbero';

  @override
  String get nextAppointments => 'Próximas Citas';

  @override
  String get myProfile => 'Mi Perfil';

  @override
  String get settings => 'Configuraciones';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get darkMode => 'Modo Oscuro';

  @override
  String get language => 'Idioma';

  @override
  String get helpSupport => 'Ayuda y Soporte';

  @override
  String get logout => 'Cerrar Sesión';

  @override
  String get editProfile => 'Editar Perfil';

  @override
  String get saveChanges => 'Guardar Cambios';

  @override
  String get name => 'Nombre';

  @override
  String get phone => 'Teléfono';

  @override
  String get contactTitle => 'Contacto';

  @override
  String get addressTitle => 'Dirección';

  @override
  String get addressContent => 'Calle de las Tijeras, 123\nCentro, Ciudad - SP';

  @override
  String get phoneTitle => 'Teléfono';

  @override
  String get phoneContent => '(11) 99999-9999\n(11) 3333-3333';

  @override
  String get hoursTitle => 'Horario';

  @override
  String get hoursContent => 'Lun - Vie: 09:00 - 20:00\nSáb: 09:00 - 18:00';

  @override
  String get whatsappButton => 'Hablar por WhatsApp';

  @override
  String get bannerSubtitle => 'Estilo y tradición para el hombre moderno';

  @override
  String get bookSchedule => 'Agendar Cita';

  @override
  String get loyaltyProgram => 'Programa de Lealtad';

  @override
  String loyaltyPoints(int current, int total) {
    return '¡$current de $total cortes para obtener 1 gratis!';
  }

  @override
  String get subscribePremium => 'Suscríbete a Premium';

  @override
  String get premiumOffer => 'Cortes ilimitados por \$99/mes';

  @override
  String get subscribe => 'Suscribirse';

  @override
  String get referShare => '¡Comparte tu código y obtén descuentos!';

  @override
  String get barberProfileName => 'Barbero Profesional';

  @override
  String appointmentsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString Citas',
      one: '1 Cita',
      zero: 'Sin citas',
    );
    return '$_temp0';
  }

  @override
  String totalPrice(double price) {
    final intl.NumberFormat priceNumberFormat = intl.NumberFormat.currency(
      locale: localeName,
      symbol: 'R\$',
      decimalDigits: 2,
    );
    final String priceString = priceNumberFormat.format(price);

    return 'Total: $priceString';
  }

  @override
  String bookingDate(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Fecha: $dateString';
  }

  @override
  String welcomeUser(String gender, String name) {
    String _temp0 = intl.Intl.selectLogic(gender, {
      'male': 'Bienvenido, $name',
      'female': 'Bienvenida, $name',
      'other': 'Hola, $name',
    });
    return '$_temp0';
  }

  @override
  String get myAppointments => 'Mis Citas';

  @override
  String get newSchedule => 'Nueva Cita';

  @override
  String get pending => 'Pendiente';

  @override
  String get confirmed => 'Confirmada';

  @override
  String get cancelled => 'Cancelada';

  @override
  String get myServices => 'Mis Servicios';

  @override
  String get businessHours => 'Horario de Atención';

  @override
  String get reviews => 'Reseñas';

  @override
  String get scheduleServiceTitle => 'Agendar Servicio';

  @override
  String get retry => 'Intentar de nuevo';

  @override
  String get guestBookingMessage =>
      'Reservando como Invitado. ¡Regístrate luego para ganar puntos!';

  @override
  String get serviceLabel => 'Servicio';

  @override
  String get barberLabel => 'Barbero';

  @override
  String get dateLabel => 'Fecha';

  @override
  String get timeLabel => 'Hora';

  @override
  String get confirmSchedule => 'Confirmar Cita';

  @override
  String get scheduleSuccess => '¡Cita confirmada con éxito!';

  @override
  String get selectServiceAndBarber => 'Seleccione un servicio y un barbero';

  @override
  String get welcomeTitle => 'Bienvenido';

  @override
  String get loginPrompt => '¿Cómo desea entrar?';

  @override
  String get imClient => 'Soy Cliente';

  @override
  String get ourServicesTitle => 'Nuestros Servicios';

  @override
  String get traditionSince => 'Tradición desde 1990';

  @override
  String get historyText1 =>
      'Comenzamos como una pequeña barbería familiar y hoy somos referencia en estilo y cuidado masculino. Nuestra misión es proporcionar no solo un corte de cabello, sino una experiencia de relajación y confianza.';

  @override
  String get historyText2 =>
      'Preservamos las técnicas clásicas de barbería mientras abrazamos las tendencias modernas. Aquí, cada cliente es tratado como un viejo amigo.';

  @override
  String get fullNameLabel => 'Nombre Completo';

  @override
  String get specialtiesLabel => 'Especialidades';

  @override
  String get specialtiesHelper => 'Separar por comas';

  @override
  String get bioLabel => 'Bio / Sobre Mí';

  @override
  String get profileUpdatedSuccess => '¡Perfil actualizado con éxito!';
}
