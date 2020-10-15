import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:receipt_parser/bloc/moor/bloc.dart';
import 'package:receipt_parser/converter/color_converter.dart';
import 'package:receipt_parser/database//receipt_database.dart';
import 'package:receipt_parser/date/date_manipulator.dart';
import 'package:receipt_parser/factory/categories_factory.dart';
import 'package:receipt_parser/factory/padding_factory.dart';
import 'package:receipt_parser/factory/text_form_history.dart';
import 'package:receipt_parser/model/receipt_category.dart';
import 'package:receipt_parser/theme/theme_manager.dart';

class HistoryWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HistoryWidgetState();
}

class HistoryWidgetState extends State<HistoryWidget> {
  final _editFormKey = GlobalKey<FormState>();
  DbBloc _bloc;
  List<Receipt> receipts;
  DateTime receiptDate;

  TextEditingController storeNameController;
  TextEditingController receiptTotalController;
  TextEditingController dateController;
  TextEditingController _controller = TextEditingController();

  List<ReceiptCategory> categories = ReceiptCategoryFactory.get();

  String receiptCategory;
  ReceiptCategory selectedCategory;

  @override
  void initState() {
    storeNameController = TextEditingController();
    receiptTotalController = TextEditingController();
    dateController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<DbBloc>(context);
    _bloc.add(ReceiptAllFetch());

    return BlocBuilder(
      cubit: _bloc,
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
        return Container(color: Colors.white);
      },
    );
  }

  _buildList(r) {
    return new Container(
        color: Colors.white,
        child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: r.length,
            itemBuilder: (_, index) {
              final receipt = r[index];
              return _buildListItems(receipt);
            }));
  }

  Widget _buildListItems(Receipt receipt) {
    String path = "assets/" +
        receipt.category.split(" ")[0].toLowerCase().trim() +
        ".png";

    return Slidable(
        actionPane: SlidableDrawerActionPane(),
        closeOnScroll: true,
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              _bloc.add(DeleteEvent(receipt: receipt));
              _bloc.add(ReceiptAllFetch());
            },
          ),
          IconSlideAction(
            caption: 'Update',
            foregroundColor: HexColor.fromHex("#F9AA33"),
            color: HexColor.fromHex("#232F34"),
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
                    color: Colors.white, backgroundBlendMode: BlendMode.darken),
                child: ListTile(
                    leading: Container(
                        width: 40,
                        height: 40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.asset(
                            path,
                            fit: BoxFit.fill,
                          ),
                        )),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    trailing: Text(
                      "-" + receipt.receiptTotal + "€",
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w300,
                          fontSize: 20),
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        Text(
                            receipt.category +
                                ", " +
                                DateManipulator.humanDate(receipt.receiptDate),
                            style: TextStyle(color: Colors.black))
                      ],
                    ),
                    title: Text(
                      receipt.shopName,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 18),
                    )))));
  }

  Container createEditMenu({hint, icon, controller}) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.blueAccent,
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

  String storeName;
  String receiptTotal;
  String currentReceiptDate;
  String category;

  _showDialog({controller, Receipt receipt}) async {
    storeName = receipt.shopName;
    receiptTotal = receipt.receiptTotal;
    currentReceiptDate = DateManipulator.humanDate(receipt.receiptDate);
    category = receipt.category;

    storeNameController.text = storeName;
    receiptTotalController.text = receiptTotal;
    dateController.text = currentReceiptDate;

    await showDialog<String>(
      context: context,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          titleTextStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w400, fontSize: 22),
          backgroundColor: Colors.white,
          title: Text('Update Task'),
          content: Container(
            height: 300,
            width: 250,
            color: Colors.white,
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                    hasScrollBody: false,
                    child: Form(
                        key: _editFormKey,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: PaddingFactory.create(Column(
                                children: <Widget>[
                                  PaddingFactory.create(new Theme(
                                      data: ThemeManager.getTheme(),
                                      child: TextFormFactory.storeName(
                                          storeNameController))),
                                  PaddingFactory.create(new Theme(
                                      data: ThemeManager.getTheme(),
                                      child: TextFormFactory.total(
                                          receiptTotalController))),
                                  PaddingFactory.create(new Theme(
                                      data: ThemeManager.getTheme(),
                                      child: TextFormFactory.date(
                                          dateController,
                                          receiptDate,
                                          context))),
                                ],
                              )),
                            )
                          ],
                        )))
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                'Update',
                style: TextStyle(color: HexColor.fromHex("#F9AA33")),
              ),
              onPressed: () {
                if (_editFormKey.currentState.validate()) {
                  try {
                    storeName = storeNameController.text;
                    receiptTotal = receiptTotalController.text;
                  } catch (e) {
                    receiptTotalController.clear();
                    storeNameController.clear();
                    dateController.clear();
                    Navigator.pop(context);
                    return;
                  }

                  _bloc.add(UpdateEvent(
                      receipt: Receipt(
                          category: category,
                          shopName: storeName,
                          receiptTotal: receiptTotal,
                          receiptDate: receiptDate,
                          id: receipt.id)));
                  _bloc.add(ReceiptAllFetch());

                  Scaffold.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text('Update successfully'),
                      backgroundColor: Colors.green,
                    ));

                  _controller.clear();
                  receiptDate = null;
                  storeName = "";
                  receiptTotal = "";
                } else {
                  Scaffold.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text("Failed to update receipt"),
                      backgroundColor: Colors.red,
                    ));
                }

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
