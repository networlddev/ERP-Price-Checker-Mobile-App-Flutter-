import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:netpospricechecker/app_constants/images_paths.dart';
import 'package:netpospricechecker/models/product_details.dart';
import 'package:netpospricechecker/view/widgets/custom_dialogue_box.dart';
import 'package:netpospricechecker/view/widgets/custom_text_field_widget.dart';
import 'package:netpospricechecker/view/widgets/price_checker_container_widget.dart';
import 'package:netpospricechecker/view/widgets/text_widget.dart';
import 'package:netpospricechecker/view/widgets/textfield_widget.dart';
import 'package:netpospricechecker/view_models/price_checker_view_model.dart';
import 'package:provider/provider.dart';

class PriceCheckerScreen extends StatefulWidget {
  const PriceCheckerScreen({super.key});

  @override
  State<PriceCheckerScreen> createState() => _PriceCheckerScreenState();
}

class _PriceCheckerScreenState extends State<PriceCheckerScreen> {
  bool showDetails = false;
  final TextEditingController _controllerBarcode = TextEditingController();
  final FocusNode barcodeFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    var priceCheckerViewModel = context.watch<PriceCheckerViewModel>();
    bool isLoading = priceCheckerViewModel.isLoading;
    ProductDetails? productDetails = priceCheckerViewModel.productDetails;
    var productName = priceCheckerViewModel.productName;
    // SystemChannels.textInput.invokeMethod('TextInput.hide');

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Scaffold(
          body: Stack(children: [
            BarcodeKeyboardListener(
              onBarcodeScanned: (value) {
                context.read<PriceCheckerViewModel>().checkPrice(value);
             //   _controllerBarcode.text = "";
                if (showDetails) {
                  setState(() {
                    showDetails = false;
                  });
                }
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.fill,
                  image: Image.asset(
                    ImagesPath.backgroundImage,
                  ).image,
                )),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onDoubleTap: () {
                                setState(() {
                                  showDetails = !showDetails;
                                });
                                Future.delayed(const Duration(seconds: 30), () {
                                  if (showDetails) {
                                    setState(() {
                                      showDetails = false;
                                    });
                                  }
                                });
                              },
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
                            ),
                            // SizedBox(
                            //   width: size.width * 0.2,
                            //   height: size.width * 0.1,
                            //   child: NoKeyboardEditableText(
                            //     controller: _controllerBarcode,
                            //     //  hintText: '',
                            //     //  autoFocus: true,
                            //     //   isReadOnly: true,
                            //     //    focusNode: barcodeFocusNode,

                            //     // color: Colors.transparent,
                            //     // cursorColor: Colors.transparent,
                            //     // textColor: Colors.transparent,
                            //     // keyboardType: TextInputType.multiline,
                            //     // onTap: () {
                            //     //    SystemChannels.textInput.invokeMethod('TextInput.hide');
                            //     // },
                            //     // onEditingComplete: () =>  SystemChannels.textInput.invokeMethod('TextInput.hide'),
                            //     // style: const TextStyle(),
                            //     // cursorColor: Colors.transparent,
                            //     style: const TextStyle(
                            //         fontSize: 20, color: Colors.white),
                            //     cursorColor: Colors.white,
                            //     onChanged: (text) {
                            //       print(text);

                            //       // if (text.endsWith('\n')) {
                            //       //   String filter =
                            //       //       text.substring(0, text.length - 1);
                            //       //   _controllerBarcode.value = TextEditingValue(
                            //       //     text: filter,
                            //       //     selection: TextSelection.collapsed(
                            //       //         offset: filter.length),
                            //       //   );
                            //       //   context
                            //       //       .read<PriceCheckerViewModel>()
                            //       //       .checkPrice(filter);
                            //       //   _controllerBarcode.text = "";
                            //       //   if (showDetails) {
                            //       //     setState(() {
                            //       //       showDetails = false;
                            //       //     });
                            //       //   }
                            //       // }
                            //       // FocusScope.of(context)
                            //       //     .requestFocus(barcodeFocusNode);
                            //     },
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 40, 10, 20),
                        child: CustomContainerWidget(
                          height: size.height * 0.4,
                          width: size.width * 0.6,
                          widget: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const TextWidget(
                                  txt: 'Price',
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : TextWidget(
                                        txt: productDetails?.salesPrice
                                                .toString() ??
                                            "",
                                        fontSize: 120,
                                        fontWeight: FontWeight.bold,
                                      ),
                              ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        child: CustomContainerWidget(
                          height: size.height * 0.1,
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          widget: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 50,
                                ),
                                child: TextWidget(
                                  txt: productName,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 250,vertical: 50),
                        child: CustomContainerWidget(
                          height: size.height * 0.1,
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          radius: 35,
                          widget: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 50,
                                ),
                                child: TextWidget(
                                  txt:
                                      'Check Price here        تحقق من السعر هنا',
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            showDetails
                ? CustomDialogue(
                    showDialog: (value) {
                      setState(() {
                        showDetails = value;
                      });
                    },
                  )
                : const SizedBox()
          ]),
        ),
      ),
    );
  }
}
