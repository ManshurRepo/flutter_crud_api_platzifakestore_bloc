import 'package:fic4_project/data/local_datasources/auth_local_storage.dart';
import 'package:fic4_project/data/models/request/login_model.dart';
import 'package:fic4_project/data/models/request/register_model.dart';
import 'package:fic4_project/data/models/response/login_respon_model.dart';
import 'package:fic4_project/data/models/response/profile_response_model.dart';
import 'package:fic4_project/data/models/response/register_response_model.dart';
import 'package:http/http.dart' as http;

class AuthDatasource {
  Future<RegisterResponseModel> register(RegisterModel registerModel) async {
    final response =
        await http.post(Uri.parse('https://api.escuelajs.co/api/v1/users/'),
            // headers: {'Content-Type': 'Content-Type'},
            body: registerModel.toMap());
    final result = RegisterResponseModel.fromJson(response.body);
    return result;
  }

  Future<LoginResponseModel> login(LoginModel loginModel) async {
    final response = await http.post(
        Uri.parse('https://api.escuelajs.co/api/v1/auth/login'),
        body: loginModel.toMap());
    final result = LoginResponseModel.fromJson(response.body);
    return result;
  }

  Future<ProfileResponseModel> getProfil() async {
    final token = await AuthLocalStorage().getToken();
    var headers = {
      'Authorization':
          'Bearer $token'
    };
    final response = await http.get(
        Uri.parse('https://api.escuelajs.co/api/v1/auth/profile'),
        headers: headers, );
    final result = ProfileResponseModel.fromJson(response.body);
    return result;
  }
}
