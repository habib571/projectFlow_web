// members_tab_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projectflow_web/presentation/features/projects/views/screens/invite_member_screen.dart';
import 'package:projectflow_web/presentation/features/projects/views/widgets/members_section.dart';


class MembersTabRouter extends StatefulWidget {
  const MembersTabRouter({super.key});

  @override
  State<MembersTabRouter> createState() => _MembersTabRouterState();
}

class _MembersTabRouterState extends State<MembersTabRouter> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => MembersSection(
            onInviteTap: () => _router.go('/invite'),
          ),
        ),
        GoRoute(
          path: '/invite',
          builder: (context, state) =>  InviteMemberScreen(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Router(
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }
}
