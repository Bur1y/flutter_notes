import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/** 25.07.2023 Bur1y
 * Main menu screen
 *
 *
 */

class main_menu extends StatelessWidget {
  const main_menu({super.key});

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
        body: SafeArea(
          top: false,
          bottom: false,
          child: Builder(
            builder: (BuildContext context) {

              return CustomScrollView(
                slivers: <Widget>[
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: SliverFixedExtentList(
                      itemExtent: 80.0,
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return _noteCard();
                        },
                        childCount: 10,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: _floatingButton(),
    );
  }
}

// Card view
class _noteCard extends StatelessWidget {

  const _noteCard( {
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

// Float button
class _floatingButton extends StatelessWidget {
  const _floatingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        // Navigator.push(context,
        //     MaterialPageRoute<Widget>(builder: (BuildContext context) {
        //       return edit_note();
        //       }));
      },
      backgroundColor: Colors.redAccent,
      child: const Icon(
        Icons.note_add_outlined,
        size: 28,
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
