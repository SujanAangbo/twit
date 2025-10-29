// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'twit_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TwitModel {

 String get content; List<String> get hashtags; String? get link; List<String> get images; String get id; String get userId; String? get createdAt; List<String> get likes; List<String> get comments; int get shareCount; TwitType get twitType; bool get isReposted; String? get repostedTwitId; String? get repostedUserId; String? get replyTo; String? get replyTwitId; TwitEventType? get event;
/// Create a copy of TwitModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TwitModelCopyWith<TwitModel> get copyWith => _$TwitModelCopyWithImpl<TwitModel>(this as TwitModel, _$identity);

  /// Serializes this TwitModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TwitModel&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other.hashtags, hashtags)&&(identical(other.link, link) || other.link == link)&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.likes, likes)&&const DeepCollectionEquality().equals(other.comments, comments)&&(identical(other.shareCount, shareCount) || other.shareCount == shareCount)&&(identical(other.twitType, twitType) || other.twitType == twitType)&&(identical(other.isReposted, isReposted) || other.isReposted == isReposted)&&(identical(other.repostedTwitId, repostedTwitId) || other.repostedTwitId == repostedTwitId)&&(identical(other.repostedUserId, repostedUserId) || other.repostedUserId == repostedUserId)&&(identical(other.replyTo, replyTo) || other.replyTo == replyTo)&&(identical(other.replyTwitId, replyTwitId) || other.replyTwitId == replyTwitId)&&(identical(other.event, event) || other.event == event));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,const DeepCollectionEquality().hash(hashtags),link,const DeepCollectionEquality().hash(images),id,userId,createdAt,const DeepCollectionEquality().hash(likes),const DeepCollectionEquality().hash(comments),shareCount,twitType,isReposted,repostedTwitId,repostedUserId,replyTo,replyTwitId,event);

@override
String toString() {
  return 'TwitModel(content: $content, hashtags: $hashtags, link: $link, images: $images, id: $id, userId: $userId, createdAt: $createdAt, likes: $likes, comments: $comments, shareCount: $shareCount, twitType: $twitType, isReposted: $isReposted, repostedTwitId: $repostedTwitId, repostedUserId: $repostedUserId, replyTo: $replyTo, replyTwitId: $replyTwitId, event: $event)';
}


}

/// @nodoc
abstract mixin class $TwitModelCopyWith<$Res>  {
  factory $TwitModelCopyWith(TwitModel value, $Res Function(TwitModel) _then) = _$TwitModelCopyWithImpl;
@useResult
$Res call({
 String content, List<String> hashtags, String? link, List<String> images, String id, String userId, String? createdAt, List<String> likes, List<String> comments, int shareCount, TwitType twitType, bool isReposted, String? repostedTwitId, String? repostedUserId, String? replyTo, String? replyTwitId, TwitEventType? event
});




}
/// @nodoc
class _$TwitModelCopyWithImpl<$Res>
    implements $TwitModelCopyWith<$Res> {
  _$TwitModelCopyWithImpl(this._self, this._then);

  final TwitModel _self;
  final $Res Function(TwitModel) _then;

/// Create a copy of TwitModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = null,Object? hashtags = null,Object? link = freezed,Object? images = null,Object? id = null,Object? userId = null,Object? createdAt = freezed,Object? likes = null,Object? comments = null,Object? shareCount = null,Object? twitType = null,Object? isReposted = null,Object? repostedTwitId = freezed,Object? repostedUserId = freezed,Object? replyTo = freezed,Object? replyTwitId = freezed,Object? event = freezed,}) {
  return _then(_self.copyWith(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,hashtags: null == hashtags ? _self.hashtags : hashtags // ignore: cast_nullable_to_non_nullable
as List<String>,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as List<String>,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as List<String>,shareCount: null == shareCount ? _self.shareCount : shareCount // ignore: cast_nullable_to_non_nullable
as int,twitType: null == twitType ? _self.twitType : twitType // ignore: cast_nullable_to_non_nullable
as TwitType,isReposted: null == isReposted ? _self.isReposted : isReposted // ignore: cast_nullable_to_non_nullable
as bool,repostedTwitId: freezed == repostedTwitId ? _self.repostedTwitId : repostedTwitId // ignore: cast_nullable_to_non_nullable
as String?,repostedUserId: freezed == repostedUserId ? _self.repostedUserId : repostedUserId // ignore: cast_nullable_to_non_nullable
as String?,replyTo: freezed == replyTo ? _self.replyTo : replyTo // ignore: cast_nullable_to_non_nullable
as String?,replyTwitId: freezed == replyTwitId ? _self.replyTwitId : replyTwitId // ignore: cast_nullable_to_non_nullable
as String?,event: freezed == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as TwitEventType?,
  ));
}

}


/// Adds pattern-matching-related methods to [TwitModel].
extension TwitModelPatterns on TwitModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TwitModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TwitModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TwitModel value)  $default,){
final _that = this;
switch (_that) {
case _TwitModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TwitModel value)?  $default,){
final _that = this;
switch (_that) {
case _TwitModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String content,  List<String> hashtags,  String? link,  List<String> images,  String id,  String userId,  String? createdAt,  List<String> likes,  List<String> comments,  int shareCount,  TwitType twitType,  bool isReposted,  String? repostedTwitId,  String? repostedUserId,  String? replyTo,  String? replyTwitId,  TwitEventType? event)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TwitModel() when $default != null:
return $default(_that.content,_that.hashtags,_that.link,_that.images,_that.id,_that.userId,_that.createdAt,_that.likes,_that.comments,_that.shareCount,_that.twitType,_that.isReposted,_that.repostedTwitId,_that.repostedUserId,_that.replyTo,_that.replyTwitId,_that.event);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String content,  List<String> hashtags,  String? link,  List<String> images,  String id,  String userId,  String? createdAt,  List<String> likes,  List<String> comments,  int shareCount,  TwitType twitType,  bool isReposted,  String? repostedTwitId,  String? repostedUserId,  String? replyTo,  String? replyTwitId,  TwitEventType? event)  $default,) {final _that = this;
switch (_that) {
case _TwitModel():
return $default(_that.content,_that.hashtags,_that.link,_that.images,_that.id,_that.userId,_that.createdAt,_that.likes,_that.comments,_that.shareCount,_that.twitType,_that.isReposted,_that.repostedTwitId,_that.repostedUserId,_that.replyTo,_that.replyTwitId,_that.event);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String content,  List<String> hashtags,  String? link,  List<String> images,  String id,  String userId,  String? createdAt,  List<String> likes,  List<String> comments,  int shareCount,  TwitType twitType,  bool isReposted,  String? repostedTwitId,  String? repostedUserId,  String? replyTo,  String? replyTwitId,  TwitEventType? event)?  $default,) {final _that = this;
switch (_that) {
case _TwitModel() when $default != null:
return $default(_that.content,_that.hashtags,_that.link,_that.images,_that.id,_that.userId,_that.createdAt,_that.likes,_that.comments,_that.shareCount,_that.twitType,_that.isReposted,_that.repostedTwitId,_that.repostedUserId,_that.replyTo,_that.replyTwitId,_that.event);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _TwitModel implements TwitModel {
  const _TwitModel({required this.content, final  List<String> hashtags = const [], this.link, final  List<String> images = const [], required this.id, required this.userId, this.createdAt, final  List<String> likes = const [], final  List<String> comments = const [], this.shareCount = 0, required this.twitType, this.isReposted = false, this.repostedTwitId, this.repostedUserId, this.replyTo, this.replyTwitId, this.event}): _hashtags = hashtags,_images = images,_likes = likes,_comments = comments;
  factory _TwitModel.fromJson(Map<String, dynamic> json) => _$TwitModelFromJson(json);

@override final  String content;
 final  List<String> _hashtags;
@override@JsonKey() List<String> get hashtags {
  if (_hashtags is EqualUnmodifiableListView) return _hashtags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hashtags);
}

@override final  String? link;
 final  List<String> _images;
@override@JsonKey() List<String> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

@override final  String id;
@override final  String userId;
@override final  String? createdAt;
 final  List<String> _likes;
@override@JsonKey() List<String> get likes {
  if (_likes is EqualUnmodifiableListView) return _likes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_likes);
}

 final  List<String> _comments;
@override@JsonKey() List<String> get comments {
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comments);
}

@override@JsonKey() final  int shareCount;
@override final  TwitType twitType;
@override@JsonKey() final  bool isReposted;
@override final  String? repostedTwitId;
@override final  String? repostedUserId;
@override final  String? replyTo;
@override final  String? replyTwitId;
@override final  TwitEventType? event;

/// Create a copy of TwitModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TwitModelCopyWith<_TwitModel> get copyWith => __$TwitModelCopyWithImpl<_TwitModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TwitModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TwitModel&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other._hashtags, _hashtags)&&(identical(other.link, link) || other.link == link)&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._likes, _likes)&&const DeepCollectionEquality().equals(other._comments, _comments)&&(identical(other.shareCount, shareCount) || other.shareCount == shareCount)&&(identical(other.twitType, twitType) || other.twitType == twitType)&&(identical(other.isReposted, isReposted) || other.isReposted == isReposted)&&(identical(other.repostedTwitId, repostedTwitId) || other.repostedTwitId == repostedTwitId)&&(identical(other.repostedUserId, repostedUserId) || other.repostedUserId == repostedUserId)&&(identical(other.replyTo, replyTo) || other.replyTo == replyTo)&&(identical(other.replyTwitId, replyTwitId) || other.replyTwitId == replyTwitId)&&(identical(other.event, event) || other.event == event));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,content,const DeepCollectionEquality().hash(_hashtags),link,const DeepCollectionEquality().hash(_images),id,userId,createdAt,const DeepCollectionEquality().hash(_likes),const DeepCollectionEquality().hash(_comments),shareCount,twitType,isReposted,repostedTwitId,repostedUserId,replyTo,replyTwitId,event);

@override
String toString() {
  return 'TwitModel(content: $content, hashtags: $hashtags, link: $link, images: $images, id: $id, userId: $userId, createdAt: $createdAt, likes: $likes, comments: $comments, shareCount: $shareCount, twitType: $twitType, isReposted: $isReposted, repostedTwitId: $repostedTwitId, repostedUserId: $repostedUserId, replyTo: $replyTo, replyTwitId: $replyTwitId, event: $event)';
}


}

/// @nodoc
abstract mixin class _$TwitModelCopyWith<$Res> implements $TwitModelCopyWith<$Res> {
  factory _$TwitModelCopyWith(_TwitModel value, $Res Function(_TwitModel) _then) = __$TwitModelCopyWithImpl;
@override @useResult
$Res call({
 String content, List<String> hashtags, String? link, List<String> images, String id, String userId, String? createdAt, List<String> likes, List<String> comments, int shareCount, TwitType twitType, bool isReposted, String? repostedTwitId, String? repostedUserId, String? replyTo, String? replyTwitId, TwitEventType? event
});




}
/// @nodoc
class __$TwitModelCopyWithImpl<$Res>
    implements _$TwitModelCopyWith<$Res> {
  __$TwitModelCopyWithImpl(this._self, this._then);

  final _TwitModel _self;
  final $Res Function(_TwitModel) _then;

/// Create a copy of TwitModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = null,Object? hashtags = null,Object? link = freezed,Object? images = null,Object? id = null,Object? userId = null,Object? createdAt = freezed,Object? likes = null,Object? comments = null,Object? shareCount = null,Object? twitType = null,Object? isReposted = null,Object? repostedTwitId = freezed,Object? repostedUserId = freezed,Object? replyTo = freezed,Object? replyTwitId = freezed,Object? event = freezed,}) {
  return _then(_TwitModel(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,hashtags: null == hashtags ? _self._hashtags : hashtags // ignore: cast_nullable_to_non_nullable
as List<String>,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,likes: null == likes ? _self._likes : likes // ignore: cast_nullable_to_non_nullable
as List<String>,comments: null == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<String>,shareCount: null == shareCount ? _self.shareCount : shareCount // ignore: cast_nullable_to_non_nullable
as int,twitType: null == twitType ? _self.twitType : twitType // ignore: cast_nullable_to_non_nullable
as TwitType,isReposted: null == isReposted ? _self.isReposted : isReposted // ignore: cast_nullable_to_non_nullable
as bool,repostedTwitId: freezed == repostedTwitId ? _self.repostedTwitId : repostedTwitId // ignore: cast_nullable_to_non_nullable
as String?,repostedUserId: freezed == repostedUserId ? _self.repostedUserId : repostedUserId // ignore: cast_nullable_to_non_nullable
as String?,replyTo: freezed == replyTo ? _self.replyTo : replyTo // ignore: cast_nullable_to_non_nullable
as String?,replyTwitId: freezed == replyTwitId ? _self.replyTwitId : replyTwitId // ignore: cast_nullable_to_non_nullable
as String?,event: freezed == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as TwitEventType?,
  ));
}


}

// dart format on
