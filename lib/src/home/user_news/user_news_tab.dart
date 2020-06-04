import 'package:botiblog/src/home/user_news/user_news_bloc.dart';
import 'package:botiblog/src/home/user_news/user_news_state.dart';
import 'package:botiblog/src/home/user_news/user_news_tab_texts.dart';
import 'package:botiblog/src/shared/widgets/boti_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserNewsTab extends StatefulWidget {
  @override
  _UserNewsTabState createState() => _UserNewsTabState();
}

class _UserNewsTabState extends State<UserNewsTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 24),
            Text(
              UserNewsTabTexts.introduceMessage,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
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
            SizedBox(height: 8),
            BlocBuilder<UserNewsBloc, UserNewsState>(
              builder: (context, state) {
                if (state is UserNewsLoadSuccess) {
                  return ListView.builder(
                    itemBuilder: (listViewContext, index) {
                      return Card(
                        child: Text('item $index'),
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
