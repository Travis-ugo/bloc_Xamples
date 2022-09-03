import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

import '../../../lib_infinite_list/post/bloc/post_bloc.dart';
import '../../../lib_infinite_list/post/models/models.dart';

class MockClient extends Mock implements http.Client {}

Uri _postsUrl({required int startIndex}) {
  return Uri.https(
    'jsonplaceholder.typicode.com',
    '/posts',
    <String, String>{'_start': '$startIndex', '_limit': '20'},
  );
}

void main() {
  group('Post Bloc', () {
    const _mockPosts = [Post(id: 1, title: 'post title', body: 'post body')];

    const extraPosts = [
      Post(id: 2, title: 'post title', body: 'post body'),
    ];
    const multiPosts = [Post(id: 1, title: 'post title', body: 'post body')];

    late http.Client httpClient;

    setUpAll(() {
      registerFallbackValue(Uri());
    });

    setUp(() {
      httpClient = MockClient();
    });

    test('Initial state is PostState()', () {
      expect(PostBloc(httpClient: httpClient).state, const PostState());
    });

    group('PostFetched', () {
      blocTest<PostBloc, PostState>(
        'emits nothing whe post reach max limit',
        build: () => PostBloc(httpClient: httpClient),
        seed: () => const PostState(hasReachedMax: true),
        act: (bloc) => bloc.add(PostFetched()),
        expect: () => <PostState>[],
      );

      blocTest<PostBloc, PostState>(
        'emit successful status when http fetches initial post',
        setUp: (() {
          when(() => httpClient.get(any())).thenAnswer((_) async {
            return http.Response(
              '[{ "id": 1, "title": "post title", "body": "post body" }]',
              200,
            );
          });
        }),
        build: () => PostBloc(httpClient: httpClient),
        act: (bloc) => bloc.add(PostFetched()),
        expect: () => const <PostState>[
          PostState(
            status: PostStatus.success,
            posts: _mockPosts,
          ),
        ],
        verify: (_) {
          verify(() => httpClient.get(_postsUrl(startIndex: 0))).called(1);
        },
      );

      blocTest<PostBloc, PostState>(
        'drops new event while processing the current',
        setUp: (() {
          when(
            () => httpClient.get(any()),
          ).thenAnswer((_) async {
            return http.Response(
              '[{ "id": 1, "title": "post title", "body": "post body" }]',
              200,
            );
          });
        }),
        build: () => PostBloc(httpClient: httpClient),
        act: (bloc) => bloc
          ..add(PostFetched())
          ..add(PostFetched()),
        expect: () => const <PostState>[
          PostState(
            status: PostStatus.success,
            posts: _mockPosts,
          ),
        ],
        verify: (_) {
          verify(() => httpClient.get(any())).called(1);
        },
      );

      blocTest<PostBloc, PostState>(
        'throttle event',
        setUp: (() {
          when(() => httpClient.get(any())).thenAnswer((_) async {
            return http.Response(
              '[{ "id": 1, "title": "post title", "body": "post body" }]',
              200,
            );
          });
        }),
        build: () => PostBloc(httpClient: httpClient),
        act: (bloc) async {
          bloc.add(PostFetched());
          await Future<void>.delayed(Duration.zero);
          bloc.add(PostFetched());
        },
        expect: () => const <PostState>[
          PostState(
            status: PostStatus.success,
            posts: _mockPosts,
          ),
        ],
        verify: (_) {
          verify(() => httpClient.get(any())).called(1);
        },
      );

      blocTest<PostBloc, PostState>(
        'emits failure status when http fetches posts and throw exception',
        setUp: (() {
          when(() => httpClient.get(any())).thenAnswer((_) async {
            return http.Response('', 500);
          });
        }),
        build: () => PostBloc(httpClient: httpClient),
        act: (bloc) => bloc.add(PostFetched()),
        expect: () => const <PostState>[PostState(status: PostStatus.failure)],
        verify: (_) {
          verify(() => httpClient.get(any())).called(1);
        },
      );
      blocTest<PostBloc, PostState>(
        'emits successful status and reaches max posts when '
        '0 additional posts are fetched',
        setUp: (() {
          when(() => httpClient.get(any())).thenAnswer((_) async {
            return http.Response('[]', 200);
          });
        }),
        build: () => PostBloc(httpClient: httpClient),
        seed: () =>
            const PostState(status: PostStatus.success, posts: _mockPosts),
        act: (bloc) => bloc.add(PostFetched()),
        expect: () => const <PostState>[
          PostState(
            status: PostStatus.success,
            hasReachedMax: true,
            posts: _mockPosts,
          ),
        ],
        verify: (_) {
          verify(() => httpClient.get(_postsUrl(startIndex: 1))).called(1);
        },
      );

      blocTest<PostBloc, PostState>(
        'emits successful status and does not reach max posts '
        'when additional posts are fetched',
        setUp: (() {
          when(
            () => httpClient.get(any()),
          ).thenAnswer((_) async {
            return http.Response(
              '[{ "id": 2, "title": "post title", "body": "post body" }]',
              200,
            );
          });
        }),
        build: () => PostBloc(httpClient: httpClient),
        act: (bloc) => bloc.add(PostFetched()),
        seed: () => const PostState(
          status: PostStatus.success,
          posts: _mockPosts,
        ),
        expect: () => const <PostState>[
          PostState(
            status: PostStatus.success,
            posts: [..._mockPosts, ...extraPosts],
          ),
        ],
        verify: (_) {
          verify(() => httpClient.get(_postsUrl(startIndex: 1))).called(1);
        },
      );
    });
  });
}
