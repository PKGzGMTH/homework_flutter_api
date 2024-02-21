class Users {
  int id;
  String fname;
  String lname;
  String email;
  String phone;
  String city;

  Users({
    required this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.phone,
    required this.city
    });

  Users.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        fname = json['fname'],
        lname = json['lname'],
        email = json['email'],
        phone = json['phone'],
        city = json['phone'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['city'] = this.city;
    return data;
  }
}
