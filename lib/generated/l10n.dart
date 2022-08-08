// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Copy`
  String get copy {
    return Intl.message(
      'Copy',
      name: 'copy',
      desc: '',
      args: [],
    );
  }

  /// `Execute`
  String get launch {
    return Intl.message(
      'Execute',
      name: 'launch',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Open Link`
  String get launchUrl {
    return Intl.message(
      'Open Link',
      name: 'launchUrl',
      desc: '',
      args: [],
    );
  }

  /// `Save Bookmark`
  String get saveBookmark {
    return Intl.message(
      'Save Bookmark',
      name: 'saveBookmark',
      desc: '',
      args: [],
    );
  }

  /// `Send Email`
  String get sendEmail {
    return Intl.message(
      'Send Email',
      name: 'sendEmail',
      desc: '',
      args: [],
    );
  }

  /// `Send SMS`
  String get sendSMS {
    return Intl.message(
      'Send SMS',
      name: 'sendSMS',
      desc: '',
      args: [],
    );
  }

  /// `Call`
  String get call {
    return Intl.message(
      'Call',
      name: 'call',
      desc: '',
      args: [],
    );
  }

  /// `Open Map`
  String get openMap {
    return Intl.message(
      'Open Map',
      name: 'openMap',
      desc: '',
      args: [],
    );
  }

  /// `Connect Wifi`
  String get connectWifi {
    return Intl.message(
      'Connect Wifi',
      name: 'connectWifi',
      desc: '',
      args: [],
    );
  }

  /// `Save Contact`
  String get saveContact {
    return Intl.message(
      'Save Contact',
      name: 'saveContact',
      desc: '',
      args: [],
    );
  }

  /// `Save Calendar`
  String get saveCalendar {
    return Intl.message(
      'Save Calendar',
      name: 'saveCalendar',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cannot open`
  String get canNotOpen {
    return Intl.message(
      'Cannot open',
      name: 'canNotOpen',
      desc: '',
      args: [],
    );
  }

  /// `coordinate`
  String get coordinate {
    return Intl.message(
      'coordinate',
      name: 'coordinate',
      desc: '',
      args: [],
    );
  }

  /// `name`
  String get name {
    return Intl.message(
      'name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Please turn on Wifi first`
  String get openWifi {
    return Intl.message(
      'Please turn on Wifi first',
      name: 'openWifi',
      desc: '',
      args: [],
    );
  }

  /// `Copied`
  String get copied {
    return Intl.message(
      'Copied',
      name: 'copied',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get password {
    return Intl.message(
      'password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Choose`
  String get choose {
    return Intl.message(
      'Choose',
      name: 'choose',
      desc: '',
      args: [],
    );
  }

  /// `result`
  String get result {
    return Intl.message(
      'result',
      name: 'result',
      desc: '',
      args: [],
    );
  }

  /// `Save failed`
  String get saveError {
    return Intl.message(
      'Save failed',
      name: 'saveError',
      desc: '',
      args: [],
    );
  }

  /// `Save successfully`
  String get saveSuccess {
    return Intl.message(
      'Save successfully',
      name: 'saveSuccess',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Choose All`
  String get chooseAll {
    return Intl.message(
      'Choose All',
      name: 'chooseAll',
      desc: '',
      args: [],
    );
  }

  /// `Build Qrcode`
  String get buildQrcode {
    return Intl.message(
      'Build Qrcode',
      name: 'buildQrcode',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get info {
    return Intl.message(
      'Information',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade Pro`
  String get pro {
    return Intl.message(
      'Upgrade Pro',
      name: 'pro',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Data`
  String get data {
    return Intl.message(
      'Data',
      name: 'data',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get complete {
    return Intl.message(
      'Complete',
      name: 'complete',
      desc: '',
      args: [],
    );
  }

  /// `You haven't scanned any barcodes`
  String get youHaveNotScan {
    return Intl.message(
      'You haven\'t scanned any barcodes',
      name: 'youHaveNotScan',
      desc: '',
      args: [],
    );
  }

  /// `build`
  String get build {
    return Intl.message(
      'build',
      name: 'build',
      desc: '',
      args: [],
    );
  }

  /// `Choose Type`
  String get chooseType {
    return Intl.message(
      'Choose Type',
      name: 'chooseType',
      desc: '',
      args: [],
    );
  }

  /// `Content`
  String get content {
    return Intl.message(
      'Content',
      name: 'content',
      desc: '',
      args: [],
    );
  }

  /// `TEXT`
  String get text {
    return Intl.message(
      'TEXT',
      name: 'text',
      desc: '',
      args: [],
    );
  }

  /// `URL`
  String get url {
    return Intl.message(
      'URL',
      name: 'url',
      desc: '',
      args: [],
    );
  }

  /// `EMAIL`
  String get email {
    return Intl.message(
      'EMAIL',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `PHONE`
  String get phone {
    return Intl.message(
      'PHONE',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `SMS`
  String get sms {
    return Intl.message(
      'SMS',
      name: 'sms',
      desc: '',
      args: [],
    );
  }

  /// `GEO`
  String get geo {
    return Intl.message(
      'GEO',
      name: 'geo',
      desc: '',
      args: [],
    );
  }

  /// `WIFI`
  String get wifi {
    return Intl.message(
      'WIFI',
      name: 'wifi',
      desc: '',
      args: [],
    );
  }

  /// `CONTACT`
  String get contact {
    return Intl.message(
      'CONTACT',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `BOOKMARK`
  String get bookmark {
    return Intl.message(
      'BOOKMARK',
      name: 'bookmark',
      desc: '',
      args: [],
    );
  }

  /// `CALENDAR`
  String get calendar {
    return Intl.message(
      'CALENDAR',
      name: 'calendar',
      desc: '',
      args: [],
    );
  }

  /// `Subject`
  String get subject {
    return Intl.message(
      'Subject',
      name: 'subject',
      desc: '',
      args: [],
    );
  }

  /// `Latitude`
  String get geoLat {
    return Intl.message(
      'Latitude',
      name: 'geoLat',
      desc: '',
      args: [],
    );
  }

  /// `Longitude`
  String get geoLon {
    return Intl.message(
      'Longitude',
      name: 'geoLon',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `Personal Info`
  String get personalInfo {
    return Intl.message(
      'Personal Info',
      name: 'personalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get displayName {
    return Intl.message(
      'Name',
      name: 'displayName',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Organization`
  String get organization {
    return Intl.message(
      'Organization',
      name: 'organization',
      desc: '',
      args: [],
    );
  }

  /// `Organization Name`
  String get organizationName {
    return Intl.message(
      'Organization Name',
      name: 'organizationName',
      desc: '',
      args: [],
    );
  }

  /// `Organization Department`
  String get organizationDepartment {
    return Intl.message(
      'Organization Department',
      name: 'organizationDepartment',
      desc: '',
      args: [],
    );
  }

  /// `Organization Title`
  String get organizationTitle {
    return Intl.message(
      'Organization Title',
      name: 'organizationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Website`
  String get website {
    return Intl.message(
      'Website',
      name: 'website',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Street`
  String get street {
    return Intl.message(
      'Street',
      name: 'street',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get state {
    return Intl.message(
      'State',
      name: 'state',
      desc: '',
      args: [],
    );
  }

  /// `Postal`
  String get postal {
    return Intl.message(
      'Postal',
      name: 'postal',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get note {
    return Intl.message(
      'Note',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `All Day`
  String get allDay {
    return Intl.message(
      'All Day',
      name: 'allDay',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `end`
  String get end {
    return Intl.message(
      'end',
      name: 'end',
      desc: '',
      args: [],
    );
  }

  /// `Format error`
  String get wrongFormat {
    return Intl.message(
      'Format error',
      name: 'wrongFormat',
      desc: '',
      args: [],
    );
  }

  /// `Length does not match`
  String get wrongLength {
    return Intl.message(
      'Length does not match',
      name: 'wrongLength',
      desc: '',
      args: [],
    );
  }

  /// `Unsupported character`
  String get wrongChar {
    return Intl.message(
      'Unsupported character',
      name: 'wrongChar',
      desc: '',
      args: [],
    );
  }

  /// `Allowed Char`
  String get allowedChar {
    return Intl.message(
      'Allowed Char',
      name: 'allowedChar',
      desc: '',
      args: [],
    );
  }

  /// `Remove ads, unlock features`
  String get proHint {
    return Intl.message(
      'Remove ads, unlock features',
      name: 'proHint',
      desc: '',
      args: [],
    );
  }

  /// `To Google Play`
  String get toGooglePlay {
    return Intl.message(
      'To Google Play',
      name: 'toGooglePlay',
      desc: '',
      args: [],
    );
  }

  /// `Reminder`
  String get notify {
    return Intl.message(
      'Reminder',
      name: 'notify',
      desc: '',
      args: [],
    );
  }

  /// `Don't show again`
  String get notShowAgain {
    return Intl.message(
      'Don\'t show again',
      name: 'notShowAgain',
      desc: '',
      args: [],
    );
  }

  /// `soon to open`
  String get soonOpen {
    return Intl.message(
      'soon to open',
      name: 'soonOpen',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Before opening the link, please confirm whether it is a trusted link`
  String get safetyNotify {
    return Intl.message(
      'Before opening the link, please confirm whether it is a trusted link',
      name: 'safetyNotify',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `General Settings`
  String get generalSetting {
    return Intl.message(
      'General Settings',
      name: 'generalSetting',
      desc: '',
      args: [],
    );
  }

  /// `vibrate`
  String get vibrate {
    return Intl.message(
      'vibrate',
      name: 'vibrate',
      desc: '',
      args: [],
    );
  }

  /// `Link open notification`
  String get urlNotify {
    return Intl.message(
      'Link open notification',
      name: 'urlNotify',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Collect`
  String get collect {
    return Intl.message(
      'Collect',
      name: 'collect',
      desc: '',
      args: [],
    );
  }

  /// `No records`
  String get noData {
    return Intl.message(
      'No records',
      name: 'noData',
      desc: '',
      args: [],
    );
  }

  /// `Improvement suggestion`
  String get recommendation {
    return Intl.message(
      'Improvement suggestion',
      name: 'recommendation',
      desc: '',
      args: [],
    );
  }

  /// `Error report`
  String get errorReport {
    return Intl.message(
      'Error report',
      name: 'errorReport',
      desc: '',
      args: [],
    );
  }

  /// `Usage problem`
  String get usageProblem {
    return Intl.message(
      'Usage problem',
      name: 'usageProblem',
      desc: '',
      args: [],
    );
  }

  /// `Other...`
  String get other {
    return Intl.message(
      'Other...',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Please select the type of feedback you want`
  String get feedbackType {
    return Intl.message(
      'Please select the type of feedback you want',
      name: 'feedbackType',
      desc: '',
      args: [],
    );
  }

  /// `Please explain your question or feedback`
  String get explainFeedback {
    return Intl.message(
      'Please explain your question or feedback',
      name: 'explainFeedback',
      desc: '',
      args: [],
    );
  }

  /// `Yor content`
  String get yorContent {
    return Intl.message(
      'Yor content',
      name: 'yorContent',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the type`
  String get typeEmpty {
    return Intl.message(
      'Please enter the type',
      name: 'typeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Please enter content`
  String get contentEmpty {
    return Intl.message(
      'Please enter content',
      name: 'contentEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Please enter...`
  String get enter {
    return Intl.message(
      'Please enter...',
      name: 'enter',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get feedback {
    return Intl.message(
      'Feedback',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  /// `You have already purchased, if the purchased content is not executed correctly, please try to restart the APP`
  String get purchasedNote {
    return Intl.message(
      'You have already purchased, if the purchased content is not executed correctly, please try to restart the APP',
      name: 'purchasedNote',
      desc: '',
      args: [],
    );
  }

  /// `Basic Edition`
  String get normalUser {
    return Intl.message(
      'Basic Edition',
      name: 'normalUser',
      desc: '',
      args: [],
    );
  }

  /// `Professional Edition`
  String get proUser {
    return Intl.message(
      'Professional Edition',
      name: 'proUser',
      desc: '',
      args: [],
    );
  }

  /// `Restore Purchases`
  String get restore {
    return Intl.message(
      'Restore Purchases',
      name: 'restore',
      desc: '',
      args: [],
    );
  }

  /// `Already purchased? Please click here`
  String get restoreNote {
    return Intl.message(
      'Already purchased? Please click here',
      name: 'restoreNote',
      desc: '',
      args: [],
    );
  }

  /// `To use this feature, please upgrade to the Pro version.\n\nAlready purchased? Please click to restore the purchase.`
  String get needPro {
    return Intl.message(
      'To use this feature, please upgrade to the Pro version.\n\nAlready purchased? Please click to restore the purchase.',
      name: 'needPro',
      desc: '',
      args: [],
    );
  }

  /// `You have successfully restored your purchase`
  String get restoreSuccess {
    return Intl.message(
      'You have successfully restored your purchase',
      name: 'restoreSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to leave?`
  String get leaveApp {
    return Intl.message(
      'Do you want to leave?',
      name: 'leaveApp',
      desc: '',
      args: [],
    );
  }

  /// `new version`
  String get released {
    return Intl.message(
      'new version',
      name: 'released',
      desc: '',
      args: [],
    );
  }

  /// `Please update to the latest version`
  String get forceUpdate {
    return Intl.message(
      'Please update to the latest version',
      name: 'forceUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Supported Types`
  String get supportType {
    return Intl.message(
      'Supported Types',
      name: 'supportType',
      desc: '',
      args: [],
    );
  }

  /// `Picture Scan`
  String get fromPicture {
    return Intl.message(
      'Picture Scan',
      name: 'fromPicture',
      desc: '',
      args: [],
    );
  }

  /// `Camera Scan`
  String get fromCamera {
    return Intl.message(
      'Camera Scan',
      name: 'fromCamera',
      desc: '',
      args: [],
    );
  }

  /// `Generate`
  String get generate {
    return Intl.message(
      'Generate',
      name: 'generate',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
