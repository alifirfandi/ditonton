import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:tvshow/data/datasource/db/database_helper_tv.dart';
import 'package:tvshow/data/datasource/tv_local_data_source.dart';
import 'package:tvshow/data/datasource/tv_remote_data_source.dart';
import 'package:tvshow/domain/repositories/tv_repository.dart';

@GenerateMocks([
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  DatabaseHelperTv,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
