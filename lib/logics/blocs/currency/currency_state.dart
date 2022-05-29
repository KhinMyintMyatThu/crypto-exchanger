part of 'currency_bloc.dart';

abstract class CurrencyState extends Equatable {
  const CurrencyState();

  @override
  List<Object> get props => [];
}

class CurrencyInitial extends CurrencyState {}

class CurrencyLoading extends CurrencyState {}

class CurrencyLoaded extends CurrencyState {
  final List<Currency> currencies;
  const CurrencyLoaded({
    this.currencies = const [],
  });

  @override
  List<Object> get props => [currencies];
}

class CurrencyFetchingError extends CurrencyState {}
