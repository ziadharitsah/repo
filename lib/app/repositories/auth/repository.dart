part of 'api.dart';

class ApiDataSource {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<ApiResponse> login(RequestLogin request) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response =
          await http.post(Uri.parse('http://192.168.1.7:8000/api/login'),
              headers: {
                'Accept': 'application/json',
                // 'Content-Type': 'application/json',
              },
              body: request.toMap());

      switch (response.statusCode) {
        case 200:
          apiResponse.data = Response.fromJson(jsonDecode(response.body));
          break;
        case 422:
          final errors = jsonDecode(response.body)['errors'];
          apiResponse.error = errors[errors.keys.elementAt(0)][0];
          break;
        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;
        default:
          apiResponse.error = "somethingWentWrong";
          break;
      }
    } catch (e) {
      apiResponse.error = "serverError";
    }

    return apiResponse;
  }

  Future<ApiResponse> register(RequestRegister request) async {
    ApiResponse apiResponse = ApiResponse();
    try {
      final response = await http.post(Uri.parse(registerUrl),
          headers: {
            'Accept': 'application/json',
            // 'Content-Type': 'application/json',
          },
          body: request.toMap());

      switch (response.statusCode) {
        case 200:
          apiResponse.data = Response.fromJson(jsonDecode(response.body));
          break;
        case 422:
          final errors = jsonDecode(response.body)['errors'];
          apiResponse.error = errors[errors.keys.elementAt(0)][0];
          break;
        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;
        default:
          apiResponse.error = "somethingWentWrong";
          break;
      }
    } catch (e) {
      apiResponse.error = "serverError";
    }

    return apiResponse;
  }

  Future<ApiResponse> user() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      var token = await hasToken();
      final response = await http.get(
        Uri.parse(userUrl),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      switch (response.statusCode) {
        case 200:
          apiResponse.data = ResponseUser.fromJson(jsonDecode(response.body));
          break;
        case 401:
          apiResponse.error = "unauthorized";
          break;
        default:
          apiResponse.error = "somethingWentWrong";
          break;
      }
    } catch (e) {
      apiResponse.error = "serverError";
    }

    return apiResponse;
  }

  Future<bool> hasToken() async {
    var value = await storage.read(key: 'access_token');
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> persistToken(String token) async {
    await storage.write(key: 'access_token', value: token);
  }

  Future<void> deleteToken() async {
    storage.delete(key: 'token');
    storage.deleteAll();
  }
}





// Future hasToken() async {
  //   Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  //   final SharedPreferences local = await _prefs;
  //   final String? token = local.getString("access_token");
  //   if (token != null) return token;
  //   return null;
  // }

  // Future persisToken(String token) async {
  //   Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  //   final SharedPreferences local = await _prefs;
  //   local.setString('access_token', token);
  // }

  // // Future<void> deleteToken() async {
  // //   storage.delete(key: 'access_token');
  // //   storage.deleteAll();
  // // }

  // String? getStringImage(File? file) {
  //   if (file == null) return null;
  //   return base64Encode(file.readAsBytesSync());
  // }