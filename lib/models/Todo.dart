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
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Todo type in your schema. */
@immutable
class Todo extends Model {
  static const classType = const _TodoModelType();
  final String id;
  final bool? _isTask;
  final bool? _isQuickNote;
  final bool? _isCheckList;
  final String? _userID;
  final Task? _task;
  final QuickNote? _quickNote;
  final CheckList? _checkList;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  bool? get isTask {
    return _isTask;
  }
  
  bool? get isQuickNote {
    return _isQuickNote;
  }
  
  bool? get isCheckList {
    return _isCheckList;
  }
  
  String? get userID {
    return _userID;
  }
  
  Task? get task {
    return _task;
  }
  
  QuickNote? get quickNote {
    return _quickNote;
  }
  
  CheckList? get checkList {
    return _checkList;
  }
  
  const Todo._internal({required this.id, isTask, isQuickNote, isCheckList, userID, task, quickNote, checkList}): _isTask = isTask, _isQuickNote = isQuickNote, _isCheckList = isCheckList, _userID = userID, _task = task, _quickNote = quickNote, _checkList = checkList;
  
  factory Todo({String? id, bool? isTask, bool? isQuickNote, bool? isCheckList, String? userID, Task? task, QuickNote? quickNote, CheckList? checkList}) {
    return Todo._internal(
      id: id == null ? UUID.getUUID() : id,
      isTask: isTask,
      isQuickNote: isQuickNote,
      isCheckList: isCheckList,
      userID: userID,
      task: task,
      quickNote: quickNote,
      checkList: checkList);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Todo &&
      id == other.id &&
      _isTask == other._isTask &&
      _isQuickNote == other._isQuickNote &&
      _isCheckList == other._isCheckList &&
      _userID == other._userID &&
      _task == other._task &&
      _quickNote == other._quickNote &&
      _checkList == other._checkList;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Todo {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("isTask=" + (_isTask != null ? _isTask!.toString() : "null") + ", ");
    buffer.write("isQuickNote=" + (_isQuickNote != null ? _isQuickNote!.toString() : "null") + ", ");
    buffer.write("isCheckList=" + (_isCheckList != null ? _isCheckList!.toString() : "null") + ", ");
    buffer.write("userID=" + "$_userID" + ", ");
    buffer.write("task=" + (_task != null ? _task!.toString() : "null") + ", ");
    buffer.write("quickNote=" + (_quickNote != null ? _quickNote!.toString() : "null") + ", ");
    buffer.write("checkList=" + (_checkList != null ? _checkList!.toString() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Todo copyWith({String? id, bool? isTask, bool? isQuickNote, bool? isCheckList, String? userID, Task? task, QuickNote? quickNote, CheckList? checkList}) {
    return Todo(
      id: id ?? this.id,
      isTask: isTask ?? this.isTask,
      isQuickNote: isQuickNote ?? this.isQuickNote,
      isCheckList: isCheckList ?? this.isCheckList,
      userID: userID ?? this.userID,
      task: task ?? this.task,
      quickNote: quickNote ?? this.quickNote,
      checkList: checkList ?? this.checkList);
  }
  
  Todo.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _isTask = json['isTask'],
      _isQuickNote = json['isQuickNote'],
      _isCheckList = json['isCheckList'],
      _userID = json['userID'],
      _task = json['task']?['serializedData'] != null
        ? Task.fromJson(new Map<String, dynamic>.from(json['task']['serializedData']))
        : null,
      _quickNote = json['quickNote']?['serializedData'] != null
        ? QuickNote.fromJson(new Map<String, dynamic>.from(json['quickNote']['serializedData']))
        : null,
      _checkList = json['checkList']?['serializedData'] != null
        ? CheckList.fromJson(new Map<String, dynamic>.from(json['checkList']['serializedData']))
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'isTask': _isTask, 'isQuickNote': _isQuickNote, 'isCheckList': _isCheckList, 'userID': _userID, 'task': _task?.toJson(), 'quickNote': _quickNote?.toJson(), 'checkList': _checkList?.toJson()
  };

  static final QueryField ID = QueryField(fieldName: "todo.id");
  static final QueryField ISTASK = QueryField(fieldName: "isTask");
  static final QueryField ISQUICKNOTE = QueryField(fieldName: "isQuickNote");
  static final QueryField ISCHECKLIST = QueryField(fieldName: "isCheckList");
  static final QueryField USERID = QueryField(fieldName: "userID");
  static final QueryField TASK = QueryField(
    fieldName: "task",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Task).toString()));
  static final QueryField QUICKNOTE = QueryField(
    fieldName: "quickNote",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (QuickNote).toString()));
  static final QueryField CHECKLIST = QueryField(
    fieldName: "checkList",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (CheckList).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Todo";
    modelSchemaDefinition.pluralName = "Todos";
    
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
      key: Todo.ISTASK,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Todo.ISQUICKNOTE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Todo.ISCHECKLIST,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Todo.USERID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Todo.TASK,
      isRequired: false,
      targetName: "todoTaskId",
      ofModelName: (Task).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Todo.QUICKNOTE,
      isRequired: false,
      targetName: "todoQuickNoteId",
      ofModelName: (QuickNote).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Todo.CHECKLIST,
      isRequired: false,
      targetName: "todoCheckListId",
      ofModelName: (CheckList).toString()
    ));
  });
}

class _TodoModelType extends ModelType<Todo> {
  const _TodoModelType();
  
  @override
  Todo fromJson(Map<String, dynamic> jsonData) {
    return Todo.fromJson(jsonData);
  }
}