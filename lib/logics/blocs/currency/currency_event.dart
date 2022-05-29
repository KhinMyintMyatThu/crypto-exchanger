part of 'currency_bloc.dart';

abstract class CurrencyEvent extends Equatable {
  const CurrencyEvent();

  @override
  List<Object> get props => [];
}

class LoadCurrencies extends CurrencyEvent {}

class UpdateCurrencies extends CurrencyEvent {
  final List<Currency> currencies;

  const UpdateCurrencies(this.currencies);

  @override
  List<Object> get props => [currencies];
}

class ErrorFetching extends CurrencyEvent {}