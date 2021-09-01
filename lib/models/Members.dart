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


/** This is an auto generated class representing the Members type in your schema. */
@immutable
class Members extends Model {
  static const classType = const _MembersModelType();
  final String id;
  final String? _avatarKey;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get avatarKey {
    return _avatarKey;
  }
  
  const Members._internal({required this.id, avatarKey}): _avatarKey = avatarKey;
  
  factory Members({String? id, String? avatarKey}) {
    return Members._internal(
      id: id == null ? UUID.getUUID() : id,
      avatarKey: avatarKey);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Members &&
      id == other.id &&
      _avatarKey == other._avatarKey;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Members {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("avatarKey=" + "$_avatarKey");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Members copyWith({String? id, String? avatarKey}) {
    return Members(
      id: id ?? this.id,
      avatarKey: avatarKey ?? this.avatarKey);
  }
  
  Members.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _avatarKey = json['avatarKey'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'avatarKey': _avatarKey
  };

  static final QueryField ID = QueryField(fieldName: "members.id");
  static final QueryField AVATARKEY = QueryField(fieldName: "avatarKey");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Members";
    modelSchemaDefinition.pluralName = "Members";
    
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
      key: Members.AVATARKEY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _MembersModelType extends ModelType<Members> {
  const _MembersModelType();
  
  @override
  Members fromJson(Map<String, dynamic> jsonData) {
    return Members.fromJson(jsonData);
  }
}