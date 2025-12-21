import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';
import 'package:ui_web/common/constants.dart';
import 'package:ui_web/data/model/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Grocery product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _headerParts(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 300,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: widget.product.color.withOpacity(0.15),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(230),
                      bottomRight: Radius.circular(230),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -35,
                  left: 0,
                  right: 0,
                  child: Hero(
                    tag: widget.product.image,
                    child: Image.asset(
                      widget.product.image,
                      height: 330,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: widget.product.rate,
                        itemSize: 26,
                        allowHalfRating: true,
                        itemBuilder: (_, __) => const Icon(
                          Icons.star_rounded,
                          color: Colors.orange,
                        ),
                        onRatingUpdate: (_) {},
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "(${widget.product.rate})",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const Spacer(),
                      _quantityControl(),
                    ],
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  ReadMoreText(
                    "${widget.product.name} ${widget.product.description}",
                    trimLines: 3,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: " Read More",
                    trimExpandedText: " Read Less",
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.black54,
                    ),
                    moreStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: widget.product.color,
                    ),
                    lessStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: widget.product.color,
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          color: Colors.white,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Price", style: TextStyle(color: Colors.grey)),
                    Text(
                      formatVND(widget.product.price),
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: gradientColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 32,
                      ),
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _quantityControl() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (quantity > 1) setState(() => quantity--);
          },
          child: _quantityButton("-"),
        ),
        const SizedBox(width: 10),
        Text(
          quantity.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () => setState(() => quantity++),
          child: _quantityButton("+", gradient: true),
        ),
      ],
    );
  }

  Widget _quantityButton(String text, {bool gradient = false}) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: gradient ? gradientColor : null,
        color: gradient ? null : Colors.green[50],
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 22,
            color: gradient ? Colors.white : Colors.green,
          ),
        ),
      ),
    );
  }

  AppBar _headerParts(BuildContext context) {
    return AppBar(
      backgroundColor: widget.product.color.withOpacity(0.15),
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back_ios_new, color: widget.product.color),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.shopping_cart_outlined, color: widget.product.color),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
