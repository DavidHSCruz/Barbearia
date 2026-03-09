enum ColumnType { dragHandle, checkbox, text, number, date, boolean }

class TableColumnData {
  final String id;
  final String title;
  final ColumnType type;
  double width;
  final double minWidth;
  final bool isSortable;
  bool isVisible;

  TableColumnData({
    required this.id,
    required this.title,
    required this.type,
    double width = 100.0,
    this.minWidth = 50.0,
    this.isSortable = true,
    this.isVisible = true,
  }) : width = width < minWidth ? minWidth : width;
}
