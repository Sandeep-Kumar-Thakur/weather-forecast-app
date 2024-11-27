part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class GetLocationEvent extends HomeEvent{}
class SearchCityEvent extends HomeEvent{}
class UpdateCityEvent extends HomeEvent{}
class NoConnectionEvent extends HomeEvent{}
class HaveConnectionEvent extends HomeEvent{}