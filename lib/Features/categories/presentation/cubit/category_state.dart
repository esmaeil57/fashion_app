import '../../domain/entities/category.dart';

abstract class CategoryState {
  const CategoryState();
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoadingMore extends CategoryState {
  final List<Category> currentCategories;

  const CategoryLoadingMore(this.currentCategories);

  @override
  List<Object> get props => [currentCategories];
}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;
  final bool hasReachedMax;
  final int currentPage;
  final bool isLoadingMore;

  const CategoryLoaded({
    required this.categories,
    this.hasReachedMax = false,
    this.currentPage = 1,
    this.isLoadingMore = false,
  });

  CategoryLoaded copyWith({
    List<Category>? categories,
    bool? hasReachedMax,
    int? currentPage,
    bool? isLoadingMore,
  }) {
    return CategoryLoaded(
      categories: categories ?? this.categories,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object> get props => [categories, hasReachedMax, currentPage, isLoadingMore];
}

class CategoryError extends CategoryState {
  final String message;

  const CategoryError(this.message);

  @override
  List<Object> get props => [message];
}