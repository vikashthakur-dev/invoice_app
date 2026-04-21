// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:invoice_app/controller/client_controller.dart';
// import 'package:invoice_app/controller/invoice_controller.dart';

// import 'client_list.dart';
// import 'create_invoice.dart';
// import 'invoice_list.dart';

// class Dashboard extends StatelessWidget {
//   Dashboard({super.key});

//   final clientCtrl = Get.put(ClientController());
//   final invoiceCtrl = Get.put(InvoiceController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Dashboard")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: () => Get.to(ClientList()),
//               child: const Text("Clients"),
//             ),
//             ElevatedButton(
//               onPressed: () => Get.to(CreateInvoice()),
//               child: const Text("Create Invoice"),
//             ),
//             ElevatedButton(
//               onPressed: () => Get.to(InvoiceList()),
//               child: const Text("Invoices"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_app/controller/client_controller.dart';
import 'package:invoice_app/controller/invoice_controller.dart';

import 'client_list.dart';
import 'create_invoice.dart';
import 'invoice_list.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});

  final clientCtrl = Get.put(ClientController());
  final invoiceCtrl = Get.put(InvoiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // 🔥 Card Buttons
            buildCard(
              title: "Clients",
              icon: Icons.people,
              color: Colors.blue,
              onTap: () => Get.to(ClientList()),
            ),

            buildCard(
              title: "Create Invoice",
              icon: Icons.add_box,
              color: Colors.green,
              onTap: () => Get.to(CreateInvoice()),
            ),

            buildCard(
              title: "Invoices",
              icon: Icons.receipt_long,
              color: Colors.orange,
              onTap: () => Get.to(InvoiceList()),
            ),
          ],
        ),
      ),
    );
  }

  // 🔥 Reusable Card Widget
  Widget buildCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(width: 15),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, color: Colors.white)
          ],
        ),
      ),
    );
  }
}
