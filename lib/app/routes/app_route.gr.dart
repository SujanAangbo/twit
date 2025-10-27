// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;
import 'package:twit/features/auth/data/models/user_model.dart' as _i17;
import 'package:twit/features/auth/presentation/pages/login_page.dart' as _i6;
import 'package:twit/features/auth/presentation/pages/signup_page.dart' as _i11;
import 'package:twit/features/auth/presentation/pages/splash_page.dart' as _i12;
import 'package:twit/features/bottom_nav_bar/presentation/pages/bottom_nav_bar.dart'
    as _i1;
import 'package:twit/features/chat/data/models/room_model.dart' as _i18;
import 'package:twit/features/chat/presentation/pages/chat_list_page.dart'
    as _i2;
import 'package:twit/features/chat/presentation/pages/message_page.dart' as _i7;
import 'package:twit/features/notification/presentation/pages/notification_page.dart'
    as _i8;
import 'package:twit/features/profile/presentation/pages/edit_profile_page.dart'
    as _i4;
import 'package:twit/features/profile/presentation/pages/profile_page.dart'
    as _i9;
import 'package:twit/features/search/presentation/pages/search_page.dart'
    as _i10;
import 'package:twit/features/twit/data/models/twit_model.dart' as _i19;
import 'package:twit/features/twit/presentation/pages/create_twit_page.dart'
    as _i3;
import 'package:twit/features/twit/presentation/pages/hashtag_page.dart' as _i5;
import 'package:twit/features/twit/presentation/pages/twit_detail_page.dart'
    as _i13;
import 'package:twit/features/twit/presentation/pages/twit_list_page.dart'
    as _i14;

/// generated route for
/// [_i1.BottomNavBar]
class BottomNavBar extends _i15.PageRouteInfo<void> {
  const BottomNavBar({List<_i15.PageRouteInfo>? children})
    : super(BottomNavBar.name, initialChildren: children);

  static const String name = 'BottomNavBar';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i1.BottomNavBar();
    },
  );
}

/// generated route for
/// [_i2.ChatListPage]
class ChatListRoute extends _i15.PageRouteInfo<void> {
  const ChatListRoute({List<_i15.PageRouteInfo>? children})
    : super(ChatListRoute.name, initialChildren: children);

  static const String name = 'ChatListRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i2.ChatListPage();
    },
  );
}

/// generated route for
/// [_i3.CreateTwitPage]
class CreateTwitRoute extends _i15.PageRouteInfo<void> {
  const CreateTwitRoute({List<_i15.PageRouteInfo>? children})
    : super(CreateTwitRoute.name, initialChildren: children);

  static const String name = 'CreateTwitRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i3.CreateTwitPage();
    },
  );
}

/// generated route for
/// [_i4.EditProfilePage]
class EditProfileRoute extends _i15.PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    _i16.Key? key,
    required _i17.UserModel user,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         EditProfileRoute.name,
         args: EditProfileRouteArgs(key: key, user: user),
         initialChildren: children,
       );

  static const String name = 'EditProfileRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<EditProfileRouteArgs>();
      return _i4.EditProfilePage(key: args.key, user: args.user);
    },
  );
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({this.key, required this.user});

  final _i16.Key? key;

  final _i17.UserModel user;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, user: $user}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! EditProfileRouteArgs) return false;
    return key == other.key && user == other.user;
  }

  @override
  int get hashCode => key.hashCode ^ user.hashCode;
}

/// generated route for
/// [_i5.HashtagPage]
class HashtagRoute extends _i15.PageRouteInfo<HashtagRouteArgs> {
  HashtagRoute({
    _i16.Key? key,
    required String hashtag,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         HashtagRoute.name,
         args: HashtagRouteArgs(key: key, hashtag: hashtag),
         initialChildren: children,
       );

  static const String name = 'HashtagRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HashtagRouteArgs>();
      return _i5.HashtagPage(key: args.key, hashtag: args.hashtag);
    },
  );
}

class HashtagRouteArgs {
  const HashtagRouteArgs({this.key, required this.hashtag});

  final _i16.Key? key;

  final String hashtag;

  @override
  String toString() {
    return 'HashtagRouteArgs{key: $key, hashtag: $hashtag}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! HashtagRouteArgs) return false;
    return key == other.key && hashtag == other.hashtag;
  }

  @override
  int get hashCode => key.hashCode ^ hashtag.hashCode;
}

/// generated route for
/// [_i6.LoginPage]
class LoginRoute extends _i15.PageRouteInfo<void> {
  const LoginRoute({List<_i15.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i6.LoginPage();
    },
  );
}

/// generated route for
/// [_i7.MessagePage]
class MessageRoute extends _i15.PageRouteInfo<MessageRouteArgs> {
  MessageRoute({
    _i16.Key? key,
    required _i18.RoomModel room,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         MessageRoute.name,
         args: MessageRouteArgs(key: key, room: room),
         initialChildren: children,
       );

  static const String name = 'MessageRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MessageRouteArgs>();
      return _i7.MessagePage(key: args.key, room: args.room);
    },
  );
}

class MessageRouteArgs {
  const MessageRouteArgs({this.key, required this.room});

  final _i16.Key? key;

  final _i18.RoomModel room;

  @override
  String toString() {
    return 'MessageRouteArgs{key: $key, room: $room}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MessageRouteArgs) return false;
    return key == other.key && room == other.room;
  }

  @override
  int get hashCode => key.hashCode ^ room.hashCode;
}

/// generated route for
/// [_i8.NotificationPage]
class NotificationRoute extends _i15.PageRouteInfo<void> {
  const NotificationRoute({List<_i15.PageRouteInfo>? children})
    : super(NotificationRoute.name, initialChildren: children);

  static const String name = 'NotificationRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i8.NotificationPage();
    },
  );
}

/// generated route for
/// [_i9.ProfilePage]
class ProfileRoute extends _i15.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({
    _i16.Key? key,
    required _i17.UserModel user,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         ProfileRoute.name,
         args: ProfileRouteArgs(key: key, user: user),
         initialChildren: children,
       );

  static const String name = 'ProfileRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProfileRouteArgs>();
      return _i9.ProfilePage(key: args.key, user: args.user);
    },
  );
}

class ProfileRouteArgs {
  const ProfileRouteArgs({this.key, required this.user});

  final _i16.Key? key;

  final _i17.UserModel user;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key, user: $user}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProfileRouteArgs) return false;
    return key == other.key && user == other.user;
  }

  @override
  int get hashCode => key.hashCode ^ user.hashCode;
}

/// generated route for
/// [_i10.SearchPage]
class SearchRoute extends _i15.PageRouteInfo<void> {
  const SearchRoute({List<_i15.PageRouteInfo>? children})
    : super(SearchRoute.name, initialChildren: children);

  static const String name = 'SearchRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i10.SearchPage();
    },
  );
}

/// generated route for
/// [_i11.SignupPage]
class SignupRoute extends _i15.PageRouteInfo<void> {
  const SignupRoute({List<_i15.PageRouteInfo>? children})
    : super(SignupRoute.name, initialChildren: children);

  static const String name = 'SignupRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i11.SignupPage();
    },
  );
}

/// generated route for
/// [_i12.SplashPage]
class SplashRoute extends _i15.PageRouteInfo<void> {
  const SplashRoute({List<_i15.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i12.SplashPage();
    },
  );
}

/// generated route for
/// [_i13.TwitDetailPage]
class TwitDetailRoute extends _i15.PageRouteInfo<TwitDetailRouteArgs> {
  TwitDetailRoute({
    _i16.Key? key,
    required _i19.TwitModel twit,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         TwitDetailRoute.name,
         args: TwitDetailRouteArgs(key: key, twit: twit),
         initialChildren: children,
       );

  static const String name = 'TwitDetailRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TwitDetailRouteArgs>();
      return _i13.TwitDetailPage(key: args.key, twit: args.twit);
    },
  );
}

class TwitDetailRouteArgs {
  const TwitDetailRouteArgs({this.key, required this.twit});

  final _i16.Key? key;

  final _i19.TwitModel twit;

  @override
  String toString() {
    return 'TwitDetailRouteArgs{key: $key, twit: $twit}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TwitDetailRouteArgs) return false;
    return key == other.key && twit == other.twit;
  }

  @override
  int get hashCode => key.hashCode ^ twit.hashCode;
}

/// generated route for
/// [_i14.TwitListPage]
class TwitListRoute extends _i15.PageRouteInfo<void> {
  const TwitListRoute({List<_i15.PageRouteInfo>? children})
    : super(TwitListRoute.name, initialChildren: children);

  static const String name = 'TwitListRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i14.TwitListPage();
    },
  );
}
