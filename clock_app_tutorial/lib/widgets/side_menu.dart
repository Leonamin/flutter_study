import 'package:clock_app_tutorial/config/data.dart';
import 'package:clock_app_tutorial/providers/menu_provider.dart';
import 'package:clock_app_tutorial/widgets/side_menu_item.dart';
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
