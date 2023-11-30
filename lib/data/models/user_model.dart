class UserSignModel {
  UserSignModel({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.address,
  });

  String email;
  String password;
  String name;
  String phone;
  String address;
}

class UserCompleteModel {
  UserCompleteModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
  });

  int? id;
  String name;
  String email;
  String phone;
  String address;
}

class ClientModel {
  ClientModel({
    required this.id,
    required this.name,
  });

  int id;
  String name;
}
