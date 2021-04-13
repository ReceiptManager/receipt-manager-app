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
  final String imagePath;

  final ReceiptHolder receiptHolder;

  SlidableHistoryWidget(
      {required this.deleteText,
      required this.deleteMethod,
      required this.editText,
      required this.editMethod,
      required this.imagePath,
      required this.receiptHolder});

  @override
  Widget build(BuildContext context) {
    String totalString = receiptHolder.receipt.total.toStringAsFixed(2);
    String dateString = DateFormat.yMMMd().format(receiptHolder.receipt.date);

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
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ClipPath(
              child: Container(
                  color: Color(0xFFEFEFF7),
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
                            color: receiptHolder.receipt.total < 0
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold,
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
                        receiptHolder.receipt.storeName,
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
