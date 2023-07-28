part of 'search_bloc.dart';

class SearchState {
  List<AudioModel> songModelistBloc;
  SearchState({required this.songModelistBloc});
}

class SearchInitial extends SearchState {
  SearchInitial() : super(songModelistBloc: allsongbloc);
}
