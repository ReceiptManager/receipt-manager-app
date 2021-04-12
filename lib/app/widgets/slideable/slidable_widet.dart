import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:receipt_manager/data/storage/receipt_database.dart';

class SlidableHistoryWidget extends StatelessWidget {
  final String deleteText;
  final Function() deleteMethod;

  final String editText;
  final Function() editMethod;
  final String imagePath;

  final Receipt receipt;

  SlidableHistoryWidget(
      {required this.deleteText,
      required this.deleteMethod,
      required this.editText,
      required this.editMethod,
      required this.imagePath,
      required this.receipt});

  @override
  Widget build(BuildContext context) {
    String totalString =
        receipt.total.toStringAsFixed(2) + receipt.total.toString();

    return Slidable(
        actionPane: SlidableDrawerActionPane(),
        closeOnScroll: true,
        secondaryActions: <Widget>[
          IconSlideAction(
              caption: deleteText,
              color: Colors.red,
              icon: Icons.delete,
              onTap: deleteMethod),
          IconSlideAction(
              caption: editText,
              icon: Icons.update,
              color: Colors.black,
              onTap: editMethod),
        ],
        child: Card(
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
                            child: Image.asset(
                              imagePath,
                              fit: BoxFit.fill,
                            ),
                          )),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      trailing: Text(
                        totalString,
                        style: TextStyle(
                            color:
                                receipt.total < 0 ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Text(
                              receipt.category.toString() +
                                  ", " +
                                  receipt.date.toString() +
                                  (receipt.tag!.isEmpty
                                      ? ''
                                      : ', ' + receipt.tag.toString()),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12))
                        ],
                      ),
                      title: Text(
                        receipt.store.toString(),
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
