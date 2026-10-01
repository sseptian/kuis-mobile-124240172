import 'package:flutter/material.dart';

import 'data.dart';

class DetailPage extends StatefulWidget {
  final Product product;

  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int _quantity = 1;
  late int _selectedSizeIndex;

  @override
  void initState() {
    super.initState();
    _selectedSizeIndex = 0;
  }

  void _incrementQuantity() {
    if (_quantity < widget.product.stock) {
      setState(() {
        _quantity++;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Jumlah maksimal sesuai stok (${widget.product.stock})',
          ),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  void _toggleLike() {
    setState(() {
      widget.product.isLiked = !widget.product.isLiked;
      if (widget.product.isLiked) {
        widget.product.likeCount++;
      } else {
        widget.product.likeCount--;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          widget.product.isLiked
              ? 'Disukai! (${widget.product.likeCount} likes)'
              : 'Batal menyukai (${widget.product.likeCount} likes)',
        ),
        duration: const Duration(milliseconds: 800),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          product.productName,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Produk
            Container(
              width: double.infinity,
              height: 280,
              color: Colors.grey.shade100,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFFE60012)),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.productName,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama Produk
                  Text(
                    product.productName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Kategori
                  Text(
                    product.type,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 8),

                  // Harga
                  Text(
                    product.price,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Jumlah produk',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: _decrementQuantity,
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _quantity > 1
                                      ? Colors.grey.shade400
                                      : Colors.grey.shade300,
                                ),
                              ),
                              child: Icon(
                                Icons.remove,
                                size: 16,
                                color: _quantity > 1
                                    ? Colors.black87
                                    : Colors.grey.shade300,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14.0,
                            ),
                            child: Text(
                              '$_quantity',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: _incrementQuantity,
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _quantity < product.stock
                                      ? Colors.grey.shade400
                                      : Colors.grey.shade300,
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                                size: 16,
                                color: _quantity < product.stock
                                    ? Colors.black87
                                    : Colors.grey.shade300,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Baris Like dan Stok
                  Row(
                    children: [
                      InkWell(
                        onTap: _toggleLike,
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Icon(
                                product.isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 18,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${product.likeCount} likes',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Stok: ${product.stock}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Ukuran
                  const Text(
                    'Ukuran',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: List.generate(product.sizes.length, (index) {
                      final bool isSelected = _selectedSizeIndex == index;
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedSizeIndex = index;
                          });
                        },
                        borderRadius: BorderRadius.circular(4),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFFE60012)
                                  : Colors.grey.shade300,
                              width: isSelected ? 1.5 : 1.0,
                            ),
                            borderRadius: BorderRadius.circular(4),
                            color: isSelected
                                ? const Color(0xFFE60012)
                                      .withValues(alpha: 0.08)
                                : Colors.white,
                          ),
                          child: Text(
                            product.sizes[index],
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isSelected
                                  ? const Color(0xFFE60012)
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),

                  // Deskripsi
                  const Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    product.details,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade800,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
