import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:dwyl_app/presentation/widgets/editor/emoji_picker_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/extensions.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

import 'web_embeds/web_embeds.dart';

const quillEditorKey = Key('quillEditorKey');
const emojiButtonKey = Key('emojiButtonKey');

/// Types of selection that person can make when triple clicking
enum _SelectionType {
  none,
  word,
}

/// Home page with the `flutter-quill` editor
class DeltaTodoEditor extends StatefulWidget {
  final bool isWeb;

  const DeltaTodoEditor({
    required this.isWeb,
    super.key,
  });

  @override
  DeltaTodoEditorState createState() => DeltaTodoEditorState();
}

class DeltaTodoEditorState extends State<DeltaTodoEditor> {
  /// `flutter-quill` editor controller
  QuillController? _controller;

  /// Focus node used to obtain keyboard focus and events
  final FocusNode _focusNode = FocusNode();

  /// Selection types for triple clicking
  _SelectionType _selectionType = _SelectionType.none;

  /// Show emoji picker
  bool _offstageEmojiPickerOffstage = true;

  @override
  void initState() {
    super.initState();
    _initializeText();
  }

  /// Initializing the [Delta](https://quilljs.com/docs/delta/) document with sample text.
  Future<void> _initializeText() async {
    // final doc = Document()..insert(0, 'Just a friendly empty text :)');
    final doc = Document();
    setState(() {
      _controller = QuillController(
        document: doc,
        selection: const TextSelection.collapsed(offset: 0),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Loading widget if controller's not loaded
    if (_controller == null) {
      return const Center(child: Text('Loading editor..'));
    }

    /// Returning scaffold with editor as body
    return _buildEditor(context);
  }

  /// Callback called whenever the person taps on the text.
  /// It will select nothing, then the word if another tap is detected
  /// and then the whole text if another tap is detected (triple).
  bool _onTripleClickSelection() {
    final controller = _controller!;

    // If nothing is selected, selection type is `none`
    if (controller.selection.isCollapsed) {
      _selectionType = _SelectionType.none;
    }

    // If nothing is selected, selection type becomes `word
    if (_selectionType == _SelectionType.none) {
      _selectionType = _SelectionType.word;
      return false;
    }

    // If the word is selected, select all text
    if (_selectionType == _SelectionType.word) {
      final child = controller.document.queryChild(
        controller.selection.baseOffset,
      );
      final offset = child.node?.documentOffset ?? 0;
      final length = child.node?.length ?? 0;

      final selection = TextSelection(
        baseOffset: offset,
        extentOffset: offset + length,
      );

      // Select all text and make next selection to `none`
      controller.updateSelection(selection, ChangeSource.REMOTE);

      _selectionType = _SelectionType.none;

      return true;
    }

    return false;
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

  /// Build the `flutter-quill` editor to be shown on screen.
  Widget _buildEditor(BuildContext context) {
    // Default editor (for mobile devices)
    Widget quillEditor = QuillEditor(
      controller: _controller!,
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
      onTapUp: (details, p1) {
        return _onTripleClickSelection();
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
        controller: _controller!,
        scrollController: ScrollController(),
        scrollable: true,
        focusNode: _focusNode,
        autoFocus: false,
        readOnly: false,
        placeholder: 'Add content',
        expands: false,
        padding: const EdgeInsets.only(top: 16.0),
        onTapUp: (details, p1) {
          return _onTripleClickSelection();
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
      onImagePickCallback: _onImagePickCallback,

      // `webImagePickImpl` is called after image is picked on the web
      webImagePickImpl: _webImagePickImpl,

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
          controller: _controller!,
          undo: true,
        ),
        HistoryButton(
          icon: Icons.redo_outlined,
          iconSize: toolbarIconSize,
          controller: _controller!,
          undo: false,
        ),
        SelectHeaderStyleButton(
          controller: _controller!,
          axis: Axis.horizontal,
          iconSize: toolbarIconSize,
          attributes: const [Attribute.h1, Attribute.h2, Attribute.h3],
        ),
        ToggleStyleButton(
          attribute: Attribute.bold,
          icon: Icons.format_bold,
          iconSize: toolbarIconSize,
          controller: _controller!,
        ),
        ToggleStyleButton(
          attribute: Attribute.italic,
          icon: Icons.format_italic,
          iconSize: toolbarIconSize,
          controller: _controller!,
        ),
        ToggleStyleButton(
          attribute: Attribute.underline,
          icon: Icons.format_underline,
          iconSize: toolbarIconSize,
          controller: _controller!,
        ),
        ToggleStyleButton(
          attribute: Attribute.strikeThrough,
          icon: Icons.format_strikethrough,
          iconSize: toolbarIconSize,
          controller: _controller!,
        ),
        LinkStyleButton(
          controller: _controller!,
          iconSize: toolbarIconSize,
          linkRegExp: RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+'),
        ),
        for (final builder in embedButtons) builder(_controller!, toolbarIconSize, null, null),
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
              key: quillEditorKey,
              color: Colors.white,
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: quillEditor,
            ),
          ),
          Container(child: toolbar),
          OffstageEmojiPicker(
            offstageEmojiPicker: _offstageEmojiPickerOffstage,
            quillController: _controller,
          ),
        ],
      ),
    );
  }

  /// Renders the image picked by imagePicker from local file storage
  /// You can also upload the picked image to any server (eg : AWS s3
  /// or Firebase) and then return the uploaded image URL.
  ///
  /// It's only called on mobile platforms.
  Future<String> _onImagePickCallback(File file) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final copiedFile = await file.copy('${appDocDir.path}/${basename(file.path)}');
    return copiedFile.path.toString();
  }

  /// Callback that is called after an image is picked whilst on the web platform.
  /// Returns the URL of the image.
  /// Returns null if an error occurred uploading the file or the image was not picked.
  Future<String?> _webImagePickImpl(OnImagePickCallback onImagePickCallback) async {
    // Lets the user pick one file; files with any file extension can be selected
    final result = await ImageFilePicker().pickImage();

    // The result will be null, if the user aborted the dialog
    if (result == null || result.files.isEmpty) {
      return null;
    }

    // Read file as bytes (https://github.com/miguelpruivo/flutter_file_picker/wiki/FAQ#q-how-do-i-access-the-path-on-web)
    final platformFile = result.files.first;
    final bytes = platformFile.bytes;

    if (bytes == null) {
      return null;
    }

    // Make HTTP request to upload the image to the file
    const apiURL = 'https://imgup.fly.dev/api/images';
    final request = http.MultipartRequest('POST', Uri.parse(apiURL));

    final httpImage = http.MultipartFile.fromBytes(
      'image',
      bytes,
      contentType: MediaType.parse(lookupMimeType('', headerBytes: bytes)!),
      filename: platformFile.name,
    );
    request.files.add(httpImage);

    // Check the response and handle accordingly
    return http.Client().send(request).then((response) async {
      if (response.statusCode != 200) {
        return null;
      }

      final responseStream = await http.Response.fromStream(response);
      final responseData = json.decode(responseStream.body);
      return responseData['url'];
    });
  }
}

// coverage:ignore-start
/// Image file picker wrapper class
class ImageFilePicker {
  Future<FilePickerResult?> pickImage() => FilePicker.platform.pickFiles(type: FileType.image);
}
// coverage:ignore-end
