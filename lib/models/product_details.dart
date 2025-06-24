class ProductDetails {
  String? barcode;
  String? name;
  double? salesPrice;
  String? description;

  ProductDetails({this.barcode, this.name, this.salesPrice,this.description});

  ProductDetails.fromJson(dynamic json) {
    barcode = json['Barcode'];
    name = json['Name'];
    salesPrice = json['Sp'];
   // description =
   description = json['Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Barcode'] = barcode;
    data['Name'] = name;
    data['Sp'] = salesPrice;
    return data;
  }
}