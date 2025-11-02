import 'package:auto_route/auto_route.dart';

import 'app_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true, path: '/splash'),

    AutoRoute(page: LoginRoute.page, path: '/login'),
    AutoRoute(page: SignupRoute.page, path: '/signup'),
    AutoRoute(
      page: BottomNavBar.page,
      path: '/bottom_nav_bar',
      children: [
        AutoRoute(page: TwitListRoute.page, path: 'twit_list'),
        AutoRoute(page: SearchRoute.page, path: 'search'),
        AutoRoute(page: NotificationRoute.page, path: 'notification'),
        AutoRoute(page: ChatListRoute.page, path: 'chat_list'),
      ],
    ),
    AutoRoute(page: CreateTwitRoute.page, path: '/create_twit'),
    AutoRoute(page: HashtagRoute.page, path: '/hashtag_twit'),
    AutoRoute(page: TwitDetailRoute.page, path: '/twit_detail'),
    AutoRoute(page: ProfileRoute.page, path: '/profile'),
    AutoRoute(page: EditProfileRoute.page, path: '/edit_profile'),
    AutoRoute(page: MessageRoute.page, path: '/message'),
  ];
}
