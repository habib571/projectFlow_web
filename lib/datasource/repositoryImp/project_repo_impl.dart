import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:projectflow_web/core/api/error_handler.dart';
import 'package:projectflow_web/core/api/failure.dart';
import 'package:projectflow_web/core/network/internet_checker.dart';
import 'package:projectflow_web/datasource/remotedatasource/project_remote_data_source.dart';
import 'package:projectflow_web/datasource/requests/add_member_request.dart';
import 'package:projectflow_web/datasource/requests/pagination_request.dart';
import 'package:projectflow_web/datasource/responses/projects_response.dart';
import 'package:projectflow_web/datasource/responses/users_response.dart';
import 'package:projectflow_web/domain/models/member_model.dart';
import 'package:projectflow_web/domain/models/project_model.dart';
import 'package:projectflow_web/domain/repository/project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectDataSource _projectDataSource;
  final NetworkInfo _networkInfo;
  ProjectRepositoryImpl(this._projectDataSource, this._networkInfo);

  @override
  Future<Either<Failure, ProjectModel>> addProject(ProjectModel projectRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _projectDataSource.addProject(projectRequest) ;
        if (response.statusCode == 200) {
          return Right(ProjectModel.fromJson(response.data));
        } else {
          return Left(Failure.fromJson(response.data));
        }
      } catch (error) {
        log( "errrorr:$error") ;
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }

  @override
  Future<Either<Failure, ProjectsResponse>> getMyProjects(PaginationRequest pagination) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _projectDataSource.getProjects(pagination);
        if (response.statusCode == 200) {
          return Right(ProjectsResponse.fromJson(response.data));
        } else {
          return Left(Failure.fromJson(response.data));
        }
      } catch (error) {
        log("errrorr:$error");
        return Left(ErrorHandler
            .handle(error)
            .failure);
      }
    }
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }
  @override
  Future<Either<Failure, UsersResponse>> searchUser(PaginationRequest pagination ,String query) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _projectDataSource.searchUser(pagination ,query);
        if (response.statusCode == 200) {
          return Right(UsersResponse.fromJson(response.data));
          } else {
          return Left(Failure.fromJson(response.data));
        }
      } catch (error) {
        log("errrorr:$error");
        return Left(ErrorHandler
            .handle(error)
            .failure);
      }
    }
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }

  @override
  Future<Either<Failure, MemberModel>> addMember(AddMemberRequest addMemberRequest)async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _projectDataSource.addMember(addMemberRequest) ;
        if (response.statusCode == 200) {
          return Right(MemberModel.fromJson(response.data));
        } else {
          return Left(Failure.fromJson(response.data));
        }
      } catch (error) {
        log( "errrorr:$error") ;
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }

  @override
  Future<Either<Failure, List<MemberModel>>> getProjectMembers(int projectId) async{
    if (await _networkInfo.isConnected) {
      try {
        final response = await _projectDataSource.getProjectMember(projectId) ;
        if (response.statusCode == 200) {
          final List<Map<String, dynamic>> responseData = List<Map<String, dynamic>>.from(response.data);
          final members = responseData.map((projectJson) => MemberModel.fromJson(projectJson)).toList();
          return Right(members) ;
        } else {
          return Left(Failure.fromJson(response.data));
        }
      }
      catch (error) {
        log(error.toString()) ;
        return Left(ErrorHandler.handle(error).failure);
      }
    }
    return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  }

  }



