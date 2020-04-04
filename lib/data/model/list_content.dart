import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'list_content.g.dart';

@JsonSerializable()
class ListContent {
  Map<String, bool> content;

  ListContent(this.content);

  factory ListContent.fromJson(Map<String, dynamic> json) =>
      _$ListContentFromJson(json);

  Map<String, dynamic> toJson() => _$ListContentToJson(this);
}

class ListContentConverter extends TypeConverter<ListContent, String> {
  const ListContentConverter();
  @override
  ListContent mapToDart(String fromDb) {
    if (fromDb == null) {
      return null;
    }
    return ListContent.fromJson(json.decode(fromDb) as Map<String, dynamic>);
  }

  @override
  String mapToSql(ListContent value) {
    if (value == null) {
      return null;
    }

    return json.encode(value.toJson());
  }
}
