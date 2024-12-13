import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/controller/common_controller.dart';
import 'package:track_trek/core/utils/app_color.dart';


class CustomBottomNavBar extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: AppColors.navigationColor,
        boxShadow: [

        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 0, "Home"),
          _buildNavItem(Icons.search, 1, "Search"),
          _buildNavItem(Icons.person, 2, "Profile"),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, String label) {
    return GestureDetector(
      onTap: () => CommonController.to.updateIndex(index),
      child: Obx(
            () {
          bool isSelected = CommonController.to.selectedIndex.value == index;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: isSelected ? Colors.blue : Colors.grey, size: 30),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.blue : Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
