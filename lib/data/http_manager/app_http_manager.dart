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

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:receipt_manager/domain/exceptions/app_exceptions.dart';

import 'http_manager.dart';

const timeout = Duration(seconds: 3);

@Singleton(as: HttpManager)
class AppHttpManager implements HttpManager {
  @override
  Future delete(
      {String url, Map<String, dynamic> query, Map<String, String> headers}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get(
      {String url, Map<String, dynamic> query, Map<String, String> headers}) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future post(
      {String url,
      Map body,
      Map<String, dynamic> query,
      Map<String, String> headers}) {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future put(
      {String url,
      Map body,
      Map<String, dynamic> query,
      Map<String, String> headers}) {
    // TODO: implement put
    throw UnimplementedError();
  }

  dynamic _returnResponse(http.Response response) {
    final responseJson = json.decode(response.body.toString());
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      print('Api response success with $responseJson');
      return responseJson;
    }
    print('Api response error with ${response.statusCode} + ${response.body}');
    switch (response.statusCode) {
      case 400:
        throw BadRequestException();
      case 401:
      case 403:
        throw UnauthorisedException();
      case 415:
        throw BadRequestException();
      case 500:
      default:
        throw ServerException();
    }
  }
}
