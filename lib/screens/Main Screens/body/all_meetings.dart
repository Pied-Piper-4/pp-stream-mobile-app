// ignore_for_file: prefer_final_fields

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pp_stream_mobile_app/constant/colors.dart';
import 'package:pp_stream_mobile_app/screens/Main%20Screens/body/meetings_card_tile.dart';

class AllMeetingsPage extends StatefulWidget {
  const AllMeetingsPage({Key? key}) : super(key: key);

  @override
  State<AllMeetingsPage> createState() => _AllMeetingsPageState();
}

class _AllMeetingsPageState extends State<AllMeetingsPage> {
  TextEditingController _searchview = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:primaryColor,
      body: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width / 20,
          right: MediaQuery.of(context).size.width / 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
            Padding(
              padding: EdgeInsets.only(
                top: 50.0,
                left: MediaQuery.of(context).size.width / 30,
                right: MediaQuery.of(context).size.width / 30,
              ),
              child: Text(
                "All Meetings Available",
                style: TextStyle(
                  color: pureWhiteBackgroundColor,
                  fontFamily: "PoppinsMedium",
                  fontSize: 20,
                ),
              ),
            ),
            searchField(context),
            Expanded(child: meetingsCards(context)),
          ],
        ),
      ),
    );
  }

  Widget meetingsCards(context) {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: 10,
        itemBuilder: (BuildContext ctx, int index) {
          return MeetingsCardTile();
        });
  }

  Widget searchField(context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.width / 40,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: TextField(
          autofocus: false,
          controller: _searchview,
          cursorColor: primaryColor,
          style: TextStyle(
            height: 1.8,
            color: deepBlueColor,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            prefixIcon: Icon(
              FontAwesomeIcons.search,
              color: grayButtonColor,
              size: 20,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              // borderRadius: BorderRadius.circular(10.0),
            ),
            fillColor: Colors.transparent,
            filled: true,
          ),
        ),
      ),
    );
  }


}
