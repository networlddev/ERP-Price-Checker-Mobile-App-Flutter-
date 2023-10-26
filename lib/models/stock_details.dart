class StockDetails {
  String? shelfNo;
  String? rackNo;
  dynamic contain;
  dynamic stock;

  StockDetails({this.shelfNo, this.rackNo, this.contain, this.stock});

  StockDetails.fromJson(Map<String, dynamic> json) {
    shelfNo = json['ShelfNo'];
    rackNo = json['RackNo'];
    contain = json['Contain'];
    stock = json['Stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ShelfNo'] = shelfNo;
    data['RackNo'] = rackNo;
    data['Contain'] = contain;
    data['Stock'] = stock;
    return data;
  }
}