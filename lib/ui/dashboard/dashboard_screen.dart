import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jashoda_transport/core/utils/app_assets.dart';
import 'package:jashoda_transport/core/utils/app_colors.dart';
import 'package:jashoda_transport/core/utils/app_enum.dart';
import 'package:jashoda_transport/core/utils/app_strings.dart';
import 'package:jashoda_transport/core/widgets/image_assets.dart';
import 'package:jashoda_transport/cubit/bottomnav/bottom_nav_cubit.dart';
import 'package:jashoda_transport/ui/dashboard/calculation/saved_calculation_screen.dart';
import 'package:jashoda_transport/ui/dashboard/home/home_screen.dart';
import 'package:jashoda_transport/ui/dashboard/new/create_new_calculation_screen.dart';
import 'package:jashoda_transport/ui/dashboard/profile/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomNavCubit, BottomNavItem>(
        builder: (context, state) {
          switch (state) {
            case BottomNavItem.home:
              return const HomeScreen();
            case BottomNavItem.calculation:
              return const SavedCalculationScreen();
            case BottomNavItem.newly:
              return CreateNewCalculationScreen();
            case BottomNavItem.profile:
              return const ProfileScreen();
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavCubit, BottomNavItem>(
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            color: AppColors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: BottomNavItem.values.map((item) {
                final isSelected = item == state;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      context.read<BottomNavCubit>().updateNavItem(item);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primaryBlue : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ImageAssets(
                            image: isSelected ? getSelectedIcon(item) : getUnselectedIcon(item),
                            color: isSelected ? AppColors.white : AppColors.black,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            getLabel(item),
                            style: TextStyle(
                              color: isSelected ? AppColors.white : AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  String getLabel(BottomNavItem item) {
    switch (item) {
      case BottomNavItem.home:
        return AppStrings.home;
      case BottomNavItem.calculation:
        return AppStrings.calculation;
      case BottomNavItem.newly:
        return AppStrings.newText;
      case BottomNavItem.profile:
        return AppStrings.profile;
    }
  }

  String getSelectedIcon(BottomNavItem item) {
    switch (item) {
      case BottomNavItem.home:
        return AssetsPath.selectedHomeIcon;
      case BottomNavItem.calculation:
        return AssetsPath.selectedCalculationIcon;
      case BottomNavItem.newly:
        return AssetsPath.selectedAddIcon;
      case BottomNavItem.profile:
        return AssetsPath.selectedPersonIcon;
    }
  }

  String getUnselectedIcon(BottomNavItem item) {
    switch (item) {
      case BottomNavItem.home:
        return AssetsPath.homeIcon;
      case BottomNavItem.calculation:
        return AssetsPath.calculationIcon;
      case BottomNavItem.newly:
        return AssetsPath.addBlackIcon;
      case BottomNavItem.profile:
        return AssetsPath.personIcon;
    }
  }
}
