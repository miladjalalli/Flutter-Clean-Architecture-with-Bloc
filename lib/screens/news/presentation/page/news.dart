import 'package:clean_architecture_with_bloc_app/core/widgets/custom_snak_bar.dart';
import 'package:clean_architecture_with_bloc_app/screens/news/presentation/blocs/user_login/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';

import '../../domain/entities/get_news_response.dart';
import '../blocs/user_login/news_state.dart';

class NewsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final FocusNode _viewNode = FocusNode();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  CustomSnackBar _snackBar;
  bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = true;
  }

  @override
  void dispose() {
    _viewNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _snackBar = CustomSnackBar(key: Key("snackbar"), context: context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_viewNode),
      child: SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            body: BlocProvider<NewsBloc>(
              create: (BuildContext context) => GetIt.instance(),
              child: BlocBuilder<NewsBloc, NewsState>(
                builder: (context, state) {
                  if (state is LoadingNewsErrorState) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(state.message),
                          SizedBox(height: 32,),
                          ElevatedButton(onPressed: (){
                            BlocProvider.of<NewsBloc>(context).add(GetLastNewsFromDatabaseEvent());
                          },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:Theme.of(context).primaryColor, // set the background color
                                enableFeedback: true
                              ),
                              child: Text("Click to Load Last Saved News!"))
                        ],
                      ),
                    );
                  } else if (state is LoadingNewsState) {
                    return SpinKitThreeBounce(
                      color: Theme.of(context).accentColor,
                    );
                  } else if (state is LoadingNewsSuccessState) {
                    return ListView.builder(
                        itemBuilder: (context, i) {
                          return listItem(state.newsResponseDto.data[i]);
                        },
                        itemCount: state.newsResponseDto.data.length);
                  }
                  return Container();
                },
              ),
            )),
      ),
    );
  }

  Widget listItem(News news){
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(news.title, maxLines: 2, overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600
                          ),),
                        SizedBox(height: 8,),
                        Text(news.content, maxLines: 1, overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              fontWeight: FontWeight.normal
                          ),),
                      ],
                    ),
                  ),
                  SizedBox(width: 16,),
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
            Divider(color: Colors.black,)
          ],
        ));
  }
}
