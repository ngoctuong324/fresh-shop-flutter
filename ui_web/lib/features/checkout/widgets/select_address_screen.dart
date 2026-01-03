import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ui_web/common/constants.dart';
import 'package:ui_web/data/model/shipping_address_model.dart';
import 'package:ui_web/features/address/add_address_screen.dart';

class SelectAddressScreen extends StatefulWidget {
  const SelectAddressScreen({super.key});

  @override
  State<SelectAddressScreen> createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: textGreen,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Chọn địa chỉ giao hàng",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: user == null
          ? const Center(child: Text("Bạn chưa đăng nhập"))
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user!.uid)
                  .collection('addresses')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final docs = snapshot.data!.docs;

                return Column(
                  children: [
                    Expanded(
                      child: docs.isEmpty
                          ? const Center(
                              child: Text(
                                "Bạn chưa có địa chỉ nào",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.all(12),
                              itemCount: docs.length,
                              itemBuilder: (context, index) {
                                final address = ShippingAddressModel.fromMap(
                                  docs[index].data() as Map<String, dynamic>,
                                );

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context, address);
                                  },
                                  child: Card(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: textGreen.withOpacity(0.1),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.location_on,
                                              color: textGreen,
                                            ),
                                          ),

                                          const SizedBox(width: 12),

                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${address.fullName} - ${address.phone}",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: textGreen,
                                                  ),
                                                ),
                                                const SizedBox(height: 6),
                                                Text(
                                                  "${address.detail}, ${address.ward}, ${address.district}, ${address.province}",
                                                  style: const TextStyle(
                                                    height: 1.4,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          const Icon(Icons.chevron_right),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.add, color: Colors.white),
                          label: const Text(
                            "Thêm địa chỉ mới",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: textGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AddAddressScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
