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
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ReceiptCategory {
  const ReceiptCategory(this.name, this.icon, this.path);

  final String name;
  final String path;
  final Icon icon;

  ReceiptCategory.fromJson(Map<String, dynamic> json)
      : name = json == null ? "util" : json['name'],
        path = json == null ? "util" : json['path'],
        icon = null;

  Map<String, dynamic> toJson() => {'name': name, 'path': path};
}
