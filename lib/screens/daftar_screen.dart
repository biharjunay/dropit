import 'package:flutter/material.dart';

class FurnitureItem {
  final String id;
  final String name;
  final String description;
  final String fullDescription;
  final String thumbnailAsset;
  final String modelAsset;
  final double scale;
  final double cameraZ;
  final double positionY;

  const FurnitureItem({
    required this.id,
    required this.name,
    required this.description,
    required this.fullDescription,
    required this.thumbnailAsset,
    required this.modelAsset,
    this.scale = 5,
    this.cameraZ = 7,
    this.positionY = 0,
  });
}

class DaftarScreen extends StatelessWidget {
  const DaftarScreen({super.key});

  static const List<FurnitureItem> items = [
    FurnitureItem(
      id: 'jalan',
      name: 'Jalan',
      description: 'Model jalan dengan area rumput dan detail permukaan.',
      fullDescription:
          'Model jalan dengan area rumput dan detail permukaan. Geser model di halaman detail untuk memutar, lalu cubit layar untuk memperbesar atau memperkecil.',
      thumbnailAsset: 'assets/3d/jalan/Grass1_diff.png',
      modelAsset: 'assets/3d/jalan/yayaya.obj',
      scale: 5,
      cameraZ: 8,
    ),
    FurnitureItem(
      id: 'lamppost',
      name: 'Lamp Post',
      description: 'Tiang lampu jalan dengan material metal dan kaca.',
      fullDescription:
          'Tiang lampu jalan dengan material metal dan kaca. Model ini bisa diputar langsung di halaman detail untuk melihat bentuknya dari semua sisi.',
      thumbnailAsset: 'assets/3d/lamppost/Main1_diff.png',
      modelAsset: 'assets/3d/lamppost/jkasdahskd.obj',
      scale: 4.5,
      cameraZ: 7,
      positionY: -0.6,
    ),
    FurnitureItem(
      id: 'mobil',
      name: 'Mobil',
      description: 'Model mobil compact dengan tekstur bodi kendaraan.',
      fullDescription:
          'Model mobil compact dengan tekstur bodi kendaraan. Buka halaman detail untuk memutar model dan memeriksa bentuk kendaraan secara interaktif.',
      thumbnailAsset: 'assets/3d/mobil/Meshsuzukijimny20191_diff.png',
      modelAsset: 'assets/3d/mobil/car.obj',
      scale: 5,
      cameraZ: 7,
    ),
    FurnitureItem(
      id: 'pohon',
      name: 'Pohon',
      description: 'Model pohon dengan tekstur daun dan batang.',
      fullDescription:
          'Model pohon dengan tekstur daun dan batang. Gunakan gestur pada preview 3D untuk melihat proporsi pohon dari berbagai arah.',
      thumbnailAsset: 'assets/3d/pohon/Meshpart1_diff.png',
      modelAsset: 'assets/3d/pohon/tree.obj',
      scale: 5,
      cameraZ: 7,
      positionY: -0.5,
    ),
    FurnitureItem(
      id: 'rumah',
      name: 'Rumah',
      description: 'Model rumah dengan beberapa material dinding dan atap.',
      fullDescription:
          'Model rumah dengan beberapa material dinding dan atap. Halaman detail menampilkan objek 3D yang bisa diputar dan diperbesar.',
      thumbnailAsset: 'assets/3d/rumah/Part1_diff.png',
      modelAsset: 'assets/3d/rumah/a,msnfkajsfkjahs.obj',
      scale: 5,
      cameraZ: 8,
      positionY: -0.4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            children: [
              Container(
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E5E5),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Daftar Model',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/details',
                          arguments: item,
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                              child: Image.asset(
                                item.thumbnailAsset,
                                width: 110,
                                height: 110,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 110,
                                    height: 110,
                                    color: Colors.grey[300],
                                    child: const Icon(
                                      Icons.image,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          item.name,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(
                                              0xFF2E5CB8,
                                            ).withValues(alpha: 0.1),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: const Text(
                                            'AR View',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF2E5CB8),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      item.description,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
