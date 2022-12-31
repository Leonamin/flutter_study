import 'package:clock_app_tutorial/clock_view.dart';
import 'package:clock_app_tutorial/menu_provider.dart';
import 'package:clock_app_tutorial/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
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
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEE, d MMM').format(now);
    var timezoneString = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = '-';
    if (!timezoneString.startsWith('-')) {
      offsetSign = '+';
    }

    return ChangeNotifierProvider<MenuProvider>(
      create: (context) => MenuProvider(),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Row(
          children: [
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     _buildMenuButton(context, 'Clock', 'assets/clock_icon.png'),
            //     _buildMenuButton(context, 'Alarm', 'assets/alarm_icon.png'),
            //     _buildMenuButton(context, 'Timer', 'assets/timer_icon.png'),
            //     _buildMenuButton(
            //         context, 'Stopwatch', 'assets/stopwatch_icon.png'),
            //   ],
            // ),
            const SideMenu(),
            const VerticalDivider(
              color: Colors.white54,
              width: 1,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 64,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Text(
                        'Clock',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formattedTime,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          Text(
                            formattedDate,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: Align(
                          alignment: Alignment.center,
                          child: ClockView(
                            size: MediaQuery.of(context).size.height / 4,
                          )),
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Timezone',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.language,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(
                                'UTC$offsetSign$timezoneString',
                                style: Theme.of(context).textTheme.labelSmall,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
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
