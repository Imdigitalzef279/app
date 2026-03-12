import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

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
    Locale('vi')
  ];

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @maintenance.
  ///
  /// In en, this message translates to:
  /// **'Maintenance'**
  String get maintenance;

  /// No description provided for @device.
  ///
  /// In en, this message translates to:
  /// **'Devices'**
  String get device;

  /// No description provided for @me.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get me;

  /// No description provided for @factory.
  ///
  /// In en, this message translates to:
  /// **'Factory'**
  String get factory;

  /// No description provided for @statistical.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistical;

  /// No description provided for @input_factory_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter factory name.'**
  String get input_factory_name;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @normal.
  ///
  /// In en, this message translates to:
  /// **'Normal operation'**
  String get normal;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error detected'**
  String get error;

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// No description provided for @contact_information.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get contact_information;

  /// No description provided for @service.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get service;

  /// No description provided for @instructions.
  ///
  /// In en, this message translates to:
  /// **'View user manual'**
  String get instructions;

  /// No description provided for @water.
  ///
  /// In en, this message translates to:
  /// **'Water management'**
  String get water;

  /// No description provided for @energy_saving.
  ///
  /// In en, this message translates to:
  /// **'Energy Saving'**
  String get energy_saving;

  /// No description provided for @solar_power.
  ///
  /// In en, this message translates to:
  /// **'Solar Power'**
  String get solar_power;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @no_devices.
  ///
  /// In en, this message translates to:
  /// **'No devices available'**
  String get no_devices;

  /// No description provided for @current_data.
  ///
  /// In en, this message translates to:
  /// **'Current Data'**
  String get current_data;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @peak_output.
  ///
  /// In en, this message translates to:
  /// **'Peak-time Output'**
  String get peak_output;

  /// No description provided for @off_peak_output.
  ///
  /// In en, this message translates to:
  /// **'Off-peak Output'**
  String get off_peak_output;

  /// No description provided for @normal_output.
  ///
  /// In en, this message translates to:
  /// **'Normal-hour Output'**
  String get normal_output;

  /// No description provided for @total_cost.
  ///
  /// In en, this message translates to:
  /// **'Total Cost'**
  String get total_cost;

  /// No description provided for @no_data.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get no_data;

  /// No description provided for @created_date.
  ///
  /// In en, this message translates to:
  /// **'Created Date'**
  String get created_date;

  /// No description provided for @signal_type.
  ///
  /// In en, this message translates to:
  /// **'Signal Type'**
  String get signal_type;

  /// No description provided for @signal_point.
  ///
  /// In en, this message translates to:
  /// **'Signal Point'**
  String get signal_point;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @stopped.
  ///
  /// In en, this message translates to:
  /// **'Stopped'**
  String get stopped;

  /// No description provided for @device_code.
  ///
  /// In en, this message translates to:
  /// **'Device Code'**
  String get device_code;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @warranty_expiration_date.
  ///
  /// In en, this message translates to:
  /// **'Warranty Expiration Date'**
  String get warranty_expiration_date;

  /// No description provided for @current.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get current;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @enter_alarm_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter alarm name.'**
  String get enter_alarm_name;

  /// No description provided for @alarm_information.
  ///
  /// In en, this message translates to:
  /// **'Alarm Information'**
  String get alarm_information;

  /// No description provided for @device_information.
  ///
  /// In en, this message translates to:
  /// **'Device Information'**
  String get device_information;

  /// No description provided for @device_list.
  ///
  /// In en, this message translates to:
  /// **'Device List'**
  String get device_list;

  /// No description provided for @features.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get features;

  /// No description provided for @power_kw.
  ///
  /// In en, this message translates to:
  /// **'Power (kW)'**
  String get power_kw;

  /// No description provided for @water_flow_liters.
  ///
  /// In en, this message translates to:
  /// **'Water Flow (Liters)'**
  String get water_flow_liters;

  /// No description provided for @no_value.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get no_value;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @usage_level.
  ///
  /// In en, this message translates to:
  /// **'Usage Level'**
  String get usage_level;

  /// No description provided for @grid_power.
  ///
  /// In en, this message translates to:
  /// **'Grid Power'**
  String get grid_power;

  /// No description provided for @total_output.
  ///
  /// In en, this message translates to:
  /// **'Total Output'**
  String get total_output;

  /// No description provided for @grid_supply.
  ///
  /// In en, this message translates to:
  /// **'Supplied by Grid'**
  String get grid_supply;

  /// No description provided for @solar_supply.
  ///
  /// In en, this message translates to:
  /// **'Supplied by Solar'**
  String get solar_supply;

  /// No description provided for @max_grid_power.
  ///
  /// In en, this message translates to:
  /// **'Max Grid Power'**
  String get max_grid_power;

  /// No description provided for @max_solar_power.
  ///
  /// In en, this message translates to:
  /// **'Max Solar Power'**
  String get max_solar_power;

  /// No description provided for @output.
  ///
  /// In en, this message translates to:
  /// **'Output'**
  String get output;

  /// No description provided for @pv_power.
  ///
  /// In en, this message translates to:
  /// **'PV Power'**
  String get pv_power;

  /// No description provided for @grid_energy.
  ///
  /// In en, this message translates to:
  /// **'Grid Energy'**
  String get grid_energy;

  /// No description provided for @consumed_energy.
  ///
  /// In en, this message translates to:
  /// **'Consumed Energy'**
  String get consumed_energy;

  /// No description provided for @chart.
  ///
  /// In en, this message translates to:
  /// **'Chart'**
  String get chart;

  /// No description provided for @consumed_power.
  ///
  /// In en, this message translates to:
  /// **'Consumed Power'**
  String get consumed_power;

  /// No description provided for @alarm.
  ///
  /// In en, this message translates to:
  /// **'Alarm'**
  String get alarm;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @critical.
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get critical;

  /// No description provided for @low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get low;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get high;

  /// No description provided for @login_success.
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get login_success;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @unstable_connection.
  ///
  /// In en, this message translates to:
  /// **'Unstable connection!!!'**
  String get unstable_connection;

  /// No description provided for @agree_terms.
  ///
  /// In en, this message translates to:
  /// **'I agree with Kra Power\'s Terms of Service and Privacy Policy'**
  String get agree_terms;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @no_account_register.
  ///
  /// In en, this message translates to:
  /// **'No account? Register now'**
  String get no_account_register;

  /// No description provided for @trial_login.
  ///
  /// In en, this message translates to:
  /// **'Trial login'**
  String get trial_login;

  /// No description provided for @an_error_occurred.
  ///
  /// In en, this message translates to:
  /// **'An error occurred, please try again.'**
  String get an_error_occurred;

  /// No description provided for @user_not_found.
  ///
  /// In en, this message translates to:
  /// **'User not found'**
  String get user_not_found;

  /// No description provided for @field_required.
  ///
  /// In en, this message translates to:
  /// **'Field cannot be empty'**
  String get field_required;

  /// No description provided for @deactivate_account.
  ///
  /// In en, this message translates to:
  /// **'Deactivate account'**
  String get deactivate_account;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm_deactivate_account.
  ///
  /// In en, this message translates to:
  /// **'Confirm deactivation of this account'**
  String get confirm_deactivate_account;

  /// No description provided for @got_it.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get got_it;

  /// No description provided for @trial_account_cannot_deactivate.
  ///
  /// In en, this message translates to:
  /// **'Trial account cannot be deactivated'**
  String get trial_account_cannot_deactivate;

  /// No description provided for @no_information.
  ///
  /// In en, this message translates to:
  /// **'No information'**
  String get no_information;

  /// No description provided for @warning_alert.
  ///
  /// In en, this message translates to:
  /// **'⚠️ Warning'**
  String get warning_alert;

  /// No description provided for @errorContactAdmin.
  ///
  /// In en, this message translates to:
  /// **'An error has occurred, please contact the administrator.'**
  String get errorContactAdmin;

  /// No description provided for @indicator.
  ///
  /// In en, this message translates to:
  /// **'Indicator'**
  String get indicator;

  /// No description provided for @liter.
  ///
  /// In en, this message translates to:
  /// **'Liter'**
  String get liter;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @pressure.
  ///
  /// In en, this message translates to:
  /// **'Pressure'**
  String get pressure;

  /// No description provided for @waterIndicator.
  ///
  /// In en, this message translates to:
  /// **'Water Indicator'**
  String get waterIndicator;

  /// No description provided for @indicatorList.
  ///
  /// In en, this message translates to:
  /// **'Indicator List'**
  String get indicatorList;

  /// No description provided for @limit.
  ///
  /// In en, this message translates to:
  /// **'Limit'**
  String get limit;

  /// No description provided for @unlimited.
  ///
  /// In en, this message translates to:
  /// **'Unlimited'**
  String get unlimited;

  /// No description provided for @nearestWarning.
  ///
  /// In en, this message translates to:
  /// **'Nearest Warning'**
  String get nearestWarning;

  /// No description provided for @seeMore.
  ///
  /// In en, this message translates to:
  /// **'See More'**
  String get seeMore;

  /// No description provided for @waterConsumption.
  ///
  /// In en, this message translates to:
  /// **'Water Consumption'**
  String get waterConsumption;

  /// No description provided for @registerSuccess.
  ///
  /// In en, this message translates to:
  /// **'Registration successful'**
  String get registerSuccess;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get invalidEmail;

  /// No description provided for @passwordRequirements.
  ///
  /// In en, this message translates to:
  /// **'Password must be 8 characters, include at least 1 lowercase letter, 1 uppercase letter, 1 special character, and 1 number'**
  String get passwordRequirements;

  /// No description provided for @passwordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordMismatch;

  /// No description provided for @showMax4Indicators.
  ///
  /// In en, this message translates to:
  /// **'Show up to 4 indicators'**
  String get showMax4Indicators;

  /// No description provided for @noSuccess.
  ///
  /// In en, this message translates to:
  /// **'No Success'**
  String get noSuccess;

  /// No description provided for @projectNull.
  ///
  /// In en, this message translates to:
  /// **'Project Null'**
  String get projectNull;

  /// No description provided for @deviceType.
  ///
  /// In en, this message translates to:
  /// **'Device Type'**
  String get deviceType;

  /// No description provided for @serialNumber.
  ///
  /// In en, this message translates to:
  /// **'Serial Number'**
  String get serialNumber;

  /// No description provided for @occurrenceTime.
  ///
  /// In en, this message translates to:
  /// **'Occurrence Time'**
  String get occurrenceTime;

  /// No description provided for @allWarnings.
  ///
  /// In en, this message translates to:
  /// **'All Warnings'**
  String get allWarnings;

  /// No description provided for @usernameNotMatchOrNotExist.
  ///
  /// In en, this message translates to:
  /// **'Username does not match or does not exist.'**
  String get usernameNotMatchOrNotExist;

  /// No description provided for @deleteAccountSuccess.
  ///
  /// In en, this message translates to:
  /// **'Account deleted successfully!!'**
  String get deleteAccountSuccess;

  /// No description provided for @loginExpired.
  ///
  /// In en, this message translates to:
  /// **'Login session has expired.'**
  String get loginExpired;

  /// No description provided for @badRequest.
  ///
  /// In en, this message translates to:
  /// **'Bad request.'**
  String get badRequest;

  /// No description provided for @forbidden.
  ///
  /// In en, this message translates to:
  /// **'You do not have permission.'**
  String get forbidden;

  /// No description provided for @notFound.
  ///
  /// In en, this message translates to:
  /// **'Resource not found.'**
  String get notFound;

  /// No description provided for @requestTimeout.
  ///
  /// In en, this message translates to:
  /// **'Request timeout.'**
  String get requestTimeout;

  /// No description provided for @conflictError.
  ///
  /// In en, this message translates to:
  /// **'Data conflict.'**
  String get conflictError;

  /// No description provided for @unprocessable.
  ///
  /// In en, this message translates to:
  /// **'Unprocessable entity.'**
  String get unprocessable;

  /// No description provided for @tooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many requests.'**
  String get tooManyRequests;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Server error.'**
  String get serverError;

  /// No description provided for @serverUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Server unavailable.'**
  String get serverUnavailable;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred.'**
  String get unknownError;
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
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
