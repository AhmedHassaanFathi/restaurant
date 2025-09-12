import 'package:flutter/material.dart';
import 'package:restaurant/core/helper/app_navigator.dart';
import 'package:restaurant/features/account/screens/account_screen.dart';
import 'package:restaurant/features/home/data/model/menu_response_model.dart';
import 'package:restaurant/features/home/screen/home_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // بيانات افتراضية من الموديلات عندك (يمكنك استبدالها بالـ API لاحقاً)
    final List<CategoryModel> categories = MenuResponseModel().categories ?? [];

    // نقوم باختيار عنصرين من أول فئة كمنيو رئيسي للعرض (Mexican Appetizer + أخرى)
    final List<ProductModel> demoItems = [];
    if (categories.isNotEmpty) {
      final firstCat = categories[0];
      if (firstCat.products != null && firstCat.products!.isNotEmpty) {
        demoItems.addAll(firstCat.products!.take(2));
      }
    }
    // if (demoItems.isEmpty) {
    //   // fallback بسيط لو ما فيه منتجات
    //   demoItems.addAll([
    //     ProductModel(
    //       name: 'Mexican Appetizer',
    //       description: 'Tortilla Chips With Toppings',
    //       imagePath:
    //           'https://images.unsplash.com/photo-1526312426766-8d48f04ba0f0?auto=format&fit=crop&w=600&q=60',
    //       price: 15.0,
    //       bestSeller: 0,
    //     ),
    //     ProductModel(
    //       name: 'Pork Skewer',
    //       description: 'Marinated in a rich blend of herbs and spices',
    //       imagePath:
    //           'https://images.unsplash.com/photo-1562967914-0ad2f0c3f32f?auto=format&fit=crop&w=600&q=60',
    //       price: 12.99,
    //       bestSeller: 0,
    //     ),
    //   ]);
    // }

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (idx) {
          if (idx == 0) {
            AppNavigator.goTo(context, HomeScreen());
          } else if (idx == 1) {
            AppNavigator.goTo(context, MenuScreen());
          } else if (idx == 2) {
            AppNavigator.goTo(context, AccountScreen());
          }
        },
        backgroundColor: Colors.orange,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Account',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header البرتقالي مع شريط البحث
            Container(
              width: double.infinity,
              height: 120,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              decoration: const BoxDecoration(
                // color: Colors.orange,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // شريط البحث
                  Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(Icons.shopping_cart, color: Colors.orange),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            // Row of category icons
            SizedBox(
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: const [
                  _CategoryIcon(label: 'Snacks', icon: Icons.fastfood),
                  _CategoryIcon(label: 'Meal', icon: Icons.restaurant_menu),
                  _CategoryIcon(label: 'Vegan', icon: Icons.eco),
                  _CategoryIcon(label: 'Dessert', icon: Icons.cake),
                  _CategoryIcon(label: 'Drinks', icon: Icons.local_drink),
                ],
              ),
            ),
          
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemCount: demoItems.length,
                itemBuilder: (ctx, idx) => _MenuItemCard(item: demoItems[idx]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryIcon extends StatelessWidget {
  final String label;
  final IconData icon;
  const _CategoryIcon({Key? key, required this.label, required this.icon})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Colors.orange;
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class _MenuItemCard extends StatelessWidget {
  final ProductModel item;
  const _MenuItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
              child: item.imagePath != null
                  ? Image.network(
                      item.imagePath!,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Container(height: 180, color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.description ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    item.price != null
                        ? '\$${item.price!}'
                        : '',
                    style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
