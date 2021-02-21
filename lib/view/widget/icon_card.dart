import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class IconCard extends StatelessWidget {
  final Function onclick;
  final String imageUrl;
  final String name;

  IconCard({this.onclick, this.imageUrl, this.name});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onclick,
      child: Container(
        margin: EdgeInsets.only(
          left: 5,
          right: 5,
          bottom: 8,
        ),
        padding: EdgeInsets.all(5),
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: CachedNetworkImageProvider(imageUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
                left: 0,
                child: IconButton(
                    icon: Icon(Icons.download_rounded, color: Colors.red),
                    onPressed: onclick)),
          ],
        ),
      ),
    );
  }
}
