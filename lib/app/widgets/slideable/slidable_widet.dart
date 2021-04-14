// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:receipt_manager/data/storage/receipt_database.dart';

class SlidableHistoryWidget extends StatelessWidget {
  final String deleteText;
  var deleteMethod;

  final String editText;
  var editMethod;
  final Image image;

  final Receipt receipt;

  SlidableHistoryWidget(
      {required this.deleteText,
      required this.deleteMethod,
      required this.editText,
      required this.editMethod,
      required this.image,
      required this.receipt});

  @override
  Widget build(BuildContext context) {
    String totalString = receipt.total.toStringAsFixed(2);
    String dateString = DateFormat.yMMMd().format(receipt.date);

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
                            color:
                                receipt.total < 0 ? Colors.green : Colors.black,
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
                        receipt.storeName,
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
