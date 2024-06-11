
import 'package:admin_plantbazar/bloc/fetch_bloc/fetch_state.dart';
import 'package:admin_plantbazar/models/product_model.dart';
import 'package:admin_plantbazar/view/add_products/screen/added_products.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'fetch_event.dart';
// part 'fetch_state.dart';

class FetchBloc extends Bloc<FetchEvent, FetchState> {
  FetchBloc() : super(FetchInitial()) {
    on<ProductFetchEvent>((event, emit) async {
      List<ProductClass> productFetch = await fetchProducts();
      print('----------------${productFetch.length}');
      emit(FirebaseFetchProductState(listofProducts: productFetch));
    });
  }
}
