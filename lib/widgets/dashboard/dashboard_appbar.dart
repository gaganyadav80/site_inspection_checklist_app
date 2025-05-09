import 'package:flutter/material.dart';
import 'package:site_inspection_checklist_app/widgets/dashboard/dashboard_task_summary_tile.dart';
import 'package:site_inspection_checklist_app/widgets/secondary_button.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Site Inspection'),
      actions: [
        SizedBox(
          height: 36,
          child: SecondaryButton(
            onPressed: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.sync_rounded),
                SizedBox(width: 4),
                Text('Reset'),
              ],
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(32),
        child: DashboardTaskSummaryTile(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 32);
}
