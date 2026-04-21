// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../controller/client_controller.dart';

// class AddClient extends StatelessWidget {
//   AddClient({super.key});

//   final controller = Get.find<ClientController>();
//   final nameCtrl = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Add Client")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(controller: nameCtrl),
//             ElevatedButton(
//               onPressed: () {
//                 controller.addClient(nameCtrl.text);
//                 Get.back();
//               },
//               child: const Text("Save"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_app/controller/client_controller.dart';

class AddClient extends StatelessWidget {
  AddClient({super.key});

  final controller = Get.find<ClientController>();
  final nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        title: const Text("Add Client"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // 🔥 Card Input
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 6,
                  )
                ],
              ),
              child: TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(
                  hintText: "Enter client name",
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 🔥 Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (nameCtrl.text.isEmpty) {
                    Get.snackbar("Error", "Enter client name");
                    return;
                  }

                  controller.addClient(nameCtrl.text.trim());
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.all(14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Save Client",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
