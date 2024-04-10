import 'package:fic4_project/bloc/product/create/create_product_bloc.dart';
import 'package:fic4_project/bloc/product/get_all/get_all_product_bloc.dart';
import 'package:fic4_project/bloc/profil/profil_bloc.dart';
import 'package:fic4_project/data/local_datasources/auth_local_storage.dart';
import 'package:fic4_project/data/models/request/product_model.dart';
import 'package:fic4_project/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController? titleController = TextEditingController();
  TextEditingController? descriprionController = TextEditingController();
  TextEditingController? priceController = TextEditingController();

  @override
  void initState() {
    context.read<ProfilBloc>().add(GetProfilEvent());
    context.read<GetAllProductBloc>().add(DoGetAllProduct());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
              padding: const EdgeInsets.only(right: 15),
              onPressed: () {
                AuthLocalStorage().removeToken();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LoginPage();
                }));
              },
              icon: const Icon(Icons.logout_outlined))
        ],
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          BlocBuilder<ProfilBloc, ProfilState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                const Center(child: CircularProgressIndicator());
              }
              if (state is ProfileLoaded) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.profil.name ?? ''),
                    const SizedBox(width: 8),
                    Text(state.profil.email ?? '')
                  ],
                );
              }
              return const Text('No Data');
            },
          ),
          Expanded(
            child: BlocBuilder<GetAllProductBloc, GetAllProductState>(
              builder: (context, state) {
                if (state is GetAllProductLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is GetAllProductLoaded) {
                  return ListView.builder(
                    itemCount: state.listProduct
                        .length, // Tambahkan itemCount untuk menentukan jumlah item dalam ListView
                    itemBuilder: ((context, index) {
                      if (index >= state.listProduct.length) {
                        return const SizedBox(); // Menghindari akses di luar jangkauan daftar
                      }
                      final product = state.listProduct.reversed.toList()[index];
                      return ListTile(
                        leading: CircleAvatar(child: Text('${product.price}')),
                        title: Text(product.title ?? "_"),
                        subtitle: Text(product.description ?? ""),
                      );
                    }),
                  );
                }
                return const Text('No Data');
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('add product'),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextField(
                            decoration:
                                const InputDecoration(labelText: 'title'),
                            controller: titleController),
                        TextField(
                            decoration:
                                const InputDecoration(labelText: 'description'),
                            controller: descriprionController),
                        TextField(
                          decoration: const InputDecoration(labelText: 'price'),
                          controller: priceController,
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel')),
                    BlocListener<CreateProductBloc, CreateProductState>(
                      listener: (context, state) {
                        if (state is CreateProductLoaded) {
                          Navigator.pop(context);
                          context
                              .read<GetAllProductBloc>()
                              .add(DoGetAllProduct());
                        }
                      },
                      child: BlocBuilder<CreateProductBloc, CreateProductState>(
                        builder: (context, state) {
                          if (state is CreateProductLoading) {
                            return const Center(
                              child:  CircularProgressIndicator(),
                            );
                          }
                          return ElevatedButton(
                              onPressed: () {
                                final productModel = ProductModel(
                                    title: titleController!.text,
                                    price: int.parse(priceController!.text),
                                    description: descriprionController!.text);
                                context.read<CreateProductBloc>().add(
                                    DoCreateProduct(
                                        productModel: productModel));
                              },
                              child: const Text('Save'));
                        },
                      ),
                    )
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
     
    );
  }
}
