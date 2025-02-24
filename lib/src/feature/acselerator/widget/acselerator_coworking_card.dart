import 'package:coworking_mobile/src/feature/acselerator/model/acselerator_dto.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AcseleratorCoworkingCard extends StatefulWidget {
  final Acselerator acselerator;

  const AcseleratorCoworkingCard({
    required this.acselerator,
    super.key,
  });

  @override
  State<AcseleratorCoworkingCard> createState() =>
      _AcseleratorCoworkingCardState();
}

class _AcseleratorCoworkingCardState extends State<AcseleratorCoworkingCard> {
  @override
  Widget build(BuildContext context) {
    final acselerator = widget.acselerator;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 8.0,
      ),
      child: GestureDetector(
        onTap: () {
          context.goNamed(
            'acselerator_details',
            pathParameters: {'id': acselerator.id},
          );
        },
        child: Container(
          // clipBehavior: Clip.antiAlias,
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(8.0),
          //   border: Border.all(color: Colors.black, width: 1.3),
          // ),
          child: Image.asset(
            acselerator.imagePath,
            height: 220,
          ),
        ),
      ),
    );
  }
}
