// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_product_bloc.dart';

@immutable
sealed class CreateProductEvent {}

class DoCreateProduct extends CreateProductEvent {
  final ProductModel productModel;
  DoCreateProduct({
    required this.productModel,
  });
}
