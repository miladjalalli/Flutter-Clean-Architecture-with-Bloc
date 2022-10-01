import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NewsEvent extends Equatable {
  NewsEvent([List props = const <dynamic>[]]) : super(props);
}

class GetNewsEvent extends NewsEvent {
  GetNewsEvent();
}
class GetLastNewsFromDatabaseEvent extends NewsEvent {
  GetLastNewsFromDatabaseEvent();
}

