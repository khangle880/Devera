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

import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the CheckList type in your schema. */
@immutable
class CheckList extends Model {
  static const classType = const _CheckListModelType();
  final String id;
  final List<List>? _todoList;
  final String? _color;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  List<List>? get todoList {
    return _todoList;
  }
  
  String get color {
    try {
      return _color!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  const CheckList._internal({required this.id, todoList, required color}): _todoList = todoList, _color = color;
  
  factory CheckList({String? id, List<List>? todoList, required String color}) {
    return CheckList._internal(
      id: id == null ? UUID.getUUID() : id,
      todoList: todoList != null ? List<List>.unmodifiable(todoList) : todoList,
      color: color);
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
      _color == other._color;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("CheckList {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("todoList=" + (_todoList != null ? _todoList!.toString() : "null") + ", ");
    buffer.write("color=" + "$_color");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  CheckList copyWith({String? id, List<List>? todoList, String? color}) {
    return CheckList(
      id: id ?? this.id,
      todoList: todoList ?? this.todoList,
      color: color ?? this.color);
  }
  
  CheckList.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _todoList = json['todoList']?.cast<List>(),
      _color = json['color'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'todoList': _todoList, 'color': _color
  };

  static final QueryField ID = QueryField(fieldName: "checkList.id");
  static final QueryField TODOLIST = QueryField(fieldName: "todoList");
  static final QueryField COLOR = QueryField(fieldName: "color");
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
  });
}

class _CheckListModelType extends ModelType<CheckList> {
  const _CheckListModelType();
  
  @override
  CheckList fromJson(Map<String, dynamic> jsonData) {
    return CheckList.fromJson(jsonData);
  }
}