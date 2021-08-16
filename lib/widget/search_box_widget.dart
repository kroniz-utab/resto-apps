import 'package:flutter/material.dart';

import 'package:restaurant_apps/theme/color.dart';
import 'package:restaurant_apps/theme/typography.dart';

class SearchBox extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String value)? onSubmited;

  SearchBox({
    Key? key,
    required this.controller,
    required this.focusNode,
    this.onSubmited,
  }) : super(key: key);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: new Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13.0),
          side: BorderSide(
            color: darkBlueColor.withOpacity(.1),
            width: 1,
          ),
        ),
        elevation: 3,
        shadowColor: mainColor.withOpacity(.4),
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
                  autofocus: true,
                  focusNode: widget.focusNode,
                  textInputAction: TextInputAction.search,
                  controller: widget.controller,
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
                  onSubmitted: widget.onSubmited,
                ),
              ),
              GestureDetector(
                onTap: () {
                  widget.controller.clear();
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
