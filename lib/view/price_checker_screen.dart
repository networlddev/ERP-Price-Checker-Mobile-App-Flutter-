import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:netpospricechecker/app_constants/hive_boxes.dart';
import 'package:netpospricechecker/app_constants/images_paths.dart';
import 'package:netpospricechecker/core/utils/toast_utility.dart';
import 'package:netpospricechecker/main.dart';
import 'package:netpospricechecker/models/images_model.dart';
import 'package:netpospricechecker/models/product_details.dart';
import 'package:netpospricechecker/view/widgets/custom_dialogue_box.dart';
import 'package:netpospricechecker/view/widgets/image_slider_widget.dart';
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
  bool showAds = false;
  String status = '';
  String formattedPrice = "";

  List<Item>? imgList = [];
  final TextEditingController _barcodeController = TextEditingController();
  final FocusNode _barcodeFocusNode = FocusNode();
  final TextEditingController reconfigDialogController =
      TextEditingController();
  final GlobalKey<FormState> reConfigForm = GlobalKey<FormState>();
  bool isDialogShown = false;

  @override
  void initState() {
    context.read<PriceCheckerViewModel>().handleAdsImage(false);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    var priceCheckerViewModel = context.watch<PriceCheckerViewModel>();
    context.read<PriceCheckerViewModel>().fetchImages();

    bool isLoading = priceCheckerViewModel.isLoading;
    ProductDetails? productDetails = priceCheckerViewModel.productDetails;
    var productName = priceCheckerViewModel.productName;
    var barcode = priceCheckerViewModel.barcode;
    var description = priceCheckerViewModel.description;

    imgList = priceCheckerViewModel.images;
    showAds = priceCheckerViewModel.showImages;
    status = priceCheckerViewModel.status;
    formattedPrice = priceCheckerViewModel.price;
    var showReconfigureDialog = priceCheckerViewModel.showReconfigureDialog;
    if (showReconfigureDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        print('This runs after the first frame is rendered');
        if (!isDialogShown) {
          isDialogShown = true;
          showTextFieldDialogue(context, reConfigForm, reconfigDialogController,
                  "Server Not Responding enter secret password to reconfigure Price Checker",
                  title: "Reconfigure",
                  hintText: "Password",
                  positiveButtonText: "Re-config",
                  negativeButtonText: "Cancel")
              .then(
            (value) {
              isDialogShown = false;
              priceCheckerViewModel.showReconfigureDialog = false;
           
            },
          );
        }
      });
    } else {
      Navigator.of(context, rootNavigator: true).maybePop();
    }
    ;

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Scaffold(
          body: RefreshIndicator(
            onRefresh: () =>
                context.read<PriceCheckerViewModel>().refreshData(),
            color: Colors.blue,
            backgroundColor: Colors.white,
            child: Stack(children: [
              Container(
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
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.white,
                              height: size.height * 0.05,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onDoubleTap: () {
                                      setState(() {
                                        showDetails = !showDetails;
                                      });
                                      Future.delayed(const Duration(seconds: 3),
                                          () {
                                        if (showDetails) {
                                          setState(() {
                                            showDetails = false;
                                          });
                                        }
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        TextWidget(
                                          txt: "NETWORLD ERP ",
                                          color: Colors.blue,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        TextWidget(
                                          txt: "(version 5.0566)",
                                          color: Colors.blue,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                  ),

                                  // InkWell(
                                  //              onTap: () => context
                                  // .read<PriceCheckerViewModel>()
                                  // .refreshData(),
                                  //   child: TextWidget(
                                  //     txt: "Three Star Fashion",
                                  //     color: Colors.black,
                                  //     fontSize: 18,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 0,
                        width: 0,
                        child: TextFieldWidget(
                          controller: _barcodeController,
                          hintText: '',
                          keyboardType: TextInputType.multiline,
                          autoFocus: true,
                          focusNode: _barcodeFocusNode,
                          onChanged: (text) {
                            Navigator.of(context, rootNavigator: true)
                                .maybePop();
                            _sendRequestAndClearText(text);
                          },
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(20),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       InkWell(
                      //         onDoubleTap: () {
                      //           setState(() {
                      //             showDetails = !showDetails;
                      //           });
                      //           Future.delayed(const Duration(seconds: 3), () {
                      //             if (showDetails) {
                      //               setState(() {
                      //                 showDetails = false;
                      //               });
                      //             }
                      //           });
                      //         },
                      //         child: FutureBuilder(
                      //             future: context
                      //                 .read<PriceCheckerViewModel>()
                      //                 .fetchCompanyImageStatus(),
                      //             builder: (context, snapshot) {
                      //               if (snapshot.connectionState ==
                      //                   ConnectionState.waiting) {
                      //                 return Center(
                      //                   child: CircularProgressIndicator(
                      //                     color: Colors.white,
                      //                   ),
                      //                 );
                      //               } else if (snapshot.hasData) {
                      //                 return CustomContainerWidget(
                      //                   height: size.height * 0.15,
                      //                   width: size.width * 0.30,
                      //                   isBackgroundColor: false,
                      //                   widget: ClipRRect(
                      //                       borderRadius:
                      //                           BorderRadius.circular(15),
                      //                       child: Image.asset(
                      //                         snapshot.data!,
                      //                         fit: BoxFit.contain,
                      //                       )),
                      //                 );
                      //               } else {
                      //                 return SizedBox();
                      //               }
                      //             }),
                      //       ),
                      //       SizedBox(
                      //         height: 0,
                      //         width: 0,
                      //         child: TextFieldWidget(
                      //           controller: _barcodeController,
                      //           hintText: '',
                      //           keyboardType: TextInputType.multiline,
                      //           autoFocus: true,
                      //           focusNode: _barcodeFocusNode,
                      //           onChanged: (text) {
                      //             _sendRequestAndClearText(text);
                      //           },
                      //         ),
                      //       ),
                      //       InkWell(
                      //         onTap: () => context
                      //             .read<PriceCheckerViewModel>()
                      //             .refreshData(),
                      //         child: CustomContainerWidget(
                      //           height: size.height * 0.15,
                      //           width: size.width * 0.25,
                      //           isBackgroundColor: false,
                      //           color: Colors.white,
                      //           widget: ClipRRect(
                      //               borderRadius: BorderRadius.circular(15),
                      //               child: Image.network(
                      //                 ImagesPath.getCustomerImagePath(),
                      //                 fit: BoxFit.fitHeight,
                      //               )),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: size.height * 0.4,
                              width: size.width * 0.45,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CustomContainerWidget(
                                    height: size.height * 0.25,
                                    width: size.width * 0.45,
                                    alignment: Alignment.bottomCenter,
                                    widget: barcode.isNotEmpty
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              BarcodeWidget(
                                                  data: barcode,
                                                  code: Barcode.code128()),
                                              TextWidget(
                                                txt: barcode,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              )
                                            ],
                                          )
                                        : const SizedBox(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                PriceTagContainer(
                                  height: size.height * 0.6,
                                  width: size.width * 0.6,
                                  widget: isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.blue,
                                          ),
                                        )
                                      : Container(
                                          height: size.height * 0.4,
                                          width: size.width * 0.4,
                                          //  color: Colors.amber,
                                          child: Center(
                                            child: formattedPrice.isEmpty
                                                ? const SizedBox()
                                                : FittedBox(
                                                    child: PriceText(
                                                        formattedPrice),
                                                  ),
                                          ),
                                        ),
                                ),
                                TextWidget(
                                  txt: description,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
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
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.start,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 250, vertical: 20),
                      //   child: CustomContainerWidget(
                      //     height: size.height * 0.1,
                      //     width: double.infinity,
                      //     alignment: Alignment.centerLeft,
                      //     radius: 35,
                      //     widget: const Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Padding(
                      //           padding: EdgeInsets.only(
                      //             left: 50,
                      //           ),
                      //           child: TextWidget(
                      //             txt:
                      //                 'Check Price here        تحقق من السعر هنا',
                      //             fontSize: 30,
                      //             fontWeight: FontWeight.bold,
                      //             textAlign: TextAlign.start,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
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
                  : const SizedBox(),
              showAds
                  ? imgList != null
                      ? ImageSliderWidget(
                          imgList: imgList,
                        )
                      : ImageSliderWidget(
                          imgList: null,
                        )
                  : SizedBox(),
            ]),
          ),
        ),
      ),
    );
  }

  void _sendRequestAndClearText(String text) async {
    print('onChanged : -$text-');
    if (text.endsWith('\n')) {
      // remove '\n'
      String filter = text.substring(0, text.length - 1);
      // update
      _barcodeController.value = TextEditingValue(
        text: filter,
        selection: TextSelection.collapsed(offset: filter.length),
      );

      /// you can do something
      context.read<PriceCheckerViewModel>().checkPrice(filter);
      _barcodeController.text = "";
    }

    if (showDetails) {
      setState(() {
        showDetails = false;
      });
    }
  }
}

class BarcodeWidget extends StatelessWidget {
  final String data;
  final Barcode code;

  const BarcodeWidget({super.key, required this.data, required this.code});

  @override
  Widget build(BuildContext context) {
    final svg = code.toSvg(data, width: 800, height: 90, drawText: false);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: SvgPicture.string(
          svg,
          width: 800,
          height: 90,
        ),
      ),
    );
  }
}

class PriceText extends StatelessWidget {
  final String price;

  PriceText(this.price);

  @override
  Widget build(BuildContext context) {
    final parts = price.split('.');
    final whole = parts[0];
    final decimal = parts.length > 1 ? parts[1] : '00';

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: whole,
            style: TextStyle(
              fontSize: 150,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: '.$decimal',
            style: TextStyle(
              fontSize: 75,
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
