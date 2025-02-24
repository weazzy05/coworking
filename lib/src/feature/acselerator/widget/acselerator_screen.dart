import 'package:coworking_mobile/src/core/constant/assets_path.dart';
import 'package:coworking_mobile/src/core/constant/colors.dart';
import 'package:coworking_mobile/src/core/constant/localization/localization.dart';
import 'package:coworking_mobile/src/feature/acselerator/bloc/acselerator_list_cubit.dart';
import 'package:coworking_mobile/src/feature/acselerator/bloc/acselerator_list_state.dart';
import 'package:coworking_mobile/src/feature/acselerator/widget/acselerator_coworking_card.dart';
import 'package:coworking_mobile/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// {@template dashboard_screen}
/// Protected screen, visible to authenticated users only.
/// {@endtemplate}
class AcseleratorListScreen extends StatefulWidget {
  /// {@macro dashboard_screen}
  const AcseleratorListScreen({super.key});

  @override
  State<AcseleratorListScreen> createState() => _AcseleratorListScreenState();
}

class _AcseleratorListScreenState extends State<AcseleratorListScreen> {
  late final AcseleratorListCubit _acselectorListCubit;
  late Image image;

  @override
  void initState() {
    super.initState();
    _acselectorListCubit = AcseleratorListCubit(
        DependenciesScope.of(context).acseleratorListRepository)
      ..load();
    image = Image.asset(PngAssetPath.roomListAppbar);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(image.image, context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 225,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(8)),
                  ),
                  child: Image.asset(
                    PngAssetPath.acseleratorLogo,
                    width: 156,
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
            ],
          ),
          SizedBox(height: 8),
          Expanded(
            child: BlocBuilder<AcseleratorListCubit, AcseleratorListState>(
              bloc: _acselectorListCubit,
              builder: (context, state) => state.map(
                loaded: (data) => ListView(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  physics: const AlwaysScrollableScrollPhysics(),
                  addAutomaticKeepAlives: true,
                  cacheExtent: 600,
                  children: [
                    ...data.roomsList.map(
                      (e) => AcseleratorCoworkingCard(acselerator: e),
                    ),
                  ],
                ),
                idle: (_) => Center(child: CircularProgressIndicator()),
                loading: (_) => Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
