// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:fic4_project/data/datasources/auth_datasources.dart';
import 'package:fic4_project/data/models/response/profile_response_model.dart';

part 'profil_event.dart';
part 'profil_state.dart';

class ProfilBloc extends Bloc<ProfilEvent, ProfilState> {
  final AuthDatasource authDatasource;
  ProfilBloc(
    this.authDatasource,
  ) : super(ProfileInitial()) {
    on<GetProfilEvent>((event, emit) async {
      try {
        emit(ProfileLoading());
        final result = await authDatasource.getProfil();
        emit(ProfileLoaded(profil: result));
      } catch (e) {
        emit(ProfileError(message: 'Server Error: ${e.toString()}'));
      }
    });
  }
}
