import 'package:hive/hive.dart';

class HiveService {
  // 🔹 Clients Box
  static Box get clientBox => Hive.box('clients');

  static void addClient(String name) {
    clientBox.add(name);
  }

  static List<String> getClients() {
    return clientBox.values.cast<String>().toList();
  }

  // 🔹 Invoice Box
  static Box get invoiceBox => Hive.box('invoices');

  static void addInvoice(Map data) {
    invoiceBox.add(data);
  }

  static List getInvoices() {
    return invoiceBox.values.toList();
  }

  // 🔹 Clear (optional)
  static void clearAll() {
    clientBox.clear();
    invoiceBox.clear();
  }
}
