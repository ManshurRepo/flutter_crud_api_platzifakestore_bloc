// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profil_bloc.dart';

@immutable
sealed class ProfilEvent {}

class GetProfilEvent extends ProfilEvent {}
