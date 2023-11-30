// ignore_for_file: non_constant_identifier_names

import 'dart:ffi';

class ScheduleModel {
  ScheduleModel({
    this.id,
    required this.user_id,
    required this.cars_list_id,
    required this.selected_date,
    required this.address,
    required this.observation_address,
    required this.coupon_id,
    required this.payment_schedule_id,
    this.washer_id,
    required this.status,
    this.rate,
    this.credit_card_id,
    this.three,
  });

  int? id;
  int user_id;
  String cars_list_id;
  DateTime selected_date;
  String address;
  String observation_address;
  int coupon_id;
  int payment_schedule_id;
  int? washer_id;
  String status;
  double? rate;
  String? credit_card_id;
  String? three;
}

