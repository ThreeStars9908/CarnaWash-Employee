// ignore_for_file: non_constant_identifier_names

class UserNotificationModel {
  UserNotificationModel({
    this.id,
    required this.notification_id,
    required this.user_type_id,
    required this.user_id,
  });

  int? id;
  int notification_id;
  int user_type_id;
  int user_id;
}

class GeralNotificationModel {
  GeralNotificationModel({
    this.id,
    required this.title,
    required this.destined_to,
    required this.type,
  });

  int? id;
  String title;
  String destined_to;
  int type;
}
