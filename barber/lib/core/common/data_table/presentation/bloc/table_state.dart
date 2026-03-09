import 'package:equatable/equatable.dart';
import '../../domain/entities/table_column_data.dart';
import '../../domain/entities/table_row_data.dart';

abstract class TableState extends Equatable {
  const TableState();

  @override
  List<Object?> get props => [];
}

class TableInitial extends TableState {}

class TableLoaded extends TableState {
  final List<TableColumnData> columns;
  final List<TableRowData> rows;
  final int version; // To force updates when mutable data changes in place

  const TableLoaded({
    required this.columns,
    required this.rows,
    this.version = 0,
  });

  List<TableColumnData> get visibleColumns =>
      columns.where((c) => c.isVisible).toList();

  List<TableColumnData> get hiddenColumns =>
      columns.where((c) => !c.isVisible).toList();

  bool get allSelected => rows.isNotEmpty && rows.every((r) => r.isSelected);

  TableLoaded copyWith({
    List<TableColumnData>? columns,
    List<TableRowData>? rows,
    int? version,
  }) {
    return TableLoaded(
      columns: columns ?? this.columns,
      rows: rows ?? this.rows,
      version: version ?? this.version + 1,
    );
  }

  @override
  List<Object?> get props => [columns, rows, version];
}
