import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _titleTEC = TextEditingController();
  final TextEditingController _descriptionTEC = TextEditingController();
  final TextEditingController _daysTEC = TextEditingController();

  List<Task> lists = [];

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Task Manager'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return InkWell(
            onLongPress: () {
              onTaskLongPress(context, index);
            },
            child: ListTile(
              title: Text(lists[index].title),
              subtitle: Text(lists[index].desc),
            ),
          );
        },
        itemCount: lists.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onFABTap,
        child: const Icon(Icons.add),
      ),
    );
  }

  onFABTap() {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Add Task',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  TextField(
                    controller: _titleTEC,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Title',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _descriptionTEC,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Description',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _daysTEC,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Days Required',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: onDoneButtonPress,
                    child: const Text('Done'),
                  )
                ],
              ),
            ),
          );
        });
  }

  onDoneButtonPress() {
    lists.add(Task(_titleTEC.text, _descriptionTEC.text, _daysTEC.text));
    Navigator.pop(context);
    _daysTEC.clear();
    _descriptionTEC.clear();
    _titleTEC.clear();
    if (mounted) {
      setState(() {});
    }
  }

  onTaskLongPress(context, int index) {
    _scaffoldKey.currentState?.showBottomSheet((context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Task Details',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Title: ${lists[index].title}',
              softWrap: true,
              maxLines: 5,
            ),
            Text(
              'Description: ${lists[index].desc}',
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 20,
            ),
            Text('Days Required: ${lists[index].days}'),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                lists.removeAt(0);
                Navigator.pop(context);
                if (mounted) {
                  setState(() {});
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey),
              ),
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

class Task {
  String title;
  String desc;
  String days;
  Task(this.title, this.desc, this.days);
}
