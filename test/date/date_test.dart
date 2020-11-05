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

import  'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';

const String dateSting = "2020-10-16 00:00:00";
const String invalidDateSting = "2020x10-16 00:00:00";

void main() {
  testWidgets('Test date parsing', (WidgetTester tester) async {
    DateTime d = DateTime.parse(dateSting);

    expect(2020, d.year);
    expect(10, d.month);
    expect(16, d.day);
  });

  testWidgets('Test date with invalid string', (WidgetTester tester) async {
    expect(() => DateTime.parse(invalidDateSting),
        throwsA(const TypeMatcher<FormatException>()));
  });
}
