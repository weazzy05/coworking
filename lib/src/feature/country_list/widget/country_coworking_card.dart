import 'package:coworking_mobile/src/core/constant/assets_path.dart';
import 'package:coworking_mobile/src/feature/country_list/model/country_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CountryCard extends StatefulWidget {
  final CountryDto country;

  const CountryCard({
    required this.country,
    super.key,
  });

  @override
  State<CountryCard> createState() => _CountryCardState();
}

class _CountryCardState extends State<CountryCard> {
  late ImageProvider image;

  @override
  void initState() {
    super.initState();
    image = AssetImage(widget.country.imagePath);
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (mounted) await precacheImage(image, context);
  }

  @override
  Widget build(BuildContext context) {
    final country = widget.country;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 8.0,
      ),
      child: GestureDetector(
        onTap: () {
          context.goNamed(
            'rooms',
            pathParameters: {'cityId': country.id},
          );
        },
        child: SizedBox(
          height: 220,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 20,
                      offset: Offset(0, 19), // changes position of shadow
                    ),
                  ],
                  image: DecorationImage(
                    image: image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  // TODO(gamzat): fix color theme
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        SvgAssetPath.iconPinMap,
                        color: Color(0xFF290943),
                        height: 21,
                      ),
                      SizedBox(width: 6),
                      Text(
                        country.name,
                        style: theme.textTheme.labelLarge
                            ?.copyWith(color: Color(0xFF290943)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
