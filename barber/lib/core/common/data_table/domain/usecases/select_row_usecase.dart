import '../entities/table_row_data.dart';

class SelectRowUseCase {
  void call(TableRowData row, bool selected) {
    row.isSelected = selected;
  }
}
