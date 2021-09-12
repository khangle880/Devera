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

/** This is an auto generated class representing the Task type in your schema. */
@immutable
class Task extends Model {
  static const classType = const _TaskModelType();
  final String id;
  final String? _description;
  final TemporalDateTime? _createdAt;
  final TemporalDate? _dueDate;
  final bool? _isComplete;
  final String? _userID;
  final List<String>? _members;
  final List<Comment>? _comments;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  String get description {
    try {
      return _description!;
    } catch (e) {
      throw new DataStoreException(
          DataStoreExceptionMessages
              .codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion: DataStoreExceptionMessages
              .codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString());
    }
  }

  TemporalDateTime? get createdAt {
    return _createdAt;
  }

  TemporalDate? get dueDate {
    return _dueDate;
  }

  bool get isComplete {
    try {
      return _isComplete!;
    } catch (e) {
      throw new DataStoreException(
          DataStoreExceptionMessages
              .codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion: DataStoreExceptionMessages
              .codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString());
    }
  }

  String? get userID {
    return _userID;
  }

  List<String>? get members {
    return _members;
  }

  List<Comment>? get comments {
    return _comments;
  }

  const Task._internal(
      {required this.id,
      required description,
      createdAt,
      dueDate,
      required isComplete,
      userID,
      members,
      comments})
      : _description = description,
        _createdAt = createdAt,
        _dueDate = dueDate,
        _isComplete = isComplete,
        _userID = userID,
        _members = members,
        _comments = comments;

  factory Task(
      {String? id,
      required String description,
      TemporalDateTime? createdAt,
      TemporalDate? dueDate,
      required bool isComplete,
      String? userID,
      List<String>? members,
      List<Comment>? comments}) {
    return Task._internal(
        id: id == null ? UUID.getUUID() : id,
        description: description,
        createdAt: createdAt,
        dueDate: dueDate,
        isComplete: isComplete,
        userID: userID,
        members: members != null ? List<String>.unmodifiable(members) : members,
        comments:
            comments != null ? List<Comment>.unmodifiable(comments) : comments);
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
        _userID == other._userID &&
        DeepCollectionEquality().equals(_members, other._members) &&
        DeepCollectionEquality().equals(_comments, other._comments);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Task {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("createdAt=" +
        (_createdAt != null ? _createdAt!.format() : "null") +
        ", ");
    buffer.write(
        "dueDate=" + (_dueDate != null ? _dueDate!.format() : "null") + ", ");
    buffer.write("isComplete=" +
        (_isComplete != null ? _isComplete!.toString() : "null") +
        ", ");
    buffer.write("userID=" + "$_userID" + ", ");
    buffer
        .write("members=" + (_members != null ? _members!.toString() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  Task copyWith(
      {String? id,
      String? description,
      TemporalDateTime? createdAt,
      TemporalDate? dueDate,
      bool? isComplete,
      String? userID,
      List<String>? members,
      List<Comment>? comments}) {
    return Task(
        id: id ?? this.id,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        dueDate: dueDate ?? this.dueDate,
        isComplete: isComplete ?? this.isComplete,
        userID: userID ?? this.userID,
        members: members ?? this.members,
        comments: comments ?? this.comments);
  }

  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _description = json['description'],
        _createdAt = json['createdAt'] != null
            ? TemporalDateTime.fromString(json['createdAt'])
            : null,
        _dueDate = json['dueDate'] != null
            ? TemporalDate.fromString(json['dueDate'])
            : null,
        _isComplete = json['isComplete'],
        _userID = json['userID'],
        _members = json['members']?.cast<String>(),
        _comments = json['comments'] is List
            ? (json['comments'] as List)
                .where((e) => e?['serializedData'] != null)
                .map((e) => Comment.fromJson(
                    new Map<String, dynamic>.from(e['serializedData'])))
                .toList()
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': _description,
        'createdAt': _createdAt?.format(),
        'dueDate': _dueDate?.format(),
        'isComplete': _isComplete,
        'userID': _userID,
        'members': _members,
        'comments': _comments?.map((e) => e.toJson()).toList()
      };

  static final QueryField ID = QueryField(fieldName: "task.id");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField CREATEDAT = QueryField(fieldName: "createdAt");
  static final QueryField DUEDATE = QueryField(fieldName: "dueDate");
  static final QueryField ISCOMPLETE = QueryField(fieldName: "isComplete");
  static final QueryField USERID = QueryField(fieldName: "userID");
  static final QueryField MEMBERS = QueryField(fieldName: "members");
  static final QueryField COMMENTS = QueryField(
      fieldName: "comments",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Comment).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Task";
    modelSchemaDefinition.pluralName = "Tasks";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
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
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Task.CREATEDAT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Task.DUEDATE,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.date)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Task.ISCOMPLETE,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.bool)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Task.USERID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Task.MEMBERS,
        isRequired: false,
        isArray: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.collection,
            ofModelName: describeEnum(ModelFieldTypeEnum.string))));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: Task.COMMENTS,
        isRequired: false,
        ofModelName: (Comment).toString(),
        associatedKey: Comment.TASKID));
  });
}

class _TaskModelType extends ModelType<Task> {
  const _TaskModelType();

  @override
  Task fromJson(Map<String, dynamic> jsonData) {
    return Task.fromJson(jsonData);
  }
}
