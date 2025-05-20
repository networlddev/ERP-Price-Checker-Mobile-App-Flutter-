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

class SharedFolderConfigScreen extends StatefulWidget {
  const SharedFolderConfigScreen({super.key});

  @override
  State<SharedFolderConfigScreen> createState() =>
      _SharedFolderConfigScreenState();
}

class _SharedFolderConfigScreenState extends State<SharedFolderConfigScreen> {
  final TextEditingController _baseUrlController = TextEditingController();

  final TextEditingController _portController  = TextEditingController();

  final TextEditingController _sharedFolderController = TextEditingController();

  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    bool isLoading = context.select<UserValidationViewModel, bool>(
        (viewModel) => viewModel.isLoading);
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
            ).image,
          )),
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.2,
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                  child: Center(
                                child: CustomContainerWidget(
                                  height: size.height * 0.1,
                                  width: size.width * 0.2,
                                  isBackgroundColor: false,
                                  widget: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.asset(
                                        ImagesPath.networldLogoImage,
                                        fit: BoxFit.contain,
                                      )),
                                ),
                              )),
                            ),
                            const VerticalDivider(
                              width: 20,
                              thickness: 1,
                              indent: 20,
                              endIndent: 0,
                              color: Colors.black,
                            ),
                            const Expanded(
                              child: SizedBox(
                                  child: Center(
                                      child: TextWidget(
                                txt: "NETWORLD-POS-APPLICATION",
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ))),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      SizedBox(
                        height: size.height * 0.7,
                        width: double.infinity,
                        child: Align(
                          alignment: Alignment.center,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                            //  crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width: size.width / 2,
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                        width: 110,
                                        child: Center(
                                            child: TextWidget(
                                                txt: AppConstantsStrings
                                                    .textBaseUrl)),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFieldWidget(
                                            controller: _baseUrlController,
                                            hintColor: Colors.grey.shade700,
                                            hintText:
                                                '(192.XXX.X.XX)/(www.your-domain.com)',
                                            validator: (value) => ValidationUtils
                                                .validateEmptyTextField(value),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                 SizedBox(
                                  width: size.width / 2,
                                   child: Row(
                                    children: [
                                       const SizedBox(
                                        height: 20,
                                        width: 110,
                                        child: Center(
                                            child: TextWidget(
                                                txt: AppConstantsStrings
                                                    .textPort)),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFieldWidget(
                                            controller: _portController,
                                            hintColor: Colors.grey.shade700,
                                            
                                            hintText:
                                                'Port(0000)',
                                            validator: (value) => ValidationUtils
                                                .validateEmptyTextField(value),
                                          ),
                                        ),
                                      ),
                                    ],
                                                                   ),
                                 ),
                                // Row(
                                //   children: [
                                //     const SizedBox(
                                //       height: 20,
                                //       width: 110,
                                //       child: Center(
                                //           child: TextWidget(
                                //               txt: AppConstantsStrings
                                //                   .textSharedFolder)),
                                //     ),
                                //     Expanded(
                                //       child: Padding(
                                //         padding: const EdgeInsets.all(8.0),
                                //         child: Row(
                                //           children: [
                                //             Transform.scale(
                                //               scale: 2.0,
                                //               child: Checkbox(
                                //                 value: checkBoxValue,
                                //                 onChanged: null,
                                //                 //  (value) => setState(() {
                                //                 //   checkBoxValue = value!;
                                //                 // }),
                                //                 side: BorderSide(
                                //                   width: 1,
                                //                   color: Colors.grey
                                //                       .withOpacity(0.2),
                                //                 ),
                                //                 activeColor: Colors.blue,
                                //                 visualDensity:
                                //                     VisualDensity.comfortable,
                                //               ),
                                //             ),
                                //             Expanded(
                                //               child: TextFieldWidget(
                                //                 controller:
                                //                     _sharedFolderController,
                                //                 hintText: '',
                                //                 enabled: false,
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // Row(
                                //   children: [
                                //     const SizedBox(
                                //       height: 20,
                                //       width: 110,
                                //       child: Center(
                                //           child: TextWidget(
                                //               txt: AppConstantsStrings
                                //                   .textUserName)),
                                //     ),
                                //     Expanded(
                                //       child: Padding(
                                //         padding: const EdgeInsets.all(8.0),
                                //         child: TextFieldWidget(
                                //           controller: _userNameController,
                                //           hintText: '',
                                //           enabled: false,
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                // Row(
                                //   children: [
                                //     const SizedBox(
                                //       height: 20,
                                //       width: 110,
                                //       child: Center(
                                //           child: TextWidget(
                                //               txt: AppConstantsStrings
                                //                   .textPassword)),
                                //     ),
                                //     Expanded(
                                //       child: Padding(
                                //         padding: const EdgeInsets.all(8.0),
                                //         child: TextFieldWidget(
                                //           controller: _passwordController,
                                //           hintText: '',
                                //           enabled: false,
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: 250,
                                          child: ButtonWidget(
                                              onPressed: () async {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  bool isUrlValid = await context
                                                      .read<
                                                          UserValidationViewModel>()
                                                      .validateBaseUrl(
                                                          "${_baseUrlController
                                                              .text}:${_portController.text}");
                                                  if (isUrlValid &&
                                                      context.mounted) {
                                                    // Navigator.pushReplacementNamed(
                                                    //     context,
                                                    //     Routes.priceCheckerScreen);
                                                    // Navigator.popUntil(context,
                                                    //     (route) => route.isFirst);
                                                    Navigator
                                                        .pushNamedAndRemoveUntil(
                                                            context,
                                                            Routes
                                                                .priceCheckerScreen,
                                                            (route) => false);
                                                  }
                                                }
                                              },
                                              buttonTextWidget: const TextWidget(
                                                txt: AppConstantsStrings.textSave,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: 250,
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
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
