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

import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:receipt_manager/domain/entities/receipt.dart';

class ReceiptUseCase
    extends UseCase<GetReceiptUseCaseParams, ReceiptUseCaseResponse> {
  @override
  Future<Stream<GetReceiptUseCaseParams>> buildUseCaseStream(
      ReceiptUseCaseResponse params) {
    // TODO: implement buildUseCaseStream
    throw UnimplementedError();
  }
}

class GetReceiptUseCaseParams {
  final int _id;

  GetReceiptUseCaseParams(this._id);
}

class ReceiptUseCaseResponse {
  final Receipt _receipt;

  ReceiptUseCaseResponse(this._receipt);
}
