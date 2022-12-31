import 'package:clock_app_tutorial/menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerticalMenuItem extends StatelessWidget {
  final String itemName;
  final VoidCallback onTap;
  const VerticalMenuItem(
      {super.key, required this.itemName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuProvider>(builder: ((context, provider, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor:
                  provider.isHovering(itemName) && !provider.isActive(itemName)
                      ? const Color(0xFF2D2F60)
                      : Colors.transparent,
            ),
            onPressed: onTap,
            onHover: (value) {
              // 모바일에선 외않됨?
              debugPrint("ONHOVER");
              value ? provider.onHover(itemName) : provider.onHover("");
            },
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    provider.returnIconFor(itemName),
                    scale: 1.5,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    itemName,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontFamily: 'avenir'),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Visibility(
                    visible: provider.isHovering(itemName) ||
                        provider.isActive(itemName),
                    maintainSize: true,
                    maintainState: true,
                    maintainAnimation: true,
                    // FIXME 하드코딩된 크기
                    child: Row(
                      children: [Container(height: 1, color: Colors.amber)],
                    ),
                  ),
                ],
              ),
            )),
        // child: InkWell(
        //   // onTap: onTap,
        //   onTap: () {
        //     print("faada");
        //   },
        //   onHover: (value) {
        //     print("hover");
        //     value ? provider.onHover(itemName) : provider.onHover("");
        //   },
        // child: Container(
        //   color: provider.isHovering(itemName)
        //       ? Colors.amber
        //       : Colors.transparent,
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Image.asset(
        //         provider.returnIconFor(itemName),
        //         scale: 1.5,
        //       ),
        //       const SizedBox(
        //         height: 12,
        //       ),
        //       Text(
        //         itemName,
        //         style: Theme.of(context)
        //             .textTheme
        //             .labelSmall!
        //             .copyWith(fontFamily: 'avenir'),
        //       ),
        //     ],
        //   ),
        //   ),
        // ),
      );
    }));
  }
}
