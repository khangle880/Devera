/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// ignore_for_file: public_member_api_docs

import 'ModelProvider.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the CheckList type in your schema. */
@immutable
class CheckList extends Model {
  static const classType = const _CheckListModelType();
  final String id;
  final List<String>? _todoList;
  final String? _color;
  final List<ListItem>? _listItems;
  final TemporalDateTime? _createdAt;
  final String? _userID;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  List<String>? get todoList {
    return _todoList;
  }
  
  String get color {
    try {
      return _color!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  List<ListItem>? get listItems {
    return _listItems;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  String? get userID {
    return _userID;
  }
  
  const CheckList._internal({required this.id, todoList, required color, listItems, createdAt, userID}): _todoList = todoList, _color = color, _listItems = listItems, _createdAt = createdAt, _userID = userID;
  
  factory CheckList({String? id, List<String>? todoList, required String color, List<ListItem>? listItems, TemporalDateTime? createdAt, String? userID}) {
    return CheckList._internal(
      id: id == null ? UUID.getUUID() : id,
      todoList: todoList != null ? List<String>.unmodifiable(todoList) : todoList,
      color: color,
      listItems: listItems != null ? List<ListItem>.unmodifiable(listItems) : listItems,
      createdAt: createdAt,
      userID: userID);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CheckList &&
      id == other.id &&
      DeepCollectionEquality().equals(_todoList, other._todoList) &&
      _color == other._color &&
      DeepCollectionEquality().equals(_listItems, other._listItems) &&
      _createdAt == other._createdAt &&
      _userID == other._userID;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("CheckList {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("todoList=" + (_todoList != null ? _todoList!.toString() : "null") + ", ");
    buffer.write("color=" + "$_color" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("userID=" + "$_userID");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  CheckList copyWith({String? id, List<String>? todoList, String? color, List<ListItem>? listItems, TemporalDateTime? createdAt, String? userID}) {
    return CheckList(
      id: id ?? this.id,
      todoList: todoList ?? this.todoList,
      color: color ?? this.color,
      listItems: listItems ?? this.listItems,
      createdAt: createdAt ?? this.createdAt,
      userID: userID ?? this.userID);
  }
  
  CheckList.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _todoList = json['todoList']?.cast<String>(),
      _color = json['color'],
      _listItems = json['listItems'] is List
        ? (json['listItems'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => ListItem.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _userID = json['userID'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'todoList': _todoList, 'color': _color, 'listItems': _listItems?.map((e) => e?.toJson())?.toList(), 'createdAt': _createdAt?.format(), 'userID': _userID
  };

  static final QueryField ID = QueryField(fieldName: "checkList.id");
  static final QueryField TODOLIST = QueryField(fieldName: "todoList");
  static final QueryField COLOR = QueryField(fieldName: "color");
  static final QueryField LISTITEMS = QueryField(
    fieldName: "listItems",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (ListItem).toString()));
  static final QueryField CREATEDAT = QueryField(fieldName: "createdAt");
  static final QueryField USERID = QueryField(fieldName: "userID");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "CheckList";
    modelSchemaDefinition.pluralName = "CheckLists";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: CheckList.TODOLIST,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: CheckList.COLOR,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: CheckList.LISTITEMS,
      isRequired: false,
      ofModelName: (ListItem).toString(),
      associatedKey: ListItem.CHECKLISTID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: CheckList.CREATEDAT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: CheckList.USERID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _CheckListModelType extends ModelType<CheckList> {
  const _CheckListModelType();
  
  @override
  CheckList fromJson(Map<String, dynamic> jsonData) {
    return CheckList.fromJson(jsonData);
  }
}