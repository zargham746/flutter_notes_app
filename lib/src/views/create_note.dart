import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_inkflow_app/src/model/note.dart';
import 'package:flutter_inkflow_app/src/res/assets.dart';
import 'package:flutter_inkflow_app/src/services/local_db.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isar/isar.dart';
import 'package:lottie/lottie.dart';

class CreateNoteView extends StatefulWidget {
  static const String routeName = '/create-note';

  final Note? note;
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const CreateNoteView(),
    );
  }

  const CreateNoteView({
    super.key,
    this.note,
  });

  @override
  State<CreateNoteView> createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {
  // Controllers for data Entry
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  // A local DB insance
  final localDB = LocalDBService();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      titleController.text = widget.note!.title;
      descriptionController.text = widget.note!.description;
    }
  }

  @override
  void dispose() {
    super.dispose();
    // Just Printing the Value of controllers in logs
    log(titleController.text);
    log(descriptionController.text);
    // Converting controller data to text
    final title = titleController.text;
    final description = descriptionController.text;


    if (widget.note != null) {
      if (title.isEmpty && description.isEmpty) {
        localDB.deleteNote(id: widget.note!.id);
      } else if (widget.note!.title != title ||
          widget.note!.description != description) {
        final newNote = widget.note!.copyWith(
          title: title,
          description: description,
        );
        localDB.saveNote(note: newNote);
      }
    } else if (title.isNotEmpty || description.isNotEmpty) {
      final newNote = Note(
          id: Isar.autoIncrement,
          title: title,
          description: description,
          lastModified: DateTime.now());
      localDB.saveNote(note: newNote);
    }

    // Adding controllers data to Note Model for saving

    // Disposing the controllers to avoid memory leaks
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 24.sp,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        actions: [
          widget.note != null
              ? IconButton(
                  onPressed: () {
                    // Show dialog
                    showDialog(
                        barrierColor: Colors.black45,
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                            surfaceTintColor: Colors.transparent,
                            title: Text(
                              'Delete Note',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  20.r,
                                ),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Lottie.asset(
                                  AnimationAssets.delete,
                                ),
                                Text(
                                  'This note will be permanently deleted.',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )
                              ],
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey[600],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      'Cancel',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Delete the note
                                      localDB.deleteNote(
                                        id: widget.note!.id,
                                      );
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      'Delete',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        });
                  },
                  icon: Icon(
                    Icons.delete,
                    size: 24.sp,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextFormField(
                maxLines: null,
                controller: titleController,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(),
                cursorColor: Theme.of(context).colorScheme.onPrimary,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.grey[500],
                        fontSize: 28.sp,
                      ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextFormField(
                maxLines: null,
                controller: descriptionController,
                style: Theme.of(context).textTheme.bodyMedium,
                cursorColor: Theme.of(context).colorScheme.onPrimary,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Description',
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.grey[500],
                        fontSize: 22.sp,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
