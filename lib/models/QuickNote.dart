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


/** This is an auto generated class representing the QuickNote type in your schema. */
@immutable
class QuickNote extends Model {
  static const classType = const _QuickNoteModelType();
  final String id;
  final String? _description;
  final String? _color;
  final TemporalDateTime? _createdAt;
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
  
  String get color {
    try {
      return _color!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  String? get userID {
    return _userID;
  }
  
  const QuickNote._internal({required this.id, required description, required color, createdAt, userID}): _description = description, _color = color, _createdAt = createdAt, _userID = userID;
  
  factory QuickNote({String? id, required String description, required String color, TemporalDateTime? createdAt, String? userID}) {
    return QuickNote._internal(
      id: id == null ? UUID.getUUID() : id,
      description: description,
      color: color,
      createdAt: createdAt,
      userID: userID);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is QuickNote &&
      id == other.id &&
      _description == other._description &&
      _color == other._color &&
      _createdAt == other._createdAt &&
      _userID == other._userID;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("QuickNote {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("color=" + "$_color" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("userID=" + "$_userID");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  QuickNote copyWith({String? id, String? description, String? color, TemporalDateTime? createdAt, String? userID}) {
    return QuickNote(
      id: id ?? this.id,
      description: description ?? this.description,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      userID: userID ?? this.userID);
  }
  
  QuickNote.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _description = json['description'],
      _color = json['color'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _userID = json['userID'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'description': _description, 'color': _color, 'createdAt': _createdAt?.format(), 'userID': _userID
  };

  static final QueryField ID = QueryField(fieldName: "quickNote.id");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField COLOR = QueryField(fieldName: "color");
  static final QueryField CREATEDAT = QueryField(fieldName: "createdAt");
  static final QueryField USERID = QueryField(fieldName: "userID");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "QuickNote";
    modelSchemaDefinition.pluralName = "QuickNotes";
    
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
      key: QuickNote.DESCRIPTION,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: QuickNote.COLOR,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: QuickNote.CREATEDAT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: QuickNote.USERID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _QuickNoteModelType extends ModelType<QuickNote> {
  const _QuickNoteModelType();
  
  @override
  QuickNote fromJson(Map<String, dynamic> jsonData) {
    return QuickNote.fromJson(jsonData);
  }
}