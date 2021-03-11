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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipt_manager/generated/l10n.dart';
import 'package:receipt_manager/ui/settings/discovery/discovery_list.dart';

import 'discovery/discovery_model.dart';

class DiscoverSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ChangeNotifierProvider<BonsoirDiscoveryModel>(create: (context) => BonsoirDiscoveryModel()),
    ],
    builder: (context, child) => Scaffold(
      appBar: AppBar(title: Text(S.of(context).detectReceiptServer)),
      backgroundColor: Colors.white,
      body: ServiceList(),
      ),
  );
}