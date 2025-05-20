class UserDeviceInformation {
  String userDeviceName;
  String userDeviceId;
  String? userDeviceModel;
  String? userDeviceIP;
  int? deviceSdk;
  UserDeviceInformation({
    required this.userDeviceId,
    required this.userDeviceName,
    this.userDeviceModel,
    this.userDeviceIP,
    this.deviceSdk = 25,
  });
}
