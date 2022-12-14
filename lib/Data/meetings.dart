import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pp_stream_mobile_app/constant/colors.dart';

final List<String> imgList = [
  "https://www.dickropa.com/wp-content/uploads/Live-Streaming-Churches-Featured-Image.jpg",
  "https://www.dickropa.com/wp-content/uploads/Live-Streaming-Churches-Featured-Image.jpg",
  "https://www.dickropa.com/wp-content/uploads/Live-Streaming-Churches-Featured-Image.jpg"
];

final List<Widget> imageSliders = imgList
    .map(
      (item) => ClipRRect(
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
                  children: [],
                ),
              ),
            ),
          ],
        ),
      ),
    )
    .toList();
