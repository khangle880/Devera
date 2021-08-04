import 'package:flutter/material.dart';

class ImageSwiper extends StatefulWidget {
  const ImageSwiper({
    Key? key,
    required this.listImage,
  }) : super(key: key);

  final List<dynamic> listImage;
  @override
  _ImageSwiperState createState() => _ImageSwiperState();
}

class _ImageSwiperState extends State<ImageSwiper> {
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    final int totalImages = widget.listImage.length;

    return Stack(
      children: <Widget>[
        PageView(
            onPageChanged: (int pageIndex) {
              setState(() {
                _selectedPage = pageIndex;
              });
            },
            children: <Widget>[
              for (dynamic image in widget.listImage)
                Image.network(image.toString(), fit: BoxFit.fill)
            ]),
        Positioned(
          bottom: 20.0,
          left: 0.0,
          right: 0.0,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (int imageIndex = 0; imageIndex < totalImages; imageIndex++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    width: _selectedPage == imageIndex ? 30.0 : 10.0,
                    height: 5.0,
                    decoration: BoxDecoration(
                        color: _selectedPage == imageIndex
                            ? const Color(0xFF222831)
                            : const Color(0xFF145374),
                        borderRadius: BorderRadius.circular(12.0)),
                  )
              ]),
        )
      ],
    );
  }
}
