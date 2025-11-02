// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserModel {

 String get id; String get fullName; String? get dob; String get email; String get createdAt; String? get profilePicture; String? get bannerPicture; String? get bio; bool get isVerified; int get followersCount; int get followingCount; UserStatus get userStatus;
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserModelCopyWith<UserModel> get copyWith => _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.email, email) || other.email == email)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.bannerPicture, bannerPicture) || other.bannerPicture == bannerPicture)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.followersCount, followersCount) || other.followersCount == followersCount)&&(identical(other.followingCount, followingCount) || other.followingCount == followingCount)&&(identical(other.userStatus, userStatus) || other.userStatus == userStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,dob,email,createdAt,profilePicture,bannerPicture,bio,isVerified,followersCount,followingCount,userStatus);

@override
String toString() {
  return 'UserModel(id: $id, fullName: $fullName, dob: $dob, email: $email, createdAt: $createdAt, profilePicture: $profilePicture, bannerPicture: $bannerPicture, bio: $bio, isVerified: $isVerified, followersCount: $followersCount, followingCount: $followingCount, userStatus: $userStatus)';
}


}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res>  {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) = _$UserModelCopyWithImpl;
@useResult
$Res call({
 String id, String fullName, String? dob, String email, String createdAt, String? profilePicture, String? bannerPicture, String? bio, bool isVerified, int followersCount, int followingCount, UserStatus userStatus
});




}
/// @nodoc
class _$UserModelCopyWithImpl<$Res>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? fullName = null,Object? dob = freezed,Object? email = null,Object? createdAt = null,Object? profilePicture = freezed,Object? bannerPicture = freezed,Object? bio = freezed,Object? isVerified = null,Object? followersCount = null,Object? followingCount = null,Object? userStatus = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as String?,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,profilePicture: freezed == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String?,bannerPicture: freezed == bannerPicture ? _self.bannerPicture : bannerPicture // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,followersCount: null == followersCount ? _self.followersCount : followersCount // ignore: cast_nullable_to_non_nullable
as int,followingCount: null == followingCount ? _self.followingCount : followingCount // ignore: cast_nullable_to_non_nullable
as int,userStatus: null == userStatus ? _self.userStatus : userStatus // ignore: cast_nullable_to_non_nullable
as UserStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [UserModel].
extension UserModelPatterns on UserModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserModel value)  $default,){
final _that = this;
switch (_that) {
case _UserModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String fullName,  String? dob,  String email,  String createdAt,  String? profilePicture,  String? bannerPicture,  String? bio,  bool isVerified,  int followersCount,  int followingCount,  UserStatus userStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.fullName,_that.dob,_that.email,_that.createdAt,_that.profilePicture,_that.bannerPicture,_that.bio,_that.isVerified,_that.followersCount,_that.followingCount,_that.userStatus);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String fullName,  String? dob,  String email,  String createdAt,  String? profilePicture,  String? bannerPicture,  String? bio,  bool isVerified,  int followersCount,  int followingCount,  UserStatus userStatus)  $default,) {final _that = this;
switch (_that) {
case _UserModel():
return $default(_that.id,_that.fullName,_that.dob,_that.email,_that.createdAt,_that.profilePicture,_that.bannerPicture,_that.bio,_that.isVerified,_that.followersCount,_that.followingCount,_that.userStatus);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String fullName,  String? dob,  String email,  String createdAt,  String? profilePicture,  String? bannerPicture,  String? bio,  bool isVerified,  int followersCount,  int followingCount,  UserStatus userStatus)?  $default,) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.fullName,_that.dob,_that.email,_that.createdAt,_that.profilePicture,_that.bannerPicture,_that.bio,_that.isVerified,_that.followersCount,_that.followingCount,_that.userStatus);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _UserModel implements UserModel {
  const _UserModel({required this.id, required this.fullName, this.dob, required this.email, required this.createdAt, this.profilePicture, this.bannerPicture, this.bio, this.isVerified = false, this.followersCount = 0, this.followingCount = 0, required this.userStatus});
  factory _UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

@override final  String id;
@override final  String fullName;
@override final  String? dob;
@override final  String email;
@override final  String createdAt;
@override final  String? profilePicture;
@override final  String? bannerPicture;
@override final  String? bio;
@override@JsonKey() final  bool isVerified;
@override@JsonKey() final  int followersCount;
@override@JsonKey() final  int followingCount;
@override final  UserStatus userStatus;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserModelCopyWith<_UserModel> get copyWith => __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.dob, dob) || other.dob == dob)&&(identical(other.email, email) || other.email == email)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.bannerPicture, bannerPicture) || other.bannerPicture == bannerPicture)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.followersCount, followersCount) || other.followersCount == followersCount)&&(identical(other.followingCount, followingCount) || other.followingCount == followingCount)&&(identical(other.userStatus, userStatus) || other.userStatus == userStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,fullName,dob,email,createdAt,profilePicture,bannerPicture,bio,isVerified,followersCount,followingCount,userStatus);

@override
String toString() {
  return 'UserModel(id: $id, fullName: $fullName, dob: $dob, email: $email, createdAt: $createdAt, profilePicture: $profilePicture, bannerPicture: $bannerPicture, bio: $bio, isVerified: $isVerified, followersCount: $followersCount, followingCount: $followingCount, userStatus: $userStatus)';
}


}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(_UserModel value, $Res Function(_UserModel) _then) = __$UserModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String fullName, String? dob, String email, String createdAt, String? profilePicture, String? bannerPicture, String? bio, bool isVerified, int followersCount, int followingCount, UserStatus userStatus
});




}
/// @nodoc
class __$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? fullName = null,Object? dob = freezed,Object? email = null,Object? createdAt = null,Object? profilePicture = freezed,Object? bannerPicture = freezed,Object? bio = freezed,Object? isVerified = null,Object? followersCount = null,Object? followingCount = null,Object? userStatus = null,}) {
  return _then(_UserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,dob: freezed == dob ? _self.dob : dob // ignore: cast_nullable_to_non_nullable
as String?,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,profilePicture: freezed == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String?,bannerPicture: freezed == bannerPicture ? _self.bannerPicture : bannerPicture // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,followersCount: null == followersCount ? _self.followersCount : followersCount // ignore: cast_nullable_to_non_nullable
as int,followingCount: null == followingCount ? _self.followingCount : followingCount // ignore: cast_nullable_to_non_nullable
as int,userStatus: null == userStatus ? _self.userStatus : userStatus // ignore: cast_nullable_to_non_nullable
as UserStatus,
  ));
}


}

// dart format on
