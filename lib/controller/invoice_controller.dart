// import 'package:invoice_app/services/hive_service.dart';

// import '../db/hive_service.dart';

// void loadInvoices() {
//   invoices.assignAll(HiveService.getInvoices());
//   counter = invoices.length + 1;
// }

// void addInvoice(String client, List items) {
//   String no = generateInvoiceNo();
//   double total = calculateTotal(items);

//   var data = {
//     "no": no,
//     "client": client,
//     "items": items,
//     "total": total
//   };

//   invoices.add(data);
//   HiveService.addInvoice(data);
//   counter++;
// }

import 'package:get/get.dart';
import 'package:hive/hive.dart';

class InvoiceController extends GetxController {
  var invoices = [].obs;
  int counter = 1;

  @override
  void onInit() {
    loadInvoices();
    super.onInit();
  }

  void loadInvoices() {
    var box = Hive.box('invoices');
    invoices.assignAll(box.values.toList());
    counter = invoices.length + 1;
  }

  String generateInvoiceNo() {
    return "INV-${counter.toString().padLeft(3, '0')}";
  }

  double calculateTotal(List items) {
    double total = 0;
    for (var i in items) {
      total += i['price'] * i['qty'];
    }
    return total * 1.18;
  }

  void addInvoice(String client, List items) {
    String no = generateInvoiceNo();
    double total = calculateTotal(items);

    var data = {"no": no, "client": client, "items": items, "total": total};

    invoices.add(data);
    Hive.box('invoices').add(data);
    counter++;
  }
}
