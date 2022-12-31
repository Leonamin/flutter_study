import 'package:clock_app_tutorial/config/route/menu_routes.dart';
import 'package:clock_app_tutorial/screens/alarm_page.dart';
import 'package:clock_app_tutorial/screens/clock_page.dart';
import 'package:clock_app_tutorial/providers/menu_provider.dart';
import 'package:clock_app_tutorial/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      setState(() {});
    });
    _ticker.start();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MenuProvider>(
      create: (context) => MenuProvider(),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Row(
          children: [
            const SideMenu(),
            const VerticalDivider(
              color: Colors.white54,
              width: 1,
            ),
            Expanded(
              child: Consumer<MenuProvider>(
                builder: (context, provider, child) {
                  // FIXME Ticker 관련 에러
                  // 'package:flutter/src/widgets/framework.dart': Failed assertion: line 4519 pos 12: '_lifecycleState != _ElementLifecycle.defunct': is not true.
                  // 중첩 네비게이션을 쓰면 사라질까?
                  if (provider.activeItem == ClockMenuDisplayName) {
                    return ClockPage();
                  } else if (provider.activeItem == AlarmMenuDisplayName) {
                    return AlarmPage();
                  } else {
                    return Container(
                      child: RichText(
                          text: TextSpan(children: [
                        const TextSpan(text: 'Wait for update. . .\n'),
                        TextSpan(
                          text: provider.activeItem,
                          style: Theme.of(context).textTheme.displayMedium,
                        )
                      ])),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(
      BuildContext context, String title, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextButton(
          style: TextButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                scale: 1.5,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(fontFamily: 'avenir'),
              ),
            ],
          )),
    );
  }
}
