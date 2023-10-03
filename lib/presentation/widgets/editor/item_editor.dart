import 'dart:async';
import 'dart:ui';

import 'package:dwyl_app/presentation/widgets/editor/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/extensions.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:http/http.dart' as http;

import 'image_callbacks.dart';
import 'web_embeds/web_embeds.dart';

const quillEditorKey = Key('quillEditorKey');
const emojiButtonKey = Key('emojiButtonKey');

/// Home page with the `flutter-quill` editor
class DeltaTodoEditor extends StatefulWidget {
  /// Is the platform web-based?
  final bool isWeb;

  /// Editor controller. Must be a `QuillController` object.
  final QuillController editorController;

  const DeltaTodoEditor({
    required this.isWeb,
    required this.editorController,
    super.key,
  });

  @override
  DeltaTodoEditorState createState() => DeltaTodoEditorState();
}

class DeltaTodoEditorState extends State<DeltaTodoEditor> {
  /// Focus node used to obtain keyboard focus and events
  final FocusNode _focusNode = FocusNode();

  /// Show emoji picker
  bool _offstageEmojiPickerOffstage = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Default editor (for mobile devices)
    Widget quillEditor = QuillEditor(
      key: quillEditorKey,
      controller: widget.editorController,
      scrollController: ScrollController(),
      scrollable: true,
      focusNode: _focusNode,
      autoFocus: false,
      readOnly: false,
      placeholder: 'Write what\'s on your mind.',
      enableSelectionToolbar: isMobile(),
      expands: false,
      padding: const EdgeInsets.only(top: 16.0),
      onTapDown: (details, p1) {
        // When the person taps on the text, we want to hide the emoji picker
        // so only the keyboard is shown
        setState(() {
          _offstageEmojiPickerOffstage = true;
        });
        return false;
      },
      customStyles: DefaultStyles(
        h1: DefaultTextBlockStyle(
          const TextStyle(
            fontSize: 32,
            color: Colors.black,
            height: 1.15,
            fontWeight: FontWeight.w600,
          ),
          const VerticalSpacing(16, 0),
          const VerticalSpacing(0, 0),
          null,
        ),
        h2: DefaultTextBlockStyle(
          const TextStyle(
            fontSize: 24,
            color: Colors.black87,
            height: 1.15,
            fontWeight: FontWeight.w600,
          ),
          const VerticalSpacing(8, 0),
          const VerticalSpacing(0, 0),
          null,
        ),
        h3: DefaultTextBlockStyle(
          const TextStyle(
            fontSize: 20,
            color: Colors.black87,
            height: 1.25,
            fontWeight: FontWeight.w600,
          ),
          const VerticalSpacing(8, 0),
          const VerticalSpacing(0, 0),
          null,
        ),
        sizeSmall: const TextStyle(fontSize: 9),
        subscript: const TextStyle(
          fontFamily: 'SF-UI-Display',
          fontFeatures: [FontFeature.subscripts()],
        ),
        superscript: const TextStyle(
          fontFamily: 'SF-UI-Display',
          fontFeatures: [FontFeature.superscripts()],
        ),
      ),
      embedBuilders: [...FlutterQuillEmbeds.builders()],
    );

    // Alternatively, the web editor version is shown  (with the web embeds)
    if (widget.isWeb) {
      quillEditor = QuillEditor(
        controller: widget.editorController,
        scrollController: ScrollController(),
        scrollable: true,
        focusNode: _focusNode,
        autoFocus: false,
        readOnly: false,
        placeholder: 'Add content',
        expands: false,
        padding: const EdgeInsets.only(top: 16.0),
        customStyles: DefaultStyles(
          h1: DefaultTextBlockStyle(
            const TextStyle(
              fontSize: 32,
              color: Colors.black,
              height: 1.15,
              fontWeight: FontWeight.w600,
            ),
            const VerticalSpacing(16, 0),
            const VerticalSpacing(0, 0),
            null,
          ),
          h2: DefaultTextBlockStyle(
            const TextStyle(
              fontSize: 24,
              color: Colors.black87,
              height: 1.15,
              fontWeight: FontWeight.w600,
            ),
            const VerticalSpacing(8, 0),
            const VerticalSpacing(0, 0),
            null,
          ),
          h3: DefaultTextBlockStyle(
            const TextStyle(
              fontSize: 20,
              color: Colors.black87,
              height: 1.25,
              fontWeight: FontWeight.w600,
            ),
            const VerticalSpacing(8, 0),
            const VerticalSpacing(0, 0),
            null,
          ),
          sizeSmall: const TextStyle(fontSize: 9),
        ),
        embedBuilders: [...defaultEmbedBuildersWeb],
      );
    }

    // Toolbar definitions
    const toolbarIconSize = 18.0;
    final embedButtons = FlutterQuillEmbeds.buttons(
      // Showing only necessary default buttons
      showCameraButton: false,
      showFormulaButton: false,
      showVideoButton: false,
      showImageButton: true,

      // `onImagePickCallback` is called after image is picked on mobile platforms
      onImagePickCallback: onImagePickCallback,

      // `webImagePickImpl` is called after image is picked on the web
      webImagePickImpl: (onImagePickCallback) => webImagePickImpl(http.Client(), ImageFilePicker(), onImagePickCallback),

      // defining the selector (we only want to open the gallery whenever the person wants to upload an image)
      mediaPickSettingSelector: (context) {
        return Future.value(MediaPickSetting.Gallery);
      },
    );

    // Instantiating the toolbar
    final toolbar = QuillToolbar(
      afterButtonPressed: _focusNode.requestFocus,
      multiRowsDisplay: false,
      children: [
        CustomButton(
          key: emojiButtonKey,
          onPressed: () => _onEmojiButtonPressed(context),
          icon: Icons.emoji_emotions,
          iconSize: toolbarIconSize,
        ),
        HistoryButton(
          icon: Icons.undo_outlined,
          iconSize: toolbarIconSize,
          controller: widget.editorController,
          undo: true,
        ),
        HistoryButton(
          icon: Icons.redo_outlined,
          iconSize: toolbarIconSize,
          controller: widget.editorController,
          undo: false,
        ),
        SelectHeaderStyleButton(
          controller: widget.editorController,
          axis: Axis.horizontal,
          iconSize: toolbarIconSize,
          attributes: const [Attribute.h1, Attribute.h2, Attribute.h3],
        ),
        ToggleStyleButton(
          attribute: Attribute.bold,
          icon: Icons.format_bold,
          iconSize: toolbarIconSize,
          controller: widget.editorController,
        ),
        ToggleStyleButton(
          attribute: Attribute.italic,
          icon: Icons.format_italic,
          iconSize: toolbarIconSize,
          controller: widget.editorController,
        ),
        ToggleStyleButton(
          attribute: Attribute.underline,
          icon: Icons.format_underline,
          iconSize: toolbarIconSize,
          controller: widget.editorController,
        ),
        ToggleStyleButton(
          attribute: Attribute.strikeThrough,
          icon: Icons.format_strikethrough,
          iconSize: toolbarIconSize,
          controller: widget.editorController,
        ),
        LinkStyleButton(
          controller: widget.editorController,
          iconSize: toolbarIconSize,
          linkRegExp: RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+'),
        ),
        for (final builder in embedButtons) builder(widget.editorController, toolbarIconSize, null, null),
      ],
    );

    // Rendering the final editor + toolbar
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 15,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: quillEditor,
            ),
          ),
          Container(child: toolbar),
          OffstageEmojiPicker(
            offstageEmojiPicker: _offstageEmojiPickerOffstage,
            editorController: widget.editorController,
          ),
        ],
      ),
    );
  }

  /// Callback called whenever the person taps on the emoji button in the toolbar.
  /// It shows/hides the emoji picker and focus/unfocusses the keyboard accordingly.
  void _onEmojiButtonPressed(BuildContext context) {
    final isEmojiPickerShown = !_offstageEmojiPickerOffstage;

    // If emoji picker is being shown, we show the keyboard and hide the emoji picker.
    if (isEmojiPickerShown) {
      _focusNode.requestFocus();
      setState(() {
        _offstageEmojiPickerOffstage = true;
      });
    }

    // Otherwise, we do the inverse.
    else {
      // Unfocusing when the person clicks away. This is to hide the keyboard.
      // See https://flutterigniter.com/dismiss-keyboard-form-lose-focus/
      // and https://www.youtube.com/watch?v=MKrEJtheGPk&t=40s&ab_channel=HeyFlutter%E2%80%A4com.
      final currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        //currentFocus.unfocus();
      }

      setState(() {
        _offstageEmojiPickerOffstage = false;
      });
    }
  }
}
