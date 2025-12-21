import 'package:flutter/material.dart';
import 'package:ui_web/common/constants.dart';
import 'package:ui_web/data/model/product.dart';
import 'package:ui_web/features/product_detail_screen.dart';
import 'package:ui_web/navigation/product_items_display.dart';

class HomeScreenGrocery extends StatefulWidget {
  const HomeScreenGrocery({super.key});

  @override
  State<HomeScreenGrocery> createState() => _HomeScreenGroceryState();
}

class _HomeScreenGroceryState extends State<HomeScreenGrocery> {
  String categoryes = 'ALL';
  List<Grocery> grocery = groceryItems;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headerParts(),
              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 65,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                grocery = groceryItems
                                    .where(
                                      (e) => e.name.toLowerCase().contains(
                                        value.toLowerCase(),
                                      ),
                                    )
                                    .toList();
                              });
                            },
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                                size: 30,
                              ),
                              border: InputBorder.none,
                              hintText: "Search Grocery",
                              hintStyle: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.green[50],
                      ),
                      child: const Icon(
                        Icons.tune_rounded,
                        size: 30,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              categoryItems(),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: List.generate(
                      grocery.length,
                      (index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProductDetailScreen(product: grocery[index]),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: ProductImetsDisplay(grocery: grocery[index]),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(top: 15, left: 20),
                child: Text(
                  "Recent Shop",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 20),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    groceryItems.where((e) => e.isRecent).length,
                    (index) {
                      final recent = groceryItems
                          .where((e) => e.isRecent)
                          .toList()[index];

                      return Padding(
                        padding: index == 0
                            ? const EdgeInsets.symmetric(horizontal: 20)
                            : const EdgeInsets.only(right: 20),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: AssetImage(recent.image),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      recent.name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      recent.category,
                                      style: TextStyle(
                                        fontSize: 15,
                                        height: 1.4,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(width: 8),

                              Text(
                                formatVND(recent.price),
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding categoryItems() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          groceryCategories.length,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                categoryes = groceryCategories[index];
                categoryes == "All"
                    ? grocery = groceryItems
                    : grocery = groceryItems
                          .where(
                            (e) =>
                                e.category.toLowerCase() ==
                                categoryes.toLowerCase(),
                          )
                          .toList();
              });
            },
            child: SizedBox(
              height: 50,
              child: Column(
                children: [
                  Text(
                    groceryCategories[index],
                    style: TextStyle(
                      fontSize: categoryes == groceryCategories[index]
                          ? 18
                          : 16,
                      color: categoryes == groceryCategories[index]
                          ? textGreen
                          : Colors.black26,
                      fontWeight: categoryes == groceryCategories[index]
                          ? FontWeight.w900
                          : FontWeight.w500,
                    ),
                  ),
                  if (categoryes == groceryCategories[index])
                    const CircleAvatar(radius: 4, backgroundColor: textGreen),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding headerParts() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: Row(
        children: [
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: "Welcome\n",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
                TextSpan(
                  text: "Ngọc Tường",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvPjv1lHEIpzgDk_e3Sm-e4EVOzggYdb5aHA&s",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
