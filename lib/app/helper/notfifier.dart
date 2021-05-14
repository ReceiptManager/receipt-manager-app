/*
 * Copyright (c) 2020 - 2021 : William Todt
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

// ignore: import_of_legacy_library_into_null_safe
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class UserNotifier {
  static void fail(String msg, BuildContext context) {
    print(msg);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.red,
    ));
  }

  static void success(String msg, BuildContext context) {
    print(msg);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Colors.green,
    ));
  }

  static msg(String title, String body) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 120,
            hideLargeIconOnExpand: false,
            locked: false,
            notificationLayout: NotificationLayout.Inbox,
            channelKey: 'receipt_manager_channel',
            title: title,
            body: body),
        actionButtons: [
          NotificationActionButton(
              key: 'EDIT',
              label: 'Editieren',
              buttonType: ActionButtonType.Default),
        ]);
  }

  static Future<void> progress(final int progress) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 100,
            channelKey: "receipt_manager_channel",
            title: "Upload receipt",
            notificationLayout: NotificationLayout.ProgressBar,
            progress: progress,
            locked: false));
    if (progress == 100)
      await AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 110,
              notificationLayout: NotificationLayout.Default,
              channelKey: 'receipt_manager_channel',
              title: 'Kassenbeleg wurde erfolgreich hochgeladen',
              body: 'Dein Kassenbeleg wird gerade bearbeitet.'));
  }
}
