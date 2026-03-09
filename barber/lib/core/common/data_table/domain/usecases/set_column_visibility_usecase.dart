import '../entities/table_column_data.dart';

class SetColumnVisibilityUseCase {
  void call(TableColumnData column, bool isVisible) {
    column.isVisible = isVisible;
  }
}
