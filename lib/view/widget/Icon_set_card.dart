import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconfinder/model/icon_set.dart';

class IconSetCard extends StatelessWidget {
  final Function onclick;
  final String imageUrl;
  final String name;
  final Iconsets icon;

  IconSetCard({this.onclick, this.imageUrl, this.name, this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onclick,
      child: Container(
        height: 84,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Stack(
          children: [
            Center(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.fitHeight,
                height: 84,
                errorWidget: (_, __, ___) => CachedNetworkImage(
                  imageUrl: 'https://picsum.photos/id/1004/600/100?blur',
                  height: 84,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Container(color: Colors.black.withOpacity(0.4)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: Center(
                      child: Text(
                        name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Text(
                      '→',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
