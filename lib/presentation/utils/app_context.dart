
import 'package:flutter/material.dart';
import 'package:projectflow_web/core/dependencyInjection/dependency_injector.dart';

class AppContext {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  BuildContext? _context;
  void setContext(BuildContext context) {
    _context = context;
  }
  BuildContext? get context => _context ;
/*BuildContext get context {
    if (navigatorKey.currentContext == null) {
      throw Exception("context is not yet! ");
    }
*/


}


final appContext = getIt.get<AppContext>();


