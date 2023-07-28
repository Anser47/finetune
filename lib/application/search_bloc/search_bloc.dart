import 'package:bloc/bloc.dart';
import 'package:fine_tune/db/all_songs_funtion.dart';
import 'package:fine_tune/model/model.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SeachWord>((event, emit) {
      List<AudioModel> searchList = allsongbloc
          .where((element) => element.songname!
              .toLowerCase()
              .contains(event.searchValue.toLowerCase().trim()))
          .toList();
      return emit(SearchState(songModelistBloc: searchList));
    });
  }
}
