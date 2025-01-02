import 'package:collection/collection.dart';
import 'package:coworking_mobile/src/core/constant/assets_path.dart';
import 'package:coworking_mobile/src/core/constant/colors.dart';
import 'package:coworking_mobile/src/core/constant/localization/localization.dart';
import 'package:coworking_mobile/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:coworking_mobile/src/feature/rooms_list/bloc/rooms_list_cubit.dart';
import 'package:coworking_mobile/src/feature/rooms_list/bloc/rooms_list_state.dart';
import 'package:coworking_mobile/src/feature/rooms_list/widget/rooms_coworking_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'rooms_promotions.dart';

/// {@template dashboard_screen}
/// Protected screen, visible to authenticated users only.
/// {@endtemplate}
class RoomsListScreen extends StatefulWidget {
  final String cityId;

  /// {@macro dashboard_screen}
  const RoomsListScreen({required this.cityId, super.key});

  @override
  State<RoomsListScreen> createState() => _RoomsListScreenState();
}

class _RoomsListScreenState extends State<RoomsListScreen> {
  late final RoomsListCubit _roomsListCubit;
  late Image image;

  @override
  void initState() {
    super.initState();
    _roomsListCubit =
        RoomsListCubit(DependenciesScope.of(context).roomsListRepository)
          ..load(widget.cityId);
    image = Image.asset(PngAssetPath.roomListAppbar);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    precacheImage(image.image, context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 160,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.transparent,
        shadowColor: AppColors.transparent,
        scrolledUnderElevation: 0,
        flexibleSpace: Column(
          children: [
            Stack(children: [
              SizedBox(
                height: 180,
                width: MediaQuery.of(context).size.width,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage(PngAssetPath.roomListAppbar),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: 0,
                child: TextButton.icon(
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icon(Icons.chevron_left, color: AppColors.white),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.transparent,
                  ),
                  label: Text(
                    Localization.of(context).back,
                    style: theme.textTheme.labelLarge
                        ?.copyWith(fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Positioned(
                bottom: 24,
                left: 12,
                child: SizedBox(
                  height: 28,
                  width: 160,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(PngAssetPath.logo),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
            SizedBox(height: 16)
          ],
        ),
      ),
      body: BlocBuilder<RoomsListCubit, RoomsListState>(
        bloc: _roomsListCubit,
        builder: (context, state) => state.map(
          loaded: (data) => ListView(
            addAutomaticKeepAlives: true,
            children: [
              _PromotionPageView(
                promotions: [
                  // TODO(gamzat): from fake to data
                  // PngAssetPath.promotionExample,
                  // PngAssetPath.promotionExample,
                  // PngAssetPath.promotionExample,
                ],
              ),
              ...data.roomsList.map(
                (e) => RoomsCoworkingCard(rooms: e),
              ),
            ],
          ),
          idle: (_) => Center(child: CircularProgressIndicator()),
          loading: (_) => Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
