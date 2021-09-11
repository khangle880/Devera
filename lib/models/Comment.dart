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
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Comment type in your schema. */
@immutable
class Comment extends Model {
  static const classType = const _CommentModelType();
  final String id;
  final String? _avatarKey;
  final String? _comment;
  final String? _taskID;
  final String? _username;
  final TemporalDateTime? _createdAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get avatarKey {
    return _avatarKey;
  }
  
  String? get comment {
    return _comment;
  }
  
  String? get taskID {
    return _taskID;
  }
  
  String? get username {
    return _username;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  const Comment._internal({required this.id, avatarKey, comment, taskID, username, createdAt}): _avatarKey = avatarKey, _comment = comment, _taskID = taskID, _username = username, _createdAt = createdAt;
  
  factory Comment({String? id, String? avatarKey, String? comment, String? taskID, String? username, TemporalDateTime? createdAt}) {
    return Comment._internal(
      id: id == null ? UUID.getUUID() : id,
      avatarKey: avatarKey,
      comment: comment,
      taskID: taskID,
      username: username,
      createdAt: createdAt);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Comment &&
      id == other.id &&
      _avatarKey == other._avatarKey &&
      _comment == other._comment &&
      _taskID == other._taskID &&
      _username == other._username &&
      _createdAt == other._createdAt;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Comment {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("avatarKey=" + "$_avatarKey" + ", ");
    buffer.write("comment=" + "$_comment" + ", ");
    buffer.write("taskID=" + "$_taskID" + ", ");
    buffer.write("username=" + "$_username" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Comment copyWith({String? id, String? avatarKey, String? comment, String? taskID, String? username, TemporalDateTime? createdAt}) {
    return Comment(
      id: id ?? this.id,
      avatarKey: avatarKey ?? this.avatarKey,
      comment: comment ?? this.comment,
      taskID: taskID ?? this.taskID,
      username: username ?? this.username,
      createdAt: createdAt ?? this.createdAt);
  }
  
  Comment.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _avatarKey = json['avatarKey'],
      _comment = json['comment'],
      _taskID = json['taskID'],
      _username = json['username'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'avatarKey': _avatarKey, 'comment': _comment, 'taskID': _taskID, 'username': _username, 'createdAt': _createdAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "comment.id");
  static final QueryField AVATARKEY = QueryField(fieldName: "avatarKey");
  static final QueryField COMMENT = QueryField(fieldName: "comment");
  static final QueryField TASKID = QueryField(fieldName: "taskID");
  static final QueryField USERNAME = QueryField(fieldName: "username");
  static final QueryField CREATEDAT = QueryField(fieldName: "createdAt");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Comment";
    modelSchemaDefinition.pluralName = "Comments";
    
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
      key: Comment.AVATARKEY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Comment.COMMENT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Comment.TASKID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Comment.USERNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Comment.CREATEDAT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _CommentModelType extends ModelType<Comment> {
  const _CommentModelType();
  
  @override
  Comment fromJson(Map<String, dynamic> jsonData) {
    return Comment.fromJson(jsonData);
  }
}