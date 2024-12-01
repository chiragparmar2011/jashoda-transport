import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jashoda_transport/core/utils/app_enum.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavItem> {
  BottomNavCubit() : super(BottomNavItem.home);

  void updateNavItem(BottomNavItem item) {
    emit(item);
  }
}
