import 'package:flutter/material.dart';
import 'package:site_inspection_checklist_app/core/constants.dart';

class DashboardTaskSummaryTile extends StatelessWidget {
  const DashboardTaskSummaryTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: kScaffoldBackgroundColor,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: Colors.grey.shade200,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '0/12 Complete',
              style: TextTheme.of(context).bodySmall,
            ),
          ),
          Row(
            spacing: 8,
            children: List.generate(
              3,
              (index) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: [
                        kPassedItemColor,
                        kFailedItemColor,
                        kNotApplicableItemColor,
                      ][index],
                    ),
                    SizedBox(width: 4),
                    Text(
                      '0',
                      style: TextTheme.of(context).bodySmall,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
