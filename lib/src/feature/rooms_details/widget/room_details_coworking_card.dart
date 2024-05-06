import 'package:coworking_mobile/src/core/constant/colors.dart';
import 'package:coworking_mobile/src/feature/rooms_details/model/rooms_details_dto.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class RoomDetailCoworkingCard extends StatefulWidget {
  final RoomDetailEntity roomDetailEntity;

  const RoomDetailCoworkingCard({
    required this.roomDetailEntity,
    super.key,
  });

  @override
  State<RoomDetailCoworkingCard> createState() =>
      _RoomDetailCoworkingCardState();
}

class _RoomDetailCoworkingCardState extends State<RoomDetailCoworkingCard> {
  final PageController _cardPageController = PageController();
  int _currentIndexPage = 0;

  @override
  Widget build(BuildContext context) {
    final roomDetailEntity = widget.roomDetailEntity;
    final lengthPageView = roomDetailEntity.imagesPath.length;
    return SizedBox(
      height: 360,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            // TODO(gamzat): Network image?
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                roomDetailEntity.imagesPath[index],
                fit: BoxFit.cover,
              ),
            ),
            onPageChanged: (index) {
              setState(() {
                _currentIndexPage = index;
              });
            },
            itemCount: lengthPageView,
            controller: _cardPageController,
          ),
          lengthPageView > 1
              ? Positioned(
                  bottom: 16,
                  child: DotsIndicator(
                    dotsCount: lengthPageView,
                    position: _currentIndexPage,
                    decorator: DotsDecorator(
                      size: Size.square(6),
                      activeSize: Size.square(6),
                      spacing: EdgeInsets.symmetric(horizontal: 6),
                      color: AppColors.white, // Inactive color
                      activeColor: AppColors.purple,
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
