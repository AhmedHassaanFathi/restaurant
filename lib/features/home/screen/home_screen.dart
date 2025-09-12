import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/core/helper/app_navigator.dart';
import 'package:restaurant/features/account/screens/account_screen.dart';
import 'package:restaurant/features/auth/data/models/login_response_model.dart';
import 'package:restaurant/features/home/cubit/menu_cubit/menu_cubit.dart';
import 'package:restaurant/features/home/cubit/menu_cubit/menu_state.dart';
import 'package:restaurant/features/home/cubit/user_cubit/user_cubit.dart';
import 'package:restaurant/features/home/cubit/user_cubit/user_state.dart';
import 'package:restaurant/features/home/data/model/menu_response_model.dart';
import 'package:restaurant/features/home/screen/category_products_view.dart';
import 'package:restaurant/features/home/screen/menu_screen.dart';
import 'package:restaurant/features/search/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.user});
  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..controlUser(user),
      child: Scaffold(
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
          type: BottomNavigationBarType.fixed,
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
        body: BlocProvider(
          create: (context) => MenuCubit()..getMenu(),
          child: BlocBuilder<MenuCubit, MenuState>(
            builder: (context, state) {
              if (state is MenuLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MenuError) {
                return Center(child: Text(state.error));
              } else if (state is MenuSuccess) {
                final List<CategoryModel> categories = state.categories ?? [];

                // اجمع Best Sellers من كل فئة
                final List<ProductModel> _best = [];
                for (var cat in categories) {
                  final prods = cat.products;
                  if (prods != null) {
                    _best.addAll(
                      prods.where((p) => p.bestSeller == 1).toList(),
                    );
                  }
                }
                final List<ProductModel> bestShow = _best.take(4).toList();

                return RefreshIndicator(
                  onRefresh: () async {
                    MenuCubit.get(context).getMenu();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 80.h),
                      // هيدر برتقالي + شريط البحث
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                        decoration: const BoxDecoration(
                          // color: Colors.orange,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(28),
                            bottomRight: Radius.circular(28),
                          ),
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => AppNavigator.goTo(
                                context,
                                const SearchScreen(),
                              ),
                              child: Container(
                                height: 44,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
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
                                        readOnly: true,
                                      ),
                                    ),
                                    Icon(
                                      Icons.shopping_cart,
                                      color: Colors.orange,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Good Morning',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Rise And Shine! It’s Breakfast Time',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // المحتوى الأبيض السفلي
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                          padding: REdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 24,
                          ),

                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Best Seller (أول 4 منتجات Best Seller من جميع الفئات)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        'Best Seller',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'View All',
                                        style: TextStyle(color: Colors.orange),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.only(
                                      left: 12,
                                      right: 12,
                                    ),
                                    itemCount: bestShow.length,
                                    itemBuilder: (ctx, idx) {
                                      final prod = bestShow[idx];
                                      return Container(
                                        width: 140,
                                        margin: const EdgeInsets.only(
                                          right: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 6,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          onTap: () {
                                            // ممكن تضيف navigate لصفحة التفاصيل
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                  16,
                                                                ),
                                                            topRight:
                                                                Radius.circular(
                                                                  16,
                                                                ),
                                                          ),
                                                      child:
                                                          prod.imagePath !=
                                                                  null &&
                                                              prod
                                                                  .imagePath!
                                                                  .isNotEmpty
                                                          ? Image.network(
                                                              prod.imagePath!,
                                                              fit: BoxFit.cover,
                                                              width: double
                                                                  .infinity,
                                                            )
                                                          : Container(
                                                              color: Colors
                                                                  .grey[200],
                                                            ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    // Padding(
                                                    //   padding:
                                                    //       const EdgeInsets.fromLTRB(
                                                    //         8,
                                                    //         6,
                                                    //         8,
                                                    //         2,
                                                    //       ),
                                                    //   child: Text(
                                                    //     prod.name ?? '-',
                                                    //     style: const TextStyle(
                                                    //       fontWeight:
                                                    //           FontWeight.w600,
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                    Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Container(
                                                        width: 38.w,
                                                        height: 16.w,
                                                        decoration: BoxDecoration(
                                                          color: Colors.orange,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                topLeft:
                                                                    Radius.circular(
                                                                      30,
                                                                    ),
                                                                bottomLeft:
                                                                    Radius.circular(
                                                                      30,
                                                                    ),
                                                              ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              REdgeInsets.all(
                                                                8,
                                                              ),
                                                          child: Text(
                                                            prod.price != null
                                                                ? '\$${prod.price!.toStringAsFixed(2)}'
                                                                : '',
                                                            style:
                                                                const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 6),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                const SizedBox(height: 12),
                                // Promo banner 30% OFF
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: Container(
                                    height: 160,
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(16),
                                      image: const DecorationImage(
                                        image: NetworkImage(
                                          'https://images.unsplash.com/photo-1513104890138-7cbdc7ee7d3d?auto=format&fit=crop&w=800&q=60',
                                        ),
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                          Colors.black45,
                                          BlendMode.darken,
                                        ),
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(
                                          '30% OFF',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                // Recommend header
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: Text(
                                    'Recommend',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Recommend grid (فئات/Categories)
                                Expanded(child: RecommendWidget(state: state)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}

class RecommendWidget extends StatelessWidget {
  final MenuSuccess state;
  const RecommendWidget({required this.state, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<CategoryModel> categories = state.categories ?? [];
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // اتنين كارد جنب بعض
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75, // للتحكم في طول الكارد
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => AppNavigator.goTo(
            context,
            CategoryProductsView(categoryModel: category),
          ),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            shadowColor: Colors.black12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // صورة الكاتيجوري
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child:
                      category.imagePath != null &&
                          category.imagePath!.isNotEmpty
                      ? Image.network(
                          category.imagePath!,
                          height: 120,
                          fit: BoxFit.cover,
                        )
                      : Container(height: 120, color: Colors.grey[300]),
                ),
                // عنوان ووصف
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.title ?? '-',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        category.description ?? '-',
                        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
