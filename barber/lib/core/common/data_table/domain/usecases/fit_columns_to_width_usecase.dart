import '../entities/table_column_data.dart';

class FitColumnsToWidthUseCase {
  bool call(List<TableColumnData> visibleColumns, double availableWidth) {
    if (visibleColumns.isEmpty) return false;

    double currentTotalWidth = 0;
    double fixedWidth = 0;
    List<TableColumnData> flexibleColumns = [];

    for (var col in visibleColumns) {
      currentTotalWidth += col.width;
      if (col.type == ColumnType.dragHandle ||
          col.type == ColumnType.checkbox ||
          col.type == ColumnType.boolean) {
        fixedWidth += col.width;
      } else {
        flexibleColumns.add(col);
      }
    }

    if (flexibleColumns.isEmpty) {
      // If no flexible columns, distribute among all except maybe dragHandle/checkbox
      for (var col in visibleColumns) {
        if (col.type != ColumnType.dragHandle &&
            col.type != ColumnType.checkbox) {
          flexibleColumns.add(col);
        }
      }
    }

    if (flexibleColumns.isEmpty) return false;

    final double targetFlexibleWidth = availableWidth - fixedWidth;
    final double currentFlexibleWidth = currentTotalWidth - fixedWidth;

    // Tolerance for floating point comparison
    if ((targetFlexibleWidth - currentFlexibleWidth).abs() < 0.1) return false;
    if (currentFlexibleWidth <= 0) return false;

    final double ratio = targetFlexibleWidth / currentFlexibleWidth;
    bool changed = false;

    for (var col in flexibleColumns) {
      final oldWidth = col.width;
      final newWidthRaw = col.width * ratio;
      final newWidth = newWidthRaw < col.minWidth ? col.minWidth : newWidthRaw;

      if ((oldWidth - newWidth).abs() > 0.1) {
        col.width = newWidth;
        changed = true;
      }
    }
    return changed;
  }
}
