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


/** This is an auto generated class representing the User type in your schema. */
@immutable
class User extends Model {
  static const classType = const _UserModelType();
  final String id;
  final String? _username;
  final String? _email;
  final String? _avatarKey;
  final String? _description;
  final List<Todo>? _todos;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get username {
    try {
      return _username!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String? get email {
    return _email;
  }
  
  String? get avatarKey {
    return _avatarKey;
  }
  
  String? get description {
    return _description;
  }
  
  List<Todo>? get todos {
    return _todos;
  }
  
  const User._internal({required this.id, required username, email, avatarKey, description, todos}): _username = username, _email = email, _avatarKey = avatarKey, _description = description, _todos = todos;
  
  factory User({String? id, required String username, String? email, String? avatarKey, String? description, List<Todo>? todos}) {
    return User._internal(
      id: id == null ? UUID.getUUID() : id,
      username: username,
      email: email,
      avatarKey: avatarKey,
      description: description,
      todos: todos != null ? List<Todo>.unmodifiable(todos) : todos);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
      id == other.id &&
      _username == other._username &&
      _email == other._email &&
      _avatarKey == other._avatarKey &&
      _description == other._description &&
      DeepCollectionEquality().equals(_todos, other._todos);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("User {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("username=" + "$_username" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("avatarKey=" + "$_avatarKey" + ", ");
    buffer.write("description=" + "$_description");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  User copyWith({String? id, String? username, String? email, String? avatarKey, String? description, List<Todo>? todos}) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      avatarKey: avatarKey ?? this.avatarKey,
      description: description ?? this.description,
      todos: todos ?? this.todos);
  }
  
  User.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _username = json['username'],
      _email = json['email'],
      _avatarKey = json['avatarKey'],
      _description = json['description'],
      _todos = json['todos'] is List
        ? (json['todos'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Todo.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'username': _username, 'email': _email, 'avatarKey': _avatarKey, 'description': _description, 'todos': _todos?.map((e) => e?.toJson())?.toList()
  };

  static final QueryField ID = QueryField(fieldName: "user.id");
  static final QueryField USERNAME = QueryField(fieldName: "username");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField AVATARKEY = QueryField(fieldName: "avatarKey");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField TODOS = QueryField(
    fieldName: "todos",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Todo).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";
    
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
      key: User.USERNAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.EMAIL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.AVATARKEY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.DESCRIPTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: User.TODOS,
      isRequired: false,
      ofModelName: (Todo).toString(),
      associatedKey: Todo.USERID
    ));
  });
}

class _UserModelType extends ModelType<User> {
  const _UserModelType();
  
  @override
  User fromJson(Map<String, dynamic> jsonData) {
    return User.fromJson(jsonData);
  }
}