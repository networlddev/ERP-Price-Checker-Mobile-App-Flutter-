class Images {
  String? token;
  String? message;
  List<Item>? item;

  Images({this.token, this.message, this.item});

  Images.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    message = json['message'];
    if (json['item'] != null) {
      item = <Item>[];
      json['item'].forEach((v) {
        item!.add(new Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['message'] = this.message;
    if (this.item != null) {
      data['item'] = this.item!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Item {
  int? slNo;
  dynamic name;
  int? interval;
  int? duration;
  String? imageUri;
  dynamic vedioUri;
  String? fromDate;
  String? toDate;

  Item(
      {this.slNo,
      this.name,
      this.interval,
      this.duration,
      this.imageUri,
      this.vedioUri,
      this.fromDate,
      this.toDate});

  Item.fromJson(Map<String, dynamic> json) {
    slNo = json['slNo'];
    name = json['name'];
    interval = json['interval'];
    duration = json['duration'];
    imageUri = json['imageUri'];
    vedioUri = json['vedioUri'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slNo'] = this.slNo;
    data['name'] = this.name;
    data['interval'] = this.interval;
    data['duration'] = this.duration;
    data['imageUri'] = this.imageUri;
    data['vedioUri'] = this.vedioUri;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    return data;
  }
}