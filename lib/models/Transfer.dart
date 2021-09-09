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


/** This is an auto generated class representing the Transfer type in your schema. */
@immutable
class Transfer extends Model {
  static const classType = const _TransferModelType();
  final String id;
  final String? _txHash;
  final String? _walletID;
  final String? _amount;
  final TemporalDateTime? _createdAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get txHash {
    return _txHash;
  }
  
  String? get walletID {
    return _walletID;
  }
  
  String? get amount {
    return _amount;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  const Transfer._internal({required this.id, txHash, walletID, amount, createdAt}): _txHash = txHash, _walletID = walletID, _amount = amount, _createdAt = createdAt;
  
  factory Transfer({String? id, String? txHash, String? walletID, String? amount, TemporalDateTime? createdAt}) {
    return Transfer._internal(
      id: id == null ? UUID.getUUID() : id,
      txHash: txHash,
      walletID: walletID,
      amount: amount,
      createdAt: createdAt);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Transfer &&
      id == other.id &&
      _txHash == other._txHash &&
      _walletID == other._walletID &&
      _amount == other._amount &&
      _createdAt == other._createdAt;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Transfer {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("txHash=" + "$_txHash" + ", ");
    buffer.write("walletID=" + "$_walletID" + ", ");
    buffer.write("amount=" + "$_amount" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Transfer copyWith({String? id, String? txHash, String? walletID, String? amount, TemporalDateTime? createdAt}) {
    return Transfer(
      id: id ?? this.id,
      txHash: txHash ?? this.txHash,
      walletID: walletID ?? this.walletID,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt);
  }
  
  Transfer.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _txHash = json['txHash'],
      _walletID = json['walletID'],
      _amount = json['amount'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'txHash': _txHash, 'walletID': _walletID, 'amount': _amount, 'createdAt': _createdAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "transfer.id");
  static final QueryField TXHASH = QueryField(fieldName: "txHash");
  static final QueryField WALLETID = QueryField(fieldName: "walletID");
  static final QueryField AMOUNT = QueryField(fieldName: "amount");
  static final QueryField CREATEDAT = QueryField(fieldName: "createdAt");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Transfer";
    modelSchemaDefinition.pluralName = "Transfers";
    
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
      key: Transfer.TXHASH,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Transfer.WALLETID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Transfer.AMOUNT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Transfer.CREATEDAT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _TransferModelType extends ModelType<Transfer> {
  const _TransferModelType();
  
  @override
  Transfer fromJson(Map<String, dynamic> jsonData) {
    return Transfer.fromJson(jsonData);
  }
}