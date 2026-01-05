import 'package:projectflow_web/core/dependencyInjection/dependency_injector.dart';
import 'package:projectflow_web/datasource/remotedatasource/meeting_data_source.dart';
import 'package:projectflow_web/datasource/repositoryImp/meetin_repo_impl.dart';
import 'package:projectflow_web/domain/repository/meeting_repository.dart';
import 'package:projectflow_web/presentation/features/meetings/videocallbloc/video_call_bloc.dart';

import '../../../presentation/features/meetings/meetingbloc/meeting_bloc.dart';
import '../../helpers/signaling_service.dart';

class MeetingDependencies {
  MeetingDependencies._() ;
  static void init() {
    getIt.registerLazySingleton<MeetingDataSource>(
            () => MeetingDataSourceImpl(getIt()));
    getIt.registerLazySingleton<MeetingRepository>(
            () => MeetingRepositoryImpl(getIt(), getIt()));
    getIt.registerLazySingleton<MeetingBloc>(
            () => MeetingBloc(getIt() ,getIt()));
    getIt.registerLazySingleton<  SignalingService>(
            () => SignalingService());
    getIt.registerLazySingleton<VideoCallBloc>(
            () => VideoCallBloc(getIt()));
  }
}