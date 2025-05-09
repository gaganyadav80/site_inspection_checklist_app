import 'package:flutter/material.dart';
import 'package:site_inspection_checklist_app/widgets/dashboard_appbar.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(),
    );
  }
}
