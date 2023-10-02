import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:responsive_framework/responsive_framework.dart';

const emojiPickerWidgetKey = Key('emojiPickerWidgetKey');

/// Emoji picker widget that is offstage.
/// Shows an emoji picker when [offstageEmojiPicker] is `false`.
class OffstageEmojiPicker extends StatefulWidget {
  /// `QuillController` controller that is passed so the controller document is changed when emojis are inserted.
  final QuillController? editorController;

  /// Determines if the emoji picker is offstage or not.
  final bool offstageEmojiPicker;

  const OffstageEmojiPicker({required this.offstageEmojiPicker, this.editorController, super.key});

  @override
  State<OffstageEmojiPicker> createState() => _OffstageEmojiPickerState();
}

class _OffstageEmojiPickerState extends State<OffstageEmojiPicker> {
  /// Returns the emoji picker configuration according to screen size.
  Config _buildEmojiPickerConfig(BuildContext context) {
    if (ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE)) {
      return const Config(emojiSizeMax: 32.0, columns: 7);
    }

    if (ResponsiveBreakpoints.of(context).equals(TABLET)) {
      return const Config(emojiSizeMax: 24.0, columns: 10);
    }

    if (ResponsiveBreakpoints.of(context).equals(DESKTOP)) {
      return const Config(emojiSizeMax: 16.0, columns: 15);
    }

    return const Config(emojiSizeMax: 16.0, columns: 30);
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: widget.offstageEmojiPicker,
      child: SizedBox(
        height: 250,
        child: EmojiPicker(
          key: emojiPickerWidgetKey,
          onEmojiSelected: (category, emoji) {
            if (widget.editorController != null) {
              // Get pointer selection and insert emoji there
              final selection = widget.editorController?.selection;
              widget.editorController?.document.insert(selection!.end, emoji.emoji);

              // Update the pointer after the emoji we've just inserted
              widget.editorController?.updateSelection(TextSelection.collapsed(offset: selection!.end + emoji.emoji.length), ChangeSource.REMOTE);
            }
          },
          config: _buildEmojiPickerConfig(context),
        ),
      ),
    );
  }
}
