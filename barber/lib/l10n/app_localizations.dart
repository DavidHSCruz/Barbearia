import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In pt, this message translates to:
  /// **'Barbearia Clássica'**
  String get appTitle;

  /// No description provided for @sinceYear.
  ///
  /// In pt, this message translates to:
  /// **'Desde 2024'**
  String get sinceYear;

  /// No description provided for @bookCut.
  ///
  /// In pt, this message translates to:
  /// **'Agende seu corte'**
  String get bookCut;

  /// No description provided for @services.
  ///
  /// In pt, this message translates to:
  /// **'Serviços'**
  String get services;

  /// No description provided for @ourHistory.
  ///
  /// In pt, this message translates to:
  /// **'Nossa História'**
  String get ourHistory;

  /// No description provided for @contact.
  ///
  /// In pt, this message translates to:
  /// **'Contato'**
  String get contact;

  /// No description provided for @login.
  ///
  /// In pt, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @email.
  ///
  /// In pt, this message translates to:
  /// **'E-mail'**
  String get email;

  /// No description provided for @password.
  ///
  /// In pt, this message translates to:
  /// **'Senha'**
  String get password;

  /// No description provided for @enter.
  ///
  /// In pt, this message translates to:
  /// **'Entrar'**
  String get enter;

  /// No description provided for @imBarber.
  ///
  /// In pt, this message translates to:
  /// **'Sou Barbeiro'**
  String get imBarber;

  /// No description provided for @bookWithoutRegister.
  ///
  /// In pt, this message translates to:
  /// **'Agendar sem cadastro'**
  String get bookWithoutRegister;

  /// No description provided for @helloClient.
  ///
  /// In pt, this message translates to:
  /// **'Olá, Cliente'**
  String get helloClient;

  /// No description provided for @myPoints.
  ///
  /// In pt, this message translates to:
  /// **'Meus Pontos'**
  String get myPoints;

  /// No description provided for @subscriptionPlan.
  ///
  /// In pt, this message translates to:
  /// **'Plano de Assinatura'**
  String get subscriptionPlan;

  /// No description provided for @referAndEarn.
  ///
  /// In pt, this message translates to:
  /// **'Indique e Ganhe'**
  String get referAndEarn;

  /// No description provided for @bookAppointment.
  ///
  /// In pt, this message translates to:
  /// **'Agendar Corte'**
  String get bookAppointment;

  /// No description provided for @barberArea.
  ///
  /// In pt, this message translates to:
  /// **'Área do Barbeiro'**
  String get barberArea;

  /// No description provided for @nextAppointments.
  ///
  /// In pt, this message translates to:
  /// **'Próximos Agendamentos'**
  String get nextAppointments;

  /// No description provided for @myProfile.
  ///
  /// In pt, this message translates to:
  /// **'Meu Perfil'**
  String get myProfile;

  /// No description provided for @settings.
  ///
  /// In pt, this message translates to:
  /// **'Configurações'**
  String get settings;

  /// No description provided for @notifications.
  ///
  /// In pt, this message translates to:
  /// **'Notificações'**
  String get notifications;

  /// No description provided for @darkMode.
  ///
  /// In pt, this message translates to:
  /// **'Modo Escuro'**
  String get darkMode;

  /// No description provided for @language.
  ///
  /// In pt, this message translates to:
  /// **'Idioma'**
  String get language;

  /// No description provided for @helpSupport.
  ///
  /// In pt, this message translates to:
  /// **'Ajuda e Suporte'**
  String get helpSupport;

  /// No description provided for @logout.
  ///
  /// In pt, this message translates to:
  /// **'Sair da Conta'**
  String get logout;

  /// No description provided for @editProfile.
  ///
  /// In pt, this message translates to:
  /// **'Editar Perfil'**
  String get editProfile;

  /// No description provided for @saveChanges.
  ///
  /// In pt, this message translates to:
  /// **'Salvar Alterações'**
  String get saveChanges;

  /// No description provided for @name.
  ///
  /// In pt, this message translates to:
  /// **'Nome'**
  String get name;

  /// No description provided for @phone.
  ///
  /// In pt, this message translates to:
  /// **'Telefone'**
  String get phone;

  /// No description provided for @contactTitle.
  ///
  /// In pt, this message translates to:
  /// **'Entre em Contato'**
  String get contactTitle;

  /// No description provided for @addressTitle.
  ///
  /// In pt, this message translates to:
  /// **'Endereço'**
  String get addressTitle;

  /// No description provided for @addressContent.
  ///
  /// In pt, this message translates to:
  /// **'Rua das Tesouras, 123\nCentro, Cidade - SP'**
  String get addressContent;

  /// No description provided for @phoneTitle.
  ///
  /// In pt, this message translates to:
  /// **'Telefone'**
  String get phoneTitle;

  /// No description provided for @phoneContent.
  ///
  /// In pt, this message translates to:
  /// **'(11) 99999-9999\n(11) 3333-3333'**
  String get phoneContent;

  /// No description provided for @hoursTitle.
  ///
  /// In pt, this message translates to:
  /// **'Horário'**
  String get hoursTitle;

  /// No description provided for @hoursContent.
  ///
  /// In pt, this message translates to:
  /// **'Seg - Sex: 09:00 - 20:00\nSáb: 09:00 - 18:00'**
  String get hoursContent;

  /// No description provided for @whatsappButton.
  ///
  /// In pt, this message translates to:
  /// **'Falar no WhatsApp'**
  String get whatsappButton;

  /// No description provided for @bannerSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Estilo e tradição para o homem moderno'**
  String get bannerSubtitle;

  /// No description provided for @bookSchedule.
  ///
  /// In pt, this message translates to:
  /// **'Agendar Horário'**
  String get bookSchedule;

  /// No description provided for @loyaltyProgram.
  ///
  /// In pt, this message translates to:
  /// **'Programa de Fidelidade'**
  String get loyaltyProgram;

  /// No description provided for @loyaltyPoints.
  ///
  /// In pt, this message translates to:
  /// **'{current} de {total} cortes para ganhar 1 grátis!'**
  String loyaltyPoints(int current, int total);

  /// No description provided for @subscribePremium.
  ///
  /// In pt, this message translates to:
  /// **'Assine o Premium'**
  String get subscribePremium;

  /// No description provided for @premiumOffer.
  ///
  /// In pt, this message translates to:
  /// **'Cortes ilimitados por R\$99/mês'**
  String get premiumOffer;

  /// No description provided for @subscribe.
  ///
  /// In pt, this message translates to:
  /// **'Assinar'**
  String get subscribe;

  /// No description provided for @referShare.
  ///
  /// In pt, this message translates to:
  /// **'Compartilhe seu código e ganhe descontos!'**
  String get referShare;

  /// No description provided for @barberProfileName.
  ///
  /// In pt, this message translates to:
  /// **'Barbeiro Profissional'**
  String get barberProfileName;

  /// Uma mensagem plural para contagem de agendamentos
  ///
  /// In pt, this message translates to:
  /// **'{count, plural, =0{Nenhum agendamento} =1{1 Agendamento} other{{count} Agendamentos}}'**
  String appointmentsCount(num count);

  /// No description provided for @totalPrice.
  ///
  /// In pt, this message translates to:
  /// **'Total: {price}'**
  String totalPrice(double price);

  /// No description provided for @bookingDate.
  ///
  /// In pt, this message translates to:
  /// **'Data: {date}'**
  String bookingDate(DateTime date);

  /// No description provided for @welcomeUser.
  ///
  /// In pt, this message translates to:
  /// **'{gender, select, male{Bem-vindo, {name}} female{Bem-vinda, {name}} other{Olá, {name}}}'**
  String welcomeUser(String gender, String name);

  /// No description provided for @myAppointments.
  ///
  /// In pt, this message translates to:
  /// **'Meus Agendamentos'**
  String get myAppointments;

  /// No description provided for @newSchedule.
  ///
  /// In pt, this message translates to:
  /// **'Novo Agendamento'**
  String get newSchedule;

  /// No description provided for @pending.
  ///
  /// In pt, this message translates to:
  /// **'Pendente'**
  String get pending;

  /// No description provided for @confirmed.
  ///
  /// In pt, this message translates to:
  /// **'Confirmado'**
  String get confirmed;

  /// No description provided for @cancelled.
  ///
  /// In pt, this message translates to:
  /// **'Cancelado'**
  String get cancelled;

  /// No description provided for @myServices.
  ///
  /// In pt, this message translates to:
  /// **'Meus Serviços'**
  String get myServices;

  /// No description provided for @businessHours.
  ///
  /// In pt, this message translates to:
  /// **'Horário de Atendimento'**
  String get businessHours;

  /// No description provided for @reviews.
  ///
  /// In pt, this message translates to:
  /// **'Avaliações'**
  String get reviews;

  /// No description provided for @scheduleServiceTitle.
  ///
  /// In pt, this message translates to:
  /// **'Agendar Serviço'**
  String get scheduleServiceTitle;

  /// No description provided for @retry.
  ///
  /// In pt, this message translates to:
  /// **'Tentar novamente'**
  String get retry;

  /// No description provided for @guestBookingMessage.
  ///
  /// In pt, this message translates to:
  /// **'Agendando como Convidado. Cadastre-se depois para ganhar pontos!'**
  String get guestBookingMessage;

  /// No description provided for @serviceLabel.
  ///
  /// In pt, this message translates to:
  /// **'Serviço'**
  String get serviceLabel;

  /// No description provided for @barberLabel.
  ///
  /// In pt, this message translates to:
  /// **'Barbeiro'**
  String get barberLabel;

  /// No description provided for @dateLabel.
  ///
  /// In pt, this message translates to:
  /// **'Data'**
  String get dateLabel;

  /// No description provided for @timeLabel.
  ///
  /// In pt, this message translates to:
  /// **'Horário'**
  String get timeLabel;

  /// No description provided for @confirmSchedule.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar Agendamento'**
  String get confirmSchedule;

  /// No description provided for @scheduleSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Agendamento realizado com sucesso!'**
  String get scheduleSuccess;

  /// No description provided for @selectServiceAndBarber.
  ///
  /// In pt, this message translates to:
  /// **'Selecione um serviço e um barbeiro'**
  String get selectServiceAndBarber;

  /// No description provided for @welcomeTitle.
  ///
  /// In pt, this message translates to:
  /// **'Bem-vindo'**
  String get welcomeTitle;

  /// No description provided for @loginPrompt.
  ///
  /// In pt, this message translates to:
  /// **'Como você deseja entrar?'**
  String get loginPrompt;

  /// No description provided for @imClient.
  ///
  /// In pt, this message translates to:
  /// **'Sou Cliente'**
  String get imClient;

  /// No description provided for @ourServicesTitle.
  ///
  /// In pt, this message translates to:
  /// **'Nossos Serviços'**
  String get ourServicesTitle;

  /// No description provided for @traditionSince.
  ///
  /// In pt, this message translates to:
  /// **'Tradição desde 1990'**
  String get traditionSince;

  /// No description provided for @historyText1.
  ///
  /// In pt, this message translates to:
  /// **'Começamos como uma pequena barbearia familiar e hoje somos referência em estilo e cuidado masculino. Nossa missão é proporcionar não apenas um corte de cabelo, mas uma experiência de relaxamento e confiança.'**
  String get historyText1;

  /// No description provided for @historyText2.
  ///
  /// In pt, this message translates to:
  /// **'Preservamos as técnicas clássicas de barbearia enquanto abraçamos as tendências modernas. Aqui, cada cliente é tratado como um velho amigo.'**
  String get historyText2;

  /// No description provided for @fullNameLabel.
  ///
  /// In pt, this message translates to:
  /// **'Nome Completo'**
  String get fullNameLabel;

  /// No description provided for @specialtiesLabel.
  ///
  /// In pt, this message translates to:
  /// **'Especialidades'**
  String get specialtiesLabel;

  /// No description provided for @specialtiesHelper.
  ///
  /// In pt, this message translates to:
  /// **'Separe por vírgulas'**
  String get specialtiesHelper;

  /// No description provided for @bioLabel.
  ///
  /// In pt, this message translates to:
  /// **'Bio / Sobre Mim'**
  String get bioLabel;

  /// No description provided for @profileUpdatedSuccess.
  ///
  /// In pt, this message translates to:
  /// **'Perfil atualizado com sucesso!'**
  String get profileUpdatedSuccess;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
