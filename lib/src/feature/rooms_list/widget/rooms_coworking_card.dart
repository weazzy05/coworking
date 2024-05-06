import 'package:coworking_mobile/src/core/constant/assets_path.dart';
import 'package:coworking_mobile/src/core/constant/colors.dart';
import 'package:coworking_mobile/src/core/constant/localization/localization.dart';
import 'package:coworking_mobile/src/feature/rooms_list/model/rooms_dto.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class RoomsCoworkingCard extends StatefulWidget {
  final Rooms rooms;

  const RoomsCoworkingCard({
    required this.rooms,
    super.key,
  });

  @override
  State<RoomsCoworkingCard> createState() => _RoomsCoworkingCardState();
}

class _RoomsCoworkingCardState extends State<RoomsCoworkingCard> {
  final PageController _cardPageController = PageController();
  int _currentIndexPage = 0;

  @override
  Widget build(BuildContext context) {
    final rooms = widget.rooms;
    final lengthPageView = rooms.imagesPath.length;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 8.0,
      ),
      child: GestureDetector(
        onTap: () {
          context.goNamed(
            'room_details',
            pathParameters: {'roomId': rooms.id},
          );
        },
        child: SizedBox(
          height: 220,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PageView.builder(
                // TODO(gamzat): Network image?
                itemBuilder: (context, index) => ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    rooms.imagesPath[index],
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
              Positioned(
                left: 16,
                top: 24,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      PngAssetPath.iconArea,
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      Localization.of(context).area(rooms.square),
                      style: theme.textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 20,
                bottom: 28,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      SvgAssetPath.iconPinMap,
                      height: 21,
                    ),
                    SizedBox(width: 6),
                    Text(
                      rooms.city,
                      style: theme.textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
              Positioned(
                  right: 16,
                  bottom: 24,
                  child: Text(
                    rooms.displayWorkingTime(),
                    style: theme.textTheme.titleMedium,
                  )),
              lengthPageView > 1
                  ? Positioned(
                      bottom: 14,
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
        ),
      ),
    );
  }
}
