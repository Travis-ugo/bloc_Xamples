import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../lib_infinite_list/post/bloc/post_bloc.dart';
import '../../../lib_infinite_list/post/models/post.dart';
import '../../../lib_infinite_list/post/view/post_list.dart';
import '../../../lib_infinite_list/post/widgets/bottom_loader.dart';
import '../../../lib_infinite_list/post/widgets/post_list_items.dart';

class MockPostBloc extends MockBloc<PostEvent, PostState> implements PostBloc {}

extension on WidgetTester {
  Future<void> pumpPostList(PostBloc postBloc) {
    return pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: postBloc,
          child: const PostsList(),
        ),
      ),
    );
  }
}

void main() {
  var mockPost = List.generate(
    5,
    (index) => Post(id: index, title: 'post title', body: 'post body'),
  );
  late PostBloc postBloc;

  setUp(() {
    postBloc = MockPostBloc();
  });

  group('PostLists', () {
    testWidgets(
      'render circular progress indicator when status is initial',
      (tester) async {
        when(() => postBloc.state).thenAnswer((_) => const PostState());
        await tester.pumpPostList(postBloc);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
        'renders no posts text '
        'when post status is success but with 0 posts', (tester) async {
      when(() => postBloc.state).thenAnswer(
        (_) => const PostState(status: PostStatus.success),
      );
      await tester.pumpPostList(postBloc);
      expect(find.text('No available posts'), findsOneWidget);
    });

    testWidgets(
      'renders 5 posts and a bottom loader when post max is not reached yet',
      (tester) async {
        when(() => postBloc.state).thenAnswer(
            (_) => PostState(status: PostStatus.success, posts: mockPost));
        await tester.pumpPostList(postBloc);
        expect(find.byType(PostListItem), findsNWidgets(5));
        expect(find.byType(BottomLoader), findsOneWidget);
      },
    );

    testWidgets('does not render bottom loader when post max is reached',
        (tester) async {
      when(() => postBloc.state).thenAnswer(
        (_) => PostState(
          status: PostStatus.success,
          hasReachedMax: true,
          posts: mockPost,
        ),
      );
      await tester.pumpPostList(postBloc);
      expect(find.byType(PostListItem), findsNWidgets(5));
      expect(find.byType(BottomLoader), findsNothing);
    });

    testWidgets(
      'fetches more posts when scrolled to the bottom',
      (tester) async {
        when(() => postBloc.state).thenAnswer(
          (_) => PostState(
            status: PostStatus.success,
            posts: [...mockPost, ...mockPost],
          ),
        );
        await tester.pumpPostList(postBloc);
        await tester.drag(find.byType(PostsList), const Offset(0, -500));
        verify(() => postBloc.add(PostFetched())).called(1);
      },
    );

    testWidgets(
      'fails test when status code is fail',
      (tester) async {
        when(() => postBloc.state)
            .thenAnswer((_) => const PostState(status: PostStatus.failure));

        await tester.pumpPostList(postBloc);
        expect(find.text('Issue fetching posts'), findsOneWidget);
      },
    );
  });
}
