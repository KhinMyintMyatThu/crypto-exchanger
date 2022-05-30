import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/data/models/currency_model.dart';
import 'package:flutter_app/data/repositories/api_repository.dart';
part 'currency_event.dart';
part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  CurrencyBloc() : super(CurrencyLoading()) {
    on<LoadCurrencies>(_onLoadCurrencies);
    on<UpdateCurrencies>(_onUpdateCurrencies);
    on<ErrorFetching>(_onError);
  }

  _onLoadCurrencies(event, Emitter<CurrencyState> emit) async {
    try {
      List<Currency> value = await ApiRepository().getCurrencyData();

      if (value.isNotEmpty) {
        add(UpdateCurrencies(value));
      } else {
        add(ErrorFetching());
      }
    } on Exception catch (e) {
      add(ErrorFetching());
    }
  }

  _onUpdateCurrencies(event, Emitter<CurrencyState> emit) {
    emit(CurrencyLoaded(currencies: event.currencies));
  }

  _onError(event, Emitter<CurrencyState> emit) {
    emit(CurrencyFetchingError());
  }
}
