import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:receipt_parser/bloc/moor/bloc.dart';
import 'package:receipt_parser/database//receipt_database.dart';
import 'package:receipt_parser/date/date_manipulator.dart';
import 'package:receipt_parser/factory/categories_factory.dart';
import 'package:receipt_parser/model/receipt_category.dart';
import 'package:receipt_parser/theme/theme_manager.dart';

class HistoryWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HistoryWidgetState();
}

class HistoryWidgetState extends State<HistoryWidget> {
  DbBloc _bloc;
  List<Receipt> receipts;
  DateTime receiptDate;

  final _dropKey2 = GlobalKey<FormState>();

  // Main field controller handle every input in the form
  TextEditingController storeNameController;
  TextEditingController receiptTotalController;
  TextEditingController dateController;

  TextEditingController _controller = TextEditingController();

  List<ReceiptCategory> categories = ReceiptCategoryFactory.get();


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

  IconButton _buildDateButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.calendar_today,
        color: Colors.purple,
      ),
      onPressed: () async {
        receiptDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2010),
            lastDate: DateTime(2050));
        setState(() {
          dateController.text = DateFormat("dd.MM.yyyy").format(receiptDate);
        });
      },
    );
  }

  _showDialog({controller, receipt}) async {
    await showDialog<String>(
      context: context,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        var selectedCategory;
        return AlertDialog(
            title: Text('Update Task'),
            backgroundColor: Colors.blueAccent,
            content: Container(
              height: 400,
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 0.50,
              child: CustomScrollView(
                  slivers: [
                  SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                      children: <Widget>[
                  Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      new Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Theme(
                              data: ThemeManager.getTheme(),
                              child: TextFormField(
                                style: TextStyle(color: Colors.white),
                                decoration: new InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.white),
                                  ),
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.white)),
                                  hintText: 'Store name',
                                  labelText: 'Store name',
                                  helperText: "Set the store name",
                                  prefixIcon: const Icon(
                                    Icons.storefront_outlined,
                                    color: Colors.white,
                                  ),
                                  prefixText: ' ',
                                ),
                                controller: storeNameController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter a store name.';
                                  }
                                  return null;
                                },
                              ))),

                      new Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Theme(
                              data: ThemeManager.getTheme(),
                              child: TextFormField(
                                style: TextStyle(color: Colors.white),
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.white),
                                  ),
                                  border: new OutlineInputBorder(
                                      borderSide: new BorderSide(
                                          color: Colors.white)),
                                  hintText: 'Receipt total',
                                  labelText: 'Receipt total',
                                  helperText: "Set the receipt total",
                                  prefixIcon: const Icon(
                                    Icons.attach_money,
                                    color: Colors.white,
                                  ),
                                  prefixText: ' ',
                                ),
                                controller: receiptTotalController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some total.';
                                  }
                                  RegExp totalRegex = new RegExp(
                                      "^(?=.*[1-9])[0-9]*[.]?[0-9]{2}\$",
                                      caseSensitive: false,
                                      multiLine: false);

                                  if (!totalRegex.hasMatch(value)) {
                                    return "Total is invalid.";
                                  }

                                  return null;
                                },
                              ))),
                      new Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Theme(
                              data: ThemeManager.getTheme(),
                              child: TextFormField(
                                style: TextStyle(color: Colors.white),
                                keyboardType: TextInputType.number,
                                decoration: new InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.white),
                                    ),
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.white)),
                                    hintText: 'Receipt date',
                                    labelText: 'Receipt date',
                                    helperText: "Set the receipt date",
                                    prefixIcon:
                                    _buildDateButton(context)),
                                controller: dateController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some date';
                                  }
                                  RegExp totalRegex = new RegExp(
                                      "^(0?[1-9]|[12][0-9]|3[01])[.\\/ ]?(0?[1-9]|1[0-2])[./ ]?(?:19|20)[0-9]{2}\$",
                                      caseSensitive: false,
                                      multiLine: false);

                                  if (!totalRegex
                                      .hasMatch(value.trim())) {
                                    return "Date is not formatted (dd.MM.YYYY).";
                                  }

                                  return null;
                                },
                              ))), new Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Container(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0),
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  border:
                                  Border.all(color: Colors.white)),
                              child: DropdownButton<ReceiptCategory>(
                                  key: _dropKey2,
                                  dropdownColor: Colors.blueAccent,
                                  style: TextStyle(color: Colors.grey),
                                  hint: Text("Select receipt category"),
                                  value: selectedCategory,
                                  isExpanded: true,
                                  onChanged: (ReceiptCategory value) {
                                    setState(() {
                                      selectedCategory = value;
                                    });
                                  },
                                  items: categories
                                      .map((ReceiptCategory user) {
                                    return DropdownMenuItem<
                                        ReceiptCategory>(
                                      value: user,
                                      child: Row(
                                        children: <Widget>[
                                          user.icon,
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            user.name,
                                            style: TextStyle(
                                                color: Colors.black87),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList()))),
                    ],
                  )
              ),
            )],
        ))],
        )),
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
