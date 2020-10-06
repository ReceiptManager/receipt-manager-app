import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:receipt_parser/bloc/moor/bloc.dart';
import 'package:receipt_parser/db/receipt_database.dart';
import 'package:receipt_parser/util/date_manipulator.dart';

class HistoryWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HistoryWidgetState();
}

class HistoryWidgetState extends State<HistoryWidget> {
  DbBloc _bloc;
  List<Receipt> receipts;
  DateTime receiptDate;

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<DbBloc>(context);
    _bloc.dispatch(ReceiptAllFetch());

    return BlocBuilder(
      bloc: _bloc,
      builder: (BuildContext context, state) {
        if (state is LoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ErrorState) {
          return Center(
            child: Text("Error Occur, could not load listview."),
          );
        }
        if (state is LoadedState) {
          final receipt = state.receipt;
          return Column(
            children: <Widget>[Expanded(child: _buildList(receipt))],
          );
        }
        return Container(color: Colors.blueAccent);
      },
    );
  }

  _buildList(r) {
    return new Container(
        color: Colors.blueAccent,
        child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: r.length,
            itemBuilder: (_, index) {
              final receipt = r[index];
              return _buildListItems(receipt);
            }));
  }

  Widget _buildListItems(Receipt receipt) {
    String path = receipt.category.split(" ")[0].toLowerCase().trim() + ".png";

    return Slidable(
        actionPane: SlidableDrawerActionPane(),
        closeOnScroll: true,
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              _bloc.dispatch(DeleteEvent(receipt: receipt));
              _bloc.dispatch(ReceiptAllFetch());
            },
          ),
          IconSlideAction(
            caption: 'Update',
            color: Colors.blueAccent,
            icon: Icons.update,
            onTap: () {
              _showDialog(controller: _controller, receipt: receipt);
            },
          ),
        ],
        child: Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    backgroundBlendMode: BlendMode.darken),
                child: ListTile(
                    leading: Container(
                        width: 40,
                        height: 40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.asset(
                            path,
                            color: Colors.black,
                            fit: BoxFit.fill,
                          ),
                        )),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    trailing: Text(
                      "-" + receipt.receiptTotal + "€",
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        Text(
                            receipt.category +
                                ", " +
                                DateManipulator.humanDate(receipt.receiptDate),
                            style: TextStyle(
                                color: Colors.black))
                      ],
                    ),
                    title: Text(
                      receipt.shopName,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )))));
  }

  Container buildTextField({hint, icon, controller}) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          suffixIcon: Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: IconButton(
                icon: Icon(icon),
                onPressed: () async {
                  receiptDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2010),
                    lastDate: DateTime(2050),
                  );
                }),
          ),
        ),
      ),
    );
  }

  _showDialog({controller, receipt}) async {
    await showDialog<String>(
      context: context,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Update Task'),
          content: Container(
            height: 300,
            width: MediaQuery
                .of(context)
                .size
                .width / 0.50,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  buildTextField(
                    hint: 'update your name',
                    icon: Icons.calendar_today,
                    controller: controller,
                  )
                ],
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
                // Dismiss alert dialog
              },
            ),
            FlatButton(
              child: Text('Add'),
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  _bloc.dispatch(UpdateEvent(
                      receipt: receipt.copyWith(
                          name: _controller.text,
                          dueDate: receiptDate ?? null)));
                  _bloc.dispatch(ReceiptAllFetch());
                  _controller.clear();
                  receiptDate = null;
                  Navigator.of(context).pop();
                } else {
                  Scaffold.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text("Failed is Empty"),
                      backgroundColor: Colors.red,
                    ));
                }
              },
            ),
          ],
        );
      },
    );
  }
}
