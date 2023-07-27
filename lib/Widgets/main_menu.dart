import 'package:flutter/material.dart';
import 'package:flutter_notes/Database/Database_helper.dart';

class main_menu extends StatefulWidget {
  const main_menu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<main_menu> {
  List<Map<String, dynamic>> myData = [];
  final formKey = GlobalKey<FormState>();

  bool _isLoading = true;

  void _refreshData() async {
    final data = await DatabaseHelper.getNotes();
    setState(() {
      myData = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> addNote() async {
    await DatabaseHelper.createNote(
        _titleController.text, _descriptionController.text);
    _refreshData();
  }

  // Update an existing data
  Future<void> updateItem(int id) async {
    await DatabaseHelper.updateNote(
        id, _titleController.text, _descriptionController.text);
    _refreshData();
  }

  // Delete an item
  void deleteItem(int id) async {
    await DatabaseHelper.deleteNote(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Successfully deleted!', style: TextStyle(color: Colors.white),), backgroundColor: Colors.black54));
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          // These are the slivers that show up in the "outer" scroll view.
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                centerTitle: true,
                pinned: true,
                expandedHeight: 350.0,
                forceElevated: innerBoxIsScrolled,
                flexibleSpace: FlexibleSpaceBar(
                  expandedTitleScale: 1,
                  title: _safeAreaBarButtons(),
                  background: _safeAreaTitle(),
                ),
              ),
            ),
          ];
        },
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : myData.isEmpty
                ? const Center(child: Text("No Data Available"))
                : Container( padding: const EdgeInsets.all(8.0),
                  margin: EdgeInsets.only(top: 50),
                  child: Container(
                    child: ListView.builder(
                        itemCount: myData.length,
                        itemBuilder: (context, index) => Card(
                          color: index % 2 == 0 ? Colors.black54: Colors.black87,
                          child: Dismissible(
                            key: UniqueKey(),
                            background: Container(color: Colors.redAccent),
                            onDismissed: (direction) {
                              deleteItem(myData[index]['id']);
                            },
                            child: ListTile(
                              leading: FlutterLogo(size: 56.0),
                              title: Text(myData[index]['title']),
                              subtitle: Text(myData[index]['createdAt']),
                              onTap: () {
                                // Navigator.push(context,
                                //     MaterialPageRoute<Widget>(builder: (BuildContext context) {
                                //
                                //       return edit_note();
                                //     }
                                //     )
                                // );
                              },
                            ),
                          ),
                        ),
                      ),
                  ),
                ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(context,
          //     MaterialPageRoute<Widget>(builder: (BuildContext context) {
          //       return edit_note();
          //       }));
          print("КНОПКА НАЖАЛА");
          addNote();
        },
        backgroundColor: Colors.redAccent,
        child: const Icon(
          Icons.note_add_outlined,
          size: 28,
        ),
      ),
    );
  }
}

// Card view
class _noteCard extends StatelessWidget {
  const _noteCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: FlutterLogo(size: 56.0),
        title: Text('Title'),
        subtitle: Text('Date create'),
        onTap: () {
          // Navigator.push(context,
          //     MaterialPageRoute<Widget>(builder: (BuildContext context) {
          //
          //       return edit_note();
          //     }));
        },
      ),
    );
  }
}

// Area title SliverAppBar
class _safeAreaTitle extends StatelessWidget {
  const _safeAreaTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "All Notes",
            style: TextStyle(fontSize: 36),
          ),
          Text(
            "29 Notes",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

// Area AppBar buttons
class _safeAreaBarButtons extends StatelessWidget {
  const _safeAreaBarButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          iconSize: 24,
          icon: const Icon(Icons.picture_as_pdf_outlined),
          onPressed: () {},
        ),
        IconButton(
          iconSize: 24,
          icon: const Icon(Icons.find_in_page_outlined),
          onPressed: () {},
        ),
        IconButton(
          iconSize: 24,
          icon: const Icon(Icons.more_vert_outlined),
          onPressed: () {},
        ),
      ],
    ));
  }
}
