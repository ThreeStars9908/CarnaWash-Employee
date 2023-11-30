// ignore_for_file: non_constant_identifier_names

class PaymentModel {
  PaymentModel({
    this.id,
    required this.washer_id,
    required this.wash_id,
    required this.wash_date,
    this.pay_data,
  });

  int? id;
  int washer_id;
  int wash_id;
  DateTime wash_date;
  DateTime? pay_data;
}
