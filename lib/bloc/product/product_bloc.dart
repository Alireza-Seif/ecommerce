import 'package:ecommerce/bloc/product/product_event.dart';
import 'package:ecommerce/bloc/product/product_state.dart';
import 'package:ecommerce/data/repository/product_detail_repository.dart';
import 'package:ecommerce/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final IProductDetailRepository _productRepository = locator.get();

  ProductBloc() : super(ProductInitState()) {
    on<ProductInitializedEvent>((event, emit) async {
      emit(ProductDetailLoadingState());
      var productImages = await _productRepository.getProductDetailImage(event.productId);
      var productVariant = await _productRepository.getProductVariants(event.productId);
      var productCategory = await _productRepository.getProductCategory(event.categoryId);
      var productProperties = await _productRepository.getProductProperties(event.productId);

      emit(
        ProductDetailResponseState(productImages, productVariant, productCategory ,productProperties),
      );
    });
  }
}
