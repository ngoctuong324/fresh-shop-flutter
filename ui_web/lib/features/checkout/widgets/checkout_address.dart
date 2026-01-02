import 'package:flutter/material.dart';
import 'package:ui_web/common/constants.dart';
import 'package:ui_web/data/model/shipping_address_model.dart';

class CheckoutAddress extends StatelessWidget {
  final ShippingAddressModel? address;
  final VoidCallback onTap;

  const CheckoutAddress({
    super.key,
    required this.address,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.location_on, color: textGreen),
            const SizedBox(width: 10),
            Expanded(
              child: address == null
                  ? const Text(
                      "Thêm địa chỉ giao hàng",
                      style: TextStyle(
                        color: textGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${address!.fullName} | ${address!.phone}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "${address!.detail}, "
                          "${address!.ward}, "
                          "${address!.district}, "
                          "${address!.province}",
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
