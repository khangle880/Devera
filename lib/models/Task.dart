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


/** This is an auto generated class representing the Task type in your schema. */
@immutable
class Task extends Model {
  static const classType = const _TaskModelType();
  final String id;
  final String? _description;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _dueDate;
  final bool? _isComplete;
  final List<String>? _targetUsers;
  final String? _userID;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get description {
    try {
      return _description!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime get dueDate {
    try {
      return _dueDate!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  bool get isComplete {
    try {
      return _isComplete!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  List<String>? get targetUsers {
    return _targetUsers;
  }
  
  String? get userID {
    return _userID;
  }
  
  const Task._internal({required this.id, required description, createdAt, required dueDate, required isComplete, targetUsers, userID}): _description = description, _createdAt = createdAt, _dueDate = dueDate, _isComplete = isComplete, _targetUsers = targetUsers, _userID = userID;
  
  factory Task({String? id, required String description, TemporalDateTime? createdAt, required TemporalDateTime dueDate, required bool isComplete, List<String>? targetUsers, String? userID}) {
    return Task._internal(
      id: id == null ? UUID.getUUID() : id,
      description: description,
      createdAt: createdAt,
      dueDate: dueDate,
      isComplete: isComplete,
      targetUsers: targetUsers != null ? List<String>.unmodifiable(targetUsers) : targetUsers,
      userID: userID);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Task &&
      id == other.id &&
      _description == other._description &&
      _createdAt == other._createdAt &&
      _dueDate == other._dueDate &&
      _isComplete == other._isComplete &&
      DeepCollectionEquality().equals(_targetUsers, other._targetUsers) &&
      _userID == other._userID;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Task {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("dueDate=" + (_dueDate != null ? _dueDate!.format() : "null") + ", ");
    buffer.write("isComplete=" + (_isComplete != null ? _isComplete!.toString() : "null") + ", ");
    buffer.write("targetUsers=" + (_targetUsers != null ? _targetUsers!.toString() : "null") + ", ");
    buffer.write("userID=" + "$_userID");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Task copyWith({String? id, String? description, TemporalDateTime? createdAt, TemporalDateTime? dueDate, bool? isComplete, List<String>? targetUsers, String? userID}) {
    return Task(
      id: id ?? this.id,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      isComplete: isComplete ?? this.isComplete,
      targetUsers: targetUsers ?? this.targetUsers,
      userID: userID ?? this.userID);
  }
  
  Task.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _description = json['description'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _dueDate = json['dueDate'] != null ? TemporalDateTime.fromString(json['dueDate']) : null,
      _isComplete = json['isComplete'],
      _targetUsers = json['targetUsers']?.cast<String>(),
      _userID = json['userID'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'description': _description, 'createdAt': _createdAt?.format(), 'dueDate': _dueDate?.format(), 'isComplete': _isComplete, 'targetUsers': _targetUsers, 'userID': _userID
  };

  static final QueryField ID = QueryField(fieldName: "task.id");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField CREATEDAT = QueryField(fieldName: "createdAt");
  static final QueryField DUEDATE = QueryField(fieldName: "dueDate");
  static final QueryField ISCOMPLETE = QueryField(fieldName: "isComplete");
  static final QueryField TARGETUSERS = QueryField(fieldName: "targetUsers");
  static final QueryField USERID = QueryField(fieldName: "userID");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Task";
    modelSchemaDefinition.pluralName = "Tasks";
    
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
      key: Task.DESCRIPTION,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.CREATEDAT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.DUEDATE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.ISCOMPLETE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.TARGETUSERS,
      isRequired: false,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Task.USERID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _TaskModelType extends ModelType<Task> {
  const _TaskModelType();
  
  @override
  Task fromJson(Map<String, dynamic> jsonData) {
    return Task.fromJson(jsonData);
  }
}