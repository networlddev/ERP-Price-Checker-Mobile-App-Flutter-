import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netpospricechecker/core/utils/utility.dart';
import 'package:netpospricechecker/models/images_model.dart';
import 'package:video_player/video_player.dart';

class ImageSliderWidget extends StatefulWidget {
  const ImageSliderWidget({
    super.key,
    required this.imgList,
  });
  final List<Item>? imgList;

  @override
  State<ImageSliderWidget> createState() => _ImageSliderWidgetState();
}

class _ImageSliderWidgetState extends State<ImageSliderWidget> {
  late VideoPlayerController controller;
  // String videoUrl =
  //     'http://192.168.0.51:1001/images/682d2044-4022-4489-b031-219711787a6f.Mp4';

  // @override
  // void initState() {
  //   super.initState();
  //   controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
  //   print("${widget.imgList![0].imageUri!}");

  //   controller.addListener(() {
  //     setState(() {});
  //   });
  //   controller.setLooping(true);
  //   controller.initialize().then((_) => setState(() {}));
  //   controller.play();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
        
          child: widget.imgList!.isNotEmpty ? CarouselSlider(
           // disableGesture: false,
            options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 1.0,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                viewportFraction: 1.0,
                pauseAutoPlayOnTouch: false,
                pauseAutoPlayOnManualNavigate: false,
                scrollPhysics: NeverScrollableScrollPhysics(),
                autoPlayCurve: Curves.easeInOutCirc,
                autoPlayInterval: Duration(seconds: widget.imgList![0].duration!),
                ),
            items: widget.imgList!.map((item) {
              if (Utility.isImage(item.imageUri!)) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.network(
                    item.imageUri!,
                    fit: BoxFit.fill,
                  ),
                );
              } else {
                return VideoPlayer(
                  controller,
                );
              }
            }).toList(),
          ) : const SizedBox()),
    );
    
  }
}
