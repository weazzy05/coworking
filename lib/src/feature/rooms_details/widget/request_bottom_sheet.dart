import 'package:coworking_mobile/src/core/constant/assets_path.dart';
import 'package:coworking_mobile/src/core/constant/colors.dart';
import 'package:coworking_mobile/src/core/constant/localization/localization.dart';
import 'package:coworking_mobile/src/feature/rooms_details/model/rooms_details_dto.dart';
import 'package:coworking_mobile/src/feature/rooms_details/widget/form_request_text_field.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class InputInformationForSubmit extends StatefulWidget {
  final RoomsDetails roomsDetails;

  const InputInformationForSubmit({
    required this.roomsDetails,
    super.key,
  });

  @override
  State<InputInformationForSubmit> createState() =>
      _InputInformationForSubmitState();
}

class _InputInformationForSubmitState extends State<InputInformationForSubmit> {
  // TODO(gamzat): go to bloc
  bool isSubmitted = false;
  final GlobalKey<FormState> _key = GlobalKey();
  late final TextEditingController locationController;
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    locationController = TextEditingController(text: widget.roomsDetails.city);
    nameController = TextEditingController();
    phoneController = TextEditingController();

    emailController = TextEditingController();
  }

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
        child: Form(
          key: _key,
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
                      textEditingController: locationController,
                      readOnly: true,
                    ),
                    SizedBox(height: 18),
                    MyInputTextField(
                      filled: true,
                      fillColor: AppColors.textFieldFilled,
                      textEditingController: nameController,
                      title: Localization.of(context).name,
                    ),
                    SizedBox(height: 18),
                    MyInputTextField(
                      filled: true,
                      fillColor: AppColors.textFieldFilled,
                      title: Localization.of(context).phone,
                      textEditingController: phoneController,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Поле обязательно';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 18),
                    MyInputTextField(
                      filled: true,
                      fillColor: AppColors.textFieldFilled,
                      title: Localization.of(context).email,
                      textEditingController: emailController,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Поле обязательно';
                        }
                        return null;
                      },
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
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              setState(() {
                                isSubmitted = true;
                              });
                              await sendMessage(
                                id: widget.roomsDetails.id,
                                email: emailController.text,
                                phone: phoneController.text,
                                location: locationController.text,
                                name: nameController.text,
                              );
                            }
                          },
                          child: Text(
                            Localization.of(context).submitRequest,
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.purple,
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
                            backgroundColor: AppColors.purple,
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
      ),
    );
  }
}

Future<void> sendMessage({
  required String id,
  required String location,
  required String name,
  required String phone,
  required String email,
}) async {
  // Note that using a username and password for gmail only works if
  // you have two-factor authentication enabled and created an App password.
  // Search for "gmail app password 2fa"
  // The alternative is to use oauth.
  String username = r'gamzatabdullaev2003@gmail.com';
  String password = r'mczo wilq suao vdxi';

  final smtpServer = gmail(username, password);
  // Use the SmtpServer class to configure an SMTP server:
  // final smtpServer = SmtpServer('smtp.domain.com');
  // See the named arguments of SmtpServer for further configuration
  // options.

  // Create our message.
  final message = Message()
    ..from = Address(username, 'Your name')
    ..recipients.add('rooms.coworking.ist@gmail.com')
    ..subject = 'Заявка Room $id ${location} ${DateTime.now()}'
    ..text =
        'Имя: $name.\nЛокация: $location.\nRoom: $id.\nТелефон: $phone.\nE-mail: $email.';

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    debugPrint(e.message);
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
}
