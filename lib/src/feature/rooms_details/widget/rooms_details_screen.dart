import 'package:coworking_mobile/src/core/constant/assets_path.dart';
import 'package:coworking_mobile/src/core/constant/colors.dart';
import 'package:coworking_mobile/src/core/constant/localization/localization.dart';
import 'package:coworking_mobile/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:coworking_mobile/src/feature/rooms_details/bloc/rooms_details_cubit.dart';
import 'package:coworking_mobile/src/feature/rooms_details/bloc/rooms_details_state.dart';
import 'package:coworking_mobile/src/feature/rooms_details/model/rooms_details_dto.dart';
import 'package:coworking_mobile/src/feature/rooms_details/widget/request_bottom_sheet.dart';
import 'package:coworking_mobile/src/feature/rooms_details/widget/room_details_coworking_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

/// {@template dashboard_screen}
/// Protected screen, visible to authenticated users only.
/// {@endtemplate}
class RoomsDetailsScreen extends StatefulWidget {
  final String roomId;

  /// {@macro dashboard_screen}
  const RoomsDetailsScreen({
    required this.roomId,
    super.key,
  });

  @override
  State<RoomsDetailsScreen> createState() => _RoomsDetailsScreenState();
}

class _RoomsDetailsScreenState extends State<RoomsDetailsScreen> {
  late final RoomsDetailsCubit _roomsDetailsCubit;

  @override
  void initState() {
    super.initState();
    final id = widget.roomId;
    _roomsDetailsCubit =
        RoomsDetailsCubit(DependenciesScope.of(context).roomsDetailsRepository)
          ..load(id);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<RoomsDetailsCubit, RoomsDetailsState>(
          bloc: _roomsDetailsCubit,
          builder: (context, state) => state.map(
            loaded: (data) => SingleChildScrollView(
                child: Column(
              children: [
                SizedBox(
                  height: 208,
                  child: Stack(
                    children: [
                      Image.asset(
                        data.roomsDetails.titleImage,
                        height: 208,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 32,
                        left: 10,
                        child: TextButton.icon(
                          onPressed: () {
                            context.pop();
                          },
                          icon:
                              Icon(Icons.chevron_left, color: AppColors.white),
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
                        left: 20,
                        child: Image.asset(
                          PngAssetPath.logo,
                          height: 22,
                          width: 130,
                        ),
                      ),
                      Positioned(
                        bottom: 24,
                        left: 20,
                        child: Image.asset(
                          PngAssetPath.logo,
                          height: 22,
                          width: 130,
                        ),
                      ),
                      Positioned(
                        right: 16,
                        bottom: 25,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              SvgAssetPath.iconPinMap,
                              height: 21,
                            ),
                            SizedBox(width: 6),
                            Text(
                              data.roomsDetails.city,
                              style: theme.textTheme.labelLarge,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                ...data.roomsDetails.rooms.map((e) => RoomDetailBody(
                      roomDetailEntity: e,
                      roomsDetails: data.roomsDetails,
                    )),
              ],
            )),
            idle: (_) => Center(child: CircularProgressIndicator()),
            loading: (_) => Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}

class RoomDetailBody extends StatelessWidget {
  final RoomsDetails roomsDetails;
  final RoomDetailEntity roomDetailEntity;

  const RoomDetailBody({
    required this.roomsDetails,
    required this.roomDetailEntity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          if (roomDetailEntity.title.isNotEmpty)
            Text(
              roomDetailEntity.title,
              style: theme.textTheme.titleLarge,
            ),
          const SizedBox(height: 12),
          RoomDetailCoworkingCard(roomDetailEntity: roomDetailEntity),
          const SizedBox(height: 8),
          Text(
            roomDetailEntity.description,
            style: theme.textTheme.labelMedium?.copyWith(
              color: AppColors.subtitleTextColor.withOpacity(0.8),
              fontWeight: FontWeight.w400,
            ),
          ),
          _IncludedAdvantage(
            includedAdvantages: roomDetailEntity.includedAdvantages,
          ),
          SizedBox(height: 12),
          SizedBox(
            height: 52,
            width: 358,
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  // constraints: BoxConstraints(maxHeight: 500, minHeight: 478),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16.0)),
                  ),
                  backgroundColor: AppColors.white,
                  builder: (context) => InputInformationForSubmit(
                    roomsDetails: roomsDetails,
                  ),
                );
              },
              child: Text(
                Localization.of(context).findOutPrice,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: AppColors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
              ),
            ),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}

typedef IncludedAdvantage = List<String>;

class _IncludedAdvantage extends StatelessWidget {
  final IncludedAdvantage includedAdvantages;
  const _IncludedAdvantage({
    required this.includedAdvantages,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return IntrinsicHeight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (includedAdvantages.isNotEmpty) ...[
            SizedBox(height: 24),
            Text(
              Localization.of(context).includedAdvantages,
              style: theme.textTheme.titleSmall,
            ),
            SizedBox(height: 12),
            ...includedAdvantages.map(
              (e) => Text(
                '• ${e}',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: AppColors.subtitleTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
