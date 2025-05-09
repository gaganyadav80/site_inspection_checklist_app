import 'package:flutter/material.dart';
import 'package:site_inspection_checklist_app/widgets/add_inspection_item_modal_sheet.dart';
import 'package:site_inspection_checklist_app/widgets/dashboard/dashboard_appbar.dart';
import 'package:site_inspection_checklist_app/widgets/dashboard/inspection_list_builder.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(),
      body: InspectionListBuilder(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return AddInspectionItemModalSheet();
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
