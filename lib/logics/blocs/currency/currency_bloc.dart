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
    Map<String, dynamic> value = await ApiRepository().getCurrencyData();

    if (!value['hasError']) {
      add(UpdateCurrencies(value['currencies']));
    }else {
      add(ErrorFetching());
    }
  }

  _onUpdateCurrencies(event, Emitter<CurrencyState> emit) {
    emit(CurrencyLoaded(currencies: event.currencies));
  }

  _onError(event, Emitter<CurrencyState> emit){
    emit(CurrencyFetchingError());
  }
}
