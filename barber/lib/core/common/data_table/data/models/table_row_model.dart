import '../../domain/entities/table_row_data.dart';

class TableRowModel extends TableRowData {
  TableRowModel({
    required String id,
    required Map<String, dynamic> cells,
    bool isSelected = false,
  }) : super(
          id: id,
          cells: cells,
          isSelected: isSelected,
        );

  factory TableRowModel.fromEntity(TableRowData entity) {
    return TableRowModel(
      id: entity.id,
      cells: entity.cells,
      isSelected: entity.isSelected,
    );
  }
}
