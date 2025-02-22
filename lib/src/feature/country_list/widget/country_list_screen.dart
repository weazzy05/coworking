import 'package:coworking_mobile/src/core/constant/assets_path.dart';
import 'package:coworking_mobile/src/core/constant/colors.dart';
import 'package:coworking_mobile/src/feature/country_list/bloc/country_list_cubit.dart';
import 'package:coworking_mobile/src/feature/country_list/bloc/country_list_state.dart';
import 'package:coworking_mobile/src/feature/country_list/widget/country_coworking_card.dart';
import 'package:coworking_mobile/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template dashboard_screen}
/// Protected screen, visible to authenticated users only.
/// {@endtemplate}
class CountryListScreen extends StatefulWidget {
  /// {@macro dashboard_screen}
  const CountryListScreen({super.key});

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  late final CountryListCubit _countryListCubit;
  late Image image;

  @override
  void initState() {
    super.initState();
    _countryListCubit =
        CountryListCubit(DependenciesScope.of(context).countryListRepository)
          ..load();
    image = Image.asset(PngAssetPath.roomListAppbar);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(image.image, context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: AppColors.transparent,
          shadowColor: AppColors.transparent,
          scrolledUnderElevation: 0,
          flexibleSpace: Column(
            children: [
              Stack(children: [
                SizedBox(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage(PngAssetPath.roomListAppbar),
                      ),
                    ),
                  ),
                ),
                // Image.asset(PngAssetPath.roomListAppbar),
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
        body: BlocBuilder<CountryListCubit, CountryListState>(
          bloc: _countryListCubit,
          builder: (context, state) => state.map(
            loaded: (data) => ListView(
              addAutomaticKeepAlives: true,
              children: [
                ...data.countriesList.map(
                  (e) => CountryCard(country: e),
                ),
              ],
            ),
            idle: (_) => Center(child: CircularProgressIndicator()),
            loading: (_) => Center(child: CircularProgressIndicator()),
          ),
        ),
      );
}
