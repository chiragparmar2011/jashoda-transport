import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jashoda_transport/core/error/error_handler.dart';
import 'package:jashoda_transport/core/helper/shared_preference.dart';
import 'package:jashoda_transport/data/model/truck/truck_detail_model.dart';
import 'package:jashoda_transport/data/model/truck/truck_list_model.dart';
import 'package:jashoda_transport/data/repo_impl/truck_load_repo_impl/truck_load_repository_impl.dart';
import 'package:jashoda_transport/getit_injector.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.truckLoadRepositoryImpl) : super(HomeInitial());

  TruckLoadRepositoryImpl truckLoadRepositoryImpl;
  final prefs = injector.get<SharedPreferenceHelper>();
  String? id;
  String? userName;
  List<TruckListModel>? truckDetailList = [];
  TruckDetailModel? truckDetailModel;

  Future<void> fetchRecentCalculation(String userId) async {
    emit(TruckDetailLoadingState());
    try {
      truckDetailList = await truckLoadRepositoryImpl.recentCalculation(userId);
      emit(TruckDetailLoadedState(truckDetailList));
    } catch (error) {
      emit(TruckDetailErrorState(ErrorHandler.handle(error).failure.message));
    }
  }

  Future<void> fetchSingleTruck(String userId) async {
    emit(SingleTruckLoadingState());
    try {
      truckDetailModel = await truckLoadRepositoryImpl.fetchSingleTruck(userId);
      emit(SingleTruckSuccess(truckDetailModel));
    } catch (error) {
      emit(FetchSingleTruckError(ErrorHandler.handle(error).failure.message));
    }
  }
}
