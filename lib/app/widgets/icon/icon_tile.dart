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

import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class IconTile extends StatelessWidget {
  final double width;
  final double height;
  final IconData iconData;
  final Function()? fun;

  const IconTile(
      {Key? key,
      required this.width,
      required this.height,
      required this.iconData,
      required this.fun})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Color(0xFFEFEFF4),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: IconButton(
          icon: Icon(
            iconData,
            color: Colors.black,
          ),
          onPressed: fun,
        ));
  }
}
