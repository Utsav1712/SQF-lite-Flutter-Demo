class UserModel {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? dob;
  String? address;

  UserModel(
      {this.id,
        this.name,
        this.email,
        this.phoneNumber,
        this.dob,
        this.address});

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email, phoneNumber: $phoneNumber, dob: $dob, address: $address}';
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    dob = json['dob'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['dob'] = this.dob;
    data['address'] = this.address;
    return data;
  }
}
