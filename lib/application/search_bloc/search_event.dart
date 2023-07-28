part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SeachWord extends SearchEvent {
  final String searchValue;
  SeachWord({required this.searchValue});
}
