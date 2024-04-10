// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:fic4_project/data/models/response/product_response_model.dart';
import 'package:meta/meta.dart';

import 'package:fic4_project/data/datasources/product_datasources.dart';
import 'package:fic4_project/data/models/request/product_model.dart';

part 'create_product_event.dart';
part 'create_product_state.dart';

class CreateProductBloc extends Bloc<CreateProductEvent, CreateProductState> {
  final ProductDatasource productDatasource;
  CreateProductBloc(
    this.productDatasource,
  ) : super(CreateProductInitial()) {
    on<DoCreateProduct>((event, emit) async {
      emit(CreateProductLoading());
      final result = await productDatasource.createProduct(event.productModel);
      emit(CreateProductLoaded(productResponseModel: result));
    });
  }
}
