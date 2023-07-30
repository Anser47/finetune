import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:fine_tune/db/fav_function.dart';
import 'package:fine_tune/model/model.dart';
part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesState(isfav: false)) {
    on<AddToFavoriteEvent>(
      (event, emit) {
        if (state.isfav) {
          deletefav(event.song);
          emit(FavoritesState(isfav: false));
        } else {
          addtofav(event.song);
          emit(FavoritesState(isfav: true));
        }
        //addtofav(event.song);
        // return emit(FavoritesState(isfav: isFavsong(event.song)));
      },
    );
    on<FavCheckEvent>((event, emit) {
      bool fav = isFavsong(event.song);
      emit(FavoritesState(isfav: fav));
    });
  }
}
