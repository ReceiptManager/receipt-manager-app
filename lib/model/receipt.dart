/*
 *  Copyright (c) 2020 - William Todt
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:moor/moor.dart';

class Receipts extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get total => text()();

  TextColumn get shop => text()();

  TextColumn get category => text()();

  TextColumn get items => text()();

  DateTimeColumn get date => dateTime()();
}
