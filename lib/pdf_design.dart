import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_billmaker/tableData.dart';
import 'package:printing/printing.dart';

class pdf_design extends StatefulWidget {
  pdf_design({super.key});

  @override
  State<pdf_design> createState() => _pdf_designState();
}

class _pdf_designState extends State<pdf_design> {
  int logoindex = 1;

  @override
  Widget build(BuildContext context) {
    int Gint = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
                color: Colors.red,
                height: 100,
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: List.generate(
                          10,
                          (index) => Container(
                                height: 90,
                                width: 90,
                                child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        logoindex = index + 1;
                                      });
                                    },
                                    child: Image.asset(
                                        "assets/L${index + 1}.png")),
                              ))),
                )),
            Expanded(
              child: PdfPreview(
                build: (format) => design(
                    logoinx: logoindex,
                    phoneNumber: "${invoice[Gint].phoneNumber}",
                    name: "${invoice[Gint].customerName}",
                    billDate: "${invoice[Gint].billDate}",
                    invoiceNumber: "$Gint",
                    Gindex: Gint),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

pw.Widget PaddedText(
  final String text, {
  pw.TextStyle? textStyle,
  final pw.TextAlign align = pw.TextAlign.left,
}) =>
    pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        style: textStyle,
        text,
        textAlign: align,
      ),
    );

Future<Uint8List> design(
    {required int logoinx,
    required String name,
    required String invoiceNumber,
    required String phoneNumber,
    required String billDate,
    required int Gindex}) async {
  final pdf = pw.Document();
  ByteData image = await rootBundle.load('assets/L$logoinx.png');
  Uint8List imageData = (image).buffer.asUint8List();
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Column(children: [
        logoinx != null
            ? pw.Container(
                width: 50,
                height: 50,
                child: pw.Image(pw.MemoryImage(imageData)))
            : pw.Container(),
        pw.SizedBox(
          height: 50,
        ),
        pw.Table(border: pw.TableBorder.all(color: PdfColors.black), children: [
          pw.TableRow(children: [
            pw.Expanded(
                flex: 3,
                child: PaddedText("Name: ${name.toUpperCase()}",
                    textStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
            pw.Expanded(
                flex: 1,
                child: PaddedText("Invoice No. : $invoiceNumber",
                    textStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold)))
          ]),
          pw.TableRow(children: [
            PaddedText("Ph. No.: ${phoneNumber}",
                textStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            PaddedText('Bill Date: $billDate',
                textStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ]),
        ]),
        pw.SizedBox(height: 5),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.black),
          children: [
            pw.TableRow(
              children: [
                pw.Padding(
                  child: pw.Text(
                    'Sr no.',
                    style: pw.Theme.of(context).header4,
                    textAlign: pw.TextAlign.center,
                  ),
                  padding: const pw.EdgeInsets.all(20),
                ),
                pw.Padding(
                  child: pw.Text(
                    'Products',
                    style: pw.Theme.of(context).header4,
                    textAlign: pw.TextAlign.center,
                  ),
                  padding: const pw.EdgeInsets.all(20),
                ),
                pw.Padding(
                  child: pw.Text(
                    'Qty.',
                    style: pw.Theme.of(context).header4,
                    textAlign: pw.TextAlign.center,
                  ),
                  padding: const pw.EdgeInsets.all(20),
                ),
                pw.Padding(
                  child: pw.Text(
                    'Rate',
                    style: pw.Theme.of(context).header4,
                    textAlign: pw.TextAlign.center,
                  ),
                  padding: const pw.EdgeInsets.all(20),
                ),
                pw.Padding(
                  child: pw.Text(
                    'Amount',
                    style: pw.Theme.of(context).header5,
                    textAlign: pw.TextAlign.center,
                  ),
                  padding: const pw.EdgeInsets.all(20),
                ),
              ],
            ),

            ...List.generate(
              invoice[Gindex].itemData?.length ?? 0,
              (index) {
                return pw.TableRow(
                  children: [
                    pw.Expanded(
                      child: PaddedText("${index + 1}",
                          align: pw.TextAlign.center),
                      flex: 2,
                    ),
                    pw.Expanded(
                      child:
                          PaddedText("${invoice[Gindex].itemData![index][0]}"),
                      flex: 3,
                    ),
                    pw.Expanded(
                      child:
                          PaddedText("${invoice[Gindex].itemData![index][1]}"),
                      flex: 2,
                    ),
                    pw.Expanded(
                      child: PaddedText(
                          "\$${invoice[Gindex].itemData![index][2]}"),
                      flex: 2,
                    ),
                    pw.Expanded(
                      child: PaddedText(
                          "\$${invoice[Gindex].itemData![index][1] * invoice[Gindex].itemData![index][2]}"),
                      flex: 2,
                    ),
                  ],
                );
              },
            ),
            pw.TableRow(
              children: [
                PaddedText(""),
                PaddedText(""),
                PaddedText(""),
                PaddedText('TOTAL',
                    align: pw.TextAlign.center,
                    textStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                PaddedText("\$${invoice[Gindex].total}",
                    textStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ],
            )
          ],
        ),
        pw.Padding(
          child: pw.Text(
            "THANK YOU FOR YOUR BUSINESS!",
            style: pw.Theme.of(context).header2,
          ),
          padding: const pw.EdgeInsets.all(20),
        ),
      ]),
    ),
  );

  // final file =.File('example.pdf');
  // await file.writeAsBytes(await pdf.save());
  return await pdf.save();
}
