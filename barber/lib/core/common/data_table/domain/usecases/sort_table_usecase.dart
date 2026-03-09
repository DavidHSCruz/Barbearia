import 'package:barber/core/common/data_table/domain/entities/table_row_data.dart';
import 'package:barber/core/common/data_table/domain/entities/table_column_data.dart';

class SortTableUseCase {
  List<TableRowData> call(
    List<TableRowData> currentRows,
    TableColumnData column,
    bool ascending,
  ) {
    if (column.type == ColumnType.dragHandle ||
        column.type == ColumnType.checkbox) {
      return currentRows;
    }

    final rows = List<TableRowData>.from(currentRows);

    rows.sort((a, b) {
      final valA = a.cells[column.id];
      final valB = b.cells[column.id];

      if (valA == null && valB == null) return 0;
      if (valA == null) return ascending ? -1 : 1;
      if (valB == null) return ascending ? 1 : -1;

      if (column.type == ColumnType.number) {
        final numA = valA is num ? valA : num.tryParse(valA.toString()) ?? 0;
        final numB = valB is num ? valB : num.tryParse(valB.toString()) ?? 0;
        return ascending ? numA.compareTo(numB) : numB.compareTo(numA);
      } else if (column.type == ColumnType.date) {
        final dateA = valA is DateTime
            ? valA
            : DateTime.tryParse(valA.toString()) ?? DateTime(0);
        final dateB = valB is DateTime
            ? valB
            : DateTime.tryParse(valB.toString()) ?? DateTime(0);
        return ascending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
      } else {
        final strA = valA.toString().toLowerCase();
        final strB = valB.toString().toLowerCase();
        return ascending ? strA.compareTo(strB) : strB.compareTo(strA);
      }
    });

    return rows;
  }
}
