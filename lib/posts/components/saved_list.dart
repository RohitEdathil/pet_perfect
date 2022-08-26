import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_perfect/woof/model/woof_bloc.dart';
import 'package:pet_perfect/woof/model/woof_events.dart';

class SavedList extends StatefulWidget {
  const SavedList({Key? key}) : super(key: key);

  @override
  State<SavedList> createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<WoofBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved'),
        centerTitle: true,
        backgroundColor: Theme.of(context).canvasColor,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(children: [
        for (final url in bloc.saved!)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: SelectableText(url as String),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      bloc.add(DeleteWoofEvent(url: url));
                    });
                  },
                ),
              ),
            ),
          )
      ]),
    );
  }
}
