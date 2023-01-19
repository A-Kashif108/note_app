import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/services/note_service.dart';

class NoteViewPage extends StatelessWidget {
  const NoteViewPage({super.key, this.note});
  final Note? note;
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: note?.heading);
    TextEditingController contentController =
        TextEditingController(text: note?.content);
    final noteService = NoteService();
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(149, 109, 109, 109),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          CupertinoIcons.back,
                          size: 20,
                        )),
                  ),
                  Row(
                    children: [
                      note == null
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.center,
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(149, 109, 109, 109),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: IconButton(
                                    onPressed: () async {
                                      await noteService
                                          .pinNote(
                                              note!.id.toString(), !note!.isPin)
                                          .then((value) =>
                                              Navigator.pop(context));
                                    },
                                    icon: Icon(
                                      note!.isPin
                                          ? CupertinoIcons.pin_fill
                                          : CupertinoIcons.pin,
                                      size: 20,
                                    )),
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(149, 109, 109, 109),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                              onPressed: () async {
                                await noteService
                                    .deleteNote(note!.id.toString())
                                    .then((value) => Navigator.pop(context));
                              },
                              icon: const Icon(
                                CupertinoIcons.delete,
                                size: 20,
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(149, 109, 109, 109),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                              onPressed: () async {
                                if (titleController.text == "") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("Please Add Title")));
                                  return;
                                }
                                if (contentController.text == "") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("Type Something in body")));
                                  return;
                                }

                                if (note == null) {
                                  await noteService
                                      .postNote(titleController.text,
                                          contentController.text)
                                      .then((response) {
                                    Navigator.pop(context);
                                  });
                                } else {
                                  await noteService
                                      .updateNote(
                                          note!.id.toString(),
                                          titleController.text,
                                          contentController.text)
                                      .then((v) => Navigator.pop(context));
                                }
                              },
                              icon: const Icon(
                                Icons.done,
                                size: 20,
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                constraints: const BoxConstraints(maxHeight: 150),
                child: TextField(
                  controller: titleController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Title",
                  ),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  DateFormat.yMMMMd('en_US')
                      .format(note == null ? DateTime.now() : note!.lastEdit),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: contentController,
                maxLines: null,
                style: const TextStyle(
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.7)),
                    hintText: "Start Typing..."),
              ),
            )),
          ],
        ),
      )),
    );
  }
}
