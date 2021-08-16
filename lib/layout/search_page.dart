import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_indicator/loading_indicator.dart';
import 'package:restaurant_apps/layout/detail_resto.dart';
import 'package:restaurant_apps/model/restaurant_list_model.dart';
import 'package:restaurant_apps/model/restaurant_search_model.dart';
import 'package:restaurant_apps/theme/color.dart';
import 'package:restaurant_apps/theme/typography.dart';
import 'package:restaurant_apps/widget/resto_list.dart';

enum SearchState { Loading, NoData, Error, NoInput }

class SearchPage extends StatefulWidget {
  static const routeName = '/searchPage';
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _textEditingController = TextEditingController();
  late FocusNode _focusNode;
  late StreamController _streamController;
  late Stream _stream;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _streamController = StreamController();
    _stream = _streamController.stream;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  _search() async {
    if (_textEditingController.text.length == 0) {
      _streamController.add(SearchState.NoInput);
    } else {
      try {
        _streamController.add(SearchState.Loading);
        final String url =
            'https://restaurant-api.dicoding.dev/search?q=${_textEditingController.text.trim()}';

        http.Response response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          var result = RestoSearchModel.fromJson(jsonDecode(response.body));
          if (result.restaurants.length == 0) {
            _streamController.add(SearchState.NoData);
          } else {
            _streamController.add(result);
          }
        }
      } catch (e) {
        _streamController.add(SearchState.Error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: whiteColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: darkBlueColor.withOpacity(.7),
          ),
        ),
        title: Container(
          alignment: Alignment.centerLeft,
          color: whiteColor,
          child: TextFormField(
            autofocus: true,
            focusNode: _focusNode,
            textInputAction: TextInputAction.search,
            controller: _textEditingController,
            decoration: InputDecoration(
              hintText: 'Search restaurant',
              border: InputBorder.none,
              fillColor: darkBlueColor,
              hintStyle: hintTextStyle,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                vertical: 0.0,
                horizontal: 4.0,
              ),
            ),
            onFieldSubmitted: (value) {
              _search();
            },
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              _textEditingController.clear();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.cancel,
                size: 24.0,
                color: darkBlueColor.withOpacity(.2),
              ),
            ),
          ),
        ],
      ),
      body: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                whiteColor,
                bgGradientColor.withOpacity(.5),
              ],
              stops: [0, 1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: StreamBuilder(
                stream: _stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == SearchState.NoInput ||
                      snapshot.data == null) {
                    return Center(
                      child: Text('Enter a search word'),
                    );
                  } else if (snapshot.data == SearchState.Loading) {
                    return Center(
                      child: Container(
                        height: 50,
                        child: LoadingIndicator(
                          indicatorType: Indicator.lineScale,
                          colors: [
                            mainColor,
                            mainColor.withOpacity(.8),
                            mainColor.withOpacity(.6),
                            mainColor.withOpacity(.4),
                            mainColor.withOpacity(.2),
                          ],
                          strokeWidth: 1,
                        ),
                      ),
                    );
                  } else if (snapshot.data == SearchState.NoData) {
                    return Center(
                      child: Text(
                          '\'${_textEditingController.text.trim()}\' restaurant was not found!'),
                    );
                  } else {
                    final List<Restaurant> dataList = snapshot.data.restaurants;
                    return ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        SizedBox(height: 24),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: dataList.length,
                          itemBuilder: (context, index) {
                            final Restaurant data = dataList[index];
                            return RestoList(
                              restoRating: data.rating.toString(),
                              restoLocation: data.city,
                              restoName: data.name,
                              imgID: data.pictureId,
                              onClick: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  DetailResto.routeName,
                                  arguments: data.id,
                                );
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 8);
                          },
                        ),
                        SizedBox(height: 24),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
