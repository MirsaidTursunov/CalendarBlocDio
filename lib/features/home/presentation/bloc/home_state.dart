part of 'home_bloc.dart';

class HomeState extends Equatable {
  final GetDateResponse? dateResult;
  final List<GetColorsResponse>? colorsData;
  final FormzStatus? status;
  final DateTime? selectedDate;
  final CalendarMonthData? calendarMonthData;

  const HomeState({
    this.dateResult,
    this.colorsData,
    this.status = FormzStatus.pure,
    this.selectedDate,
    this.calendarMonthData,
  });

  HomeState copyWith({
    GetDateResponse? dateResult,
    List<GetColorsResponse>? colorsData,
    FormzStatus? status,
    DateTime? selectedDate,
    CalendarMonthData? calendarMonthData,
  }) {
    return HomeState(
      dateResult: dateResult ?? this.dateResult,
      colorsData: colorsData ?? this.colorsData,
      status: status ?? this.status,
      selectedDate: selectedDate ?? this.selectedDate,
      calendarMonthData: calendarMonthData ?? this.calendarMonthData,
    );
  }

  @override
  List<Object?> get props => [
    dateResult,
    colorsData,
    status,
    selectedDate,
    calendarMonthData
  ];
}