import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icalendar_parser/icalendar_parser.dart';
import 'package:intl/intl.dart';
import 'package:open_settings/open_settings.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrcode/generated/l10n.dart';
import 'package:qrcode/model/action_type.dart';
import 'package:qrcode/model/data_models.dart';
import 'package:qrcode/model/qrcode_data_type.dart';
import 'package:qrcode/utils/add_contact.dart';
import 'package:qrcode/utils/dialog.dart';
import 'package:qrcode/utils/get_content.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart' as email_sender;
import 'package:add_2_calendar/add_2_calendar.dart' as add_2_calendar;

import '../screen/widget/my_banner_ad.dart';

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
          // ActionType.search,
        ];
        break;
      case QRCodeDataType.url:
        actions = [
          ActionType.launchUrl,
          // ActionType.search,
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
      case QRCodeDataType.contact:
        actions = [
          ActionType.saveContact,
          // ActionType.call,
          // ActionType.sendSms,
          // ActionType.sendEmail,
          // ActionType.openMap,
        ];
        break;
      case QRCodeDataType.bookmark:
        actions = [
          ActionType.saveBookmark,
          ActionType.launchUrl,
          // ActionType.search,
        ];
        break;
      case QRCodeDataType.calendar:
        actions = [
          ActionType.saveCalendar,
        ];
        break;
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
        infoList = [
          const SizedBox(height: 16),
          _typeText('TEXT'),
          const SizedBox(height: 16),
          _contentTitle(
            context,
            icon: null,
            title: null,
            content: result.code ?? '',
            actionIcon: Icons.search,
            action: () {
              launch(context, 'https://www.google.com/search?q=${result.code}');
            },
          ),
        ];
        actionList = [
          actionButton(
            context,
            type: ActionType.launchApp,
            onTap: () {
              launch(context, result.code ?? '');
            },
          ),
        ];

        break;
      case QRCodeDataType.url:
        UrlModel urlModel = UrlModel.transfer(result.code ?? '');
        infoList = [
          const SizedBox(height: 16),
          _typeText('URL'),
          const SizedBox(height: 16),
          _contentTitle(
            context,
            icon: Icons.link,
            title: null,
            content: urlModel.url,
            actionIcon: Icons.search,
            action: () {
              launch(
                  context, 'https://www.google.com/search?q=${urlModel.url}');
            },
          ),
        ];
        actionList = [
          actionButton(
            context,
            type: ActionType.launchUrl,
            onTap: () {
              launch(context, urlModel.url);
            },
          ),
        ];
        break;
      case QRCodeDataType.mail:
        MailModel mailModel = MailModel.transfer(result.code ?? '');

        final email_sender.Email email = email_sender.Email(
          body: mailModel.content,
          subject: mailModel.title,
          recipients: mailModel.target,
          cc: mailModel.cc,
          bcc: mailModel.bcc,
          isHTML: false,
        );
        infoList = [
          const SizedBox(height: 16),
          _typeText('EMAIL'),
          const SizedBox(height: 16),
          _contentTitle(
            context,
            icon: Icons.mail_outline,
            title: null,
            content: listToString(mailModel.target),
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
        actionList = [
          actionButton(
            context,
            type: ActionType.sendEmail,
            onTap: () async {
              await email_sender.FlutterEmailSender.send(email);
            },
          ),
        ];
        break;
      case QRCodeDataType.phone:
        PhoneModel phoneModel = PhoneModel.transfer(result.code ?? '');
        infoList = [
          const SizedBox(height: 16),
          _typeText('TEL'),
          const SizedBox(height: 16),
          _contentTitle(
            context,
            icon: Icons.phone_outlined,
            title: null,
            content: phoneModel.phoneNumber,
            actionIcon: Icons.phone_outlined,
            action: () {
              launch(context, 'tel:${phoneModel.phoneNumber}');
            },
          ),
        ];
        actionList = [
          actionButton(
            context,
            type: ActionType.call,
            onTap: () async {
              launch(context, 'tel:${phoneModel.phoneNumber}');
            },
          ),
        ];
        break;
      case QRCodeDataType.sms:
        SMSModel smsModel = SMSModel.transfer(result.code ?? '');
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
              launch(context, 'tel:${smsModel.phoneNumber}');
            },
          ),
          _contentTitle(
            context,
            icon: Icons.sms_outlined,
            title: null,
            content: smsModel.content,
          ),
        ];
        actionList = [
          actionButton(
            context,
            type: ActionType.sendSms,
            onTap: () async {
              _sendSMS(smsModel.content, [smsModel.phoneNumber]);
            },
          ),
        ];
        break;
      case QRCodeDataType.geo:
        GEOModel geoModel = GEOModel.transfer(result.code ?? '');
        infoList = [
          const SizedBox(height: 16),
          _typeText('GEO'),
          const SizedBox(height: 16),
          if (geoModel.lon != null && geoModel.lat != null)
            _contentTitle(
              context,
              icon: Icons.my_location_outlined,
              title: null,
              content: '${geoModel.lat},${geoModel.lon}',
              actionIcon: Icons.map_outlined,
              action: () {
                launch(context, 'geo:${geoModel.lat},${geoModel.lon}');
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
                  context, 'https://www.google.com/search?q=${geoModel.name}');
            },
          ),
        ];
        actionList = [
          if (geoModel.lon != null && geoModel.lat != null)
            actionButton(
              context,
              type: ActionType.openMap,
              onTap: () async {
                launch(context, 'geo:${geoModel.lat},${geoModel.lon}');
              },
            ),
          if (geoModel.name.isNotEmpty)
            actionButton(
              context,
              type: ActionType.openMapByName,
              onTap: () async {
                launch(context,
                    'https://www.google.com/maps/search/?api=1&query=${geoModel.name}');
              },
            ),
        ];
        break;
      case QRCodeDataType.wifi:
        WifiModel wifiModel = WifiModel.transfer(result.code ?? '');
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
        actionList = [
          //TODO wifi連接問題
          actionButton(
            context,
            type: ActionType.connectWifi,
            onTap: () async {
              Clipboard.setData(ClipboardData(text: wifiModel.password));
              Fluttertoast.showToast(
                msg: S.of(context).copied +
                    ' WIFI:' +
                    wifiModel.name +
                    ' ' +
                    S.of(context).password,
                toastLength: Toast.LENGTH_LONG,
              );
              OpenSettings.openWIFISetting();
              // if (await WiFiForIoTPlugin.isEnabled()) {
              //   WiFiForIoTPlugin.findAndConnect(
              //     wifiModel.name,
              //     password: wifiModel.password,
              //     joinOnce: false,
              //   );
              //   return;
              // }
              // ShowDialog.show(
              //   context,
              //   content: S.of(context).openWifi,
              // );
            },
          ),
        ];
        break;
      case QRCodeDataType.contact:
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
        String geo = vcardGEO(result.code ?? '');
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
            icon: Icons.person_outline,
            title: null,
            content:
                '${contact.name.last}${contact.name.last.isNotEmpty ? ' ' : ''}${contact.name.middle}${contact.name.middle.isNotEmpty ? ' ' : ''}${contact.name.first}',
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
                              context, 'tel:${contact.phones[index].number}');
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
                          launch(context,
                              'mailto:${contact.emails[index].address}');
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
          _contentTitle(
            context,
            icon: Icons.my_location_outlined,
            title: null,
            content: geo,
            actionIcon: Icons.map_outlined,
            action: () {
              launch(context, 'geo:${geo.split(',')[0]},${geo.split(',')[1]}');
            },
          ),
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
                          launch(context,
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
                      _contentTitle(context,
                          icon: Icons.label_outline,
                          title: null,
                          content: contact.organizations[index].company,
                          havePadding: false,
                          actionIcon: Icons.search, action: () {
                        launch(context,
                            'https://www.google.com/search?q=${contact.organizations[index].company}');
                      }),
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
                          launch(context,
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
                        action: () {
                          launch(context, contact.websites[index].url);
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
                      _contentTitle(context,
                          icon: Icons.calendar_today,
                          title: null,
                          content:
                              '${contact.events[index].year}${contact.events[index].year != null ? '/' : ''}${contact.events[index].month}/${contact.events[index].day}',
                          actionIcon: Icons.event, action: () {
                        //TODO加入行事曆
                      }),
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
        actionList = [
          actionButton(
            context,
            type: ActionType.saveContact,
            onTap: () async {
              AddContact.add(contact.toJson());
            },
          ),
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
            actionIcon: Icons.launch,
            action: () {
              launch(context, urlModel.url);
            },
          ),
        ];
        actionList = [
          actionButton(
            context,
            type: ActionType.launchUrl,
            onTap: () {
              launch(context, urlModel.url);
            },
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

          actionList = [
            actionButton(
              context,
              type: ActionType.search,
              onTap: () {
                launch(context, result.code ?? '');
              },
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
            _contentTitle(context,
                icon: Icons.email_outlined,
                title: null,
                content: iCalendar.data[index]['uid'] ?? '',
                actionIcon: Icons.email_outlined, action: () {
              launch(context, 'mailto:${iCalendar.data[index]['uid'] ?? ''}');
            }),
            _contentTitle(
              context,
              icon: Icons.edit_note_outlined,
              title: null,
              content: iCalendar.data[index]['description'] ?? '',
            ),
            _contentTitle(context,
                icon: Icons.location_city_rounded,
                title: null,
                content: iCalendar.data[index]['location'] ?? '',
                actionIcon: Icons.search, action: () {
              launch(context,
                  'https://www.google.com/search?q=${iCalendar.data[index]['location'] ?? ''}');
            }),
            _contentTitle(
              context,
              icon: Icons.language,
              title: null,
              content: iCalendar.data[index]['url'] ?? '',
              actionIcon: Icons.launch,
              action: () {
                launch(context, iCalendar.data[index]['url'] ?? '');
              },
            ),
            if (iCalendar.data[index]['geo'] != null)
              _contentTitle(context,
                  icon: Icons.location_on_outlined,
                  title: null,
                  content: iCalendar.data[index]['geo'].toString(),
                  actionIcon: Icons.map_outlined, action: () {
                launch(context,
                    'geo:${iCalendar.data[index]['geo']['latitude']},${iCalendar.data[index]['geo']['longitude']}');
              }),
            if (iCalendar.data[index]['organizer'] != null)
              _contentTitleWithChild(
                icon: Icons.business_rounded,
                child: Column(
                  children: [
                    _contentTitle(context,
                        icon: Icons.label_outline,
                        title: null,
                        content:
                            iCalendar.data[index]['organizer']['name'] ?? '',
                        havePadding: false,
                        actionIcon: Icons.search, action: () {
                      launch(context,
                          'https://www.google.com/search?q=${iCalendar.data[index]['organizer']['name'] ?? ''}');
                    }),
                    _contentTitle(context,
                        icon: Icons.email_outlined,
                        title: null,
                        content:
                            iCalendar.data[index]['organizer']['mail'] ?? '',
                        actionIcon: Icons.email_outlined, action: () {
                      launch(context,
                          'mailto:${iCalendar.data[index]['organizer']['mail'] ?? ''}');
                    }),
                  ],
                ),
              )
          ];

          actionList = [
            actionButton(
              context,
              type: ActionType.saveCalendar,
              onTap: () {
                final allDay = (iCalendar.data[index]['dtstart'] as IcsDateTime)
                            .dt
                            .length ==
                        8 &&
                    (iCalendar.data[index]['dtend'] as IcsDateTime).dt.length ==
                        8;
                DateTime endDate = DateTime.parse(
                    (iCalendar.data[index]['dtend'] as IcsDateTime).dt);
                if (allDay) {
                  endDate = endDate.add(const Duration(days: 1));
                }
                final add_2_calendar.Event event = add_2_calendar.Event(
                  title: iCalendar.data[index]['summary'] ?? '',
                  description: iCalendar.data[index]['description'] ?? '',
                  location: iCalendar.data[index]['location'] ?? '',
                  startDate: DateTime.parse(
                      (iCalendar.data[index]['dtstart'] as IcsDateTime).dt),
                  endDate: endDate,
                  // iosParams: add_2_calendar.IOSParams(
                  //   reminder: Duration(/* Ex. hours:1 */),
                  // ),
                  androidParams: add_2_calendar.AndroidParams(
                    emailInvites: [iCalendar.data[index]['uid'] ?? ''],
                  ),
                  allDay: allDay,
                );
                add_2_calendar.Add2Calendar.addEvent2Cal(event);
              },
            ),
          ];
        }
        break;
    }
    infoList.add(const SizedBox(height: 50,));
    infoList.add(const AdBanner(large: true,));
    notifyListeners();
  }

  Widget actionButton(
    BuildContext context, {
    required ActionType type,
    required Function() onTap,
  }) {
    String title = '';
    IconData? iconData;
    switch (type) {
      case ActionType.launchApp:
        title = S.of(context).launch;
        iconData = Icons.launch;
        break;
      case ActionType.copy:
        title = S.of(context).copy;
        iconData = Icons.copy;
        break;
      case ActionType.search:
        title = S.of(context).search;
        iconData = Icons.search;
        break;
      case ActionType.launchUrl:
        title = S.of(context).launchUrl;
        iconData = Icons.language;
        break;
      case ActionType.saveBookmark:
        title = S.of(context).saveBookmark;
        iconData = Icons.bookmark_border_outlined;
        break;
      case ActionType.sendEmail:
        title = S.of(context).sendEmail;
        iconData = Icons.email_outlined;
        break;
      case ActionType.sendSms:
        title = S.of(context).sendSMS;
        iconData = Icons.sms_outlined;
        break;
      case ActionType.call:
        title = S.of(context).call;
        iconData = Icons.phone_outlined;
        break;
      case ActionType.openMap:
        title = S.of(context).openMap + '(${S.of(context).coordinate})';
        iconData = Icons.location_on_outlined;
        break;
      case ActionType.connectWifi:
        title = S.of(context).connectWifi;
        iconData = Icons.wifi;
        break;
      case ActionType.saveContact:
        title = S.of(context).saveContact;
        iconData = Icons.contact_mail_outlined;
        break;
      case ActionType.saveCalendar:
        title = S.of(context).saveCalendar;
        iconData = Icons.calendar_month_outlined;
        break;
      case ActionType.openMapByName:
        title = S.of(context).openMap + '(${S.of(context).name})';
        iconData = Icons.map_outlined;
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
                      launch(context, content);
                    }
                  : null,
            ),
          ),
          const SizedBox(width: 8),
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

  String vcardGEO(String raw) {
    List<String> list = raw.split('\n');
    String version = '';
    String location = '';
    for (final element in list) {
      if (element.toUpperCase().startsWith('VERSION:')) {
        version = element.substring('VERSION:'.length, element.length);
      }
    }
    for (final element in list) {
      if (element.toUpperCase().startsWith('GEO:')) {
        if (version == '4.0') {
          location = element.substring('GEO:geo:'.length, element.length);
        } else {
          location = element
              .substring('GEO:'.length, element.length)
              .replaceAll(';', ',');
        }
      }
    }
    location = location.replaceAll('S', '-');
    location = location.replaceAll('N', '');
    location = location.replaceAll('W', '-');
    location = location.replaceAll('E', '');
    return location;
  }

  void launch(BuildContext context, String url) {
    try {
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)
          .onError((error, stackTrace) {
        ShowDialog.show(
          context,
          content: '${S.of(context).canNotOpen}\n$url',
        );
        return true;
      });
    } catch (e) {
      ShowDialog.show(
        context,
        content: '${S.of(context).canNotOpen}\n$url',
      );
    }
  }

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
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
