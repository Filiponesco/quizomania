import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quizomania/blocs/category_blocs/category_bloc.dart';
import 'package:quizomania/models/category.dart';
import 'package:quizomania/services/repository.dart';
import 'package:mockito/mockito.dart';

class MockRepository extends Mock implements Repository{}

void main() {
  MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
  });

    group('CategoryBloc', () {
      blocTest(
        'Initialize',
        build: () => CategoryBloc(mockRepository),
        expect: [],
      );

      blocTest(
        'LoadCategories',
        build: () => CategoryBloc(mockRepository),
        act: (bloc) => bloc.add(LoadCategories()),
        expect: [isA<LoadingCategories>(), isA<CategoryList>()],
        verify: (_){
          verify(mockRepository.getAllCategories()).called(1);
        }
      );
    });
}