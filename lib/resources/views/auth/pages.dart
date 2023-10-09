import 'dart:io';

import 'package:app/app/bloc/auth/loign_bloc/login_bloc.dart';
import 'package:app/app/bloc/authenticated/auth_bloc.dart';
import 'package:app/app/models/auth/request/request_login.dart';
import 'package:app/app/repositories/auth/api.dart';
import 'package:app/resources/component/common/custom_form_button.dart';
import 'package:app/resources/component/common/custom_input_field.dart';
import 'package:app/resources/component/common/page_header.dart';
import 'package:app/resources/component/common/page_heading.dart';
import 'package:app/resources/views/dashboard/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'login.dart';
// part 'register.dart';
// part 'forgot_password.dart';
part 'login_route.dart';
