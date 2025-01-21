import 'package:das_app/data/model/Booking.dart';
import 'package:das_app/data/model/Product.dart';
import 'package:das_app/data/model/product_response.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class SaleCompleteScreen extends StatelessWidget {
  final pdf = pw.Document();
  Booking booking;
  Products product;
  SaleCompleteScreen({Key? key, required this.booking, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sale Complete'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sale Completed!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox( // Wrap with SizedBox for width
              width: 300, // Make button full width
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Same background color
                  padding: const EdgeInsets.symmetric(vertical: 16.0), // Same padding
                ),
                onPressed: () async {

                  Directory documentDirectory =
                  await getApplicationDocumentsDirectory();

                  String documentPath = documentDirectory.path;

                  String formattedTimestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());

                  String fullPath = "$documentPath/file_$formattedTimestamp.pdf";
                  writeOnPdf();
                  var data = await savePdf();


                  print(fullPath);

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => PdfPreviewScreen(
                  //           path: fullPath,
                  //         )));
                  Printing.layoutPdf(
                    // [onLayout] will be called multiple times
                    // when the user changes the printer or printer settings
                    onLayout: (PdfPageFormat format) {
                      // Any valid Pdf document can be returned here as a list of int
                      return data;
                    },
                  );
                },
                child: const Text('Send Invoice', style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void writeOnPdf() {
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.only(left: 16,right: 16),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(
              level: 2,
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: <pw.Widget>[
                    pw.Header(level: 2, text: 'TAX INVOICE'),
                  ])),
          pw.Header(
              level: 2,
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: <pw.Widget>[
                    pw.Header(level: 2, text: 'DAS GAS SAFETY EQUIPMENT PVT LTD.'),
                  ])),

          pw.Paragraph(
              text: '''
              Head Office: Sr.No. 37/2,FL No. 102 Lata Mangeshkar Layout, Pune.-411045
              Sub Office: Gala No. 6.7&8, first Floor, New Padmavati Complex, Datta Chowk,
              Near Chhatrapati Shivaji Maharaj Statue, Karad, Tal.Karad Dist.Satara
              http://dasgroupco.com
              GST-27AAJCD5582A1ZP                 MO. 7030522169             Reg No.214659
              '''),

          pw.Header( text: '', ),
          pw.Paragraph(
              text: '''

          '''),
                    pw.Paragraph(
                        text: '''
          Customer Name   : ${booking.name}
          Customer Address: ${booking.address}
          Mobile Number  : ${booking.mobileNumber}
          '''),
          pw.Padding(padding: const pw.EdgeInsets.all(10)),
          pw.TableHelper.fromTextArray(context: context,
              cellPadding: pw.EdgeInsets.all( 10),
              data: <List<String>>[
                <String>['Product detail', 'Units','Price','Total'],
                <String>['${product.name}', '1','${product.price}','${product.price}'],

              ]),

          pw.Paragraph(text:'''
          
          
          
          
          
           '''),
          pw.Header(text: ""),
          pw.Paragraph(text:'''
            Note: 1) Advance booking amount is non-refundable under any circumstances. Additional cost will be charged after the advance period. 2) If the printed text in the receipt is tampered with, the receipt will be invalid. 3) Company shall not be liable for any amount exceeding the printed amount. 4) Booking advance of Rs.500/- should be paid to the representative, company will not be responsible if more is paid. 5) The device will have a five year warranty. 6) The representative should check the goods by seeing the demo in person while making the purchase in the same manner as shown by the demo. 7) Booking Receipt should be read in full and then signed. 8) Company will not be responsible for any financial transaction without Company ID card. 1) The company will not be responsible for any damage during handling of the device. 10) Home service will not be available for any reason. 11) In case of any malfunction in the device, getting replacement from the nearest office. 22) No item comes free with Surya Gas Bing Commercial Device.
            '''),
        ];
      },
    ));
  }
  Future<Uint8List> savePdf() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File("$documentPath/example.pdf");
    if(file.exists()==true) file.delete();
    Uint8List pdfData = await pdf.save();

    await file.writeAsBytes(pdfData);
    return pdfData;
  }
}