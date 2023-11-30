// ignore_for_file: non_constant_identifier_names

import 'dart:typed_data';

import 'package:flutter/material.dart';

class BankInfoModel {
  BankInfoModel({
    required this.bank_name,
    required this.account_name,
    required this.account_number,
  });

  String bank_name;
  String account_name;
  String account_number;
}

class TimeAvailableProviderModel {
  TimeAvailableProviderModel({
    required this.sunday_list,
    required this.monday_list,
    required this.tuesday_list,
    required this.wednesday_list,
    required this.thursday_list,
    required this.friday_list,
    required this.saturday_list,
  });

  String sunday_list;
  String monday_list;
  String tuesday_list;
  String wednesday_list;
  String thursday_list;
  String friday_list;
  String saturday_list;
}

class TimeAvailableModel {
  TimeAvailableModel({
    required this.sunday_list,
    required this.monday_list,
    required this.tuesday_list,
    required this.wednesday_list,
    required this.thursday_list,
    required this.friday_list,
    required this.saturday_list,
  });

  TimeAvailableChangeModel sunday_list;
  TimeAvailableChangeModel monday_list;
  TimeAvailableChangeModel tuesday_list;
  TimeAvailableChangeModel wednesday_list;
  TimeAvailableChangeModel thursday_list;
  TimeAvailableChangeModel friday_list;
  TimeAvailableChangeModel saturday_list;
}

class TimeAvailableChangeModel {
  TimeAvailableChangeModel({
    required this.day,
    required this.start,
    required this.finish,
    required this.breakpoint,
    required this.pause,
  });

  String day;
  TimeOfDay start;
  TimeOfDay finish;
  TimeOfDay breakpoint;
  TimeOfDay pause;
}

class WasherInfoModel {
  WasherInfoModel({
    this.made_quiz,
    this.contract_accept,
    this.enable,
    this.rate,
    required this.abn,
    this.contract,
    this.driver_licence,
    this.picture,
  });

  bool? made_quiz;
  bool? contract_accept;
  bool? enable;
  double? rate;
  String abn;
  String? contract;
  String? driver_licence;
  String? picture;
}
