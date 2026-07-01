import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Department {
  final int id;
  final String subDepartment;
  final String mainDepartment;

  Department({
    required this.id,
    required this.subDepartment,
    required this.mainDepartment,
  });
}

class TableWidget extends StatefulWidget {
  const TableWidget({super.key});

  @override
  _TableWidgetState createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  late DepartmentDataSource _dataSource;

  @override
  void initState() {
    super.initState();
    _dataSource = DepartmentDataSource(_generateData());
  }

  List<Department> _generateData() {
    return List.generate(
      50,
      (index) => Department(
        id: index + 1,
        subDepartment: "SubDept ${index + 1}",
        mainDepartment: "MainDept ${((index) / 5).floor() + 1}",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
        header: const Text(
          "Departments",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        columns: const [
          DataColumn(label: Text("ID", style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text("Sub Department", style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text("Main Department", style: TextStyle(fontWeight: FontWeight.bold))),
          DataColumn(label: Text("Action", style: TextStyle(fontWeight: FontWeight.bold))),
        ],
        source: _dataSource,
        rowsPerPage: 10,
        availableRowsPerPage: const [10, 20, 50],
      )
          .animate()
          .fadeIn(duration: const Duration(milliseconds: 600))
          .slideY(begin: 0.2, duration: const Duration(milliseconds: 600));
  }
}

class DepartmentDataSource extends DataTableSource {
  final List<Department> departments;
  DepartmentDataSource(this.departments);

  @override
  DataRow? getRow(int index) {
    if (index >= departments.length) return null;
    final dept = departments[index];
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(dept.id.toString())),
        DataCell(Text(dept.subDepartment)),
        DataCell(Text(dept.mainDepartment)),
        DataCell(
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // Edit action here.
                },
                icon: const Icon(Icons.edit, size: 16),
                label: const Text("Edit", style: TextStyle(fontSize: 12)),
                style: ElevatedButton.styleFrom(
                  // primary: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
              )
                  .animate()
                  .fadeIn(duration: const Duration(milliseconds: 300))
                  .slideX(begin: -0.1, duration: const Duration(milliseconds: 300)),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () {
                  // Delete action here.
                },
                icon: const Icon(Icons.delete, size: 16),
                label: const Text("Delete", style: TextStyle(fontSize: 12)),
                style: ElevatedButton.styleFrom(
                  // primary: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
              )
                  .animate()
                  .fadeIn(duration: const Duration(milliseconds: 300))
                  .slideX(begin: 0.1, duration: const Duration(milliseconds: 300)),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => departments.length;
  @override
  int get selectedRowCount => 0;
}
