import 'package:copy_shift/models/transform_item.dart';

class ClipboardTransformer {
  final List<TransformItem> _transformItems = [];

  /// Transforms the input string based on the list of rules.
  ///
  /// @param input The string to be transformed.
  /// @return The transformed string.
  // todo - override transform items
  String transform(String input) {
    for (final item in _transformItems) {
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

  void load() {}

  void update(TransformItem items) {}

  void remove(String id) {}
}
