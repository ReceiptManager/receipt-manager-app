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
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:receipt_manager/factory/padding_factory.dart';
import 'package:receipt_manager/theme/color/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'discovery_model.dart';
import 'package:receipt_manager/generated/l10n.dart';

/// Allows to display all discovered services.
class ServiceList extends StatelessWidget {
  final emptyImagePath = "assets/not_empty";

  SharedPreferences prefs;
  ServiceList(this.prefs);

  @override
  Widget build(BuildContext context) {
    BonsoirDiscoveryModel model = context.watch<BonsoirDiscoveryModel>();
    List<ResolvedBonsoirService> discoveredServices = model.discoveredServices;
    if (discoveredServices.isEmpty) {
      return new Center(
          child: Column(children: [
        Container(
            color: Colors.white,
            child: PaddingFactory.create(Column(
              children: [
                PaddingFactory.create(
                  SvgPicture.asset(
                    this.emptyImagePath,
                    height: 250,
                  ),
                ),
                PaddingFactory.create(Text(
                  S.of(context).noReceiptServer,
                  style: TextStyle(fontSize: 16, color: LightColor.grey),
                ))
              ],
            )))
      ]));
    }
    return ListView.builder(
      itemCount: discoveredServices.length,
      itemBuilder: (context, index) =>
          _ServiceWidget(service: discoveredServices[index],  prefs: prefs,),
    );
  }
}

/// Allows to display a discovered service.
class _ServiceWidget extends StatelessWidget {
  /// The discovered service.
  final ResolvedBonsoirService service;

  /// Shared prefs
  final SharedPreferences prefs;

  /// Creates a new service widget.
  const _ServiceWidget({
    @required this.prefs, @required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return PaddingFactory.create(InkWell(
        onTap: () {
          prefs.setString("ipv4", service.ip);

          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Text(S.of(context).updateServerIP),
              backgroundColor: Colors.green,
            ));
        },
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ClipPath(
              child: Container(
                  color: Colors.white,
                  child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      subtitle: Row(
                        children: <Widget>[
                          Text(
                              "Typ: ${service.type}, Port: ${service.port}, IP: ${service.ip}",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12))
                        ],
                      ),
                      title: Text(
                        service.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ))),
              clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
            ))));
  }
}
