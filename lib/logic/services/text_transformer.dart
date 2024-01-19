import 'package:copy_shift/models/transform_item.dart';

class TextTransformer {
  /// Transforms the input string based on the list of rules.
  ///
  /// input: The string to be transformed.
  /// transformers: The list of rules to be applied.
  /// it return The transformed string.
  static String transform(
    String input, {
    required List<TransformItem> transformers,
  }) {
    for (final item in transformers) {
      // If enabled and match the pattern
      if (item.enabled && RegExp(item.matchPattern).hasMatch(input)) {
        // Replace matched pattern
        input = input.replaceAllMapped(
          RegExp(item.matchPattern),
          (match) => item.replacePattern,
        );
        // Stop further transformations if it's set to stopOnApply
        if (item.stopOnApply) break;
      }
    }
    // Return the transformed string
    return input;
  }
}
