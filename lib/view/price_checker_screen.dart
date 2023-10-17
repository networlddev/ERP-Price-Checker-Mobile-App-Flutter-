import 'package:flutter/material.dart';
import 'package:netpospricechecker/view/widgets/text_widget.dart';

class PriceCheckerScreen extends StatefulWidget {
  const PriceCheckerScreen({super.key});

  @override
  State<PriceCheckerScreen> createState() => _PriceCheckerScreenState();
}

class _PriceCheckerScreenState extends State<PriceCheckerScreen> {
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
                              child:
                                  TextWidget(txt: "NETWORLD-ERP-Solutions",fontSize: 25,fontWeight: FontWeight.bold,))),
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
                        txt: "Four Stars Gift",
                        fontSize: 20,
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
                height: size.height * 0.5,
                width: double.infinity,
                child: const Align(
                    alignment: Alignment.center,
                    child: TextWidget(
                      txt: '195.60',
                      fontSize: 160,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              const Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: size.height * 0.2,
                width: double.infinity,
                child: const Align(
                    alignment: Alignment.center,
                    child: TextWidget(
                      txt: 'Main Dubai water - Bottled drinking water',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
