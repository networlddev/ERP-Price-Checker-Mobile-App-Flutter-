import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:netpospricechecker/app_constants/images_paths.dart';
import 'package:netpospricechecker/app_constants/strings.dart';
import 'package:netpospricechecker/core/routes_manager.dart';
import 'package:netpospricechecker/core/utils/validation_utils.dart';
import 'package:netpospricechecker/view/widgets/button_widget.dart';
import 'package:netpospricechecker/view/widgets/price_checker_container_widget.dart';
import 'package:netpospricechecker/view/widgets/text_widget.dart';
import 'package:netpospricechecker/view/widgets/textfield_widget.dart';
import 'package:netpospricechecker/view_models/user_validation_view_model.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

// ignore: must_be_immutable
class UserValidationScreen extends StatelessWidget {
  UserValidationScreen({super.key});

  final TextEditingController _companyCodeField = TextEditingController();
  final TextEditingController _companyNameField = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String qrCode = '';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    var validationViewModel = context.watch<UserValidationViewModel>();
    bool isLoading = validationViewModel.isLoading;
    bool isFetchKeyEnabled = validationViewModel.isFetchKeyEnabled;
    bool isSendRequestEnabled = validationViewModel.isSendRequestEnabled;
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.fill,
            image: Image.asset(
              ImagesPath.backgroundImage,
              fit: BoxFit.fill,
              color:const Color(0xFF1C1568),
            ).image,
          )),
          child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.white,),
                  )
                : SingleChildScrollView(
            child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.2,
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             CustomContainerWidget(
                          height: size.height * 0.15,
                          width: size.width * 0.25,
                          isBackgroundColor: false,
                          widget: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                ImagesPath.networldLogoImage,
                                fit: BoxFit.fill,
                              )),
                        ),
                          ],
                        ),
                      ),
                    
                      SizedBox(
                        //    height: size.height * 0.9,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Form(
                                key: _formKey,
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                      width: 110,
                                      child: Center(
                                          child: TextWidget(
                                              txt: AppConstantsStrings
                                                  .textCompanyCode)),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFieldWidget(
                                          controller: _companyCodeField,
                                          hintText: '',
                                          validator: (value) => ValidationUtils
                                              .validateEmptyTextField(value),
                                              keyboardType: TextInputType.number,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                      width: 110,
                                      child: Center(
                                          child: TextWidget(
                                              txt: AppConstantsStrings
                                                  .textCompanyName)),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFieldWidget(
                                          controller: _companyNameField,
                                          hintText: '',
                                          validator: (value) => ValidationUtils
                                              .validateEmptyTextField(value),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: SizedBox(
                                  height: size.height * 0.4,
                                  width: double.infinity,
                                  child: Center(
                                    child: FutureBuilder(
                                      future:
                                          generateQrCodeWithDeviceInfo(context),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          qrCode = snapshot.data ?? '';
                                          return Center(
                                            child: QrImageView(
                                              data: snapshot.data ?? '',
                                              version: QrVersions.auto,
                                              size: 300.0,
                                              eyeStyle: const QrEyeStyle(
                                                eyeShape: QrEyeShape.square,
                                                color: Colors.white,
                                              ),
                                              dataModuleStyle:
                                                  const QrDataModuleStyle(
                                                dataModuleShape:
                                                    QrDataModuleShape.square,
                                                color: Colors.white,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  // mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: 200,
                                        child: ButtonWidget(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              context
                                                  .read<
                                                      UserValidationViewModel>()
                                                  .validateUser(
                                                    _companyCodeField.text,
                                                    _companyNameField.text,
                                                    qrCode,
                                                  );
                                            }
                                          },
                                          buttonTextWidget: const TextWidget(
                                            txt: AppConstantsStrings
                                                .textSendRequest,
                                            color: Colors.white,
                                          ),
                                          isEnabled: isSendRequestEnabled,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: 200,
                                        child: ButtonWidget(
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              bool isKeyFetched = await context
                                                  .read<
                                                      UserValidationViewModel>()
                                                  .fetchKey(
                                                    _companyCodeField.text,
                                                    qrCode,
                                                  );
                                              // ignore: use_build_context_synchronously
                                              if (isKeyFetched &&
                                                  context.mounted) {
                                                Navigator.pushNamed(
                                                    context,
                                                    Routes
                                                        .sharedFolderConfigScreen);
                                              }
                                            }
                                          },
                                          buttonTextWidget: const TextWidget(
                                            txt: AppConstantsStrings
                                                .textFetchKey,
                                            color: Colors.white,
                                          ),
                                          isEnabled: isFetchKeyEnabled,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: 200,
                                        child: ButtonWidget(
                                            onPressed: () {},
                                            buttonTextWidget: const TextWidget(
                                              txt: AppConstantsStrings
                                                  .textKeyBoard,
                                              color: Colors.white,
                                            )),
                                      ),
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

    return ip;
  }
}
