import 'package:fic4_project/bloc/login/login_bloc.dart';
import 'package:fic4_project/bloc/register/register_bloc.dart';
import 'package:fic4_project/data/local_datasources/auth_local_storage.dart';
import 'package:fic4_project/data/models/request/register_model.dart';
import 'package:fic4_project/presentation/pages/home_page.dart';
import 'package:fic4_project/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/request/login_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
     isLogin();
    Future.delayed(const Duration(seconds: 2));
   
    super.initState();
  }

  void isLogin() async {
    final isTokenExist = await AuthLocalStorage().isTokenExist();
    if (isTokenExist) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const HomePage();
      }));
    }
  }

  @override
  void dispose() {
    emailController!.dispose();
    passwordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
                decoration: const InputDecoration(labelText: 'email'),
                controller: emailController),
            TextField(
              decoration: const InputDecoration(labelText: 'password'),
              controller: passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 15),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginLoaded) {
                  emailController!.clear();
                  passwordController!.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Login Sucess'),
                    ),
                  );
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const HomePage();
                  }));
                }
              },
              builder: (context, state) {
                if (state is LoginLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ElevatedButton(
                  onPressed: () {
                    final loginModel = LoginModel(
                        email: emailController!.text,
                        password: passwordController!.text);
                    context
                        .read<LoginBloc>()
                        .add(DoLoginEvent(loginModel: loginModel));
                  },
                  child: const Text('Login'),
                );
              },
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const RegisterPage();
                }));
              },
              child: const Text(
                'Belum punya akun? Register',
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
