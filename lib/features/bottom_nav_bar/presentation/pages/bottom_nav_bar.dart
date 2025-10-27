import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twit/core/constants/app_assets.dart';
import 'package:twit/features/profile/presentation/widgets/profile_drawer.dart';
import 'package:twit/theme/color_palette.dart';
import 'package:twit/utils/ui/app_horizontal_divider.dart';

import '../../../../app/routes/app_route.gr.dart';

@RoutePage()
class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;

  void updateIndex(int index) {
    if (selectedIndex == index) {
      return;
    }
    selectedIndex = index;
  }

  Color getColor(int index, int selectedIndex) {
    return selectedIndex == index
        ? ColorPalette.primaryColor
        : ColorPalette.greyColor;
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      homeIndex: selectedIndex,
      routes: const [
        TwitListRoute(),
        SearchRoute(),
        NotificationRoute(),
        ChatListRoute(),
      ],
      drawer: ProfileDrawer(),
      floatingActionButton: selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                context.router.push(CreateTwitRoute());
              },
              child: Icon(Icons.add),
            )
          : null,
      bottomNavigationBuilder: (final context, final router) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppHorizontalDivider(),
            BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    router.activeIndex == 0
                        ? AppAssets.homeFilledIcon
                        : AppAssets.homeOutlinedIcon,
                    colorFilter: ColorFilter.mode(
                      getColor(0, router.activeIndex),
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppAssets.searchIcon,
                    colorFilter: ColorFilter.mode(
                      getColor(1, router.activeIndex),
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    router.activeIndex == 2
                        ? AppAssets.notifFilledIcon
                        : AppAssets.notifOutlinedIcon,
                    colorFilter: ColorFilter.mode(
                      getColor(2, router.activeIndex),
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Notifications',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    AppAssets.chatIcon,
                    colorFilter: ColorFilter.mode(
                      getColor(3, router.activeIndex),
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Chat',
                ),
              ],
              unselectedFontSize: 14,
              showUnselectedLabels: true,
              onTap: router.setActiveIndex,
              currentIndex: router.activeIndex,
              unselectedItemColor: Colors.grey,
            ),
          ],
        );
      },
      backgroundColor: Colors.transparent,
    );
  }
}
