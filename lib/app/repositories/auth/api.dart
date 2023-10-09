import 'dart:convert';

import 'package:app/app/models/auth/response/response_token.dart';
import 'package:app/app/models/auth/response/response_user.dart';
import 'package:app/app/repositories/auth/api_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../models/auth/request/request_login.dart';
import '../../models/auth/request/request_register.dart';
part 'repository.dart';

const baseUrl = 'http://192.168.1.7:8000/api/';
const loginUrl = '$baseUrl login';
const registerUrl = '$baseUrl register';
const userUrl = '$baseUrl user';
