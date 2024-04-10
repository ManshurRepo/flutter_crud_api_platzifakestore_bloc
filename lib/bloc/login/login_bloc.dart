// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:fic4_project/data/local_datasources/auth_local_storage.dart';
import 'package:meta/meta.dart';

import 'package:fic4_project/data/datasources/auth_datasources.dart';
import 'package:fic4_project/data/models/request/login_model.dart';
import 'package:fic4_project/data/models/response/login_respon_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthDatasource authDatasource;
  LoginBloc(
    this.authDatasource,
  ) : super(LoginInitial()) {
    on<DoLoginEvent>((event, emit) async {
      try {
        emit(LoginLoading());
        final result = await authDatasource.login(event.loginModel);
        emit(LoginLoaded(loginResponseModel: result));
        await AuthLocalStorage().saveToken(result.accessToken);
      } catch (e) {
        emit(LoginError(message: 'Server Error'));
      }
    });
  }
}
