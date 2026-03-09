import 'package:flutter/material.dart';
import '../../domain/entities/table_column_data.dart';
import '../../domain/entities/table_row_data.dart';
import 'custom_data_table.dart';

// Use this page to preview and test the CustomDataTable component.
// You can add this page to your routes or run it directly via a temporary main() function.

class TablePreviewPage extends StatelessWidget {
  const TablePreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Table Component Preview')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomDataTable(
          columns: _mockColumns(),
          rows: _mockRows(),
          onRowReorder: (oldIndex, newIndex) {
            debugPrint('Reorder row: $oldIndex -> $newIndex');
          },
          onColumnReorder: (oldIndex, newIndex) {
            debugPrint('Reorder column: $oldIndex -> $newIndex');
          },
          onRowDelete: (row) {
            debugPrint('Delete row: ${row.id}');
          },
          onRowSelect: (row, selected) {
            debugPrint('Select row: ${row.id}, selected: $selected');
          },
          onSelectAll: (selected) {
            debugPrint('Select all: $selected');
          },
        ),
      ),
    );
  }

  List<TableColumnData> _mockColumns() {
    return [
      TableColumnData(
        id: 'drag',
        title: '',
        type: ColumnType.dragHandle,
        width: 40,
        isSortable: false,
      ),
      TableColumnData(
        id: 'select',
        title: '',
        type: ColumnType.checkbox,
        width: 40,
        isSortable: false,
      ),
      TableColumnData(
        id: 'name',
        title: 'Name',
        type: ColumnType.text,
        width: 150,
      ),
      TableColumnData(
        id: 'age',
        title: 'Age',
        type: ColumnType.number,
        width: 80,
      ),
      TableColumnData(
        id: 'date',
        title: 'Date',
        type: ColumnType.date,
        width: 120,
      ),
      TableColumnData(
        id: 'active',
        title: 'Active',
        type: ColumnType.boolean,
        width: 80,
      ),
    ];
  }

  List<TableRowData> _mockRows() {
    return List.generate(20, (index) {
      return TableRowData(
        id: 'row_$index',
        cells: {
          'name': 'Person $index',
          'age': 20 + index,
          'date': DateTime.now().add(Duration(days: index)),
          'active': index % 2 == 0,
        },
      );
    });
  }
}

// Optional: Uncomment this main function to run this file directly for quick preview
void main() {
  runApp(
    MaterialApp(
      home: const TablePreviewPage(),
      theme: ThemeData(useMaterial3: true),
    ),
  );
}
