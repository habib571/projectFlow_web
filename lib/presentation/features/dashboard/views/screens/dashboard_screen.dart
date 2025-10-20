import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:projectflow_web/core/helpers/extensions/screen_config_extension.dart';
import 'package:projectflow_web/core/routes/app_routes.dart';
import 'package:projectflow_web/presentation/features/auth/views/screens/login_screen.dart';
import 'package:projectflow_web/presentation/features/dashboard/bloc/navigation_bloc.dart';
import 'package:projectflow_web/presentation/features/dashboard/views/widgets/dashboard_header.dart';
import 'package:projectflow_web/presentation/features/dashboard/views/widgets/new_project_dialog.dart';
import 'package:projectflow_web/presentation/features/dashboard/views/widgets/statistic_section.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width <= 800 ? 40.w : 200.w,
          right: 40.w,
          //   top: 40.h,
          bottom: 40.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashboardHeader(
              onPressed: () {
                context.go('/projects') ;

              },
            ),
            const SizedBox(
              height: 30,
            ),
            const StatisticSection(),
            const SizedBox(
              height: 30,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Card(
                        elevation: 2,
                        margin: const EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Recent Projects",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 16),
                              // Example project list
                              ListView(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    ListTile(
                                        title: const Text("test"),
                                        subtitle: const Text("test"),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ElevatedButton(
                                              style : ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                              ) ,
                                              onPressed: () {},
                                              child: const Text("View Board"),
                                            ),
                                            const SizedBox(width: 8),
                                            OutlinedButton(
                                              onPressed: () {},
                                              child: const Text("Details"),
                                            ),
                                          ],
                                        )),
                                  ]),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                const Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 2,
                    margin: EdgeInsets.all(8),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Upcoming Deadlines",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 24),
                          Center(
                            child: Column(
                              children: [
                                Icon(Icons.calendar_today_outlined,
                                    size: 48, color: Colors.grey),
                                SizedBox(height: 8),
                                Text("No upcoming deadlines",
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
