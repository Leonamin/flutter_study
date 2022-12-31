import 'package:clock_app_tutorial/menu_provider.dart';
import 'package:clock_app_tutorial/menu_routes.dart';
import 'package:clock_app_tutorial/side_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Consumer<MenuProvider>(
        builder: (context, provider, child) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: sideMenuItems
              .map(
                (item) => VerticalMenuItem(
                  itemName: item.name,
                  onTap: () {
                    // TODO Navigate
                    if (!provider.isActive(item.name)) {
                      provider.changeActiveItemTo(item.name);
                    }
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
