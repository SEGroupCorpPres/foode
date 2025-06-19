import 'package:dartz/dartz.dart';
import 'package:foode/core/errors/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef DataMap = Map<String, dynamic>;
typedef DataList = List<DataMap>;
