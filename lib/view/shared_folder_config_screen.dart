import 'package:flutter/material.dart';
import 'package:netpospricechecker/core/routes_manager.dart';
import 'package:netpospricechecker/view/widgets/button_widget.dart';
import 'package:netpospricechecker/view/widgets/text_widget.dart';
import 'package:netpospricechecker/view/widgets/textfield_widget.dart';

class SharedFolderConfigScreen extends StatefulWidget {
  const SharedFolderConfigScreen({super.key});

  @override
  State<SharedFolderConfigScreen> createState() =>
      _SharedFolderConfigScreenState();
}

class _SharedFolderConfigScreenState extends State<SharedFolderConfigScreen> {
  final TextEditingController _baseUrlController = TextEditingController();

  final TextEditingController _sharedFolderController = TextEditingController();

  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.2,
                child: const Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                          child: Center(
                              child: TextWidget(
                        txt: "NETWORLD-POS-APPLICATION",
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ))),
                    ),
                    VerticalDivider(
                      width: 20,
                      thickness: 1,
                      indent: 20,
                      endIndent: 0,
                      color: Colors.black,
                    ),
                    Expanded(
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            height: 20,
                            width: 110,
                            child: Center(child: TextWidget(txt: 'Base URL')),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFieldWidget(
                                controller: _baseUrlController,
                                hintText: '',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            height: 20,
                            width: 110,
                            child: Center(
                                child: TextWidget(txt: 'Shared Folder Auth')),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Transform.scale(
                                    scale: 2.0,
                                    child: Checkbox(
                                      value: checkBoxValue,
                                      onChanged: (value) => setState(() {
                                        checkBoxValue = value!;
                                      }),
                                      visualDensity: VisualDensity.comfortable,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFieldWidget(
                                      controller: _sharedFolderController,
                                      hintText: '',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            height: 20,
                            width: 110,
                            child: Center(child: TextWidget(txt: 'User Name')),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFieldWidget(
                                controller: _userNameController,
                                hintText: '',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            height: 20,
                            width: 110,
                            child: Center(child: TextWidget(txt: 'Password')),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFieldWidget(
                                controller: _passwordController,
                                hintText: '',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ButtonWidget(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, Routes.priceCheckerScreen);
                                  },
                                  buttonTextWidget: const TextWidget(
                                    txt: 'Save',
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
}
