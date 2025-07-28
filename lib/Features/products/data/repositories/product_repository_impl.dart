import 'package:fashion/core/network/error/exceptions.dart';
import 'package:fashion/core/network/network_info.dart';
import 'package:fashion/features/products/data/datasources/product_remote_data_source.dart';
import 'package:fashion/features/products/domain/repo_interface/product_repository.dart';
import 'package:fashion/features/products/domain/entities/product.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<Product>> getProductsByCategory(String categoryId) async {
    if (await networkInfo.isConnected) {
      try {
        final products = await remoteDataSource.getProductsByCategory(categoryId);
        return products;
      } on NetworkException {
        rethrow;
      } catch (e) {
        throw CustomException(e.toString());
      }
    } else {
      throw NoInternetConnectionException();
    }
  }

  @override
  Future<List<Product>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final products = await remoteDataSource.getAllProducts();
        return products;
      } on NetworkException {
        rethrow;
      } catch (e) {
        throw CustomException(e.toString());
      }
    } else {
      throw NoInternetConnectionException();
    }
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final products = await remoteDataSource.searchProducts(query);
        return products;
      } on NetworkException {
        rethrow;
      } catch (e) {
        throw CustomException(e.toString());
      }
    } else {
      throw NoInternetConnectionException();
    }
  }
}