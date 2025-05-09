import 'package:flutter/material.dart';
import 'package:site_inspection_checklist_app/core/constants.dart';
import 'package:site_inspection_checklist_app/core/extensions.dart';
import 'package:site_inspection_checklist_app/core/ui_helper.dart';
import 'package:site_inspection_checklist_app/mock_data.dart';
import 'package:site_inspection_checklist_app/widgets/dashboard_appbar.dart';
import 'package:site_inspection_checklist_app/widgets/inspection_item_status_icon.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(),
      body: ListView.separated(
        itemCount: mockData.length,
        padding: EdgeInsets.all(16).copyWith(
          bottom: context.bottomSafePadding,
        ),
        separatorBuilder: (context, index) {
          return SizedBox(height: 16);
        },
        itemBuilder: (context, index) {
          final item = mockData[index];

          final backgroundColor = UiHelper.getStatusColor(item.status);

          return Material(
            color: Colors.white,
            borderRadius: kDefaultBorderRadius,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: backgroundColor?.shade50 ?? Colors.white,
                borderRadius: kDefaultBorderRadius,
                border: Border.all(
                  color: backgroundColor?.shade100 ?? Colors.grey.shade100,
                ),
                boxShadow: kLightBoxShadow,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: context.textTheme.titleMedium?.copyWith(
                            color: Colors.grey.shade800,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          item.category,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InspectionItemStatusIcon(
                    status: item.status,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
