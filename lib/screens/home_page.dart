import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:note_app/blocs/note/note_bloc.dart';
import 'package:note_app/screens/note_page.dart';
import 'package:note_app/utils/color_combination.dart';
import '../model/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [];
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<NoteBloc>(context).add(GetAllNotes());
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Notes",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(149, 109, 109, 109),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            size: 20,
                          )),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<NoteBloc, NoteState>(
                builder: (context, state) {
                  if (state is NoteLoading) {
                    print('loading');
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is NoteLoaded) {
                    List<Note> notes = state.notes;
                    double h1 = 0;
                    double h2 = 0;
                    bool toggle = false;
                    bool full = false;
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: StaggeredGrid.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          children: List.generate(notes.length, (index) {
                            if ((h1 == h2 && h1 != 0) && !full) {
                              full = true;
                              h1 = h1 + 1;
                              h2 = h2 + 1;
                            } else {
                              full = false;
                              if (toggle) {
                                if (notes[index].heading.length > 55) {
                                  h2 = h2 + 1.5;
                                } else {
                                  h2 = h2 + 1;
                                }
                                toggle = false;
                              } else {
                                if (notes[index].heading.length > 55) {
                                  h1 = h1 + 1.5;
                                } else {
                                  h1 = h1 + 1;
                                }
                                toggle = true;
                              }
                            }
                            print(notes[index]);
                            return StaggeredGridTile.count(
                              crossAxisCellCount: full ? 2 : 1,
                              mainAxisCellCount:
                                  notes[index].heading.length > 55 ? 1.5 : 1,
                              child: InkWell(
                                onTap: (() {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        NoteViewPage(note: notes[index]),
                                  ));
                                }),
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 20, 15, 20),
                                  alignment: Alignment.topLeft,
                                  decoration: BoxDecoration(
                                      color: Color(notes[index].primary),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          notes[index].heading,
                                          style: TextStyle(
                                              color:
                                                  Color(notes[index].secondary),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Text(
                                        DateFormat.yMMMMd('en_US')
                                            .format(notes[index].lastEdit),
                                        style: TextStyle(
                                          color: Color(notes[index].secondary)
                                              .withOpacity(0.7),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    );
                  }
                  return Container(
                    child: Text('error'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const NoteViewPage(),
          ));
        },
        child: const Icon(Icons.add, size: 25),
      ),
    );
  }
}
