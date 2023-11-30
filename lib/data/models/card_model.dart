// ignore_for_file: non_constant_identifier_names

class CardModel {
  CardModel({
    this.id,
    required this.user_id,
    required this.name,
    required this.last_digits,
    required this.date,
  });

  int? id;
  int user_id;
  String name;
  String last_digits;
  String date;
}

class CardCreateUpdateModel {
  CardCreateUpdateModel({
    this.id,
    required this.name,
    required this.card,
    required this.date,
  });

  int? id;
  String name;
  String card;
  String date;
}
