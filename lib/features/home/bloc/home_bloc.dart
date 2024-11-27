import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_forcast/api/api_repo.dart';
import 'package:weather_forcast/features/home/model/forecast_model.dart';
import 'package:weather_forcast/features/search/model/places_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  String? cityName;
  ForecastModel? forecastModel;
  Places? placesModel;
  StreamSubscription<List<ConnectivityResult>>? subscription;

  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetLocationEvent>(_handlerGetLocation);
    on<UpdateCityEvent>(_handlerUpdateCity);
    on<NoConnectionEvent>(_handlerNoConnection);
    on<HaveConnectionEvent>(_handlerHaveConnection);
  }

  FutureOr<void> _handlerGetLocation(
      GetLocationEvent event, Emitter<HomeState> emit) async {
    if (subscription == null) {
      getConnectivityStatus();
    }
    PermissionStatus permissionStatus = await Permission.location.request();
    if (permissionStatus.isDenied) {
      add(GetLocationEvent());
    } else if (permissionStatus.isPermanentlyDenied) {
      openAppSettings();
    } else {
      Position position = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      cityName = placemarks.first.locality;
      forecastModel = await ApiRepo.getForecasting(cityName ?? "");
      emit(LocationFetched());
    }
  }

  FutureOr<void> _handlerUpdateCity(
      UpdateCityEvent event, Emitter<HomeState> emit) async {
    cityName = placesModel!.name;
    forecastModel = await ApiRepo.getForecasting(cityName ?? "");
    emit(LocationFetched());
  }

  getConnectivityStatus() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.none)) {
        add(NoConnectionEvent());
      } else {
        add(HaveConnectionEvent());
      }
      // Received changes in available connectivity types!
    });
  }

  FutureOr<void> _handlerNoConnection(
      NoConnectionEvent event, Emitter<HomeState> emit) {
    emit(NoConnection());
  }

  FutureOr<void> _handlerHaveConnection(
      HaveConnectionEvent event, Emitter<HomeState> emit) {
    add(GetLocationEvent());
    emit(HaveConnection());
  }
}
