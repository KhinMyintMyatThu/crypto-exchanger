class Currency {
  String? exchangeID;
  String? currencySymbol;
  String? baseAsset;
  String? quoteAsset;
  dynamic exchangePrice;
  Map<String, dynamic>? intlCurrencies; 
  DateTime? updatedAt;
  dynamic marketChangePrice;

  Currency({this.exchangeID, this.currencySymbol, this.baseAsset, this.quoteAsset, this.exchangePrice, this.intlCurrencies, this.updatedAt, this.marketChangePrice});
 
}