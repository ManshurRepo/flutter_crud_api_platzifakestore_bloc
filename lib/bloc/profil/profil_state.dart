// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profil_bloc.dart';

@immutable
sealed class ProfilState {}

class ProfileInitial extends ProfilState {}

class ProfileLoading extends ProfilState {}

class ProfileLoaded extends ProfilState {
  final ProfileResponseModel profil;
  ProfileLoaded({
    required this.profil,
  });
}

class ProfileError extends ProfilState {
  final String message;
  ProfileError({
    required this.message,
  });
}
