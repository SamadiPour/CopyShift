import 'dart:async';

import 'package:copy_shift/logic/services/clipboard_action.dart';

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
  final ClipboardAction _clipboardAction;
  Timer? _timer;
  String? _lastSeen;

  ClipboardListenerPulling({
    required ClipboardAction clipboardAction,
  }): _clipboardAction = clipboardAction;

  @override
  void listen() {
    if (_timer != null) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _checkLatest();
    });
  }

  void _checkLatest() async {
    final value = await _clipboardAction.readString();
    if (value == null) {
      return;
    }

    // check if value has changed since last time
    // and send it to the stream if it's new
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
