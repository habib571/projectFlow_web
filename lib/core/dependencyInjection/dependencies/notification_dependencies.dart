import 'package:projectflow_web/core/dependencyInjection/dependency_injector.dart';
import 'package:projectflow_web/core/services/firebase_notification_service.dart';
import 'package:projectflow_web/datasource/remotedatasource/notification_data_source.dart';
import 'package:projectflow_web/datasource/repositoryImp/notification_repo_impl.dart';
import 'package:projectflow_web/domain/repository/notification_repository.dart';
import 'package:projectflow_web/presentation/features/notifications/bloc/notification_bloc.dart';

class NotificationDependencies {
  NotificationDependencies._();

  static void init() {
    getIt.registerLazySingleton<NotificationDataSource>(
        () => NotificationDataSourceImpl(getIt()));
    getIt.registerLazySingleton<NotificationRepository>(
        () => NotificationRepositoryImpl(getIt(), getIt()));
    getIt.registerLazySingleton<NotificationBloc>(
        () => NotificationBloc(getIt()));
    getIt.registerLazySingleton(() => FirebaseNotificationService());
  }
}
