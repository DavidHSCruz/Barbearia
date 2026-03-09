import 'package:flutter/material.dart';
import '../../domain/entities/table_column_data.dart';

class TableHeader extends StatelessWidget {
  final List<TableColumnData> columns;
  final List<TableColumnData> hiddenColumns;
  final bool allSelected;
  final ValueChanged<bool?>? onSelectAll;
  final void Function(int fromIndex, int toIndex)? onColumnReorder;
  final void Function(int index, double delta)? onColumnResize;
  final void Function(TableColumnData column)? onHideColumn;
  final void Function(TableColumnData column)? onShowColumn;
  final void Function(TableColumnData column, bool ascending)? onSort;

  const TableHeader({
    super.key,
    required this.columns,
    this.hiddenColumns = const [],
    required this.allSelected,
    this.onSelectAll,
    this.onColumnReorder,
    this.onColumnResize,
    this.onHideColumn,
    this.onShowColumn,
    this.onSort,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: columns.asMap().entries.map((entry) {
          final index = entry.key;
          final col = entry.value;
          return _buildHeaderCell(index, col);
        }).toList(),
      ),
    );
  }

  Widget _buildHeaderCell(int index, TableColumnData col) {
    Widget cellContent;

    if (col.type == ColumnType.checkbox) {
      cellContent = Checkbox(value: allSelected, onChanged: onSelectAll);
    } else if (col.type == ColumnType.dragHandle) {
      cellContent = const Icon(Icons.drag_indicator, color: Colors.grey);
    } else {
      // Content with Menu
      cellContent = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              col.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.arrow_drop_down, size: 20),
            tooltip: 'Opções',
            onSelected: (value) {
              if (value == 'hide') {
                onHideColumn?.call(col);
              } else if (value == 'asc') {
                onSort?.call(col, true);
              } else if (value == 'desc') {
                onSort?.call(col, false);
              } else if (value.startsWith('show_')) {
                final colId = value.replaceFirst('show_', '');
                final columnToShow = hiddenColumns.firstWhere(
                  (c) => c.id == colId,
                  orElse: () => col,
                );
                onShowColumn?.call(columnToShow);
              }
            },
            itemBuilder: (context) {
              final isText = col.type == ColumnType.text;
              final canSort =
                  col.type != ColumnType.dragHandle &&
                  col.type != ColumnType.checkbox;

              return [
                const PopupMenuItem(
                  value: 'hide',
                  child: Row(
                    children: [
                      Icon(Icons.visibility_off, size: 18),
                      SizedBox(width: 8),
                      Text('Ocultar coluna'),
                    ],
                  ),
                ),
                if (canSort) ...[
                  PopupMenuItem(
                    value: 'asc',
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_upward, size: 18),
                        const SizedBox(width: 8),
                        Text(isText ? 'A-Z' : 'Crescente'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'desc',
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_downward, size: 18),
                        const SizedBox(width: 8),
                        Text(isText ? 'Z-A' : 'Decrescente'),
                      ],
                    ),
                  ),
                ],
                if (hiddenColumns.isNotEmpty) ...[
                  const PopupMenuDivider(),
                  const PopupMenuItem(
                    enabled: false,
                    child: Text(
                      'Mostrar colunas:',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                  ...hiddenColumns.map((hiddenCol) {
                    return PopupMenuItem(
                      value: 'show_${hiddenCol.id}',
                      child: Row(
                        children: [
                          const Icon(Icons.visibility, size: 18),
                          const SizedBox(width: 8),
                          Text(hiddenCol.title),
                        ],
                      ),
                    );
                  }),
                ],
              ];
            },
          ),
        ],
      );
    }

    // Determine if this column can be reordered (dragged)
    final canReorder =
        col.type != ColumnType.dragHandle && col.type != ColumnType.checkbox;

    // The drag target wraps the entire cell so you can drop onto any part of it
    return DragTarget<int>(
      onWillAcceptWithDetails: (details) => details.data != index,
      onAcceptWithDetails: (details) {
        onColumnReorder?.call(details.data, index);
      },
      builder: (context, candidateData, rejectedData) {
        // Base container for the cell
        return Container(
          width: col.width,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey[300]!),
              right: BorderSide(color: Colors.grey[300]!),
            ),
            color: Colors.grey[100],
          ),
          child: Stack(
            children: [
              // Content Area - Only this part is draggable
              Positioned.fill(
                child: canReorder
                    ? Draggable<int>(
                        data: index,
                        feedback: Material(
                          elevation: 4.0,
                          child: Container(
                            width: col.width,
                            height: 50,
                            color: Colors.grey[200],
                            alignment: Alignment.center,
                            child: DefaultTextStyle(
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              child: col.type == ColumnType.text
                                  ? Text(col.title)
                                  : cellContent,
                            ),
                          ),
                        ),
                        // When dragging, show the original cell in place (or ghost)
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: cellContent,
                        ),
                      )
                    : Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: cellContent,
                      ),
              ),

              // Resize Handle - Placed ON TOP of the content/draggable
              // This ensures gestures here are caught by the handle, not the draggable
              if (col.type != ColumnType.dragHandle &&
                  col.type != ColumnType.checkbox)
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeColumn,
                    child: GestureDetector(
                      behavior:
                          HitTestBehavior.opaque, // Ensure it catches hits
                      onPanUpdate: (details) {
                        onColumnResize?.call(index, details.delta.dx);
                      },
                      onHorizontalDragUpdate: (details) {
                        onColumnResize?.call(index, details.delta.dx);
                      },
                      child: Container(
                        width: 15, // Slightly wider hit area
                        color: Colors.transparent,
                        child: Center(
                          child: Container(width: 2, color: Colors.grey[400]),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
