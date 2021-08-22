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


/** This is an auto generated class representing the ListItem type in your schema. */
@immutable
class ListItem extends Model {
  static const classType = const _ListItemModelType();
  final String id;
  final String? _description;
  final bool? _isComplete;
  final String? _checklistID;

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
  
  bool get isComplete {
    try {
      return _isComplete!;
    } catch(e) {
      throw new DataStoreException(DataStoreExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage, recoverySuggestion: DataStoreExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion, underlyingException: e.toString());
    }
  }
  
  String? get checklistID {
    return _checklistID;
  }
  
  const ListItem._internal({required this.id, required description, required isComplete, checklistID}): _description = description, _isComplete = isComplete, _checklistID = checklistID;
  
  factory ListItem({String? id, required String description, required bool isComplete, String? checklistID}) {
    return ListItem._internal(
      id: id == null ? UUID.getUUID() : id,
      description: description,
      isComplete: isComplete,
      checklistID: checklistID);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ListItem &&
      id == other.id &&
      _description == other._description &&
      _isComplete == other._isComplete &&
      _checklistID == other._checklistID;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("ListItem {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("isComplete=" + (_isComplete != null ? _isComplete!.toString() : "null") + ", ");
    buffer.write("checklistID=" + "$_checklistID");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  ListItem copyWith({String? id, String? description, bool? isComplete, String? checklistID}) {
    return ListItem(
      id: id ?? this.id,
      description: description ?? this.description,
      isComplete: isComplete ?? this.isComplete,
      checklistID: checklistID ?? this.checklistID);
  }
  
  ListItem.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _description = json['description'],
      _isComplete = json['isComplete'],
      _checklistID = json['checklistID'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'description': _description, 'isComplete': _isComplete, 'checklistID': _checklistID
  };

  static final QueryField ID = QueryField(fieldName: "listItem.id");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField ISCOMPLETE = QueryField(fieldName: "isComplete");
  static final QueryField CHECKLISTID = QueryField(fieldName: "checklistID");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ListItem";
    modelSchemaDefinition.pluralName = "ListItems";
    
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
      key: ListItem.DESCRIPTION,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ListItem.ISCOMPLETE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: ListItem.CHECKLISTID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}

class _ListItemModelType extends ModelType<ListItem> {
  const _ListItemModelType();
  
  @override
  ListItem fromJson(Map<String, dynamic> jsonData) {
    return ListItem.fromJson(jsonData);
  }
}