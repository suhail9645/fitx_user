import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_page.g.dart';

@JsonSerializable()
class CategoryPage extends Equatable {
  final int? count;
  final dynamic next;
  final dynamic previous;
  final List<dynamic>? results;

  const CategoryPage({this.count, this.next, this.previous, this.results});

  factory CategoryPage.fromJson(Map<String, dynamic> json) {
    return _$CategoryPageFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CategoryPageToJson(this);

  @override
  List<Object?> get props => [count, next, previous, results];
}
