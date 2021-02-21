import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class IconCard extends StatelessWidget {
  final Function onclick;
  final String imageUrl;
  final String name;

  IconCard({this.onclick, this.imageUrl, this.name});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onclick,
      leading: Container(
        height: 56,
        width: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          border: Border.all(
            width: 1,
            color: Colors.black,
          ),
        ),
        padding: EdgeInsets.all(12),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          errorWidget: (_, __, ___) => Center(
            child: Text(
              'NA',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      title: Text(name),
      trailing: Text('→'),
    );
  }
}
