import 'package:flutter/material.dart';
import 'package:restaurant_apps/theme/color.dart';
import 'package:restaurant_apps/theme/typography.dart';

class SearchBox extends StatefulWidget {
  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  TextEditingController _textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: new Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.0),
          side: BorderSide(
            color: blackColor.withOpacity(.01),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.search,
                size: 24.0,
                color: darkBlueColor.withOpacity(.2),
              ),
              Expanded(
                flex: 2,
                child: TextField(
                  textInputAction: TextInputAction.search,
                  controller: _textEditingController,
                  decoration: new InputDecoration(
                    hintText: 'Search restaurant',
                    border: InputBorder.none,
                    fillColor: blackColor,
                    hintStyle: hintTextStyle,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 6.0,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _textEditingController.clear();
                },
                child: Icon(
                  Icons.cancel,
                  size: 24.0,
                  color: darkBlueColor.withOpacity(.2),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
