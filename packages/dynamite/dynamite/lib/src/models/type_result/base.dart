part of 'type_result.dart';

@immutable
class TypeResultBase extends TypeResult {
  TypeResultBase(
    super.className, {
    super.nullable,
    super.isTypeDef,
  });

  @override
  String? get _builderFactory => null;

  @override
  String? get _serializer => null;

  @override
  String encode(
    final String object, {
    final bool onlyChildren = false,
    final String? mimeType,
  }) {
    switch (mimeType) {
      case null:
      case 'application/json':
      case 'application/x-www-form-urlencoded':
        if (className == 'String') {
          return object;
        } else {
          return '$object.toString()';
        }
      case 'application/octet-stream':
        switch (className) {
          case 'Uint8List':
            return object;
          case 'String':
            return '(utf8.encode($object) as Uint8List)';
          default:
            throw Exception('"$mimeType" can only be Uint8List or String');
        }
      default:
        throw Exception('Can not encode mime type "$mimeType"');
    }
  }

  @override
  TypeResultBase get dartType {
    final dartName = switch (name) {
      'JsonObject' => 'dynamic',
      _ => name,
    };

    return TypeResultBase(dartName, nullable: nullable);
  }
}
