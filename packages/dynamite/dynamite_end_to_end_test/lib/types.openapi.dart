// ignore_for_file: camel_case_types
// ignore_for_file: discarded_futures
// ignore_for_file: public_member_api_docs
// ignore_for_file: unreachable_switch_case
import 'dart:typed_data';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:dynamite_runtime/built_value.dart';
import 'package:dynamite_runtime/http_client.dart';
import 'package:dynamite_runtime/models.dart';

part 'types.openapi.g.dart';

class Client extends DynamiteClient {
  Client(
    super.baseURL, {
    super.baseHeaders,
    super.userAgent,
    super.httpClient,
    super.cookieJar,
  });

  Client.fromClient(final DynamiteClient client)
      : super(
          client.baseURL,
          baseHeaders: client.baseHeaders,
          httpClient: client.httpClient,
          cookieJar: client.cookieJar,
          authentications: client.authentications,
        );
}

@BuiltValue(instantiable: false)
abstract interface class $BaseInterface {
  @BuiltValueField(wireName: 'bool')
  bool? get $bool;
  int? get integer;
  @BuiltValueField(wireName: 'double')
  double? get $double;
  @BuiltValueField(wireName: 'num')
  num? get $num;
  String? get string;
  @BuiltValueField(wireName: 'content-string')
  ContentString<int>? get contentString;
  @BuiltValueField(wireName: 'string-binary')
  Uint8List? get stringBinary;
  BuiltList<JsonObject>? get list;
  @BuiltValueField(wireName: 'list-never')
  BuiltList<Never>? get listNever;
  @BuiltValueField(wireName: 'list-string')
  BuiltList<String>? get listString;
}

abstract class Base implements $BaseInterface, Built<Base, BaseBuilder> {
  factory Base([final void Function(BaseBuilder)? b]) = _$Base;

  const Base._();

  factory Base.fromJson(final Map<String, dynamic> json) => _jsonSerializers.deserializeWith(serializer, json)!;

  Map<String, dynamic> toJson() => _jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;

  static Serializer<Base> get serializer => _$baseSerializer;
}

// coverage:ignore-start
final Serializers _serializers = (Serializers().toBuilder()
      ..addBuilderFactory(const FullType(Base), BaseBuilder.new)
      ..add(Base.serializer)
      ..addBuilderFactory(const FullType(ContentString, [FullType(int)]), ContentStringBuilder<int>.new)
      ..add(ContentString.serializer)
      ..addBuilderFactory(const FullType(BuiltList, [FullType(JsonObject)]), ListBuilder<JsonObject>.new)
      ..addBuilderFactory(const FullType(BuiltList, [FullType(Never)]), ListBuilder<Never>.new)
      ..addBuilderFactory(const FullType(BuiltList, [FullType(String)]), ListBuilder<String>.new))
    .build();

final Serializers _jsonSerializers = (_serializers.toBuilder()
      ..add(DynamiteDoubleSerializer())
      ..addPlugin(StandardJsonPlugin())
      ..addPlugin(const ContentStringPlugin()))
    .build();
// coverage:ignore-end
