part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class FetchMonthEvent extends HomeEvent {
  const FetchMonthEvent();

  @override
  List<Object?> get props => [];
}

class FetchColorsEvent extends HomeEvent {
  const FetchColorsEvent();

  @override
  List<Object?> get props => [];
}

class SelectDayEvent extends HomeEvent {
  final DateTime newDate;

  const SelectDayEvent({required this.newDate});

  @override
  List<Object?> get props => [newDate];
}
