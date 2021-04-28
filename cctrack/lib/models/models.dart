class CCData {
  String name;
  String symbol;
  int rank;
  String price_usd;

  CCData({this.name, this.symbol, this.rank, this.price_usd});

  factory CCData.fromJson(Map<String, dynamic> json) => CCData(
      name:  json["name"],
      symbol: json['symbol'],
      rank: json['rank'],
      price_usd: json['price_usd']
  );

}