class TableRowData {
  final String id;
  final Map<String, dynamic> cells;
  bool isSelected;

  TableRowData({
    required this.id,
    required this.cells,
    this.isSelected = false,
  });
}
