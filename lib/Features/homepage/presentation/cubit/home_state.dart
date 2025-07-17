import '../../domain/entities/product_category.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<ProductCategory> categories;

  const HomeLoaded(this.categories);
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);
}