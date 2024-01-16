import 'dart:async';

import 'package:super_clipboard/super_clipboard.dart';

abstract class ClipboardListener {
  final StreamController<String> _controller = StreamController();

  Stream<String> get stream => _controller.stream;

  void listen();

  void stop();

  void dispose() {
    _controller.close();
  }
}

class ClipboardListenerPulling extends ClipboardListener {
  final _clipboard = SystemClipboard.instance!;
  Timer? _timer;
  String? _lastSeen;

  @override
  void listen() {
    if (_timer != null) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _checkLatest();
    });
  }

  void _checkLatest() async {
    final reader = await _clipboard.read();
    final value = await reader.readValue(Formats.plainText);
    if (value == null) return;
    if (value != _lastSeen) {
      _lastSeen = value;
      _controller.add(value);
    }
  }

  @override
  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
