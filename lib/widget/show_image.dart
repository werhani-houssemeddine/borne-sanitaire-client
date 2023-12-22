import 'package:borne_sanitaire_client/config.dart';
import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
  final String? onlinePictureSrc;
  final String defaultAssets;
  final Size size;
  final double? padding;
  final Color? color;

  const ShowImage({
    Key? key,
    required this.defaultAssets,
    required this.size,
    this.onlinePictureSrc,
    this.padding,
    this.color,
  }) : super(key: key);

  Widget get getImage {
    if (onlinePictureSrc == null) {
      return Container(
        padding: padding != null ? EdgeInsets.all(padding!) : null,
        child: Image(
          image: AssetImage(defaultAssets),
          fit: BoxFit.cover,
          height: size.height,
          width: size.width,
        ),
      );
    }

    String fullPictureSrc =
        "http://$BASE_URL/api/client/update$onlinePictureSrc";

    return Image.network(
      fullPictureSrc,
      fit: BoxFit.cover,
      height: size.height,
      width: size.width,
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
          color: color ?? Colors.black54,
          width: 2,
        ),
      ),
      child: ClipOval(
          child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular((size.height - 4) / 2),
          color: Colors.white,
        ),
        child: getImage,
      )),
    );
  }
}
