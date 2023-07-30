part of 'favorites_bloc.dart';

class FavoritesEvent {}

class FavCheckEvent extends FavoritesEvent {
  final AudioModel song;

  FavCheckEvent(this.song);
}

class AddToFavoriteEvent extends FavoritesEvent {
  final AudioModel song;
  AddToFavoriteEvent({required this.song});
}
