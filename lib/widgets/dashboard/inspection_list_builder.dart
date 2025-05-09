import 'package:flutter/material.dart';
import 'package:site_inspection_checklist_app/core/extensions.dart';
import 'package:site_inspection_checklist_app/mock_data.dart';
import 'package:site_inspection_checklist_app/widgets/dashboard/inspection_list_item.dart';

class InspectionListBuilder extends StatelessWidget {
  const InspectionListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: mockData.length,
      padding: EdgeInsets.all(16).copyWith(
        bottom: context.bottomSafePadding,
      ),
      separatorBuilder: (context, index) {
        return SizedBox(height: 16);
      },
      itemBuilder: (context, index) {
        final item = mockData[index];

        return InspectionListItem(
          item: item,
        );
      },
    );
  }
}
