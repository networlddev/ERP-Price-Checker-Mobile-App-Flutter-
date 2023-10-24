class ActivationKey {
  
  String? activationKey;

  ActivationKey({this.activationKey});

  ActivationKey.fromJson(Map<String, dynamic> json) {
    activationKey = json['ActivationKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ActivationKey'] = activationKey;
    return data;
  }
}