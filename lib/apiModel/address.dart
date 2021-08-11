class AddressInfoModel {
  int id;
  String name;
  String phone;
  String city;
  String district;
  String address;
  AddressInfoModel({this.id,this.name, this.phone, this.city, this.address,this.district});

  AddressInfoModel.formJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    city = json['city'];
    district = json['district'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["phone"] = this.phone;
    data["city"] = this.city;
    data["district"] = this.district;
    data["address"] = this.address;
    return data;
  }
}
