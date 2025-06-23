import 'package:flutter/material.dart';
import 'package:netpospricechecker/app_constants/images_paths.dart';

class CustomContainerWidget extends StatelessWidget {
  const CustomContainerWidget({
    super.key,
    this.radius = 20,
    required this.height,
    required this.width,
    required this.widget,
    this.alignment,
    this.isBackgroundColor = true,
    this.color
  });
  final double radius;
  final double height;
  final double width;
  final Widget widget;
  final AlignmentGeometry? alignment;
  final bool isBackgroundColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: alignment,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.black),
        color: isBackgroundColor ? Colors.white : color != null ? color : null,
        // image: DecorationImage(
        //   image: AssetImage(ImagesPath.priceTagBackGround)
        // )
      ),
      child: Center(child: widget),
    );
  }
}



class PriceTagContainer extends StatelessWidget {
  const  PriceTagContainer({
    super.key,
    this.radius = 20,
    required this.height,
    required this.width,
    required this.widget,
    this.alignment,
    this.isBackgroundColor = true,
    this.color
  });
  final double radius;
  final double height;
  final double width;
  final Widget widget;
  final AlignmentGeometry? alignment;
  final bool isBackgroundColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: alignment,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      //  color: isBackgroundColor ? Colors.white : color != null ? color : null,
        // image: DecorationImage(
        //   fit: BoxFit.cover,
        //   image: AssetImage(ImagesPath.priceTagBackGround)
        // )
      ),
      child: Stack(
        children: [
          Image.asset(
            ImagesPath.priceTagBackGround,
            fit: BoxFit.cover,
            height: height,
      width: width,
          ),
          Positioned.fill(top: 100,right: 50, child: Center(child: widget)),
        ], 
      ),
    );
  }
}
