import '../../domain/entities/search_result.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final SearchResult searchResult;

  SearchLoaded({required this.searchResult});
}

class SearchError extends SearchState {
  final String message;

  SearchError({required this.message});
}