import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/models/currency_model.dart';
import 'package:flutter_app/logics/blocs/currency/currency_bloc.dart';
import 'package:flutter_app/utils/widgets/card_widget.dart';
import 'package:flutter_app/utils/widgets/dropdown_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String chosenCurrency = 'ETH-USDT';
  String chosenExchanger = 'BINANCE';

  List<Currency> currencies = [];
  List<String?> cryptoCurrencies = [];

  Currency currency = Currency();

  List<String?> exchangers = [];
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    CurrencyState state =
        BlocProvider.of<CurrencyBloc>(context, listen: true).state;
    if (state is CurrencyLoading) {
      setState(() {
        isLoading = true;
      });
    }
    if (state is CurrencyLoaded) {
      setState(() {
        isLoading = false;
        currencies = state.currencies;
        exchangers = _getExchangers();
        cryptoCurrencies = _getCurrencies();
        currency = _getCurrency();
      });
    }
  }

  _getExchangers() {
    return currencies.map((e) => e.exchangeID).toList().toSet().toList();
  }

  _getCurrencies() {
    return currencies
        .where((e) => e.exchangeID == chosenExchanger)
        .map((e) => e.currencySymbol)
        .toList();
  }

  _getCurrency() {
    return currencies
        .where((e) => e.exchangeID == chosenExchanger)
        .firstWhere((e) => e.currencySymbol == chosenCurrency);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: _titleContainer(),
          toolbarHeight: 270,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(children: [
            BlocBuilder<CurrencyBloc, CurrencyState>(builder: (context, state) {
              if (state is CurrencyLoading) {
                return _showLoading();
              }
              if (state is CurrencyLoaded) {
                return _showCurrencyData();
              }
              if (state is CurrencyFetchingError) {
                return _showError();
              }
              return Container();
            })
          ])),
        ),
      ),
    );
  }

  Widget _showLoading() {
    return const Center(
      child: SpinKitPouringHourGlass(
        color: Colors.black,
        size: 50.0,
      ),
    );
  }

  _titleContainer() {
    return Material(
        elevation: 7.0,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: double.infinity,
          height: 30.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.deepPurpleAccent,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    width: 25.w,
                    child: Text(
                      'Exchanger',
                      style: TextStyle(fontSize: 13.sp, color: Colors.white),
                    )),
                const SizedBox(width: 10),
                DropDownWidget(
                    onChangedCallback: (value) {
                      setState(() {
                        chosenExchanger = value!;
                        cryptoCurrencies = _getCurrencies();
                        currency = _getCurrency();
                      });
                    },
                    dropdownValue: chosenExchanger,
                    valueList: exchangers)
              ]),
              const SizedBox(
                height: 30,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    width: 25.w,
                    child: Text(
                      'Crypto',
                      style: TextStyle(fontSize: 13.sp, color: Colors.white),
                    )),
                const SizedBox(width: 10),
                DropDownWidget(
                    onChangedCallback: (value) {
                      setState(() {
                        chosenCurrency = value!;
                        currency = _getCurrency();
                      });
                    },
                    dropdownValue: chosenCurrency,
                    valueList: cryptoCurrencies),
              ]),
              const SizedBox(
                height: 17,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                    '1 ${currency.baseAsset} ~ ${currency.exchangePrice} ${currency.quoteAsset}',
                    style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                const SizedBox(width: 5),
                (currency.marketChangePrice > 0)
                    ? Text(
                        '(+' +
                            double.parse(currency.marketChangePrice.toString())
                                .toStringAsFixed(2) +
                            '%)',
                        style: TextStyle(color: Colors.green.shade500),
                      )
                    : Text(
                        '(' +
                            double.parse(currency.marketChangePrice.toString())
                                .toStringAsFixed(2) +
                            '%)',
                        style: const TextStyle(color: Colors.red),
                      ),
                (currency.marketChangePrice > 0)
                    ? Icon(Icons.arrow_upward,
                        size: 17, color: Colors.green.shade500)
                    : const Icon(Icons.arrow_downward,
                        size: 17, color: Colors.red)
              ]),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Updated at - ${currency.updatedAt}',
                style: TextStyle(fontSize: 9.sp),
              )
            ],
          ),
        ));
  }

  _showCurrencyData() {
    Map<String, dynamic>? intlCurrencies = currency.intlCurrencies;

    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: intlCurrencies!.length,
        itemBuilder: (context, index) {
          String currencyName = intlCurrencies.keys.elementAt(index);
          return HomeCardWidget(
            flagCode: _getFlagCode(currencyName),
            currencyName: currencyName,
            longTerm: _getLongTerm(currencyName),
            price: num.parse(intlCurrencies[currencyName]['price'].toString())
                .toStringAsFixed(2),
          );
        });
  }

  _showError() {
    return const Center(
      child: Text('Something went wrong'),
    );
  }

  _getFlagCode(currencyName) {
    switch (currencyName) {
      case 'JPY':
        return FlagsCode.JP;
      case 'NZD':
        return FlagsCode.NZ;
      case 'CAD':
        return FlagsCode.CA;
      case 'AUD':
        return FlagsCode.AU;
      case 'EUR':
        return FlagsCode.EU;
      case 'GBP':
        return FlagsCode.GB;
      case 'USD':
        return FlagsCode.US;
      default:
        return FlagsCode.NULL;
    }
  }

  _getLongTerm(currencyName) {
    switch (currencyName) {
      case 'JPY':
        return 'Japanese Yen';
      case 'NZD':
        return 'New Zealand Dollar';
      case 'CAD':
        return 'Canadian Dollar';
      case 'AUD':
        return 'Australian Dollar';
      case 'EUR':
        return 'Euro';
      case 'GBP':
        return 'The British Pound';
      case 'USD':
        return 'United States Dollar';
      default:
        return '';
    }
  }
}
