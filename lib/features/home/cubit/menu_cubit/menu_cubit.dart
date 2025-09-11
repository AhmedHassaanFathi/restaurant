import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/features/home/data/repo/home_repo.dart';

import 'menu_state.dart';

class MenuCubit extends Cubit<MenuState>
{
  MenuCubit() : super(MenuInitial());
  static MenuCubit get(context)=> BlocProvider.of(context);
  getMenu()async
  {
    HomeRepo homeRepo = HomeRepo();
    emit(MenuLoading());
    var response = await homeRepo.getMenu();
    response.fold(
        (error)=> emit(MenuError(error: error)),
        (menu)=> emit(MenuSuccess(categories: menu))
    );

  }
}