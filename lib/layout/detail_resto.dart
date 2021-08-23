import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:restaurant_apps/api/api_service.dart';
import 'package:restaurant_apps/model/restaurant_details.dart';
import 'package:restaurant_apps/provider/resto_detail_provider.dart';

import 'package:restaurant_apps/theme/color.dart';
import 'package:restaurant_apps/theme/typography.dart';
import 'package:restaurant_apps/widget/custom_back_button.dart';
import 'package:restaurant_apps/widget/favorite_button.dart';
import 'package:restaurant_apps/widget/menu_card.dart';

class DetailResto extends StatelessWidget {
  static const routeName = '/detailResto';
  static const _paddingValue = 24.0;

  final String restoID;

  DetailResto({
    Key? key,
    required this.restoID,
  }) : super(key: key);

  final _fadeInController = FadeInController(autoStart: true);
  final Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              whiteColor,
              bgGradientColor.withOpacity(.8),
            ],
            stops: [0, 1],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ChangeNotifierProvider<RestaurantDetailProvider>(
          create: (context) =>
              RestaurantDetailProvider(apiServices: ApiServices(), id: restoID),
          child: Consumer<RestaurantDetailProvider>(
            builder: (context, state, _) {
              if (state.state == DetailResultState.Loading) {
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
              } else if (state.state == DetailResultState.NoData) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state.state == DetailResultState.Error) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state.state == DetailResultState.HasData) {
                var detailData = state.restaurantDetail.restaurant;
                return _buildOverallPage(detailData);
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildOverallPage(RestaurantDetail detailData) {
    return FadeIn(
      duration: Duration(seconds: 1),
      curve: Curves.easeOut,
      controller: _fadeInController,
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/images/placeholder.jpg',
                        image:
                            'https://restaurant-api.dicoding.dev/images/medium/${detailData.pictureId}',
                        height: 325,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomBackButton(size: 40, buttonSize: 22),
                          FavoriteButton(size: 40, isFavorite: false),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: _paddingValue),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        detailData.name,
                        style: detailTitleTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.place,
                            color: blackColor.withOpacity(.5),
                            size: 20,
                          ),
                          Text(
                            detailData.city,
                            style: detailLocationTextStyle,
                          )
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Description',
                        style: detailSubitleTextStyle,
                      ),
                      SizedBox(height: 8),
                      ReadMoreText(
                        detailData.description,
                        trimLines: 2,
                        colorClickableText: mainColor,
                        trimMode: TrimMode.Length,
                        trimCollapsedText: 'Read More',
                        trimExpandedText: ' Show Less',
                        style: detailContentTextStyle,
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: _paddingValue),
                  child: Text(
                    'Foods',
                    style: detailSubitleTextStyle,
                  ),
                ),
                SizedBox(height: 8),
                _buildMenuCardView(detailData.menus.foods),
                SizedBox(height: 8),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: _paddingValue),
                  child: Text(
                    'Drinks',
                    style: detailSubitleTextStyle,
                  ),
                ),
                SizedBox(height: 8),
                _buildMenuCardView(detailData.menus.drinks),
                SizedBox(height: 8),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: _paddingValue),
                  child: Text(
                    'Give Ratings',
                    style: detailSubitleTextStyle,
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: RatingBar.builder(
                    itemBuilder: (context, index) {
                      return Icon(
                        Icons.star_rounded,
                        color: starColor,
                      );
                    },
                    onRatingUpdate: (value) {
                      print(value);
                    },
                    minRating: 1,
                    initialRating: 0,
                    itemPadding: EdgeInsets.symmetric(horizontal: 2),
                    allowHalfRating: true,
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: _paddingValue),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Top Reviews',
                        style: detailSubitleTextStyle,
                      ),
                      SizedBox(height: 8),
                      ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: detailData.customerReviews.length <= 5
                            ? detailData.customerReviews.length
                            : detailData.customerReviews.sublist(0, 5).length,
                        itemBuilder: (context, index) {
                          List<CustomerReview> reviewer =
                              detailData.customerReviews.length <= 5
                                  ? detailData.customerReviews
                                  : detailData.customerReviews.sublist(0, 5);
                          return _buildTopReview(reviewer[index]);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 8);
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(height: _paddingValue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopReview(CustomerReview review) {
    var _reviewerName = review.name;
    var _reviewerSplit = _reviewerName.split(" ");
    String _initials = _reviewerSplit[0].substring(0, 2).toUpperCase();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor:
              profileColorList[random.nextInt(profileColorList.length)],
          radius: 25,
          child: Text(
            _initials,
            style: avatarNameTextStyle,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                _reviewerName,
                style: reviewerNameTextStyle,
              ),
              Text(
                review.date,
                style: reviewerDateTextStyle,
              ),
              SizedBox(height: 4),
              Text(
                review.review,
                style: detailContentTextStyle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ],
    );
  }

  Container _buildMenuCardView(var data) {
    return Container(
      height: 175,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(width: _paddingValue),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            separatorBuilder: (context, index) {
              return SizedBox(width: 5);
            },
            itemBuilder: (context, index) {
              return MenuCard(menuName: data[index].name);
            },
          ),
          SizedBox(width: _paddingValue)
        ],
      ),
    );
  }
}
