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

import 'package:animated_stack/animated_stack.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:receipt_manager/app/pages/home/home_controller.dart';
import 'package:receipt_manager/app/widgets/form/input_form.dart';
import 'package:receipt_manager/app/widgets/stack/stack_bottom_widget.dart';
import 'package:receipt_manager/app/widgets/stack/stack_column_widget.dart';
import 'package:receipt_manager/data/repository/data_receipts_repository.dart';
import 'package:receipt_manager/generated/l10n.dart';

class HomePage extends View {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ViewState<HomePage, HomeController> {
  _HomePageState() : super(HomeController(DataReceiptRepository()));

  @override
  Widget get view => Material(
      child: AnimatedStack(
          backgroundColor: Colors.transparent,
          fabBackgroundColor: Colors.red,
          buttonIcon: Icons.workspaces_filled,
          fabIconColor: Colors.white,
          animateButton: true,
          foregroundWidget: Scaffold(
              key: globalKey,
              backgroundColor: Colors.white,
              appBar: NeumorphicAppBar(title: Text(S.of(context).addReceipt)),
              body: InputForm()),
          columnWidget: StackColumnWidget(),
          bottomWidget: BottomColumnWidget()));
}
