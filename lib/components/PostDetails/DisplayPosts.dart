import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/components/PostDetails/bloc/postdetails_bloc.dart';
import 'package:health_plus/components/PostDetails/comment.dart';
import 'package:health_plus/models/Post.dart';

import 'bloc/postDetails.dart';

class PostDetails extends StatefulWidget {
  final Post post;

  const PostDetails({Key key, this.post}) : super(key: key);
  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  @override
  Widget build(BuildContext context) {
    Post post = ModalRoute.of(context).settings.arguments;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) {
          var dets = PostdetailsBloc();
          dets.add(LoadComments(post));
          return dets;
        }),
      ],
      child: Content(post),
    );
  }
}

class Content extends StatelessWidget {
  final Post post;
  Content(this.post);
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostdetailsBloc, PostdetailsState>(
        builder: (context, state) {
      return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
              child: ListView.builder(
            itemBuilder: (context, index) {
              if (state is CommentsLoadSuccess) {
                List<Comment> comments = state.comments;
                if (index == 0) {
                  return Padding(
                      padding: EdgeInsets.all(10), child: Text(post.title));
                }

                if (index == 1) {
                  return Padding(
                      padding: EdgeInsets.all(10), child: Text(post.content));
                }
                if (index == 2) {
                  return OutlineButton(
                    child: Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.arrow_upward),
                            onPressed: () {
                              BlocProvider.of<PostdetailsBloc>(context)
                                  .add(ToggleLikePost(post));
                            }),
                        Text(post.likesCount.toString())
                      ],
                    ),
                    onPressed: () {},
                  );
                }
                if (index == 3) {
                  return Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            controller: commentController,
                            decoration: InputDecoration(
                              hintText: 'Add comment',
                              border: OutlineInputBorder(),
                            )),
                      ),
                      IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            BlocProvider.of<PostdetailsBloc>(context)
                                .add(SendComment(commentController.text, post));
                          }),
                    ],

                    //ADD COMMENTS
                  );
                } else if (index > 3) {
                  return ListTile(
                      title: InkWell(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(comments[index - 4].content != null
                              ? comments[index - 4].content
                              : 'this is a random text that i am generating in order to fill in the empty text'),
                        ),
                        SizedBox(height: 20),
                        IconButton(
                          icon: Icon(Icons.save),
                          onPressed: () {
                            BlocProvider.of<PostdetailsBloc>(context).add(
                                ToggleLikeComment(comments[index - 4].key));
                          },
                        )
                      ],
                    ),
                  ));
                }
              } else
                return CircularProgressIndicator();
            },
            itemCount:
                state is CommentsLoadSuccess ? state.comments.length : null,
            scrollDirection: Axis.vertical,
          )));
    });
  }

  comments(PostdetailsState state) {
    if (state is CommentsLoadSuccess) {
      List<Comment> comments = state.comments;
      return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
              title: InkWell(
            child: Row(
              children: [
                Expanded(
                  child: Text(comments[index].content != null
                      ? comments[index].content
                      : 'this is a random text that i am generating in order to fill in the empty text'),
                ),
                SizedBox(height: 20),
                IconButton(
                    icon: Icon(Icons.save),
                    onPressed: () => print('like/unlike'))
              ],
            ),
          ));
        },
        itemCount: comments.length,
      );
    }
  }
}
