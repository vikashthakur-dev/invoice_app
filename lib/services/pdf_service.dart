import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> generatePdf(Map data) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (_) => pw.Column(
        children: [
          pw.Text("Invoice No: ${data['no']}"),
          pw.Text("Client: ${data['client']}"),
          pw.Text("Total: ₹ ${data['total']}"),
        ],
      ),
    ),
  );

  await Printing.layoutPdf(onLayout: (f) async => pdf.save());
}
