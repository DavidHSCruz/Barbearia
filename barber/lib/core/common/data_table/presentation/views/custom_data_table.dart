import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/table_column_data.dart';
import '../../domain/entities/table_row_data.dart';
import '../bloc/table_cubit.dart';
import '../bloc/table_state.dart';
import '../widgets/table_header.dart';
import '../widgets/table_row.dart';

class CustomDataTable extends StatelessWidget {
  final List<TableColumnData> columns;
  final List<TableRowData> rows;
  final void Function(int oldIndex, int newIndex)? onRowReorder;
  final void Function(int oldIndex, int newIndex)? onColumnReorder;
  final void Function(TableRowData row)? onRowDelete;
  final void Function(int index)? onRowAdd; // index to insert at
  final void Function(TableRowData row, bool selected)? onRowSelect;
  final void Function(bool selected)? onSelectAll;

  const CustomDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.onRowReorder,
    this.onColumnReorder,
    this.onRowDelete,
    this.onRowAdd,
    this.onRowSelect,
    this.onSelectAll,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TableCubit(columns: columns, rows: rows),
      child: _CustomDataTableContent(
        onRowReorder: onRowReorder,
        onColumnReorder: onColumnReorder,
        onRowDelete: onRowDelete,
        onRowAdd: onRowAdd,
        onRowSelect: onRowSelect,
        onSelectAll: onSelectAll,
      ),
    );
  }
}

class _CustomDataTableContent extends StatefulWidget {
  final void Function(int oldIndex, int newIndex)? onRowReorder;
  final void Function(int oldIndex, int newIndex)? onColumnReorder;
  final void Function(TableRowData row)? onRowDelete;
  final void Function(int index)? onRowAdd;
  final void Function(TableRowData row, bool selected)? onRowSelect;
  final void Function(bool selected)? onSelectAll;

  const _CustomDataTableContent({
    this.onRowReorder,
    this.onColumnReorder,
    this.onRowDelete,
    this.onRowAdd,
    this.onRowSelect,
    this.onSelectAll,
  });

  @override
  State<_CustomDataTableContent> createState() =>
      _CustomDataTableContentState();
}

class _CustomDataTableContentState extends State<_CustomDataTableContent> {
  final ScrollController _horizontalController = ScrollController();

  @override
  void dispose() {
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TableCubit, TableState>(
      builder: (context, state) {
        if (state is! TableLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        final controller = context.read<TableCubit>();
        final visibleColumns = state.visibleColumns;
        final hiddenColumns = state.hiddenColumns;
        final double totalWidth = visibleColumns.fold(
          0.0,
          (sum, col) => sum + col.width,
        );

        return LayoutBuilder(
          builder: (context, constraints) {
            // Check if we need to fit columns to available width
            if ((totalWidth - constraints.maxWidth).abs() > 1.0) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  controller.fitToWidth(constraints.maxWidth);
                }
              });
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: SizedBox(
                  width: totalWidth > constraints.maxWidth
                      ? totalWidth
                      : constraints.maxWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header
                      TableHeader(
                        columns: visibleColumns,
                        hiddenColumns: hiddenColumns,
                        allSelected: state.allSelected,
                        onSelectAll: (val) {
                          controller.selectAll(val ?? false);
                          widget.onSelectAll?.call(val ?? false);
                        },
                        onColumnReorder: (fromIndex, toIndex) {
                          controller.reorderColumn(fromIndex, toIndex);
                          widget.onColumnReorder?.call(fromIndex, toIndex);
                        },
                        onColumnResize: controller.resizeColumn,
                        onHideColumn: controller.hideColumn,
                        onShowColumn: controller.showColumn,
                        onSort: controller.sortColumn,
                      ),

                      // Rows (Reorderable) + Add Button
                      Expanded(
                        child: ReorderableListView.builder(
                          buildDefaultDragHandles: false,
                          itemCount: state.rows.length + 1, // +1 for Add Button
                          onReorder: (oldIndex, newIndex) {
                            controller.reorderRow(oldIndex, newIndex);
                            widget.onRowReorder?.call(oldIndex, newIndex);
                          },
                          itemBuilder: (context, index) {
                            if (index == state.rows.length) {
                              // The Add Button Row
                              return Padding(
                                key: const ValueKey('add_button_row'),
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: ElevatedButton.icon(
                                    onPressed: () => widget.onRowAdd?.call(
                                      state.rows.length,
                                    ),
                                    icon: const Icon(Icons.add),
                                    label: const Text('Adicionar'),
                                  ),
                                ),
                              );
                            }

                            final row = state.rows[index];
                            return TableRowWidget(
                              key: ValueKey(row.id),
                              row: row,
                              columns: visibleColumns,
                              index: index,
                              onSelect: (val) {
                                controller.selectRow(row, val ?? false);
                                widget.onRowSelect?.call(row, val ?? false);
                              },
                              onAddAbove: () => widget.onRowAdd?.call(index),
                              onAddBelow: () =>
                                  widget.onRowAdd?.call(index + 1),
                              onDelete: () {
                                controller.deleteRow(row);
                                widget.onRowDelete?.call(row);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
