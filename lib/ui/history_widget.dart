import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:receipt_parser/bloc/moor/bloc.dart';
import 'package:receipt_parser/db/receipt_database.dart';

class HistoryWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HistoryWidgetState();
}

class HistoryWidgetState extends State<HistoryWidget> {
  bool showCompleted = false;
  DbBloc _bloc;
  List<Receipt> receipts;
  DateTime newTaskDate;
  TextEditingController _nameController;

  @override
  void initState() {
    _nameController = TextEditingController(text: "");
    setState(() {
      if (showCompleted == true) {
        print("true :$showCompleted");
      } else {
        print("false :$showCompleted");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<DbBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("HomePage"),
          actions: <Widget>[_buildSwitchButton()],
        ),
        body: BlocBuilder(
          bloc: _bloc,
          builder: (BuildContext context, state) {
            if (state is InitialState) {
              return Center(
                child: Text("Please Insert Record"),
              );
            }
            if (state is LoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ErrorState) {
              return Center(
                child: Text("Error Occur"),
              );
            }
            if (state is LoadedState) {
              final tasks = state.receipt;
              return Column(
                children: <Widget>[
                  Expanded(child: _buildList(tasks)),
                ],
              );
            }
            return Container();
          },
        ));
  }

  _buildList(tasks) {
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (_, index) {
          final itemTask = tasks[index];
          return _buildListItems(itemTask);
        });
  }

  Widget _buildListItems(Receipt receipt) {
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
          color: Colors.green,
          icon: Icons.update,
          onTap: () {
            _showDialog(controller: _nameController, task: receipt);
          },
        ),
      ],
      child: Container(),
    );
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
                  newTaskDate = await showDatePicker(
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

  _showDialog({controller, task}) async {
    await showDialog<String>(
      context: context,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Update Task'),
          content: Container(
            height: 300,
            width: MediaQuery.of(context).size.width / 0.50,
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
                if (_nameController.text.isNotEmpty) {
                  _bloc.dispatch(UpdateEvent(
                      receipt: task.copyWith(
                          name: _nameController.text,
                          dueDate: newTaskDate ?? null)));
                  _bloc.dispatch(ReceiptAllFetch());
                  _nameController.clear();
                  newTaskDate = null;
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

  Row _buildSwitchButton() {
    return Row(
      children: <Widget>[
        Text("Completed Task"),
        Switch(
            activeColor: Colors.red,
            value: showCompleted,
            onChanged: (newValue) {
              setState(() {
                showCompleted = newValue;
                if (showCompleted) {
                  _bloc.dispatch(SwitchButtonEvent());
                } else {
                  _bloc.dispatch(ReceiptAllFetch());
                }
              });
            })
      ],
    );
  }
}
