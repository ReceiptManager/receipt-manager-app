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
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'package:bonsoir/bonsoir.dart';
import 'package:flutter/material.dart';
import 'package:receipt_manager/ui/settings/discovery/app_service.dart';

/// Provider model that allows to handle Bonsoir broadcasts.
class BonsoirBroadcastModel extends ChangeNotifier {
  /// The current Bonsoir broadcast object instance.
  BonsoirBroadcast _bonsoirBroadcast;

  /// Whether Bonsoir is currently broadcasting the app's service.
  bool _isBroadcasting = false;

  /// Returns wether Bonsoir is currently broadcasting the app's service.
  bool get isBroadcasting => _isBroadcasting;

  /// Starts the Bonsoir broadcast.
  Future<void> start({bool notify = true}) async {
    if (_bonsoirBroadcast == null || _bonsoirBroadcast.isStopped) {
      _bonsoirBroadcast = BonsoirBroadcast(service: await AppService.getService());
      await _bonsoirBroadcast.ready;
    }

    await _bonsoirBroadcast.start();
    _isBroadcasting = true;
    if (notify) {
      notifyListeners();
    }
  }

  /// Stops the Bonsoir broadcast.
  void stop({bool notify = true}) {
    _bonsoirBroadcast?.stop();
    _isBroadcasting = false;
    if (notify) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    stop(notify: false);
    super.dispose();
  }
}