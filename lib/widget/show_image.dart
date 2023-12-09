import 'package:flutter/material.dart';

class ShowOnlineImage extends StatelessWidget {
  final Size size;
  final Color color;
  final String? urlImage;

  const ShowOnlineImage({
    Key? key,
    required this.size,
    required this.color,
    required this.urlImage,
  }) : super(key: key);

  Image _showImage(String URL_IMAGE) {
    return Image.network(
      URL_IMAGE,
      fit: BoxFit.cover,
      scale: 0.5,
      height: 90,
      width: 90,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.height,
      height: size.width,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.height / 2),
        border: Border.all(
          color: color,
          width: 2,
        ),
      ),
      child: ClipOval(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular((size.height - 4) / 2),
            color: Colors.white,
          ),
          child: urlImage != null ? _showImage(urlImage!) : null,
        ),
      ),
    );
  }
}
