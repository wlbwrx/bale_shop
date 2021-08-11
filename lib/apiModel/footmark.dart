class FootMarkModel {
  int id;
  String date;
  String img;
  double price;
  double originalPrice;
  FootMarkModel({this.date,this.img, this.price, this.originalPrice});

  FootMarkModel.formJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    img = json['img'];
    price = json['price'];
    originalPrice = json['originalPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["date"] = this.date;
    data["img"] = this.img;
    data["price"] = this.price;
    data["originalPrice"] = this.originalPrice;
    return data;
  }
}
