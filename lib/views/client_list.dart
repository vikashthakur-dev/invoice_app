// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:invoice_app/controller/client_controller.dart';
// import 'package:invoice_app/views/add_client.dart';

// class ClientList extends StatelessWidget {
//   ClientList({super.key});

//   final controller = Get.find<ClientController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Clients")),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => Get.to(AddClient()),
//         child: const Icon(Icons.add),
//       ),
//       body: Obx(() => ListView.builder(
//             itemCount: controller.clients.length,
//             itemBuilder: (_, i) => ListTile(title: Text(controller.clients[i])),
//           )),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice_app/controller/client_controller.dart';
import 'add_client.dart';

class ClientList extends StatelessWidget {
  ClientList({super.key});

  final controller = Get.find<ClientController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        title: const Text("Clients"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(AddClient()),
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
      body: Obx(() {
        if (controller.clients.isEmpty) {
          return const Center(
            child: Text(
              "No Clients Added",
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.clients.length,
          itemBuilder: (_, i) {
            String name = controller.clients[i];

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                children: [
                  // 🔥 Avatar
                  CircleAvatar(
                    backgroundColor: Colors.deepPurple.shade100,
                    child: Text(
                      name[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // 🔥 Name
                  Expanded(
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  // 🔥 Delete Button (optional but pro)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      controller.clients.removeAt(i);
                    },
                  )
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
