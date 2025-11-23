
import 'package:flutter/material.dart';

class KanbanColumn extends StatefulWidget {
  const KanbanColumn({super.key});

  @override
  State<KanbanColumn> createState() => _KanbanColumnState();
}

class _KanbanColumnState extends State<KanbanColumn> {
  final List<int> _items = List<int>.generate(10, (int index) => index);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.15);

    return Expanded( // <–– give each column a width constraint
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.shade100,
        ),
        child: ReorderableListView(
          buildDefaultDragHandles: false,
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            for (int index = 0; index < _items.length; index++)
              ReorderableDragStartListener(
                key: Key('$index'),
                index: index,
                child: ListTile(
                  tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,
                  title: Text('Item ${_items[index]}'),
                ),
              ),
          ],
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (oldIndex < newIndex) newIndex -= 1;
              final int item = _items.removeAt(oldIndex);
              _items.insert(newIndex, item);
            });
          },
        ),
      ),
    );
  }
}
