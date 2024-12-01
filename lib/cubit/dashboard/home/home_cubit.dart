import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jashoda_transport/core/error/error_handler.dart';
import 'package:jashoda_transport/data/model/load/calculation_model.dart';
import 'package:jashoda_transport/data/model/truck/truck_detail_model.dart';
import 'package:jashoda_transport/data/repo_impl/truck_load_repo_impl/truck_load_repository_impl.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.truckLoadRepositoryImpl) : super(HomeInitial());

  TruckLoadRepositoryImpl truckLoadRepositoryImpl;

  List<TruckDetailModel>? truckDetailList = [];

  Future<void> fetchRecentCalculation(String userID) async {
    emit(TruckDetailLoadingState());
    try {
      truckDetailList = await truckLoadRepositoryImpl.recentCalculation(userID);
      emit(TruckDetailLoadedState(truckDetailList));
    } catch (error) {
      emit(TruckDetailErrorState(ErrorHandler.handle(error).failure.message));
    }
  }
}
