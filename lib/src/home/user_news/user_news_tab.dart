import 'package:botiblog/src/home/user_news/user_news_bloc.dart';
import 'package:botiblog/src/home/user_news/user_news_event.dart';
import 'package:botiblog/src/home/user_news/user_news_state.dart';
import 'package:botiblog/src/home/user_news/user_news_tab_texts.dart';
import 'package:botiblog/src/shared/theme/app_colors.dart';
import 'package:botiblog/src/shared/widgets/boti_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserNewsTab extends StatefulWidget {
  @override
  _UserNewsTabState createState() => _UserNewsTabState();
}

class _UserNewsTabState extends State<UserNewsTab> {
  @override
  void initState() {
    super.initState();
    context.bloc<UserNewsBloc>().add(UserNewsLoaded());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 16),
            Text(
              UserNewsTabTexts.introduceMessage,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Form(
              child: TextField(
                maxLength: 280,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32)),
                  hintText: UserNewsTabTexts.publishHint,
                  hintStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
            BotiFlatButton(
              text: UserNewsTabTexts.publishButton,
              onPressed: () {},
            ),
            SizedBox(height: 8),
            Divider(),

            SizedBox(height: 16),
            BlocBuilder<UserNewsBloc, UserNewsState>(
              builder: (context, state) {
                if (state is UserNewsLoadSuccess) {
                  return ListView.builder(
                    itemCount: state.posts.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (listViewContext, index) {
                      final item = state.posts[index];
                      return Card(

                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(item.userName, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: AppColors.blue )),
                              SizedBox(height: 4),
                              Text(item.text,style: TextStyle(color: AppColors.lightOrange )),
                              SizedBox(height: 4),

                              Align(
                                alignment: Alignment.centerRight,
                                  child: Text(item.date,style: TextStyle(fontSize: 12,color: Color(0xFFBABABA)),)),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is UserNewsLoadFailure) {
                  return Text('');
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
