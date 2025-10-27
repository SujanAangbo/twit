// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_twit_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateTwitState {

 List<File> get images; bool get isLoading;
/// Create a copy of CreateTwitState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateTwitStateCopyWith<CreateTwitState> get copyWith => _$CreateTwitStateCopyWithImpl<CreateTwitState>(this as CreateTwitState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateTwitState&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(images),isLoading);

@override
String toString() {
  return 'CreateTwitState(images: $images, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class $CreateTwitStateCopyWith<$Res>  {
  factory $CreateTwitStateCopyWith(CreateTwitState value, $Res Function(CreateTwitState) _then) = _$CreateTwitStateCopyWithImpl;
@useResult
$Res call({
 List<File> images, bool isLoading
});




}
/// @nodoc
class _$CreateTwitStateCopyWithImpl<$Res>
    implements $CreateTwitStateCopyWith<$Res> {
  _$CreateTwitStateCopyWithImpl(this._self, this._then);

  final CreateTwitState _self;
  final $Res Function(CreateTwitState) _then;

/// Create a copy of CreateTwitState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? images = null,Object? isLoading = null,}) {
  return _then(_self.copyWith(
images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<File>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateTwitState].
extension CreateTwitStatePatterns on CreateTwitState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateTwitState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateTwitState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateTwitState value)  $default,){
final _that = this;
switch (_that) {
case _CreateTwitState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateTwitState value)?  $default,){
final _that = this;
switch (_that) {
case _CreateTwitState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<File> images,  bool isLoading)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateTwitState() when $default != null:
return $default(_that.images,_that.isLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<File> images,  bool isLoading)  $default,) {final _that = this;
switch (_that) {
case _CreateTwitState():
return $default(_that.images,_that.isLoading);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<File> images,  bool isLoading)?  $default,) {final _that = this;
switch (_that) {
case _CreateTwitState() when $default != null:
return $default(_that.images,_that.isLoading);case _:
  return null;

}
}

}

/// @nodoc


class _CreateTwitState implements CreateTwitState {
  const _CreateTwitState({final  List<File> images = const [], this.isLoading = false}): _images = images;
  

 final  List<File> _images;
@override@JsonKey() List<File> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

@override@JsonKey() final  bool isLoading;

/// Create a copy of CreateTwitState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateTwitStateCopyWith<_CreateTwitState> get copyWith => __$CreateTwitStateCopyWithImpl<_CreateTwitState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateTwitState&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_images),isLoading);

@override
String toString() {
  return 'CreateTwitState(images: $images, isLoading: $isLoading)';
}


}

/// @nodoc
abstract mixin class _$CreateTwitStateCopyWith<$Res> implements $CreateTwitStateCopyWith<$Res> {
  factory _$CreateTwitStateCopyWith(_CreateTwitState value, $Res Function(_CreateTwitState) _then) = __$CreateTwitStateCopyWithImpl;
@override @useResult
$Res call({
 List<File> images, bool isLoading
});




}
/// @nodoc
class __$CreateTwitStateCopyWithImpl<$Res>
    implements _$CreateTwitStateCopyWith<$Res> {
  __$CreateTwitStateCopyWithImpl(this._self, this._then);

  final _CreateTwitState _self;
  final $Res Function(_CreateTwitState) _then;

/// Create a copy of CreateTwitState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? images = null,Object? isLoading = null,}) {
  return _then(_CreateTwitState(
images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<File>,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
