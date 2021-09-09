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


/** This is an auto generated class representing the Wallet type in your schema. */
@immutable
class Wallet extends Model {
  static const classType = const _WalletModelType();
  final String id;
  final String? _address;
  final String? _privateKey;
  final List<Transfer>? _transfers;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get address {
    return _address;
  }
  
  String? get privateKey {
    return _privateKey;
  }
  
  List<Transfer>? get transfers {
    return _transfers;
  }
  
  const Wallet._internal({required this.id, address, privateKey, transfers}): _address = address, _privateKey = privateKey, _transfers = transfers;
  
  factory Wallet({String? id, String? address, String? privateKey, List<Transfer>? transfers}) {
    return Wallet._internal(
      id: id == null ? UUID.getUUID() : id,
      address: address,
      privateKey: privateKey,
      transfers: transfers != null ? List<Transfer>.unmodifiable(transfers) : transfers);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Wallet &&
      id == other.id &&
      _address == other._address &&
      _privateKey == other._privateKey &&
      DeepCollectionEquality().equals(_transfers, other._transfers);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Wallet {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("address=" + "$_address" + ", ");
    buffer.write("privateKey=" + "$_privateKey");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Wallet copyWith({String? id, String? address, String? privateKey, List<Transfer>? transfers}) {
    return Wallet(
      id: id ?? this.id,
      address: address ?? this.address,
      privateKey: privateKey ?? this.privateKey,
      transfers: transfers ?? this.transfers);
  }
  
  Wallet.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _address = json['address'],
      _privateKey = json['privateKey'],
      _transfers = json['transfers'] is List
        ? (json['transfers'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Transfer.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'address': _address, 'privateKey': _privateKey, 'transfers': _transfers?.map((e) => e?.toJson())?.toList()
  };

  static final QueryField ID = QueryField(fieldName: "wallet.id");
  static final QueryField ADDRESS = QueryField(fieldName: "address");
  static final QueryField PRIVATEKEY = QueryField(fieldName: "privateKey");
  static final QueryField TRANSFERS = QueryField(
    fieldName: "transfers",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Transfer).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Wallet";
    modelSchemaDefinition.pluralName = "Wallets";
    
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
      key: Wallet.ADDRESS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Wallet.PRIVATEKEY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Wallet.TRANSFERS,
      isRequired: false,
      ofModelName: (Transfer).toString(),
      associatedKey: Transfer.WALLETID
    ));
  });
}

class _WalletModelType extends ModelType<Wallet> {
  const _WalletModelType();
  
  @override
  Wallet fromJson(Map<String, dynamic> jsonData) {
    return Wallet.fromJson(jsonData);
  }
}