class ProductDetails {
  String? barcode;
  String? name;
  double? salesPrice;

  ProductDetails({this.barcode, this.name, this.salesPrice});

  ProductDetails.fromJson(dynamic json) {
    barcode = json['Barcode'];
    name = json['Name'];
    salesPrice = json['Sp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Barcode'] = barcode;
    data['Name'] = name;
    data['Sp'] = salesPrice;
    return data;
  }
}