import 'package:freezed_annotation/freezed_annotation.dart';

part 'transform_item.freezed.dart';
part 'transform_item.g.dart';

@freezed
class TransformItem with _$TransformItem {
  const factory TransformItem({
    required String id,
    required int order,
    required String matchPattern,
    required String replacePattern,
    @Default(false) bool stopOnApply,
    @Default(true) bool enabled,
    // todo - mode: regex, contains, startsWith, endsWith, equals
    // todo - regex mode: first, all, multiline
  }) = _TransformItem;

  factory TransformItem.fromJson(Map<String, dynamic> json) =>
      _$TransformItemFromJson(json);
}
