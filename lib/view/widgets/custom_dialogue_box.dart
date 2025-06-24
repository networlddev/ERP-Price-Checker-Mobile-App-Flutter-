import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:netpospricechecker/app_constants/hive_boxes.dart';
import 'package:netpospricechecker/core/utils/toast_utility.dart';
import 'package:netpospricechecker/main.dart';
import 'package:netpospricechecker/models/stock_details.dart';
import 'package:netpospricechecker/view/widgets/button_widget.dart';
import 'package:netpospricechecker/view/widgets/text_widget.dart';
import 'package:netpospricechecker/view/widgets/textfield_widget.dart';
import 'package:netpospricechecker/view_models/price_checker_view_model.dart';
import 'package:provider/provider.dart';

class CustomDialogue extends StatefulWidget {
  const CustomDialogue(
      {super.key,
      this.itemName = '',
      this.isFetchingFromServer = false,
      this.length = 0,
      this.counter = 1,
      this.singleRecordName = '',
      this.totalItems = 0,
      this.isDecoding = false,
      this.isStoringInLocalDB = false,
      this.status = '',
      this.showDialog});
  final String itemName;
  final bool isFetchingFromServer;
  final int length;
  final int counter;
  final String singleRecordName;
  final int totalItems;
  final bool isDecoding;
  final bool isStoringInLocalDB;
  final String status;
  final ValueChanged<bool>? showDialog;

  @override
  State<CustomDialogue> createState() => _CustomLoadingDialogueState();
}

class _CustomLoadingDialogueState extends State<CustomDialogue> {
  double percentageCompleted = 0;
  int totalItems = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    StockDetails stockDetails =
        context.watch<PriceCheckerViewModel>().stockDetails;
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.7), // Overlay background color
            child: Center(
              child: Container(
                  height: size.height * 0.4,
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Scaffold(
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: TextWidget(
                              txt: 'Item Information',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 5,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const TextWidget(
                                  txt: 'Stock left',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                TextWidget(
                                  txt: stockDetails.stock.toString(),
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const TextWidget(
                                  txt: 'Rack No.',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                TextWidget(
                                  txt: stockDetails.rackNo.toString(),
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const TextWidget(
                                  txt: 'Shelf No.',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                TextWidget(
                                  txt: stockDetails.shelfNo.toString(),
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 25),
                                  child: ButtonWidget(
                                      onPressed: () =>
                                          widget.showDialog!(false),
                                      buttonTextWidget: const TextWidget(
                                        txt: 'OK',
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                  // const Center(child:  CircularProgressIndicator())
                  ), // Loading indicator
            ),
          ),
        ),
      ],
    );
  }
}

Future showTextFieldDialogue(
  BuildContext context,
  GlobalKey<FormState> key,
  TextEditingController controller,
  String message, {
  String? title,
  String? positiveButtonText,
  String? negativeButtonText,
  String? hintText,
  bool hidePostiveButton = false,
}) {
  String resolvedText = title ?? "";
  String resolvedPositiveButtonText = positiveButtonText ?? "";
  String resolvedNegativeButtonText = negativeButtonText ?? "";
  String resolvedHintText = hintText ?? "";

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () => Future.value(false),
        child: AlertDialog(
          title: TextWidget(
            txt: resolvedText,
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          content: Form(
            key: key,
            child: TextFieldWidget(
              controller: controller,
              hintText: resolvedHintText,
              obscureText: true,
              maxLines: 1,
              
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return message;
                }
                return null;
              },
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ButtonWidget(
                  onPressed: () => Navigator.pop(context, false),
                  buttonTextWidget: TextWidget(
                    txt:
                        hidePostiveButton ? "Okay" : resolvedNegativeButtonText,
                        color: Colors.white,
                  )),
            ),
            !hidePostiveButton
                ? Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ButtonWidget(
                        onPressed: () {
                           if (key.currentState!.validate()) {
                if (checkPasswordAndRunLogic(controller.text)) {
                  Hive.box(HiveBoxes.urlBox).clear();
                  RestartWidget.restartApp(context);
                  // Navigator.pop(context);
                  // restartApp();
                } else {
                  ToastUtility.show("Password Incorrect", ToastType.error);
                }
              }
                      
                        },
                        buttonTextWidget: TextWidget(
                          txt: resolvedPositiveButtonText,
                          color: Colors.white,
                        )),
                  )
                : const SizedBox(),
          ],
        ),
      );
    },
  );
}


  bool checkPasswordAndRunLogic(String userInput) {
    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0'); // e.g. 24
    final nextMonth =
        (now.month % 12 + 1).toString().padLeft(2, '0'); // e.g. 07

    final generatedPassword = '$day$nextMonth'; // e.g. "2407"

    if (userInput == generatedPassword) {
      print("✅ Password matched. Running secret logic...");
      return true;
    } else {
      print("❌ Incorrect password.");
      return false;
    }
  }