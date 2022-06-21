import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:icalendar_parser/icalendar_parser.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrcode/generated/l10n.dart';
import 'package:qrcode/model/action_type.dart';
import 'package:qrcode/model/data_models.dart';
import 'package:qrcode/model/qrcode_data_type.dart';
import 'package:qrcode/utils/dialog.dart';
import 'package:qrcode/utils/get_content.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class QRCodeProvider extends ChangeNotifier {
  Widget mainAction = const SizedBox();
  List<Widget> actionList = [];

  List<Widget> infoList = [];

  void setActionList(
    BuildContext context, {
    required QRCodeDataType type,
  }) {
    actionList.clear();
    List<ActionType> actions = [];
    notifyListeners();

    switch (type) {
      case QRCodeDataType.text:
        actions = [
          ActionType.launchApp,
          ActionType.search,
        ];
        break;
      case QRCodeDataType.url:
        actions = [
          ActionType.launchUrl,
          ActionType.search,
        ];
        break;
      case QRCodeDataType.mail:
        actions = [
          ActionType.sendEmail,
        ];
        break;
      case QRCodeDataType.phone:
        actions = [
          ActionType.call,
        ];
        break;
      case QRCodeDataType.sms:
        actions = [
          ActionType.sendSms,
        ];
        break;
      case QRCodeDataType.geo:
        actions = [
          ActionType.openMap,
        ];
        break;
      case QRCodeDataType.wifi:
        actions = [
          ActionType.connectWifi,
        ];
        break;
      case QRCodeDataType.contract:
        actions = [
          ActionType.saveContact,
          ActionType.call,
          ActionType.sendSms,
          ActionType.sendEmail,
          ActionType.openMap,
        ];
        break;
      case QRCodeDataType.bookmark:
        actions = [
          ActionType.saveBookmark,
          ActionType.launchUrl,
          ActionType.search,
        ];
        break;
      case QRCodeDataType.calendar:
        actions = [
          ActionType.saveCalendar,
        ];
        break;
    }

    for (int i = 0; i < actions.length; i++) {
      actionList.add(actionButton(context, type: actions[i]));
    }
    notifyListeners();
  }

  void setInfoList(
    BuildContext context, {
    required QRCodeDataType type,
    required Barcode result,
  }) {
    switch (type) {
      case QRCodeDataType.text:
        //TODO 動作
        infoList = [
          const SizedBox(height: 16),
          _typeText('TEXT'),
          const SizedBox(height: 16),
          _contentTitle(context,
              icon: null,
              title: null,
              content: result.code ?? '',
              actionIcon: Icons.search, action: () {
            launch('https://www.google.com/search?q=${result.code}');
          }),
        ];
        break;
      case QRCodeDataType.url:
        UrlModel urlModel = UrlModel.transfer(result.code ?? '');
        //TODO 動作
        infoList = [
          const SizedBox(height: 16),
          _typeText('URL'),
          const SizedBox(height: 16),
          _contentTitle(
            context,
            icon: Icons.link,
            title: null,
            content: urlModel.url,
          ),
        ];
        break;
      case QRCodeDataType.mail:
        MailModel mailModel = MailModel.transfer(result.code ?? '');
        //TODO 動作
        infoList = [
          const SizedBox(height: 16),
          _typeText('EMAIL'),
          const SizedBox(height: 16),
          _contentTitle(
            context,
            icon: Icons.mail_outline,
            title: null,
            content: mailModel.target,
            showAnyway: true,
          ),
          _contentTitle(
            context,
            icon: Icons.title,
            title: null,
            content: mailModel.title,
          ),
          _contentTitle(
            context,
            icon: null,
            title: 'CC',
            content: listToString(mailModel.cc),
          ),
          _contentTitle(
            context,
            icon: null,
            title: 'Bcc',
            content: listToString(mailModel.bcc),
          ),
          _contentTitle(
            context,
            icon: Icons.subject,
            title: null,
            content: mailModel.content,
          ),
        ];
        break;
      case QRCodeDataType.phone:
        PhoneModel phoneModel = PhoneModel.transfer(result.code ?? '');
        //TODO 動作
        infoList = [
          const SizedBox(height: 16),
          _typeText('TEL'),
          const SizedBox(height: 16),
          _contentTitle(
            context,
            icon: Icons.phone_outlined,
            title: null,
            content: phoneModel.phoneNumber,
          ),
        ];
        break;
      case QRCodeDataType.sms:
        SMSModel smsModel = SMSModel.transfer(result.code ?? '');
        //TODO 動作
        infoList = [
          const SizedBox(height: 16),
          _typeText('SMS'),
          const SizedBox(height: 16),
          _contentTitle(
            context,
            icon: Icons.phone_outlined,
            title: null,
            content: smsModel.phoneNumber,
            actionIcon: Icons.phone_outlined,
            action: () {
              launch('tel:${smsModel.phoneNumber}');
            },
          ),
          _contentTitle(
            context,
            icon: Icons.sms_outlined,
            title: null,
            content: smsModel.content,
          ),
        ];
        break;
      case QRCodeDataType.geo:
        GEOModel geoModel = GEOModel.transfer(result.code ?? '');
        //TODO 動作
        infoList = [
          const SizedBox(height: 16),
          _typeText('GEO'),
          const SizedBox(height: 16),
          _contentTitle(
            context,
            icon: Icons.my_location_outlined,
            title: null,
            content: '${geoModel.lon},${geoModel.lat}',
            actionIcon: Icons.map_outlined,
            action: () {
              launch('geo:${geoModel.lon},${geoModel.lat}');
            },
          ),
          _contentTitle(
            context,
            icon: Icons.location_on_outlined,
            title: null,
            content: geoModel.name,
            actionIcon: Icons.search,
            action: () {
              launch(
                  'https://www.google.com/search?q=${geoModel.name}');
            },
          ),
        ];
        break;
      case QRCodeDataType.wifi:
        WifiModel wifiModel = WifiModel.transfer(result.code ?? '');
        //TODO 動作
        infoList = [
          const SizedBox(height: 16),
          _typeText('WIFI'),
          const SizedBox(height: 16),
          _contentTitle(
            context,
            icon: Icons.wifi,
            title: null,
            content: wifiModel.name,
          ),
          _contentTitle(
            context,
            icon: Icons.vpn_key_outlined,
            title: null,
            content: wifiModel.password,
          ),
          _contentTitle(
            context,
            icon: Icons.settings_ethernet,
            title: null,
            content: wifiModel.type,
          ),
        ];
        break;
      case QRCodeDataType.contract:
        Contact contact = Contact();

        // Import contact from vCard

        if (result.code!.toUpperCase().startsWith('MECARD:')) {
          contact = handleMeCard(result.code ?? '');
        }
        if (result.code!.toUpperCase().startsWith('BIZCARD:')) {
          contact = handleBizCard(result.code ?? '');
        }
        if (result.code!.toUpperCase().startsWith('BEGIN:VCARD')) {
          contact = Contact.fromVCard(result.code ?? '');
        }
        print(contact);
        //TODO 動作
        infoList = [
          const SizedBox(height: 16),
          _typeText('CONTACT'),
          const SizedBox(height: 16),
          if (contact.photo != null) Image.memory(contact.photo!),
          if (contact.thumbnail != null) Image.memory(contact.thumbnail!),
          _contentTitle(
            context,
            icon: Icons.person_outline,
            title: null,
            content: contact.displayName,
          ),
          _contentTitle(
            context,
            icon: Icons.person,
            title: null,
            content: '${contact.name.last}${contact.name.middle}${contact.name.first}',
          ),
          _contentTitle(
            context,
            icon: Icons.person_outline,
            title: null,
            content: contact.name.nickname,
          ),
          if (contact.phones.isNotEmpty) ...[
            const Divider(),
            _contentTitleWithChild(
              icon: Icons.settings_phone_outlined,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: contact.phones.length,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      _contentTitle(
                        context,
                        icon: Icons.label_outline,
                        title: null,
                        content:
                            '${_phoneLabelToString[contact.phones[index].label]}',
                        havePadding: false,
                      ),
                      _contentTitle(
                        context,
                        icon: Icons.phone_outlined,
                        title: null,
                        content: contact.phones[index].number,
                        actionIcon: Icons.phone_outlined,
                        action: () {
                          launch(
                              'tel:${contact.phones[index].number}');
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
          //TODO email problem
          if (contact.emails.isNotEmpty) ...[
            const Divider(),
            _contentTitleWithChild(
              icon: Icons.mail_outline,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: contact.emails.length,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      _contentTitle(
                        context,
                        icon: Icons.label_outline,
                        title: null,
                        content:
                            '${_emailLabelToString[contact.emails[index].label]}',
                        havePadding: false,
                      ),
                      _contentTitle(
                        context,
                        icon: Icons.email_outlined,
                        title: null,
                        content: contact.emails[index].address,
                        actionIcon: Icons.email_outlined,
                        action: () {
                          launch(
                              'emailto:${contact.phones[index].number}');
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
          if (contact.addresses.isNotEmpty) ...[
            const Divider(),
            _contentTitleWithChild(
              icon: Icons.location_on_outlined,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: contact.addresses.length,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      _contentTitle(
                        context,
                        icon: Icons.label_outline,
                        title: null,
                        content:
                            '${_addressLabelToString[contact.addresses[index].label]}',
                        havePadding: false,
                      ),
                      _contentTitle(
                        context,
                        icon: Icons.location_city_outlined,
                        title: null,
                        content: contact.addresses[index].address,
                        actionIcon: Icons.map_outlined,
                        action: () {
                          launch(
                              'https://www.google.com/maps/search/?api=1&query=${contact.addresses[index].address}');
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
          if (contact.organizations.isNotEmpty) ...[
            const Divider(),
            _contentTitleWithChild(
              icon: Icons.business_rounded,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: contact.organizations.length,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      _contentTitle(
                        context,
                        icon: Icons.label_outline,
                        title: null,
                        content: contact.organizations[index].company,
                        havePadding: false,
                      ),
                      _contentTitle(
                        context,
                        icon: Icons.work_outline,
                        title: null,
                        content: contact.organizations[index].department,
                      ),
                      _contentTitle(
                        context,
                        icon: Icons.badge_outlined,
                        title: null,
                        content: contact.organizations[index].title,
                      ),
                      _contentTitle(
                        context,
                        icon: Icons.edit_note_outlined,
                        title: null,
                        content: contact.organizations[index].jobDescription,
                      ),
                      _contentTitle(
                        context,
                        icon: Icons.location_on_outlined,
                        title: null,
                        content: contact.organizations[index].officeLocation,
                        actionIcon: Icons.map_outlined,
                        action: () {
                          launch(
                              'https://www.google.com/maps/search/?api=1&query=${contact.organizations[index].officeLocation}');
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
          if (contact.websites.isNotEmpty) ...[
            const Divider(),
            _contentTitleWithChild(
              icon: Icons.language,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: contact.websites.length,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      _contentTitle(
                        context,
                        icon: Icons.label_outline,
                        title: null,
                        content:
                            '${_websiteLabelToString[contact.websites[index].label]}',
                        havePadding: false,
                      ),
                      _contentTitle(
                        context,
                        icon: Icons.link,
                        title: null,
                        content: contact.websites[index].url,
                        actionIcon: Icons.launch,
                        action: (){
                          launch(contact.websites[index].url);
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
          if (contact.socialMedias.isNotEmpty) ...[
            const Divider(),
            _contentTitleWithChild(
              icon: Icons.face,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: contact.socialMedias.length,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      _contentTitle(
                        context,
                        icon: Icons.label_outline,
                        title: null,
                        content:
                            '${_socialMediaLabelToString[contact.socialMedias[index].label]}',
                        havePadding: false,
                      ),
                      _contentTitle(
                        context,
                        icon: Icons.drive_file_rename_outline,
                        title: null,
                        content: contact.socialMedias[index].userName,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
          if (contact.events.isNotEmpty) ...[
            const Divider(),
            _contentTitleWithChild(
              icon: Icons.event,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: contact.events.length,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      _contentTitle(
                        context,
                        icon: Icons.label_outline,
                        title: null,
                        content:
                            '${_eventLabelToString[contact.events[index].label]}',
                        havePadding: false,
                      ),
                      _contentTitle(
                        context,
                        icon: Icons.calendar_today,
                        title: null,
                        content:
                            '${contact.events[index].year}${contact.events[index].year != null ? '/' : ''}${contact.events[index].month}/${contact.events[index].day}',
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
          if (contact.notes.isNotEmpty) ...[
            const Divider(),
            _contentTitleWithChild(
              icon: Icons.edit,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: contact.notes.length,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      _contentTitle(
                        context,
                        icon: Icons.label_outline,
                        title: null,
                        content: contact.notes[index].note,
                        havePadding: false,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
          if (contact.groups.isNotEmpty) ...[
            const Divider(),
            _contentTitleWithChild(
              icon: Icons.groups_outlined,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: contact.groups.length,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      _contentTitle(
                        context,
                        icon: Icons.label_outline,
                        title: null,
                        content: contact.groups[index].id,
                        havePadding: false,
                      ),
                      _contentTitle(
                        context,
                        icon: Icons.edit,
                        title: null,
                        content: contact.groups[index].name,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ];
        break;
      case QRCodeDataType.bookmark:
        UrlModel urlModel = UrlModel.transfer(result.code ?? '');
        //TODO 動作
        infoList = [
          const SizedBox(height: 16),
          _typeText('BOOKMARK'),
          const SizedBox(height: 16),
          _contentTitle(
            context,
            icon: Icons.bookmark_border_outlined,
            title: null,
            content: urlModel.title,
          ),
          _contentTitle(
            context,
            icon: Icons.link,
            title: null,
            content: urlModel.url,
          ),
        ];
        break;
      case QRCodeDataType.calendar:
        String code =
            'BEGIN:VCALENDAR\nVERSION:2.0\nPRODID:-//hacksw/handcal//NONSGML v1.0//EN\n' +
                (result.code ?? '');
        code = code + '\n' + 'END:VCALENDAR';
        final iCalendar = ICalendar.fromString(code);
        int index =
            iCalendar.data.indexWhere((element) => element['type'] == 'VEVENT');
        //TODO 動作
        if (index == -1) {
          infoList = [
            const SizedBox(height: 16),
            _typeText('CALENDAR'),
            const SizedBox(height: 16),
            _contentTitle(
              context,
              icon: Icons.subject,
              title: null,
              content: result.code ?? '',
            ),
          ];
        } else {
          final dateTimeFormat = DateFormat('yyyy/MM/dd, HH:mm');
          String start = '';
          String end = '';
          String timeStamp = '';
          if (iCalendar.data[index]['dtstart'] != null) {
            final time = DateTime.parse(
                (iCalendar.data[index]['dtstart'] as IcsDateTime).dt);
            start = dateTimeFormat.format(time);
          }
          if (iCalendar.data[index]['dtend'] != null) {
            final time = DateTime.parse(
                (iCalendar.data[index]['dtend'] as IcsDateTime).dt);
            end = dateTimeFormat.format(time);
          }
          if (iCalendar.data[index]['dtstamp'] != null) {
            final time = DateTime.parse(
                (iCalendar.data[index]['dtstamp'] as IcsDateTime).dt);
            timeStamp = dateTimeFormat.format(time);
          }

          infoList = [
            const SizedBox(height: 16),
            _typeText('CALENDAR'),
            const SizedBox(height: 16),
            _contentTitle(
              context,
              icon: Icons.title,
              title: null,
              content: iCalendar.data[index]['summary'] ?? '',
            ),
            _contentTitle(
              context,
              icon: Icons.start,
              title: null,
              content: start,
              allowTap: false,
            ),
            _contentTitle(
              context,
              icon: Icons.start,
              title: null,
              content: end,
              quarterTurns: 2,
              allowTap: false,
            ),
            _contentTitle(
              context,
              icon: Icons.access_time_outlined,
              title: null,
              content: timeStamp,
              allowTap: false,
            ),
            _contentTitle(
              context,
              icon: Icons.email_outlined,
              title: null,
              content: iCalendar.data[index]['uid'] ?? '',
            ),
            _contentTitle(
              context,
              icon: Icons.edit_note_outlined,
              title: null,
              content: iCalendar.data[index]['description'] ?? '',
            ),
            _contentTitle(
              context,
              icon: Icons.location_city_rounded,
              title: null,
              content: iCalendar.data[index]['location'] ?? '',
            ),
            _contentTitle(
              context,
              icon: Icons.language,
              title: null,
              content: iCalendar.data[index]['url'] ?? '',
            ),
            if (iCalendar.data[index]['geo'] != null)
              _contentTitle(
                context,
                icon: Icons.location_on_outlined,
                title: null,
                content: iCalendar.data[index]['geo'].toString(),
              ),
            if (iCalendar.data[index]['organizer'] != null)
              _contentTitleWithChild(
                icon: Icons.business_rounded,
                child: Column(
                  children: [
                    _contentTitle(
                      context,
                      icon: Icons.label_outline,
                      title: null,
                      content: iCalendar.data[index]['organizer']['name'] ?? '',
                      havePadding: false,
                    ),
                    _contentTitle(
                      context,
                      icon: Icons.email_outlined,
                      title: null,
                      content: iCalendar.data[index]['organizer']['mail'] ?? '',
                    ),
                  ],
                ),
              )
          ];
        }
        break;
    }
    notifyListeners();
  }

  Widget actionButton(
    BuildContext context, {
    required ActionType type,
  }) {
    String title = '';
    Function() onTap = () {};
    IconData? iconData;
    switch (type) {
      case ActionType.launchApp:
        title = S.of(context).launch;
        iconData = Icons.launch;
        onTap = () {};
        break;
      case ActionType.copy:
        title = S.of(context).copy;
        iconData = Icons.copy;
        onTap = () {};
        break;
      case ActionType.search:
        title = S.of(context).search;
        iconData = Icons.search;
        onTap = () {};
        break;
      case ActionType.launchUrl:
        title = S.of(context).launchUrl;
        iconData = Icons.language;
        onTap = () {};
        break;
      case ActionType.saveBookmark:
        title = S.of(context).saveBookmark;
        iconData = Icons.bookmark_border_outlined;
        onTap = () {};
        break;
      case ActionType.sendEmail:
        title = S.of(context).sendEmail;
        iconData = Icons.email_outlined;
        onTap = () {};
        break;
      case ActionType.sendSms:
        title = S.of(context).sendSMS;
        iconData = Icons.sms_outlined;
        onTap = () {};
        break;
      case ActionType.call:
        title = S.of(context).call;
        iconData = Icons.phone_outlined;
        onTap = () {};
        break;
      case ActionType.openMap:
        title = S.of(context).openMap;
        iconData = Icons.location_on_outlined;
        onTap = () {};
        break;
      case ActionType.connectWifi:
        title = S.of(context).connectWifi;
        iconData = Icons.wifi;
        onTap = () {};
        break;
      case ActionType.saveContact:
        title = S.of(context).saveContact;
        iconData = Icons.contact_mail_outlined;
        onTap = () {};
        break;
      case ActionType.saveCalendar:
        title = S.of(context).saveCalendar;
        iconData = Icons.calendar_month_outlined;
        onTap = () {};
        break;
    }
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
      ),
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData),
          const SizedBox(width: 16),
          Text(title),
        ],
      ),
    );
  }

  Contact handleMeCard(String rawString) {
    Contact contact = Contact();

    String name = GetContent.getContent(
      name: 'N:',
      split: ';',
      rawString: rawString,
    );
    contact.name.last = name.split(',')[0];
    if (name.split(',').length > 1) {
      contact.name.first = name.split(',')[1];
    }
    contact.displayName = name.replaceAll(',', ' ');

    String sound = GetContent.getContent(
      name: 'SOUND:',
      split: ';',
      rawString: rawString,
    );
    contact.name.lastPhonetic = sound.split(',')[0];
    if (sound.split(',').length > 1) {
      contact.name.firstPhonetic = sound.split(',')[1];
    }

    List<String> tels = [];
    for (final element in rawString.split(';')) {
      if (element.toUpperCase().startsWith('TEL:')) {
        tels.add(element.substring('TEL:'.length, element.length));
      }
    }
    for (final element in tels) {
      contact.phones.add(Phone(element, label: PhoneLabel.home));
    }

    List<String> telAVs = [];
    for (final element in rawString.split(';')) {
      if (element.toUpperCase().startsWith('TEL-AV:')) {
        telAVs.add(element.substring('TEL-AV:'.length, element.length));
      }
    }
    for (final element in telAVs) {
      contact.phones.add(Phone(element, label: PhoneLabel.radio));
    }

    List<String> emails = [];
    for (final element in rawString.split(';')) {
      if (element.toUpperCase().startsWith('EMAIL:')) {
        emails.add(element.substring('EMAIL:'.length, element.length));
      }
    }
    for (final element in emails) {
      contact.emails.add(Email(element, label: EmailLabel.home));
    }

    List<String> notes = [];
    for (final element in rawString.split(';')) {
      if (element.toUpperCase().startsWith('NOTE:')) {
        notes.add(element.substring('NOTE:'.length, element.length));
      }
    }
    for (final element in notes) {
      contact.notes.add(Note(element));
    }

    ///Not Use
    String birthday = GetContent.getContent(
      name: 'BDAY:',
      split: ';',
      rawString: rawString,
    );

    List<String> address = [];
    for (final element in rawString.split(';')) {
      if (element.toUpperCase().startsWith('ADR:')) {
        address.add(element.substring('ADR:'.length, element.length));
      }
    }
    for (final element in address) {
      List<String> addressList = element.split(',');
      contact.addresses.add(
        Address(
          element.replaceAll(',', ' '),
          pobox: addressList[0],
          street: '${addressList[1]} ${addressList[2]}',
          city: addressList[3],
          state: addressList[4],
          postalCode: addressList[5],
          country: addressList[6],
        ),
      );
    }

    List<String> urls = [];
    for (final element in rawString.split(';')) {
      if (element.toUpperCase().startsWith('URL:')) {
        urls.add(element.substring('URL:'.length, element.length));
      }
    }
    for (final element in urls) {
      contact.websites.add(Website(element, label: WebsiteLabel.homepage));
    }

    String nickname = GetContent.getContent(
      name: 'NICKNAME:',
      split: ';',
      rawString: rawString,
    );
    contact.name.nickname = nickname;
    return contact;
  }

  Contact handleBizCard(String rawString) {
    Contact contact = Contact();

    String firstname = GetContent.getContent(
      name: 'N:',
      split: ';',
      rawString: rawString,
    );
    contact.name.first = firstname;
    String lastname = GetContent.getContent(
      name: 'X:',
      split: ';',
      rawString: rawString,
    );
    contact.name.last = lastname;
    contact.displayName = lastname + ' ' + firstname;

    String title = GetContent.getContent(
      name: 'T:',
      split: ';',
      rawString: rawString,
    );
    String company = GetContent.getContent(
      name: 'C:',
      split: ';',
      rawString: rawString,
    );
    contact.organizations.add(Organization(title: title, company: company));

    String address = GetContent.getContent(
      name: 'A:',
      split: ';',
      rawString: rawString,
    );
    contact.addresses.add(
      Address(
        address.replaceAll(',', ' '),
        label: AddressLabel.work,
      ),
    );

    String phone = GetContent.getContent(
      name: 'B:',
      split: ';',
      rawString: rawString,
    );
    contact.phones.add(Phone(phone, label: PhoneLabel.work));

    String email = GetContent.getContent(
      name: 'E:',
      split: ';',
      rawString: rawString,
    );
    contact.emails.add(Email(email, label: EmailLabel.work));

    return contact;
  }

  String listToString(List<String> list) {
    String text = '';
    for (int i = 0; i < list.length; i++) {
      text += list[i];
      if (i != list.length - 1) {
        text += ',';
      }
    }
    return text;
  }

  Widget _typeText(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _contentTitle(
    BuildContext context, {
    required IconData? icon,
    required String? title,
    required String content,
    IconData? actionIcon,
    Function()? action,
    bool showAnyway = false,
    bool havePadding = true,
    int quarterTurns = 0,
    bool allowTap = true,
  }) {
    if (content.isEmpty && !showAnyway) {
      return const SizedBox();
    }
    bool canTap = content.contains(':');
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: havePadding ? 4 : 0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null)
            RotatedBox(
              quarterTurns: quarterTurns,
              child: Icon(icon),
            ),
          if (title != null)
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          const SizedBox(width: 8),
          Expanded(
            child: SelectableText(
              content,
              style: TextStyle(
                color: canTap && allowTap ? Colors.blue : null,
                decoration:
                    canTap && allowTap ? TextDecoration.underline : null,
              ),
              strutStyle: const StrutStyle(
                forceStrutHeight: true,
                leading: 0.5,
              ),
              onTap: canTap && allowTap
                  ? () async {
                      launchUrlString(content).onError((error, stackTrace) {
                        ShowDialog.show(
                          context,
                          content: '${S.of(context).canNotOpen} $content',
                        );
                        return true;
                      });
                    }
                  : null,
            ),
          ),
          const Spacer(),
          if (actionIcon != null)
            ElevatedButton(
              onPressed: action,
              child: Icon(actionIcon, color: Colors.white),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                primary: Colors.blue, // <-- Button color
              ),
            )
        ],
      ),
    );
  }

  Widget _contentTitleWithChild(
      {required IconData icon, required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Expanded(child: child),
        ],
      ),
    );
  }
  
  void launch(String url){
    launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
  }
}

final _phoneLabelToString = {
  PhoneLabel.assistant: 'assistant',
  PhoneLabel.callback: 'callback',
  PhoneLabel.car: 'car',
  PhoneLabel.companyMain: 'companyMain',
  PhoneLabel.faxHome: 'faxHome',
  PhoneLabel.faxOther: 'faxOther',
  PhoneLabel.faxWork: 'faxWork',
  PhoneLabel.home: 'home',
  PhoneLabel.iPhone: 'iPhone',
  PhoneLabel.isdn: 'isdn',
  PhoneLabel.main: 'main',
  PhoneLabel.mms: 'mms',
  PhoneLabel.mobile: 'mobile',
  PhoneLabel.pager: 'pager',
  PhoneLabel.radio: 'radio',
  PhoneLabel.school: 'school',
  PhoneLabel.telex: 'telex',
  PhoneLabel.ttyTtd: 'ttyTtd',
  PhoneLabel.work: 'work',
  PhoneLabel.workMobile: 'workMobile',
  PhoneLabel.workPager: 'workPager',
  PhoneLabel.other: 'other',
  PhoneLabel.custom: 'custom',
};

final _emailLabelToString = {
  EmailLabel.home: 'home',
  EmailLabel.iCloud: 'iCloud',
  EmailLabel.mobile: 'mobile',
  EmailLabel.school: 'school',
  EmailLabel.work: 'work',
  EmailLabel.other: 'other',
  EmailLabel.custom: 'custom',
};

final _addressLabelToString = {
  AddressLabel.home: 'home',
  AddressLabel.school: 'school',
  AddressLabel.work: 'work',
  AddressLabel.other: 'other',
  AddressLabel.custom: 'custom',
};

final _websiteLabelToString = {
  WebsiteLabel.blog: 'blog',
  WebsiteLabel.ftp: 'ftp',
  WebsiteLabel.home: 'home',
  WebsiteLabel.homepage: 'homepage',
  WebsiteLabel.profile: 'profile',
  WebsiteLabel.school: 'school',
  WebsiteLabel.work: 'work',
  WebsiteLabel.other: 'other',
  WebsiteLabel.custom: 'custom',
};

final _socialMediaLabelToString = {
  SocialMediaLabel.aim: 'aim',
  SocialMediaLabel.baiduTieba: 'baiduTieba',
  SocialMediaLabel.discord: 'discord',
  SocialMediaLabel.facebook: 'facebook',
  SocialMediaLabel.flickr: 'flickr',
  SocialMediaLabel.gaduGadu: 'gaduGadu',
  SocialMediaLabel.gameCenter: 'gameCenter',
  SocialMediaLabel.googleTalk: 'googleTalk',
  SocialMediaLabel.icq: 'icq',
  SocialMediaLabel.instagram: 'instagram',
  SocialMediaLabel.jabber: 'jabber',
  SocialMediaLabel.line: 'line',
  SocialMediaLabel.linkedIn: 'linkedIn',
  SocialMediaLabel.medium: 'medium',
  SocialMediaLabel.messenger: 'messenger',
  SocialMediaLabel.msn: 'msn',
  SocialMediaLabel.mySpace: 'mySpace',
  SocialMediaLabel.netmeeting: 'netmeeting',
  SocialMediaLabel.pinterest: 'pinterest',
  SocialMediaLabel.qqchat: 'qqchat',
  SocialMediaLabel.qzone: 'qzone',
  SocialMediaLabel.reddit: 'reddit',
  SocialMediaLabel.sinaWeibo: 'sinaWeibo',
  SocialMediaLabel.skype: 'skype',
  SocialMediaLabel.snapchat: 'snapchat',
  SocialMediaLabel.telegram: 'telegram',
  SocialMediaLabel.tencentWeibo: 'tencentWeibo',
  SocialMediaLabel.tikTok: 'tikTok',
  SocialMediaLabel.tumblr: 'tumblr',
  SocialMediaLabel.twitter: 'twitter',
  SocialMediaLabel.viber: 'viber',
  SocialMediaLabel.wechat: 'wechat',
  SocialMediaLabel.whatsapp: 'whatsapp',
  SocialMediaLabel.yahoo: 'yahoo',
  SocialMediaLabel.yelp: 'yelp',
  SocialMediaLabel.youtube: 'youtube',
  SocialMediaLabel.zoom: 'zoom',
  SocialMediaLabel.other: 'other',
  SocialMediaLabel.custom: 'custom',
};

final _eventLabelToString = {
  EventLabel.anniversary: 'anniversary',
  EventLabel.birthday: 'birthday',
  EventLabel.other: 'other',
  EventLabel.custom: 'custom',
};
