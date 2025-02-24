import 'package:coworking_mobile/src/core/constant/assets_path.dart';
import 'package:coworking_mobile/src/core/constant/colors.dart';
import 'package:coworking_mobile/src/core/constant/localization/localization.dart';
import 'package:coworking_mobile/src/feature/acselerator_details/bloc/acselerator_details_cubit.dart';
import 'package:coworking_mobile/src/feature/acselerator_details/bloc/acselerator_details_state.dart';
import 'package:coworking_mobile/src/feature/acselerator_details/model/acselector_details_dto.dart';
import 'package:coworking_mobile/src/feature/acselerator_details/widget/acselerator_pdf_screen.dart';
import 'package:coworking_mobile/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pdfx/pdfx.dart';

/// {@template dashboard_screen}
/// Protected screen, visible to authenticated users only.
/// {@endtemplate}
class AcseleratorDetailsScreen extends StatefulWidget {
  final String acselectorId;

  /// {@macro dashboard_screen}
  const AcseleratorDetailsScreen({
    required this.acselectorId,
    super.key,
  });

  @override
  State<AcseleratorDetailsScreen> createState() =>
      _AcseleratorDetailsScreenState();
}

class _AcseleratorDetailsScreenState extends State<AcseleratorDetailsScreen> {
  late final AcseleratorDetailsCubit _acseleratorDetailsCubit;

  @override
  void initState() {
    super.initState();
    final id = widget.acselectorId;
    _acseleratorDetailsCubit = AcseleratorDetailsCubit(
        DependenciesScope.of(context).acseleratorDetailsRepository)
      ..load(id);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: BlocBuilder<AcseleratorDetailsCubit, AcseleratorDetailsState>(
        bloc: _acseleratorDetailsCubit,
        builder: (context, state) => state.map(
          loaded: (data) => SingleChildScrollView(
            child: Column(
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'О проекте:',
                        style: TextStyle(
                          fontSize: 22,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        data.acselectorDetails.description,
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  child: SizedBox(
                    height: (MediaQuery.of(context).size.width - 80) / 1.79,
                    child: PdfAcseleratorViewer(
                        acseleratorDetails: data.acselectorDetails),
                  ),
                ),
              ],
            ),
          ),
          idle: (_) => Center(child: CircularProgressIndicator()),
          loading: (_) => Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

class PdfAcseleratorViewer extends StatefulWidget {
  const PdfAcseleratorViewer({required this.acseleratorDetails});

  final AcseleratorDetails acseleratorDetails;

  @override
  State<PdfAcseleratorViewer> createState() => _PdfAcseleratorViewerState();
}

class _PdfAcseleratorViewerState extends State<PdfAcseleratorViewer> {
  late final PdfController pdfController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pdfController = PdfController(
      document: PdfDocument.openAsset(widget.acseleratorDetails.pdfPath),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          splashRadius: 16,
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          onPressed: () {
            pdfController.previousPage(
                duration: Duration(seconds: 1), curve: Curves.easeInOut);
          },
          icon: Icon(Icons.arrow_circle_left_outlined),
        ),
        SizedBox(width: 6),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PdfAcseleratorScreen(
                      acseleratorDetails: widget.acseleratorDetails),
                ),
              );
            },
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.black, width: 1.5),
              ),
              child: ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(8.0),
                child: Transform.scale(
                  scale: 1.05,
                  child: PdfView(
                    controller: pdfController,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 6),
        IconButton(
          splashRadius: 16,
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          onPressed: () {
            pdfController.nextPage(
                duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          },
          icon: Icon(
            Icons.arrow_circle_right_outlined,
          ),
        ),
      ],
    );
  }
}
