import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:netpospricechecker/core/routes_manager.dart';
import 'package:netpospricechecker/view/widgets/button_widget.dart';
import 'package:netpospricechecker/view/widgets/text_widget.dart';
import 'package:netpospricechecker/view/widgets/textfield_widget.dart';
import 'package:netpospricechecker/view_models/user_validation_view_model.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UserValidationScreen extends StatelessWidget {
  UserValidationScreen({super.key});

  final TextEditingController _companyCodeField = TextEditingController();
  final TextEditingController _companyNameField = TextEditingController();
  String qrCode = '';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var isLoading = context.watch<UserValidationViewModel>().isLoading;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * 0.2,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                            txt: "NETWORLD-POS-APPLICATION",
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: size.height * 0.7,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  height: 20,
                                  width: 110,
                                  child: Center(
                                      child: TextWidget(txt: 'Company Code')),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFieldWidget(
                                      controller: _companyCodeField,
                                      hintText: '',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                  width: 110,
                                  child: Center(
                                      child: TextWidget(txt: 'Company Name')),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFieldWidget(
                                      controller: _companyNameField,
                                      hintText: '',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.4,
                              width: double.infinity,
                              child: Center(
                                child: FutureBuilder(
                                  future: generateQrCodeWithDeviceInfo(context),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      qrCode = snapshot.data ?? '';
                                      return Center(
                                        child: QrImageView(
                                          data: snapshot.data ?? '',
                                          version: QrVersions.auto,
                                          size: 300.0,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ButtonWidget(
                                        onPressed: () {
                                          context
                                              .read<UserValidationViewModel>()
                                              .validateUser(
                                                _companyCodeField.text,
                                                _companyNameField.text,
                                                qrCode,
                                              );
                                        },
                                        buttonTextWidget: const TextWidget(
                                          txt: 'Send request',
                                          color: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ButtonWidget(
                                        onPressed: () {
                                          Navigator.pushNamed(context,
                                              Routes.sharedFolderConfigScreen);
                                        },
                                        buttonTextWidget: const TextWidget(
                                          txt: 'Fetch key',
                                          color: Colors.white,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ButtonWidget(
                                        onPressed: () {},
                                        buttonTextWidget: const TextWidget(
                                          txt: 'Keyboard',
                                          color: Colors.white,
                                        )),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  Future<String> generateQrCodeWithDeviceInfo(BuildContext context) async {
    final deviceInfo = DeviceInfoPlugin();
    String ip = '';

    try {
      if (Theme.of(context).platform == TargetPlatform.iOS) {
        final iosDeviceInfo = await deviceInfo.iosInfo;
        ip = iosDeviceInfo.utsname.nodename;
      } else {
        final androidDeviceInfo = await deviceInfo.androidInfo;
        ip = androidDeviceInfo.id;
      }
    } catch (e) {
      print('Error getting device info: $e');
    }

    // Generate QR code with the IP address
    final qrCode = QrImageView(
      data: ip,
      version: QrVersions.auto,
      size: 200.0,
    );

    // Return the QR code as a string
    return qrCode.toString();
  }
}
