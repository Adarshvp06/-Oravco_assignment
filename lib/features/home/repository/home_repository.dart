import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oravco_assignment/core/api/api_constants.dart';
import 'package:oravco_assignment/features/home/model/product_model.dart';

import '../../../core/exception/custom_exception.dart';
import '../../../core/api/api_service.dart';

final homeRepositoryProvier = Provider<HomeRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return HomeRepository(dio: dio);
});

class HomeRepository {
  final Dio dio;
  HomeRepository({required this.dio});

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await dio.get(ApiConstants.productListing);
      final data = response.data as List;
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      throw CustomException.fromError(e);
    }
  }

  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await dio.get('${ApiConstants.productListing}/$id');
      return ProductModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw CustomException.fromError(e);
    }
  }
}
