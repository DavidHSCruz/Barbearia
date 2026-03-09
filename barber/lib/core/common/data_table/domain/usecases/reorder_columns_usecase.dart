import 'package:barber/core/common/data_table/domain/entities/table_column_data.dart';

class ReorderColumnsUseCase {
  List<TableColumnData> call(
    List<TableColumnData> allColumns,
    List<TableColumnData> visibleColumns,
    int fromIndex,
    int toIndex,
  ) {
    final columns = List<TableColumnData>.from(allColumns);

    // fromIndex and toIndex refer to indices within the visibleColumns list
    if (fromIndex >= visibleColumns.length || toIndex > visibleColumns.length) {
      return columns;
    }

    final fromCol = visibleColumns[fromIndex];
    // If dragging to the end, handle carefully
    final toColIndex = toIndex < visibleColumns.length
        ? toIndex
        : visibleColumns.length - 1;
    final toCol = visibleColumns[toColIndex];

    final realFromIndex = columns.indexOf(fromCol);
    final realToIndex = columns.indexOf(toCol);

    if (realFromIndex == -1 || realToIndex == -1) return columns;

    final item = columns.removeAt(realFromIndex);

    // If dragging to the very end of visible columns (conceptually)
    // The UI usually handles this by dropping ON the last item or similar.
    // The standard Flutter reorder logic is followed here.

    columns.insert(realToIndex, item);

    return columns;
  }
}
