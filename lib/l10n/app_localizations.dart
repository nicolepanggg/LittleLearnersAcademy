import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

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
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Little Learners Academy'**
  String get appTitle;

  /// No description provided for @helloFriend.
  ///
  /// In en, this message translates to:
  /// **'Hello Friend!'**
  String get helloFriend;

  /// No description provided for @readyToPlay.
  ///
  /// In en, this message translates to:
  /// **'Ready to play today?'**
  String get readyToPlay;

  /// No description provided for @sweetDreams.
  ///
  /// In en, this message translates to:
  /// **'Sweet Dreams, Learner!'**
  String get sweetDreams;

  /// No description provided for @readyToPlayToday.
  ///
  /// In en, this message translates to:
  /// **'Ready to play today?'**
  String get readyToPlayToday;

  /// No description provided for @animals.
  ///
  /// In en, this message translates to:
  /// **'Animals'**
  String get animals;

  /// No description provided for @animalsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap to hear the animal or learn its name!'**
  String get animalsSubtitle;

  /// No description provided for @numbers.
  ///
  /// In en, this message translates to:
  /// **'Numbers'**
  String get numbers;

  /// No description provided for @food.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get food;

  /// No description provided for @yummyFood.
  ///
  /// In en, this message translates to:
  /// **'Yummy Food!'**
  String get yummyFood;

  /// No description provided for @tapToTaste.
  ///
  /// In en, this message translates to:
  /// **'Tap to taste!'**
  String get tapToTaste;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @countingFun.
  ///
  /// In en, this message translates to:
  /// **'Counting Fun'**
  String get countingFun;

  /// No description provided for @countTheApples.
  ///
  /// In en, this message translates to:
  /// **'Count the apples!'**
  String get countTheApples;

  /// No description provided for @oneApple.
  ///
  /// In en, this message translates to:
  /// **'One Apple'**
  String get oneApple;

  /// No description provided for @twoApples.
  ///
  /// In en, this message translates to:
  /// **'Two Apples'**
  String get twoApples;

  /// No description provided for @threeApples.
  ///
  /// In en, this message translates to:
  /// **'Three Apples'**
  String get threeApples;

  /// No description provided for @fourApples.
  ///
  /// In en, this message translates to:
  /// **'Four Apples'**
  String get fourApples;

  /// No description provided for @fiveApples.
  ///
  /// In en, this message translates to:
  /// **'Five Apples'**
  String get fiveApples;

  /// No description provided for @apple.
  ///
  /// In en, this message translates to:
  /// **'Apple'**
  String get apple;

  /// No description provided for @banana.
  ///
  /// In en, this message translates to:
  /// **'Banana'**
  String get banana;

  /// No description provided for @carrot.
  ///
  /// In en, this message translates to:
  /// **'Carrot'**
  String get carrot;

  /// No description provided for @milk.
  ///
  /// In en, this message translates to:
  /// **'Milk'**
  String get milk;

  /// No description provided for @lion.
  ///
  /// In en, this message translates to:
  /// **'Lion'**
  String get lion;

  /// No description provided for @elephant.
  ///
  /// In en, this message translates to:
  /// **'Elephant'**
  String get elephant;

  /// No description provided for @monkey.
  ///
  /// In en, this message translates to:
  /// **'Monkey'**
  String get monkey;

  /// No description provided for @giraffe.
  ///
  /// In en, this message translates to:
  /// **'Giraffe'**
  String get giraffe;

  /// No description provided for @owl.
  ///
  /// In en, this message translates to:
  /// **'Owl'**
  String get owl;

  /// No description provided for @sounds.
  ///
  /// In en, this message translates to:
  /// **'Sounds'**
  String get sounds;

  /// No description provided for @gameSounds.
  ///
  /// In en, this message translates to:
  /// **'Game Sounds'**
  String get gameSounds;

  /// No description provided for @music.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get music;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @traditionalChinese.
  ///
  /// In en, this message translates to:
  /// **'Traditional\nChinese'**
  String get traditionalChinese;

  /// No description provided for @parentsOnly.
  ///
  /// In en, this message translates to:
  /// **'Parents Only'**
  String get parentsOnly;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// No description provided for @solveToUnlock.
  ///
  /// In en, this message translates to:
  /// **'Solve to unlock extra settings!'**
  String get solveToUnlock;

  /// No description provided for @unlocked.
  ///
  /// In en, this message translates to:
  /// **'Unlocked!'**
  String get unlocked;

  /// No description provided for @changeYourSettings.
  ///
  /// In en, this message translates to:
  /// **'Change your settings here.'**
  String get changeYourSettings;
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
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
