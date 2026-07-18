import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/ai_insight_entities.dart';
import '../../domain/repositories/ai_assistant_repository.dart';
import '../datasources/ai_assistant_remote_data_source.dart';

class AiAssistantRepositoryImpl implements AiAssistantRepository {
  final AiAssistantRemoteDataSource remoteDataSource;
  AiAssistantRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, AiInsightResponse>> getAiInsights({
    required int page,
    required int limit,
    required bool unseenOnly,
  }) async {
    try {
      final result = await remoteDataSource.getAiInsights(page, limit, unseenOnly);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, List<AiInsightEntity>>> generateFreshInsights() async {
    try {
      final result = await remoteDataSource.generateFreshInsights();
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> markInsightAsSeen(String id) async {
    try {
      await remoteDataSource.markInsightAsSeen(id);
      return const Right(unit);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> submitFeedback({
    required String insightId,
    required int rating,
    String? comment,
  }) async {
    try {
      final Map<String, dynamic> body = {'insightId': insightId, 'rating': rating};
      if (comment != null) body['comment'] = comment;

      await remoteDataSource.submitFeedback(body);
      return const Right(unit);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getAdminFeedback({
    required int page,
    required int limit,
  }) async {
    try {
      // 🟢 استدعاء الـ Remote Data Source المحدثة بالخامسة
      final result = await remoteDataSource.getAdminFeedback(page: page, limit: limit);
      return Right(result);
    } on ServerException catch (error) {
      return Left(ServerFailure(error.message));
    }
  }
}