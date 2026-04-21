// import 'package:invoice_app/services/hive_service.dart';

// import '../db/hive_service.dart';

// void addClient(String name) {
//   clients.add(name);
//   HiveService.addClient(name);
// }

// void loadClients() {
//   clients.assignAll(HiveService.getClients());
// }

import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ClientController extends GetxController {
  var clients = <String>[].obs;

  @override
  void onInit() {
    loadClients();
    super.onInit();
  }

  void addClient(String name) {
    clients.add(name);
    Hive.box('clients').add(name);
  }

  void loadClients() {
    var box = Hive.box('clients');
    clients.assignAll(box.values.cast<String>());
  }
}
