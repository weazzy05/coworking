import 'package:coworking_mobile/src/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyInputTextField extends StatefulWidget {
  final String? title;
  final bool filled;
  final Color? fillColor;
  final bool readOnly;
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
    this.readOnly = false,
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
            readOnly: widget.readOnly,
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
