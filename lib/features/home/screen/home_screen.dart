import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/core/helper/app_navigator.dart';
import 'package:restaurant/features/auth/data/models/login_response_model.dart';
import 'package:restaurant/features/home/cubit/menu_cubit/menu_cubit.dart';
import 'package:restaurant/features/home/cubit/menu_cubit/menu_state.dart';
import 'package:restaurant/features/home/cubit/user_cubit/user_cubit.dart';
import 'package:restaurant/features/home/cubit/user_cubit/user_state.dart';
import 'package:restaurant/features/home/screen/category_products_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key,  this.user});
  final UserModel? user;
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => UserCubit()..controlUser(user),
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<UserCubit, UserState>(
            builder: (context, state)
            {
              if(state is UserLoading)
              {
                return CircularProgressIndicator();
              }
              else if(state is UserError)
              {
                return Text(state.error);
              }
              else if(state is UserSuccess)
              {
                return Text(state.user.email??'');
              }
              else
              {
                return SizedBox();
              }
            }
          ),
          actions:
          [
            TextButton(onPressed: (){

              BlocProvider.of<UserCubit>(context).logout();

              }, child: Text('Logout')
            ),
          ],
        ),
        body: BlocProvider(
          create: (context) => MenuCubit()..getMenu(),
          child: BlocBuilder<MenuCubit, MenuState>(
              builder: (context, state)
              {
                if(state is MenuLoading)
                {
                  return Center(child: CircularProgressIndicator());
                }
                else if(state is MenuError)
                {
                  return Center(child: Text(state.error));
                }
                else if(state is MenuSuccess)
                {
                  return RefreshIndicator(
                    onRefresh: ()async
                    {
                      MenuCubit.get(context).getMenu();
                    },
                    child: ListView.builder(
                      itemBuilder: (context, index)=> InkWell(
                        onTap: (){AppNavigator.goTo(context, CategoryProductsView(categoryModel: state.categories[index],));},
                        child: Column(
                          children:
                          [
                            Image.network(state.categories[index].imagePath??''),
                            Text(state.categories[index].title??'-'),
                            Text(state.categories[index].description??'-'),
                          ],
                        ),
                      ),
                      itemCount: state.categories.length,
                    ),
                  );
                }
                else {
                  return SizedBox();
                }
              }
          ),
        ),
      ),
    );
  }
}