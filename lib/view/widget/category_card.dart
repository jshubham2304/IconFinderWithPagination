import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final Function onclick;
  final String imageUrl;
  final String name;

  Category({this.onclick, this.imageUrl, this.name});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onclick,
      child: Container(
          margin: EdgeInsets.only(left: 15, right: 10, bottom: 8),
          padding: EdgeInsets.all(5),
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(Colors.black45, BlendMode.hue)),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          )
          // Stack(
          //   children: [
          //     Container(
          //         height: MediaQuery.of(context).size.width,
          //         width: MediaQuery.of(context).size.width,
          //         decoration: BoxDecoration(
          //           shape: BoxShape.rectangle,
          //           image: DecorationImage(
          //               image: NetworkImage(imageUrl),
          //               fit: BoxFit.fill,
          //               colorFilter:
          //                   ColorFilter.mode(Colors.black45, BlendMode.colorBurn)),
          //           borderRadius: BorderRadius.circular(15),
          //         )),
          //     Container(
          //       height: MediaQuery.of(context).size.width,
          //       width: MediaQuery.of(context).size.width,
          //       padding: EdgeInsets.all(5),
          //       decoration: BoxDecoration(
          //         shape: BoxShape.rectangle,
          //         gradient: LinearGradient(
          //             colors: [Colors.black87, Colors.transparent],
          //             begin: Alignment.topCenter,
          //             end: Alignment.center),
          //         borderRadius: BorderRadius.circular(15),
          //       ),
          //     ),
          //     Positioned(
          //       bottom: 0,
          //       child: Container(
          //         height: 30,
          //         width: MediaQuery.of(context).size.width * 0.43,
          //         padding: EdgeInsets.all(5),
          //         decoration: BoxDecoration(
          //           shape: BoxShape.rectangle,
          //           color: Color(0xffdcdde0),
          //           borderRadius: BorderRadius.circular(15),
          //         ),
          //         child: Center(
          //           child: Flexible(
          //             child: Text(name,
          //                 style:
          //                     TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          ),
    );
  }
}
