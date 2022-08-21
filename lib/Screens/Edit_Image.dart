import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_editor/models/text_info.dart';
import 'package:image_editor/widgets/image_texts.dart';

import '../widgets/edit_image_view_model.dart';
import 'package:screenshot/screenshot.dart';

class EditImageScreen extends StatefulWidget {
  final String selectedImage;
  const EditImageScreen({Key? key,
  required this.selectedImage}) : super(key: key);

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends EditImageViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Screenshot(
        controller: screenshotController ,
          child : SafeArea(
        child : SizedBox(
          height : MediaQuery.of(context).size.height*0.3,
          child: Stack(
             children : [
               _selectedImage,
               for (int i = 0; i < texts.length ; i++)
                 Positioned(
                   left: texts[i].left,
                   top : texts[i].top ,
                   child : GestureDetector(
                     onLongPress: () {
                       setState(() {
                         currentIndex  = i;
                         removeText(context);
                       });
                     },
                     onTap: () => setCurrentIndex(context,i),
                     child: Draggable(
                       feedback: ImageText(textInfo : (texts[i] as TextInfo)),
                       child : ImageText(textInfo : (texts[i] as TextInfo)),
                       onDragEnd: (drag) {
                         final renderBox = context.findRenderObject() as RenderBox;
                         Offset off = renderBox.globalToLocal(drag.offset);
                         setState(() {
                           texts[i].top = off.dy-96;
                           texts[i].left = off.dx;



                         });
                       },
                     ),
                   )
                 ),
               creatorText.text.isNotEmpty ? Positioned(
                 left : 0 , bottom : 0 , child : Text(creatorText.text ,
               style : TextStyle(
                 fontSize: 20,
                 fontWeight : FontWeight.bold,
                 color : Colors.black.withOpacity(0.3)
               ))
               ):
                   const SizedBox.shrink(),
             ]
          ),
        )
      )),
      floatingActionButton: _addNewText,
    );
  }
  Widget get _selectedImage => Center(
    child: Image.file(File(widget.selectedImage),fit: BoxFit.fill,
    width : MediaQuery.of(context).size.width)
  );
  Widget get _addNewText => FloatingActionButton(
        onPressed : () => addNewDialog(context),
        backgroundColor: Colors.blue,
        tooltip: 'Add New Text',
        child : Icon(
          Icons.edit,
          color: Colors.white
        )


  );

  AppBar get _appBar => AppBar(
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    title : SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children : [
          IconButton(
            icon: Icon(Icons.save , color : Colors.purpleAccent),
            onPressed: () => saveToGallery(context) ,
            tooltip: 'Save Image',
          ),
          IconButton(
            icon: Icon(Icons.add , color : Colors.purpleAccent),
            onPressed: increaseFontSize,
            tooltip: 'Increase Font Size',
          ),
          IconButton(
            icon: Icon(Icons.remove , color : Colors.purpleAccent),
            onPressed: decreaseFontSize ,
            tooltip: 'Decrease Font Size',
          ),
          IconButton(
            icon: Icon(Icons.format_align_left , color : Colors.purpleAccent),
            onPressed: alignLeft ,
            tooltip: 'Align Left',
          ),
          IconButton(
            icon: Icon(Icons.format_align_center , color : Colors.purpleAccent),
            onPressed: alignCenter,
            tooltip: 'Align Center',
          ),
          IconButton(
            icon: Icon(Icons.format_align_right , color : Colors.purpleAccent),
            onPressed: alignLeft ,
            tooltip: 'Align Right',
          ),
          IconButton(
            icon: Icon(Icons.format_bold , color : Colors.purpleAccent),
            onPressed: boldText ,
            tooltip: 'Bold',
          ),
          IconButton(
            icon: Icon(Icons.format_italic , color : Colors.purpleAccent),
            onPressed: ItalicText ,
            tooltip: 'Italic',
          ),
          IconButton(
            icon: Icon(Icons.space_bar , color : Colors.purpleAccent),
            onPressed: addLinesText ,
            tooltip: 'Add New Line ',
          ),
          Tooltip(
            message: 'Red',
            child : GestureDetector(
              onTap : () => changeTextColor(Colors.red),
              child : const CircleAvatar(
                backgroundColor: Colors.red,
              )
            )
          ),
          SizedBox( width : 5),
          Tooltip(
              message: 'Orange',
              child : GestureDetector(
                  onTap : () => changeTextColor(Colors.deepOrange),
                  child : const CircleAvatar(
                    backgroundColor: Colors.deepOrange,
                  )
              )
          ),
          SizedBox( width : 5),
          Tooltip(
              message: 'White',
              child : GestureDetector(
                  onTap : () => changeTextColor(Colors.white),
                  child : const CircleAvatar(
                    backgroundColor: Colors.white,
                  )
              )
          ),
          SizedBox( width : 5),
          Tooltip(
              message: 'Blue',
              child : GestureDetector(
                  onTap : () => changeTextColor(Colors.blue),
                  child : const CircleAvatar(
                    backgroundColor: Colors.blue,
                  )
              )
          ),
          SizedBox( width : 5),
          Tooltip(
              message: 'Yellow',
              child : GestureDetector(
                  onTap : changeTextColor(Colors.yellow),
                  child : const CircleAvatar(
                    backgroundColor: Colors.yellow,
                  )
              )
          ),
          SizedBox( width : 5),
          Tooltip(
              message: 'Green',
              child : GestureDetector(
                  onTap : () => changeTextColor(Colors.green),
                  child : const CircleAvatar(
                    backgroundColor: Colors.green,
                  )
              )
          ),
          SizedBox( width : 5),
          Tooltip(
              message: 'Pink',
              child : GestureDetector(
                  onTap : changeTextColor(Colors.pink),
                  child : const CircleAvatar(
                    backgroundColor: Colors.pink,
                  )
              )
          ),
          SizedBox( width : 5),
          Tooltip(
              message: 'Black',
              child : GestureDetector(
                  onTap : () => changeTextColor(Colors.black),
                  child : const CircleAvatar(
                    backgroundColor: Colors.black,
                  )
              )
          ),
          SizedBox( width : 5)
        ]
      ),
    )
  );
}
