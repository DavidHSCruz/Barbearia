import '../../domain/entities/table_column_data.dart';

class TableColumnModel extends TableColumnData {
  TableColumnModel({
    required String id,
    required String title,
    required ColumnType type,
    double width = 100.0,
    double minWidth = 50.0,
    bool isSortable = true,
    bool isVisible = true,
  }) : super(
          id: id,
          title: title,
          type: type,
          width: width,
          minWidth: minWidth,
          isSortable: isSortable,
          isVisible: isVisible,
        );

  factory TableColumnModel.fromEntity(TableColumnData entity) {
    return TableColumnModel(
      id: entity.id,
      title: entity.title,
      type: entity.type,
      width: entity.width,
      minWidth: entity.minWidth,
      isSortable: entity.isSortable,
      isVisible: entity.isVisible,
    );
  }
}
