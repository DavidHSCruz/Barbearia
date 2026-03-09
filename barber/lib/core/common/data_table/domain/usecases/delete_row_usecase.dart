import '../entities/table_row_data.dart';

class DeleteRowUseCase {
  List<TableRowData> call(List<TableRowData> currentRows, TableRowData rowToDelete) {
    final rows = List<TableRowData>.from(currentRows);
    rows.remove(rowToDelete);
    return rows;
  }
}
