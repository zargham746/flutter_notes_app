import 'package:flutter/material.dart';
import 'package:flutter_inkflow_app/src/model/note.dart';
import 'package:flutter_inkflow_app/src/res/strings.dart';
import 'package:flutter_inkflow_app/src/services/local_db.dart';
import 'package:flutter_inkflow_app/src/views/create_note.dart';
import 'package:flutter_inkflow_app/src/views/widgets/empty_view.dart';
import 'package:flutter_inkflow_app/src/views/widgets/main_drawer.dart';
import 'package:flutter_inkflow_app/src/views/widgets/notes_grid.dart';
import 'package:flutter_inkflow_app/src/views/widgets/notes_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatefulWidget {
  static const String routeName = '/home-view';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const HomeView(),
    );
  }

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  bool isListView = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      drawer: const MainDrawer(),
      appBar: AppBar(
        // Drawer Button
        leading: IconButton(
          onPressed: () {
            _scaffoldkey.currentState!.openDrawer();
          },
          icon: Icon(
            Icons.menu,
            size: 24.sp,
          ),
        ),
        title: Text(
          AppStrings.appName,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(
                () {
                  isListView = !isListView;
                },
              );
            },
            icon: Icon(
              isListView
                  ? Icons.splitscreen_outlined
                  : Icons.grid_view_outlined,
              size: 24.sp,
            ),
          ),
        ],
      ),
      body: 
      StreamBuilder<List<Note>>(
          stream: LocalDBService().listenAllNotes(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const EmptyView();
            } else {
              final notes = snapshot.data!;

              return AnimatedSwitcher(
                duration: const Duration(
                  milliseconds: 600,
                ),
                child: isListView
                    ? NotesList(notes: notes)
                    : NotesGrid(notes: notes),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            CreateNoteView.routeName,
          );
        },
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        child: Icon(
          Icons.add,
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
    );
  }
}
