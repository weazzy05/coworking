import 'package:coworking_mobile/src/feature/acselerator_details/model/acselector_details_dto.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfAcseleratorScreen extends StatefulWidget {
  const PdfAcseleratorScreen({required this.acseleratorDetails});

  final AcseleratorDetails acseleratorDetails;

  @override
  State<PdfAcseleratorScreen> createState() => _PdfAcseleratorScreenState();
}

class _PdfAcseleratorScreenState extends State<PdfAcseleratorScreen> {
  late final PdfController pdfController;

  int currentPage = 1;
  int totalPages = 1;

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
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 60,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Color(0xFFDDDDDD),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  '$currentPage/${totalPages}',
                  style: TextStyle(),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.width / 1.79,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.black, width: 1.5),
              ),
              child: ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(8.0),
                child: Transform.scale(
                  scale: 1.04,
                  child: PdfView(
                    onPageChanged: (page) {
                      setState(() {
                        currentPage = page;
                      });
                    },
                    onDocumentLoaded: (pages) {
                      setState(() {
                        totalPages = pages.pagesCount;
                      });
                    },
                    controller: pdfController,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 60,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Color(0xFFDDDDDD),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  '$currentPage/${totalPages}',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
