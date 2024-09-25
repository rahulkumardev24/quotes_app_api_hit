/// inner model
class QuoteModel {
  int id;
  String quote;
  String author;

  QuoteModel({required this.author, required this.id, required this.quote});

  /// Map(JSON) -> Model
  /// fromJson
  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
        author: json['author'], id: json['id'], quote: json['quote']);
  }
}

/// Otter model
class QuoteDataModel {
  int limit;
  int skip;
  int total;

  /// quotes come in list
  List<QuoteModel> quotes = [];

  QuoteDataModel(
      {required this.limit,
      required this.quotes,
      required this.skip,
      required this.total});

  factory QuoteDataModel.fromJson(Map<String, dynamic> json) {
    List<QuoteModel> mQuotes = [];

    for (Map<String, dynamic> eachQuotes in json['quotes']) {
      var eachQuoteModel = QuoteModel.fromJson(eachQuotes);
      mQuotes.add(eachQuoteModel);
    }
    return QuoteDataModel(
        limit: json['limit'],
        skip: json['skip'],
        total: json['total'],
        quotes: mQuotes);
  }
}
