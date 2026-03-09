import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/table_column_data.dart';
import '../../domain/entities/table_row_data.dart';
import '../../domain/usecases/reorder_rows_usecase.dart';
import '../../domain/usecases/sort_table_usecase.dart';
import '../../domain/usecases/reorder_columns_usecase.dart';
import '../../domain/usecases/set_column_visibility_usecase.dart';
import '../../domain/usecases/resize_column_usecase.dart';
import '../../domain/usecases/select_all_rows_usecase.dart';
import '../../domain/usecases/select_row_usecase.dart';
import '../../domain/usecases/delete_row_usecase.dart';
import '../../domain/usecases/fit_columns_to_width_usecase.dart';
import 'table_state.dart';

class TableCubit extends Cubit<TableState> {
  final ReorderRowsUseCase _reorderRowsUseCase;
  final SortTableUseCase _sortTableUseCase;
  final ReorderColumnsUseCase _reorderColumnsUseCase;
  final SetColumnVisibilityUseCase _setColumnVisibilityUseCase;
  final ResizeColumnUseCase _resizeColumnUseCase;
  final SelectAllRowsUseCase _selectAllRowsUseCase;
  final SelectRowUseCase _selectRowUseCase;
  final DeleteRowUseCase _deleteRowUseCase;
  final FitColumnsToWidthUseCase _fitColumnsToWidthUseCase;

  TableCubit({
    required List<TableColumnData> columns,
    required List<TableRowData> rows,
    ReorderRowsUseCase? reorderRowsUseCase,
    SortTableUseCase? sortTableUseCase,
    ReorderColumnsUseCase? reorderColumnsUseCase,
    SetColumnVisibilityUseCase? setColumnVisibilityUseCase,
    ResizeColumnUseCase? resizeColumnUseCase,
    SelectAllRowsUseCase? selectAllRowsUseCase,
    SelectRowUseCase? selectRowUseCase,
    DeleteRowUseCase? deleteRowUseCase,
    FitColumnsToWidthUseCase? fitColumnsToWidthUseCase,
  }) : _reorderRowsUseCase = reorderRowsUseCase ?? ReorderRowsUseCase(),
       _sortTableUseCase = sortTableUseCase ?? SortTableUseCase(),
       _reorderColumnsUseCase =
           reorderColumnsUseCase ?? ReorderColumnsUseCase(),
       _setColumnVisibilityUseCase =
           setColumnVisibilityUseCase ?? SetColumnVisibilityUseCase(),
       _resizeColumnUseCase = resizeColumnUseCase ?? ResizeColumnUseCase(),
       _selectAllRowsUseCase = selectAllRowsUseCase ?? SelectAllRowsUseCase(),
       _selectRowUseCase = selectRowUseCase ?? SelectRowUseCase(),
       _deleteRowUseCase = deleteRowUseCase ?? DeleteRowUseCase(),
       _fitColumnsToWidthUseCase =
           fitColumnsToWidthUseCase ?? FitColumnsToWidthUseCase(),
       super(TableLoaded(columns: List.from(columns), rows: List.from(rows)));

  void updateData(List<TableColumnData> columns, List<TableRowData> rows) {
    emit(TableLoaded(columns: List.from(columns), rows: List.from(rows)));
  }

  void reorderRow(int oldIndex, int newIndex) {
    final currentState = state;
    if (currentState is! TableLoaded) return;

    final newRows = _reorderRowsUseCase(currentState.rows, oldIndex, newIndex);
    emit(currentState.copyWith(rows: newRows));
  }

  void hideColumn(TableColumnData column) {
    final currentState = state;
    if (currentState is! TableLoaded) return;

    _setColumnVisibilityUseCase(column, false);
    emit(currentState.copyWith()); // version bump
  }

  void showColumn(TableColumnData column) {
    final currentState = state;
    if (currentState is! TableLoaded) return;

    _setColumnVisibilityUseCase(column, true);
    emit(currentState.copyWith());
  }

  void sortColumn(TableColumnData column, bool ascending) {
    final currentState = state;
    if (currentState is! TableLoaded) return;

    final newRows = _sortTableUseCase(currentState.rows, column, ascending);
    emit(currentState.copyWith(rows: newRows));
  }

  void reorderColumn(int fromIndex, int toIndex) {
    final currentState = state;
    if (currentState is! TableLoaded) return;

    final newColumns = _reorderColumnsUseCase(
      currentState.columns,
      currentState.visibleColumns,
      fromIndex,
      toIndex,
    );

    emit(currentState.copyWith(columns: newColumns));
  }

  void resizeColumn(int index, double delta) {
    final currentState = state;
    if (currentState is! TableLoaded) return;

    _resizeColumnUseCase(currentState.visibleColumns, index, delta);

    emit(currentState.copyWith());
  }

  void fitToWidth(double width) {
    final currentState = state;
    if (currentState is! TableLoaded) return;

    final changed = _fitColumnsToWidthUseCase(
      currentState.visibleColumns,
      width,
    );
    if (changed) {
      emit(currentState.copyWith());
    }
  }

  void selectAll(bool selected) {
    final currentState = state;
    if (currentState is! TableLoaded) return;

    _selectAllRowsUseCase(currentState.rows, selected);
    emit(currentState.copyWith());
  }

  void selectRow(TableRowData row, bool selected) {
    final currentState = state;
    if (currentState is! TableLoaded) return;

    _selectRowUseCase(row, selected);
    emit(currentState.copyWith());
  }

  void deleteRow(TableRowData row) {
    final currentState = state;
    if (currentState is! TableLoaded) return;

    final newRows = _deleteRowUseCase(currentState.rows, row);
    emit(currentState.copyWith(rows: newRows));
  }
}
