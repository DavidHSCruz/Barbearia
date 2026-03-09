import 'package:barber/core/common/data_table/domain/entities/table_row_data.dart';

class ReorderRowsUseCase {
  List<TableRowData> call(
    List<TableRowData> currentRows,
    int oldIndex,
    int newIndex,
  ) {
    final rows = List<TableRowData>.from(currentRows);

    if (oldIndex >= rows.length) return rows;
    if (newIndex > rows.length) newIndex = rows.length;
    if (oldIndex < newIndex) newIndex -= 1;

    final item = rows.removeAt(oldIndex);
    rows.insert(newIndex, item);

    return rows;
  }
}
