part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class LocationFetched extends HomeState {}

final class NoConnection extends HomeState {}
final class HaveConnection extends HomeState {}
