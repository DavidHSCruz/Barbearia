// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Classic Barbershop';

  @override
  String get sinceYear => 'Since 2024';

  @override
  String get bookCut => 'Book your cut';

  @override
  String get services => 'Services';

  @override
  String get ourHistory => 'Our History';

  @override
  String get contact => 'Contact';

  @override
  String get login => 'Login';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get enter => 'Enter';

  @override
  String get imBarber => 'I\'m a Barber';

  @override
  String get bookWithoutRegister => 'Book without registration';

  @override
  String get helloClient => 'Hello, Client';

  @override
  String get myPoints => 'My Points';

  @override
  String get subscriptionPlan => 'Subscription Plan';

  @override
  String get referAndEarn => 'Refer and Earn';

  @override
  String get bookAppointment => 'Book Appointment';

  @override
  String get barberArea => 'Barber Area';

  @override
  String get nextAppointments => 'Next Appointments';

  @override
  String get myProfile => 'My Profile';

  @override
  String get settings => 'Settings';

  @override
  String get notifications => 'Notifications';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get language => 'Language';

  @override
  String get helpSupport => 'Help & Support';

  @override
  String get logout => 'Logout';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get name => 'Name';

  @override
  String get phone => 'Phone';

  @override
  String get contactTitle => 'Get in Touch';

  @override
  String get addressTitle => 'Address';

  @override
  String get addressContent => '123 Scissors St\nDowntown, City - SP';

  @override
  String get phoneTitle => 'Phone';

  @override
  String get phoneContent => '(11) 99999-9999\n(11) 3333-3333';

  @override
  String get hoursTitle => 'Hours';

  @override
  String get hoursContent => 'Mon - Fri: 09:00 - 20:00\nSat: 09:00 - 18:00';

  @override
  String get whatsappButton => 'Chat on WhatsApp';

  @override
  String get bannerSubtitle => 'Style and tradition for the modern man';

  @override
  String get bookSchedule => 'Book Appointment';

  @override
  String get loyaltyProgram => 'Loyalty Program';

  @override
  String loyaltyPoints(int current, int total) {
    return '$current out of $total cuts to get 1 free!';
  }

  @override
  String get subscribePremium => 'Subscribe to Premium';

  @override
  String get premiumOffer => 'Unlimited cuts for \$99/mo';

  @override
  String get subscribe => 'Subscribe';

  @override
  String get referShare => 'Share your code and get discounts!';

  @override
  String get barberProfileName => 'Professional Barber';

  @override
  String appointmentsCount(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString Appointments',
      one: '1 Appointment',
      zero: 'No appointments',
    );
    return '$_temp0';
  }

  @override
  String totalPrice(double price) {
    final intl.NumberFormat priceNumberFormat = intl.NumberFormat.currency(
      locale: localeName,
      symbol: '\$',
      decimalDigits: 2,
    );
    final String priceString = priceNumberFormat.format(price);

    return 'Total: $priceString';
  }

  @override
  String bookingDate(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Date: $dateString';
  }

  @override
  String welcomeUser(String gender, String name) {
    String _temp0 = intl.Intl.selectLogic(gender, {
      'male': 'Welcome, $name',
      'female': 'Welcome, $name',
      'other': 'Hello, $name',
    });
    return '$_temp0';
  }

  @override
  String get myAppointments => 'My Appointments';

  @override
  String get newSchedule => 'New Appointment';

  @override
  String get pending => 'Pending';

  @override
  String get confirmed => 'Confirmed';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get myServices => 'My Services';

  @override
  String get businessHours => 'Business Hours';

  @override
  String get reviews => 'Reviews';

  @override
  String get scheduleServiceTitle => 'Schedule Service';

  @override
  String get retry => 'Retry';

  @override
  String get guestBookingMessage =>
      'Booking as Guest. Register later to earn points!';

  @override
  String get serviceLabel => 'Service';

  @override
  String get barberLabel => 'Barber';

  @override
  String get dateLabel => 'Date';

  @override
  String get timeLabel => 'Time';

  @override
  String get confirmSchedule => 'Confirm Schedule';

  @override
  String get scheduleSuccess => 'Schedule confirmed successfully!';

  @override
  String get selectServiceAndBarber => 'Please select a service and a barber';

  @override
  String get welcomeTitle => 'Welcome';

  @override
  String get loginPrompt => 'How do you want to login?';

  @override
  String get imClient => 'I\'m a Client';

  @override
  String get ourServicesTitle => 'Our Services';

  @override
  String get traditionSince => 'Tradition since 1990';

  @override
  String get historyText1 =>
      'We started as a small family barbershop and today we are a reference in style and male care. Our mission is to provide not just a haircut, but an experience of relaxation and confidence.';

  @override
  String get historyText2 =>
      'We preserve classic barbering techniques while embracing modern trends. Here, every client is treated like an old friend.';

  @override
  String get fullNameLabel => 'Full Name';

  @override
  String get specialtiesLabel => 'Specialties';

  @override
  String get specialtiesHelper => 'Separate by commas';

  @override
  String get bioLabel => 'Bio / About Me';

  @override
  String get profileUpdatedSuccess => 'Profile updated successfully!';
}
