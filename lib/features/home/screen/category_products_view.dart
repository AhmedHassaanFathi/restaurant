import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/features/home/data/model/menu_response_model.dart';

class CategoryProductsView extends StatelessWidget {
  const CategoryProductsView({super.key, required this.categoryModel});

  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryModel.title??'-'),
      ),
      body: ListView.builder(
        itemCount: categoryModel.products!.length,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemBuilder: (context, index)=> Column(
          children: [
            Container(
              height: 200.h,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(categoryModel.products![index].imagePath??''),
                  fit: BoxFit.cover
                )
              ),
            ),
            SizedBox(height: 10.h,),
            Row(
              children:
              [
                Expanded(
                  child: Text(
                    categoryModel.products![index].name??'',
                  ),
                ),
                Text(
                  categoryModel.products![index].price.toString()
                )

              ],
            ),
            SizedBox(height: 10.h,),
            IconButton(
              onPressed: (){}  ,
              icon: Icon(categoryModel.products![index].isFavorite == true? Icons.favorite: Icons.favorite_border,
              color: Colors.red,)
            )

          ],
        ),
      ),
    );
  }
}
