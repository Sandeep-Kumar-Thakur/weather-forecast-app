import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_forcast/api/api_repo.dart';

import '../model/places_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  TextEditingController searchController = TextEditingController();
  PlacesModel? placesModel;

  SearchBloc() : super(SearchInitial()) {
    on<SearchEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SearchPlaceEvent>(_handlerSearchPlace);
  }

  FutureOr<void> _handlerSearchPlace(SearchPlaceEvent event, Emitter<SearchState> emit) async{
  placesModel = await ApiRepo.getPlaceSearch(searchController.value.text);
    emit(ShowItemsState());
  }
}
