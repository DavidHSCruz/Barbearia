import '../entities/table_column_data.dart';

class ResizeColumnUseCase {
  void call(List<TableColumnData> visibleColumns, int index, double delta) {
    if (index < 0 || index >= visibleColumns.length - 1) return;

    final currentColumn = visibleColumns[index];
    final nextColumn = visibleColumns[index + 1];

    if (currentColumn.type == ColumnType.dragHandle ||
        currentColumn.type == ColumnType.checkbox) {
      return;
    }

    if (nextColumn.type == ColumnType.dragHandle ||
        nextColumn.type == ColumnType.checkbox) {
      return;
    }

    // Determine min/max delta allowed based on minWidth constraints
    // If delta > 0: current grows, next shrinks.
    // Max positive delta is limited by nextColumn shrinking to its minWidth.
    // nextColumn.width - delta >= nextColumn.minWidth  =>  delta <= nextColumn.width - nextColumn.minWidth

    // If delta < 0: current shrinks, next grows.
    // Max negative delta (absolute value) is limited by currentColumn shrinking to its minWidth.
    // currentColumn.width + delta >= currentColumn.minWidth => delta >= currentColumn.minWidth - currentColumn.width

    final double maxDelta = nextColumn.width - nextColumn.minWidth;
    final double minDelta = currentColumn.minWidth - currentColumn.width;

    // Clamp delta
    double actualDelta = delta;
    if (actualDelta > maxDelta) actualDelta = maxDelta;
    if (actualDelta < minDelta) actualDelta = minDelta;

    // Apply
    currentColumn.width += actualDelta;
    nextColumn.width -= actualDelta;
  }
}
