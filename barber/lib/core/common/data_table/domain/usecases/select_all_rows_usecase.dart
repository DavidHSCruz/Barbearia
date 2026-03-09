import '../entities/table_row_data.dart';

class SelectAllRowsUseCase {
  void call(List<TableRowData> rows, bool selected) {
    for (var row in rows) {
      row.isSelected = selected;
    }
  }
}
