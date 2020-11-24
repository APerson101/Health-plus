import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:health_plus/components/PostDetails/comment.dart';
import 'package:health_plus/models/Post.dart';

import '../Posts_repo.dart';
import 'postDetails.dart';

class PostdetailsBloc extends Bloc<PostdetailsEvent, PostdetailsState> {
  PostdetailsBloc() : super(PostdetailsInitial());
  PostsRepo postRepo = PostsRepo();
  @override
  Stream<PostdetailsState> mapEventToState(
    PostdetailsEvent event,
  ) async* {
    if (event is LoadComments) {
      //load comments
      yield EventLoading();
      try {
        var comments = await loadComments(event.post);

        yield CommentsLoadSuccess(comments);
      } catch (e) {
        print(e);
        yield EventFailure();
      }
    }
    if (event is SendComment) {
      // yield EventLoading();
      try {
        await saveComment(event.comment, event.post);
        // yield EventSuccessful();
      } catch (e) {
        // print(e);
        // yield EventFailure();
      }
    }

    if (event is ToggleLikePost) {
      try {
        await _toggleLikePost(event.post);
      } catch (err) {
        yield EventFailure();
      }
    }

    if (event is ToggleLikeComment) {
      try {
        await _toggleComment(event.key);
      } catch (err) {
        yield EventFailure();
      }
    }
  }

  Future saveComment(String comment, Post post) async {
    await postRepo.saveComment(comment, post);
  }

  Future<List<Comment>> loadComments(post) async {
    return await postRepo.loadComments(post);
  }

  Future _toggleLikePost(Post post) async {
    /**
     * transaction for like count?
     *  Like the thing,
     * 
     *  */

    await postRepo.toggleLikePost(post);
  }

  Future _toggleComment(String key) async {
    await postRepo.toggleLikeComment(key);
  }
}
