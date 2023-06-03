import 'dart:convert';

import 'package:http/http.dart';

import '../error/exceptions.dart';

mixin HandlingExceptionRequest {
  Exception getException({required Response response}) {
    final String message = json.decode(response.body)['message'];

    return ServerException(message);
  }
}
