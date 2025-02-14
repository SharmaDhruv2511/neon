import 'package:dynamite/src/helpers/dart_helpers.dart';
import 'package:dynamite/src/models/type_result.dart';

String valueToEscapedValue(final TypeResult result, final String value) {
  if (result is TypeResultBase && result.name == 'String') {
    return "'$value'";
  }
  if (result is TypeResultList) {
    return 'const <${result.subType.name}>$value';
  }
  if (result is TypeResultEnum) {
    return '${result.name}.${toDartName(value)}';
  }
  return value;
}
