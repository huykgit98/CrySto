import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_event.dart';

part 'home_event.freezed.dart';

//Events are the input to a Bloc. They are commonly added in response to user
// interactions such as button presses or lifecycle events like page loads.
abstract class HomeEvent extends BaseBlocEvent {
  const HomeEvent();
}

@freezed
class HomePageInitiated extends HomeEvent with _$HomePageInitiated {
  const factory HomePageInitiated() = _HomePageInitiated;
}

@freezed
class HomePageRefreshed extends HomeEvent with _$HomePageRefreshed {
  const factory HomePageRefreshed({
    required Completer<void> completer,
  }) = _HomePageRefreshed;
}

@freezed
class UserLoadMore extends HomeEvent with _$UserLoadMore {
  const factory UserLoadMore() = _UserLoadMore;
}
