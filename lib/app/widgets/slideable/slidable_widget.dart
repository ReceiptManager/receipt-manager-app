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
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:receipt_manager/data/storage/scheme/holder_table.dart';

class SlidableHistoryWidget extends StatelessWidget {
  final String deleteText;
  var deleteMethod;

  final String editText;
  var editMethod;
  final Image image;

  final ReceiptHolder holder;

  SlidableHistoryWidget(
      {required this.deleteText,
      required this.deleteMethod,
      required this.editText,
      required this.editMethod,
      required this.image,
      required this.holder});

  @override
  Widget build(BuildContext context) {
    String totalString =
        holder.receipt.total.toStringAsFixed(2) + holder.receipt.currency;
    String dateString = DateFormat.yMMMd().format(holder.receipt.date);

    return Slidable(
        actionPane: SlidableDrawerActionPane(),
        closeOnScroll: true,
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: deleteText,
            color: Colors.red,
            icon: Icons.delete,
          ),
          IconSlideAction(
              caption: editText, icon: Icons.update, color: Colors.black),
        ],
        child: Card(
            shadowColor: Colors.black,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ClipPath(
              child: Container(
                  color: Colors.white,
                  child: ListTile(
                      leading: Container(
                          width: 50,
                          height: 50,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: image)),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      trailing: Text(
                        totalString,
                        style: TextStyle(
                            color: holder.receipt.total < 0
                                ? Colors.green
                                : Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Text(dateString,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12))
                        ],
                      ),
                      title: Text(
                        holder.store.storeName,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ))),
              clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
            )));
  }
}
