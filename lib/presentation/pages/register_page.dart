import 'package:fic4_project/bloc/register/register_bloc.dart';
import 'package:fic4_project/data/models/request/register_model.dart';
import 'package:fic4_project/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController!.dispose();
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
                decoration: const InputDecoration(labelText: 'name'),
                controller: nameController),
            TextField(
                decoration: const InputDecoration(labelText: 'email'),
                controller: emailController),
            TextField(
              decoration: const InputDecoration(labelText: 'password'),
              controller: passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 15),
            BlocConsumer<RegisterBloc, RegisterState>(
              listener: (context, state) {
                if (state is RegisterLoaded) {
                  nameController!.clear();
                  emailController!.clear();
                  passwordController!.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Register Sucess, ID Anda: ${state.model.id}, Silahkan Login'),
                    ),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginPage();
                      },
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is RegisterLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ElevatedButton(
                  onPressed: () {
                    final requestModel = RegisterModel(
                        name: nameController!.text,
                        email: emailController!.text,
                        password: passwordController!.text);
                    context
                        .read<RegisterBloc>()
                        .add(SaveRegisterEvent(request: requestModel));
                  },
                  child: const Text('Register'),
                );
              },
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LoginPage();
                }));
              },
              child: const Text(
                'Kembali ke Login Page',
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
