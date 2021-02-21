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
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Container(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.fill,
                    ))),
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
