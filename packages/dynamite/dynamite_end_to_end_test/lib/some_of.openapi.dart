// ignore_for_file: camel_case_types
// ignore_for_file: discarded_futures
// ignore_for_file: public_member_api_docs
// ignore_for_file: unreachable_switch_case

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:dynamite_runtime/built_value.dart';
import 'package:dynamite_runtime/http_client.dart';
import 'package:dynamite_runtime/utils.dart' as dynamite_utils;

part 'some_of.openapi.g.dart';

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
abstract interface class $OneValueSomeOfInObjectInterface {
  @BuiltValueField(wireName: 'OneValue')
  int get oneValue;
  @BuiltValueField(wireName: 'IntDouble')
  num get intDouble;
  @BuiltValueField(wireName: 'IntDoubleString')
  OneValueSomeOfInObject_IntDoubleString? get intDoubleString;
}

abstract class OneValueSomeOfInObject
    implements $OneValueSomeOfInObjectInterface, Built<OneValueSomeOfInObject, OneValueSomeOfInObjectBuilder> {
  factory OneValueSomeOfInObject([final void Function(OneValueSomeOfInObjectBuilder)? b]) = _$OneValueSomeOfInObject;

  const OneValueSomeOfInObject._();

  factory OneValueSomeOfInObject.fromJson(final Map<String, dynamic> json) =>
      _jsonSerializers.deserializeWith(serializer, json)!;

  Map<String, dynamic> toJson() => _jsonSerializers.serializeWith(serializer, this)! as Map<String, dynamic>;

  static Serializer<OneValueSomeOfInObject> get serializer => _$oneValueSomeOfInObjectSerializer;

  @BuiltValueHook(finalizeBuilder: true)
  static void _validate(final OneValueSomeOfInObjectBuilder b) {
    b.intDoubleString?.validateOneOf();
  }
}

typedef OneOfIntDoubleOther = ({num? $num, String? string});

typedef AnyOfIntDoubleOther = ({num? $num, String? string});

typedef OneValueSomeOfInObject_IntDoubleString = ({num? $num, String? string});

typedef $NumString = ({num? $num, String? string});

extension $NumStringExtension on $NumString {
  List<dynamic> get _values => [$num, string];
  void validateOneOf() => dynamite_utils.validateOneOf(_values);
  void validateAnyOf() => dynamite_utils.validateAnyOf(_values);
  static Serializer<$NumString> get serializer => const _$NumStringSerializer();
  static $NumString fromJson(final Object? json) => _jsonSerializers.deserializeWith(serializer, json)!;
  Object? toJson() => _jsonSerializers.serializeWith(serializer, this);
}

class _$NumStringSerializer implements PrimitiveSerializer<$NumString> {
  const _$NumStringSerializer();

  @override
  Iterable<Type> get types => const [$NumString];

  @override
  String get wireName => r'$NumString';

  @override
  Object serialize(
    final Serializers serializers,
    final $NumString object, {
    final FullType specifiedType = FullType.unspecified,
  }) {
    dynamic value;
    value = object.$num;
    if (value != null) {
      return serializers.serialize(value, specifiedType: const FullType(num))!;
    }
    value = object.string;
    if (value != null) {
      return serializers.serialize(value, specifiedType: const FullType(String))!;
    }
// Should not be possible after validation.
    throw StateError('Tried to serialize without any value.');
  }

  @override
  $NumString deserialize(
    final Serializers serializers,
    final Object data, {
    final FullType specifiedType = FullType.unspecified,
  }) {
    num? $num;
    try {
      $num = serializers.deserialize(data, specifiedType: const FullType(num))! as num;
    } catch (_) {}
    String? string;
    try {
      string = serializers.deserialize(data, specifiedType: const FullType(String))! as String;
    } catch (_) {}
    return ($num: $num, string: string);
  }
}

// coverage:ignore-start
final Serializers _serializers = (Serializers().toBuilder()
      ..add($NumStringExtension.serializer)
      ..addBuilderFactory(const FullType(OneValueSomeOfInObject), OneValueSomeOfInObjectBuilder.new)
      ..add(OneValueSomeOfInObject.serializer))
    .build();

final Serializers _jsonSerializers = (_serializers.toBuilder()
      ..add(DynamiteDoubleSerializer())
      ..addPlugin(StandardJsonPlugin())
      ..addPlugin(const ContentStringPlugin()))
    .build();
// coverage:ignore-end
