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

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ScrollWidget extends StatelessWidget {
  final Widget widget;
  final ScrollController controller;

  const ScrollWidget({required this.widget, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            controller.jumpTo(controller.position.maxScrollExtent);
          });
        },
        child: widget);
  }
}
