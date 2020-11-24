import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_plus/components/Data/FakeDataGenerator.dart';
import 'package:health_plus/components/PostDetails/DisplayPosts.dart';
import 'package:health_plus/components/Home_page/bloc/Page_bloc/home_page_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/app_bar_bloc/appBarBloc.dart';
import 'bloc/Page_bloc/bloc.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) {
          final home = HomePageBloc();
          home.add(FetchPostsEvent());
          return home;
        }),
        BlocProvider(create: (_) {
          final appBar = HomeAppBarBloc();
          appBar.add(InitialAppBarEvent());
          return appBar;
        }),
      ],
      child: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: AppBarTitle(),
              actions: homeMenuActions(state),
            ),
            body: SafeArea(
              child: Container(
                  // color: state is HomeView ? Colors.red : Colors.blue,
                  child: buildContainer(state)),
            ),
          );
        },
      ),
    );
  }

  Widget buildContainer(HomePageState state) {
    if (state is HomePageLoading) {
      // print('wait....loading');
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state is PostsLoadSuccess) {
      return RefreshIndicator(
          child: ListView(
            scrollDirection: Axis.vertical,
            controller: scrollController,
            children: state.list
                .map((e) => ListTile(
                        title: InkWell(
                      child: Column(
                        children: [
                          Text(e.title),
                          SizedBox(height: 20),
                          Text(e.content),
                          SizedBox(height: 70),
                        ],
                      ),
                      onTap: () async {
                        await Navigator.of(context)
                            .pushNamed('/postDetails', arguments: e);
                      },
                    )))
                .toList(),
          ),
          onRefresh: () async => print('refresh complete'));
    }
    if (state is PostsLoadFailure) {
      return Container(
          child: Center(
        child: Text('error while trying to load'),
      ));
    } else
      return Container(
          child: Center(
        child: Text(state.toString()),
      ));
    // var _fateDate = GenerateFakeData();
    // return Column(
    //   children: [
    //     ButtonBar(alignment: MainAxisAlignment.spaceEvenly, children: [
    // RaisedButton(
    //   color: Colors.green,
    //   onPressed: () async {
    //     final auth = Authentication_Repo();

    //     BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
    //     await auth.signOut();
    //   },
    //   child: Text('signOut'),
    // ),
    // RaisedButton(
    //   color: Colors.red,
    //   onPressed: () async {
    //     final auth = Authentication_Repo();
    //     BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
    //     await auth.delete();
    //   },
    //   child: Text('Delete Acount'),
    // ),
    // OutlineButton(onPressed: counter),
    // Text(value.toString()),

    // RaisedButton(
    //   onPressed: _fateDate.populateFollowers,
    //   child: Text('create user_groups'),
    // ),
    //     ]),
    //   ],
    // );
    //   ],
    // );
  }

  homeMenuActions(HomePageState state) {
    return [
      IconButton(
          icon: Icon(Icons.chat_bubble),
          onPressed: () async {
            BlocProvider.of<HomePageBloc>(context).add(UserJoinedGroup());
            if (state is PostingStatus)
              newChat(state.userGroups);
            else
              Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('cant post until you join a group')));
          }),
    ];
  }

  // @override
  // bool get wantKeepAlive => true;

  void newChat(List<String> userGroups) {
    Navigator.of(context).pushNamed('/GroupChat', arguments: userGroups);
  }
}

class AppBarTitle extends StatefulWidget {
  const AppBarTitle({Key key}) : super(key: key);
  @override
  _AppBarTitleState createState() => _AppBarTitleState();
}

class _AppBarTitleState extends State<AppBarTitle>
// with AutomaticKeepAliveClientMixin
{
  final List<DropdownMenuItem<String>> dropMenu = HomeViewState.values
      .map((e) => DropdownMenuItem<String>(
            value: e.toString().split('.').last,
            child: Text(e.toString().split('.').last),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    // super.build(context);

    return BlocBuilder<HomeAppBarBloc, AppBarState>(builder: (context, state) {
      return DropdownButton(
          items: dropMenu,
          value: state.status,
          onChanged: (value) {
            if (value != state.status) {
              BlocProvider.of<HomeAppBarBloc>(context)
                  .add(ChangedAppBarEvent());
              BlocProvider.of<HomePageBloc>(context).add(FetchPostsEvent());
            } else
              return;
          });
    });
  }

  // @override
  // bool get wantKeepAlive => true;
}
