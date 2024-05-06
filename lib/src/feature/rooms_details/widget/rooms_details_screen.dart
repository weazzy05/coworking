import 'package:coworking_mobile/src/core/constant/assets_path.dart';
import 'package:coworking_mobile/src/core/constant/colors.dart';
import 'package:coworking_mobile/src/core/constant/localization/localization.dart';
import 'package:coworking_mobile/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:coworking_mobile/src/feature/rooms_details/bloc/rooms_details_cubit.dart';
import 'package:coworking_mobile/src/feature/rooms_details/bloc/rooms_details_state.dart';
import 'package:coworking_mobile/src/feature/rooms_details/model/rooms_details_dto.dart';
import 'package:coworking_mobile/src/feature/rooms_details/widget/room_details_coworking_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                ...data.roomsDetails.rooms
                    .map((e) => RoomDetailBody(roomDetailEntity: e)),
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
  final RoomDetailEntity roomDetailEntity;

  const RoomDetailBody({
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
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              Localization.of(context).priceInHour(roomDetailEntity.price),
              style: theme.textTheme.titleSmall,
            ),
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
                  builder: (BuildContext context) =>
                      InputInformationForSubmit(),
                );
              },
              child: Text(
                Localization.of(context).submitRequest,
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

class InputInformationForSubmit extends StatefulWidget {
  const InputInformationForSubmit({super.key});

  @override
  State<InputInformationForSubmit> createState() =>
      _InputInformationForSubmitState();
}

class _InputInformationForSubmitState extends State<InputInformationForSubmit> {
  // TODO(gamzat): go to bloc
  bool isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 32,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: !isSubmitted
              ? [
                  Text(
                    Localization.of(context).submitRequestForContactYou,
                    style: theme.textTheme.titleSmall,
                  ),
                  SizedBox(height: 24),
                  MyInputTextField(
                    filled: true,
                    fillColor: AppColors.textFieldFilled,
                    title: Localization.of(context).location,
                  ),
                  SizedBox(height: 18),
                  MyInputTextField(
                    filled: true,
                    fillColor: AppColors.textFieldFilled,
                    title: Localization.of(context).name,
                  ),
                  SizedBox(height: 18),
                  MyInputTextField(
                    filled: true,
                    fillColor: AppColors.textFieldFilled,
                    title: Localization.of(context).phone,
                  ),
                  SizedBox(height: 18),
                  MyInputTextField(
                    filled: true,
                    fillColor: AppColors.textFieldFilled,
                    title: Localization.of(context).email,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 32,
                      bottom: 24,
                    ),
                    child: SizedBox(
                      height: 52,
                      width: 358,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isSubmitted = true;
                          });
                        },
                        child: Text(
                          Localization.of(context).submitRequest,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
              : [
                  Text(Localization.of(context).applicationHasBeenSent,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleSmall),
                  SizedBox(height: 30),
                  Image.asset(
                    PngAssetPath.requestSended,
                    height: 225,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 50,
                      bottom: 24,
                    ),
                    child: SizedBox(
                      height: 52,
                      width: 358,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          Localization.of(context).close,
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
        ),
      ),
    );
  }
}

class MyInputTextField extends StatefulWidget {
  final String? title;
  final bool filled;
  final Color? fillColor;
  final String? helperText;
  final bool isSecure;
  final int maxLength;
  final String? hint;
  final TextInputType? inputType;
  final String? initValue;
  final Color? backColor;
  final Widget? suffix;
  final Widget? prefix;
  final TextEditingController? textEditingController;
  final String? Function(String? value)? validator;
  final Function(String)? onTextChanged;
  final Function(String)? onSaved;
  List<TextInputFormatter>? inputFormatters;

  static const int MAX_LENGTH = 500;

  MyInputTextField({
    this.title,
    this.hint,
    this.helperText,
    this.inputType,
    this.initValue = "",
    this.isSecure = false,
    this.filled = true,
    this.fillColor,
    this.textEditingController,
    this.validator,
    this.maxLength = MAX_LENGTH,
    this.onTextChanged,
    this.onSaved,
    this.inputFormatters,
    this.backColor,
    this.suffix,
    this.prefix,
  });

  @override
  _MyInputTextFieldState createState() => _MyInputTextFieldState();
}

class _MyInputTextFieldState extends State<MyInputTextField> {
  late bool _passwordVisibility;
  late ThemeData theme;

  FocusNode _focusNode = FocusNode();

  Color _borderColor = AppColors.transparent;
  double _borderSize = 1;

  @override
  void initState() {
    super.initState();
    _passwordVisibility = !widget.isSecure;
    widget.textEditingController?.text = widget.initValue ?? "";

    _focusNode.addListener(() {
      setState(() {
        _borderSize = _focusNode.hasFocus ? 1.7 : 1;
      });
    });
  }

  @override
  void didChangeDependencies() {
    theme = Theme.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 52,
          decoration: BoxDecoration(
            color: widget.fillColor,
            border: Border.all(color: _borderColor, width: _borderSize),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: TextFormField(
            focusNode: _focusNode,
            controller: widget.textEditingController,
            autocorrect: false,
            obscureText: !_passwordVisibility,
            keyboardType: widget.inputType,
            cursorColor: AppColors.black,
            validator: (value) {
              String? f = widget.validator?.call(value);
              setState(() {
                _borderColor =
                    f != null ? AppColors.red : AppColors.transparent;
              });
              return f;
            },
            style:
                theme.textTheme.labelMedium?.copyWith(color: AppColors.black),
            maxLength: widget.maxLength,
            inputFormatters: widget.inputFormatters,
            maxLines: 1,
            onChanged: (text) {
              widget.onTextChanged?.call(text);
            },
            decoration: InputDecoration(
              labelStyle: theme.textTheme.labelLarge?.copyWith(
                  color: AppColors.gray, fontWeight: FontWeight.w400),
              counterText: "",
              floatingLabelStyle:
                  theme.textTheme.labelSmall?.copyWith(color: AppColors.gray),
              labelText: widget.title,
              helperText: widget.helperText,
              suffixIcon: getSuffixIcon(),
              prefixIcon: widget.prefix,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
            ),
          ),
        )
      ],
    );
  }

  Widget? getSuffixIcon() {
    return widget.isSecure ? getPasswordSuffixIcon() : widget.suffix;
  }

  Widget? getPasswordSuffixIcon() {
    return IconButton(
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      padding: EdgeInsets.zero,
      icon:
          _passwordVisibility ? Icon(Icons.remove_red_eye) : Icon(Icons.blind),
      color: Colors.white,
      onPressed: () {
        setState(() {
          _passwordVisibility = !_passwordVisibility;
        });
      },
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
