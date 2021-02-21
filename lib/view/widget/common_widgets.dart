import 'package:flutter/material.dart';

Widget noInternet(Function onTap) {
  return Center(
      child: Column(
    children: [
      Image(
        image: const AssetImage('assets/images/no_internet.gif'),
      ),
      Text(
        'Oops no internet connection! Please check your router, we\'ll be waiting for you here only',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 32,
      ),
      FlatButton(
        onPressed: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(25),
          ),
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          child: Text(
            'Retry',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    ],
  ));
}

Widget errorWidget(Function onTap) {
  return Center(
    child: Column(
      children: [
        Image(
          image: const AssetImage('assets/images/fire.gif'),
        ),
        Text(
          'Our servers are on fire! Please call fire brigade 🚒 ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 32,
        ),
        FlatButton(
          onPressed: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(25),
            ),
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            child: Text(
              'Retry',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget appLoader(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Image(
          image: const AssetImage('assets/images/loader_bike.gif'),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          text ?? 'Wait we\'ll quickly bring your icons to you.',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget noDataFound() {
  return Center(child: Text('No data found'));
}

Widget buildProgressIndicator() {
  return Image(
    image: const AssetImage('assets/images/loader_cat.gif'),
    height: 86,
  );
}

Widget renderEmptySearchState() {
  return Column(
    children: [
      Image(
        image: const AssetImage('assets/images/waiting.gif'),
      ),
      Text(
        'We are waiting for you input',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}
