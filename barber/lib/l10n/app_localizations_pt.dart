// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Barbearia Clássica';

  @override
  String get sinceYear => 'Desde 2024';

  @override
  String get bookCut => 'Agende seu corte';

  @override
  String get services => 'Serviços';

  @override
  String get ourHistory => 'Nossa História';

  @override
  String get contact => 'Contato';

  @override
  String get login => 'Login';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Senha';

  @override
  String get enter => 'Entrar';

  @override
  String get imBarber => 'Sou Barbeiro';

  @override
  String get bookWithoutRegister => 'Agendar sem cadastro';

  @override
  String get helloClient => 'Olá, Cliente';

  @override
  String get myPoints => 'Meus Pontos';

  @override
  String get subscriptionPlan => 'Plano de Assinatura';

  @override
  String get referAndEarn => 'Indique e Ganhe';

  @override
  String get bookAppointment => 'Agendar Corte';

  @override
  String get barberArea => 'Área do Barbeiro';

  @override
  String get nextAppointments => 'Próximos Agendamentos';

  @override
  String get myProfile => 'Meu Perfil';

  @override
  String get settings => 'Configurações';

  @override
  String get notifications => 'Notificações';

  @override
  String get darkMode => 'Modo Escuro';

  @override
  String get language => 'Idioma';

  @override
  String get helpSupport => 'Ajuda e Suporte';

  @override
  String get logout => 'Sair da Conta';

  @override
  String get editProfile => 'Editar Perfil';

  @override
  String get saveChanges => 'Salvar Alterações';

  @override
  String get name => 'Nome';

  @override
  String get phone => 'Telefone';

  @override
  String get contactTitle => 'Entre em Contato';

  @override
  String get addressTitle => 'Endereço';

  @override
  String get addressContent => 'Rua das Tesouras, 123\nCentro, Cidade - SP';

  @override
  String get phoneTitle => 'Telefone';

  @override
  String get phoneContent => '(11) 99999-9999\n(11) 3333-3333';

  @override
  String get hoursTitle => 'Horário';

  @override
  String get hoursContent => 'Seg - Sex: 09:00 - 20:00\nSáb: 09:00 - 18:00';

  @override
  String get whatsappButton => 'Falar no WhatsApp';

  @override
  String get bannerSubtitle => 'Estilo e tradição para o homem moderno';

  @override
  String get bookSchedule => 'Agendar Horário';

  @override
  String get loyaltyProgram => 'Programa de Fidelidade';

  @override
  String loyaltyPoints(int current, int total) {
    return '$current de $total cortes para ganhar 1 grátis!';
  }

  @override
  String get subscribePremium => 'Assine o Premium';

  @override
  String get premiumOffer => 'Cortes ilimitados por R\$99/mês';

  @override
  String get subscribe => 'Assinar';

  @override
  String get referShare => 'Compartilhe seu código e ganhe descontos!';

  @override
  String get barberProfileName => 'Barbeiro Profissional';

  @override
  String appointmentsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString Agendamentos',
      one: '1 Agendamento',
      zero: 'Nenhum agendamento',
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

    return 'Data: $dateString';
  }

  @override
  String welcomeUser(String gender, String name) {
    String _temp0 = intl.Intl.selectLogic(gender, {
      'male': 'Bem-vindo, $name',
      'female': 'Bem-vinda, $name',
      'other': 'Olá, $name',
    });
    return '$_temp0';
  }

  @override
  String get myAppointments => 'Meus Agendamentos';

  @override
  String get newSchedule => 'Novo Agendamento';

  @override
  String get pending => 'Pendente';

  @override
  String get confirmed => 'Confirmado';

  @override
  String get cancelled => 'Cancelado';

  @override
  String get myServices => 'Meus Serviços';

  @override
  String get businessHours => 'Horário de Atendimento';

  @override
  String get reviews => 'Avaliações';

  @override
  String get scheduleServiceTitle => 'Agendar Serviço';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get guestBookingMessage =>
      'Agendando como Convidado. Cadastre-se depois para ganhar pontos!';

  @override
  String get serviceLabel => 'Serviço';

  @override
  String get barberLabel => 'Barbeiro';

  @override
  String get dateLabel => 'Data';

  @override
  String get timeLabel => 'Horário';

  @override
  String get confirmSchedule => 'Confirmar Agendamento';

  @override
  String get scheduleSuccess => 'Agendamento realizado com sucesso!';

  @override
  String get selectServiceAndBarber => 'Selecione um serviço e um barbeiro';

  @override
  String get welcomeTitle => 'Bem-vindo';

  @override
  String get loginPrompt => 'Como você deseja entrar?';

  @override
  String get imClient => 'Sou Cliente';

  @override
  String get ourServicesTitle => 'Nossos Serviços';

  @override
  String get traditionSince => 'Tradição desde 1990';

  @override
  String get historyText1 =>
      'Começamos como uma pequena barbearia familiar e hoje somos referência em estilo e cuidado masculino. Nossa missão é proporcionar não apenas um corte de cabelo, mas uma experiência de relaxamento e confiança.';

  @override
  String get historyText2 =>
      'Preservamos as técnicas clássicas de barbearia enquanto abraçamos as tendências modernas. Aqui, cada cliente é tratado como um velho amigo.';

  @override
  String get fullNameLabel => 'Nome Completo';

  @override
  String get specialtiesLabel => 'Especialidades';

  @override
  String get specialtiesHelper => 'Separe por vírgulas';

  @override
  String get bioLabel => 'Bio / Sobre Mim';

  @override
  String get profileUpdatedSuccess => 'Perfil atualizado com sucesso!';
}
