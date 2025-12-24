import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../home_controller.dart';

class CategoryBar extends StatelessWidget {
  const CategoryBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();

    if (controller.categories.isEmpty) {
      return const SizedBox();
    }

    return SizedBox(
      height: 40,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: List.generate(controller.categories.length, (index) {
            final selected = controller.selectedIndex == index;
            final category = controller.categories[index];

            return GestureDetector(
              onTap: () => controller.selectCategory(index, category),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      category,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: selected ? Colors.black : Colors.black26,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 2,
                      width: 28,
                      color: selected ? Colors.black : Colors.transparent,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
