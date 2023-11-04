import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:netpospricechecker/app_constants/images_paths.dart';
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
    imgList = priceCheckerViewModel.images;
    showAds = priceCheckerViewModel.showImages;
    status = priceCheckerViewModel.status;
    formattedPrice = priceCheckerViewModel.price;

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
                              child: FutureBuilder(
                                  future: context
                                      .read<PriceCheckerViewModel>()
                                      .fetchCompanyImageStatus(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      );
                                    } else if (snapshot.hasData) {
                                      return CustomContainerWidget(
                                        height: size.height * 0.15,
                                        width: size.width * 0.30,
                                        isBackgroundColor: false,
                                        widget: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.asset(
                                              snapshot.data!,
                                              fit: BoxFit.contain,
                                            )),
                                      );
                                    } else {
                                      return SizedBox();
                                    }
                                  }),
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
                                  _sendRequestAndClearText(text);
                                },
                              ),
                            ),
                            InkWell(
                              onTap: () => context
                                  .read<PriceCheckerViewModel>()
                                  .refreshData(),
                              child: CustomContainerWidget(
                                height: size.height * 0.15,
                                width: size.width * 0.25,
                                isBackgroundColor: false,
                                color: Colors.white,
                                widget: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      ImagesPath.getCustomerImagePath(),
                                      fit: BoxFit.fitHeight,
                                    )),
                              ),
                            ),
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
                                        txt: formattedPrice,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 250, vertical: 20),
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
              showDetails
                  ? CustomDialogue(
                      showDialog: (value) {
                        setState(() {
                          showDetails = value;
                        });
                      },
                    )
                  : const SizedBox(),
              showAds && imgList != null
                  ? ImageSliderWidget(
                      imgList: imgList,
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
