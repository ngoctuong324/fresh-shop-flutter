import 'package:flutter/material.dart';
import 'package:ui_web/common/constants.dart';
import 'package:ui_web/features/cart/models/cart_item.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onRemove;

  final bool isSelectable;
  final bool isSelected;
  final ValueChanged<bool?>? onSelectedChanged;

  const CartItemTile({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    required this.onRemove,
    this.isSelectable = false,
    this.isSelected = false,
    this.onSelectedChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (isSelectable)
            Checkbox(
              value: isSelected,
              onChanged: onSelectedChanged,
              activeColor: Colors.green,
            ),

          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(item.product.assetImage),
                fit: BoxFit.contain,
              ),
              borderRadius: BorderRadius.circular(14),
              color: Colors.yellow[100],
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formatVND(item.product.price),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey[400], fontSize: 14),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        final newQuantity = item.quantity - 1;
                        onQuantityChanged(newQuantity);
                      },
                      child: _quantityButton("-", Colors.grey[400]!),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        item.quantity.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => onQuantityChanged(item.quantity + 1),
                      child: _quantityButton("+", gradientColor.colors.first),
                    ),
                  ],
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: onRemove,
            icon: const Icon(Icons.delete_outline, color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _quantityButton(String text, Color color) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
