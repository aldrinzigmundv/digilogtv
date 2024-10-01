import 'package:digilogtv/services/storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

const String keyUp = 'Arrow Up';
const String keyDown = 'Arrow Down';
const String keyLeft = 'Arrow Left';
const String keyRight = 'Arrow Right';
const String keyCenter = 'Select';

class DpadOption extends StatelessWidget {
  const DpadOption({
    super.key,
    required this.onSelect,
    required this.child,
    required this.onFocus,
  });

  final VoidCallback onSelect;
  final Function(bool isFocused) onFocus;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DpadOptionBuilder(
      onSelect: onSelect,
      onFocus: onFocus,
      child: child,
    );
  }
}

class DpadOptionBuilder extends StatefulWidget {
  const DpadOptionBuilder({
    super.key,
    required this.onSelect,
    required this.onFocus,
    required this.child,
  });

  final VoidCallback onSelect;
  final Function(bool isFocused) onFocus;
  final Widget child;

  @override
  State<DpadOptionBuilder> createState() => _DpadOptionBuilderState();
}

class _DpadOptionBuilderState extends State<DpadOptionBuilder> {
  final FocusNode focusNode = FocusNode();
  late Box focusBox;
  late StorageProvider storageProvider;

  @override
  void initState() {
    super.initState();
    storageProvider = StorageProvider(); // Initialize the storage provider
    focusBox = storageProvider.storage; // Access the Hive box for focus management
    focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    focusNode.removeListener(_handleFocusChange);
    focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    final isFocused = focusNode.hasFocus;
    widget.onFocus(isFocused);
    _updateFocusState(isFocused);
  }

  void _updateFocusState(bool isFocused) {
    // Update the focus state in Hive
    focusBox.put('isFocused', isFocused);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: focusNode,
      onKeyEvent: (KeyEvent event) {
        if (event is KeyDownEvent) {
          final label = event.logicalKey.keyLabel;

          if (label == keyCenter) {
            widget.onSelect();
          }
        } else if (event is KeyUpEvent) {
          // Request focus on key up events
          focusNode.requestFocus();
        }
      },
      child: widget.child,
    );
  }
}
