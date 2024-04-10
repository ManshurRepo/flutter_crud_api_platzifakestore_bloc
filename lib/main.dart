import 'package:fic4_project/bloc/login/login_bloc.dart';
import 'package:fic4_project/bloc/product/create/create_product_bloc.dart';
import 'package:fic4_project/bloc/product/get_all/get_all_product_bloc.dart';
import 'package:fic4_project/bloc/profil/profil_bloc.dart';
import 'package:fic4_project/bloc/register/register_bloc.dart';
import 'package:fic4_project/data/datasources/auth_datasources.dart';
import 'package:fic4_project/data/datasources/product_datasources.dart';
import 'package:fic4_project/presentation/pages/login_page.dart';
import 'package:fic4_project/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(AuthDatasource()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(AuthDatasource()),
        ),
        BlocProvider(
          create: (context) => ProfilBloc(AuthDatasource()),
        ),
        BlocProvider(
          create: (context) => CreateProductBloc(ProductDatasource()),
        ),
        BlocProvider(
          create: (context) => GetAllProductBloc(ProductDatasource()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
