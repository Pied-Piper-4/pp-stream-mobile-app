import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pp_stream_mobile_app/constant/colors.dart';

final List<String> imgList = [
  "https://media-cdn.tripadvisor.com/media/photo-s/07/f6/0b/af/spice-nice-restaurant.jpg",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOHwsdcuGOf1weax78vnQBPFi9wm-XG6MPPzhYGkxY2Mgwf4MYPMPaz96XVOz1XHXMKkg&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYYZqi5P93K-Q9XfGC3eiKk3_cdWUoJP7MpWExxWC5xWJ1jFVXb0fxD9Gxjr0jIWWcf6Y&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuWamarWmwfiD7RLK1Encfa0_qIcfR1xVl1A&usqp=CAU"
];

final List<Widget> imageSliders = imgList
    .map((item) => ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    item,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 10.0,
              top: 10.0,
              child: Container(
                width: 120,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: pureWhiteBackgroundColor,
                ),
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    
                  ],
                ),
              ),
            ),
          ],
        )))
    .toList();
