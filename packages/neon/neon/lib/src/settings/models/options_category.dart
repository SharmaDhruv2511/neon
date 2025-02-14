import 'package:meta/meta.dart';
import 'package:neon/src/models/label_builder.dart';
import 'package:neon/src/settings/models/option.dart';

/// Category of an [Option].
@immutable
class OptionsCategory {
  /// Creates a new Category.
  const OptionsCategory({
    required this.name,
  });

  /// Builder function for the category name.
  final LabelBuilder name;
}
