import 'package:freezed_annotation/freezed_annotation.dart';
part 'cbs_item.g.dart';
part 'cbs_item.freezed.dart';

@freezed
class CbsItem with _$CbsItem {
  const factory CbsItem(
      {
        required String id,
        required String status
       }) = _CbsItem;

  factory CbsItem.fromJson(Map<String, dynamic> json) =>
      _$CbsItemFromJson(json);
}
