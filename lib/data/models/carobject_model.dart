// ignore_for_file: non_constant_identifier_names

class CarObjectModel {
  CarObjectModel({
    this.id,
    required this.car_id,
    required this.wash_type,
    required this.additional_list_id,
  });

  int? id;
  int car_id;
  int wash_type;
  String additional_list_id;
}
