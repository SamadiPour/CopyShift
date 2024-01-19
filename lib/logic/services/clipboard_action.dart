import 'package:super_clipboard/super_clipboard.dart';

abstract class ClipboardAction {
  Future<String?> readString();

  void writeString(String value);

  void pasteString(String value);
}

class ClipboardActionImpl implements ClipboardAction {
  final _clipboard = SystemClipboard.instance!;
  final List<ValueFormat<String>> formats;

  ClipboardActionImpl({
    this.formats = const [Formats.plainText, Formats.htmlText],
  });

  @override
  Future<String?> readString() async {
    final reader = await _clipboard.read();
    final item = reader.items.firstOrNull;
    if (item == null) {
      return null;
    }

    for (final format in formats) {
      if (item.canProvide(format)) {
        return item.readValue<String>(format);
      }
    }
    return null;
  }

  @override
  Future<void> writeString(String value) async {
    final item = DataWriterItem();
    item.add(Formats.plainText(value));
    _clipboard.write([item]);
  }

  @override
  Future<void> pasteString(String value) async {
    // TODO: implement paste
    throw UnimplementedError();
  }
}
