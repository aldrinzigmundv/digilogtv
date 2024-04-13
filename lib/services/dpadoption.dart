import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocProvider(
      create: (context) => DpadOptionBloc(),
      child: DpadOptionBuilder(
        onSelect: onSelect,
        onFocus: onFocus,
        child: child,
      ),
    );
  }
}

class DpadOptionBuilder extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<DpadOptionBloc>(context);

    return BlocListener<DpadOptionBloc, DpadOptionState>(
      listener: (context, state) {
        if (state is DpadOptionFocused) {
          onFocus(state.isFocused);
        }
      },
      child: KeyboardListener(
        focusNode: bloc.focusNode,
        onKeyEvent: (KeyEvent event) {
          if (event is KeyDownEvent) {
            final label = event.logicalKey.keyLabel;

            if (label == keyCenter) {
              onSelect();
            }
          } else {
            bloc.toggleFocus();
          }
        },
        child: child,
      ),
    );
  }
}

class DpadOptionBloc extends Cubit<DpadOptionState> {
  DpadOptionBloc() : super(const DpadOptionUnfocused());

  final FocusNode focusNode = FocusNode();

  void toggleFocus() {
    focusNode.requestFocus();
    emit(state.isFocused
        ? const DpadOptionUnfocused()
        : const DpadOptionFocused());
  }
}

abstract class DpadOptionState {
  const DpadOptionState();

  bool get isFocused => false;
}

class DpadOptionFocused extends DpadOptionState {
  const DpadOptionFocused();

  @override
  bool get isFocused => true;
}

class DpadOptionUnfocused extends DpadOptionState {
  const DpadOptionUnfocused();
}
