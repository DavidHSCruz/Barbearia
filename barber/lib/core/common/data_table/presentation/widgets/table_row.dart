import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/table_column_data.dart';
import '../../domain/entities/table_row_data.dart';

class TableRowWidget extends StatefulWidget {
  final TableRowData row;
  final List<TableColumnData> columns;
  final int index;
  final ValueChanged<bool?>? onSelect;
  final VoidCallback? onAddAbove;
  final VoidCallback? onAddBelow;
  final VoidCallback? onDelete;

  const TableRowWidget({
    super.key,
    required this.row,
    required this.columns,
    required this.index,
    this.onSelect,
    this.onAddAbove,
    this.onAddBelow,
    this.onDelete,
  });

  @override
  State<TableRowWidget> createState() => _TableRowWidgetState();
}

class _TableRowWidgetState extends State<TableRowWidget> {
  bool _showActions = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Row Content
        GestureDetector(
          onLongPress: () => setState(() => _showActions = true),
          child: Container(
            color: widget.row.isSelected
                ? Colors.blue.withValues(alpha: 0.1)
                : Colors.white,
            height: 50,
            child: Row(
              children: widget.columns.map((col) {
                return Container(
                  width: col.width,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[200]!),
                      right: BorderSide(color: Colors.grey[200]!),
                    ),
                  ),
                  child: _buildCellContent(col),
                );
              }).toList(),
            ),
          ),
        ),

        // Action Overlay
        if (_showActions)
          Positioned.fill(
            child: Container(
              color: Colors.grey[50],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      setState(() => _showActions = false);
                      widget.onAddAbove?.call();
                    },
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Acima'),
                    style: TextButton.styleFrom(foregroundColor: Colors.blue),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      setState(() => _showActions = false);
                      widget.onAddBelow?.call();
                    },
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Abaixo'),
                    style: TextButton.styleFrom(foregroundColor: Colors.blue),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      setState(() => _showActions = false);
                      _showDeleteConfirmation(context);
                    },
                    icon: const Icon(Icons.delete, size: 18),
                    label: const Text('Excluir'),
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                  ),
                  IconButton(
                    onPressed: () => setState(() => _showActions = false),
                    icon: const Icon(Icons.close, size: 18, color: Colors.grey),
                    tooltip: 'Fechar',
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildCellContent(TableColumnData col) {
    if (col.type == ColumnType.dragHandle) {
      return ReorderableDragStartListener(
        index: widget.index,
        child: const Icon(Icons.drag_handle, color: Colors.grey),
      );
    } else if (col.type == ColumnType.checkbox) {
      return Checkbox(
        value: widget.row.isSelected,
        onChanged: (val) {
          setState(() => widget.row.isSelected = val ?? false);
          widget.onSelect?.call(val);
        },
      );
    } else {
      final value = widget.row.cells[col.id];
      switch (col.type) {
        case ColumnType.text:
          return Text(value?.toString() ?? '');
        case ColumnType.number:
          return Text(
            value?.toString() ?? '',
            style: const TextStyle(fontFamily: 'Monospace'),
          );
        case ColumnType.date:
          if (value is DateTime) {
            return Text(DateFormat.yMd().format(value));
          }
          return Text(value?.toString() ?? '');
        case ColumnType.boolean:
          return Checkbox(value: value == true, onChanged: null);
        default:
          return Text(value?.toString() ?? '');
      }
    }
  }

  Future<void> _showDeleteConfirmation(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text(
          'Tem certeza que deseja excluir o item ${widget.row.id}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      widget.onDelete?.call();
    }
  }
}
