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

part 'rooms_promotions.dart';

/// {@template dashboard_screen}
/// Protected screen, visible to authenticated users only.
/// {@endtemplate}
class RoomsListScreen extends StatefulWidget {
  /// {@macro dashboard_screen}
  const RoomsListScreen({super.key});

  @override
  State<RoomsListScreen> createState() => _RoomsListScreenState();
}

class _RoomsListScreenState extends State<RoomsListScreen> {
  late final RoomsListCubit _roomsListCubit;

  @override
  void initState() {
    _roomsListCubit =
        RoomsListCubit(DependenciesScope.of(context).roomsListRepository)
          ..load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 110,
          backgroundColor: AppColors.transparent,
          shadowColor: AppColors.transparent,
          scrolledUnderElevation: 0,
          flexibleSpace: Column(
            children: [
              Stack(children: [
                Image.asset(PngAssetPath.roomListAppbar),
                Positioned(
                  bottom: 24,
                  left: 12,
                  child: Image.asset(
                    PngAssetPath.logo,
                    height: 28,
                    width: 160,
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
              children: [
                _PromotionPageView(
                  promotions: [
                    // TODO(gamzat): from fake to data
                    PngAssetPath.promotionExample,
                    PngAssetPath.promotionExample,
                    PngAssetPath.promotionExample,
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
