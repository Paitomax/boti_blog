import 'package:botiblog/src/home/user_news/user_news_tab_texts.dart';
import 'package:botiblog/src/shared/widgets/boti_flat_button.dart';
import 'package:flutter/material.dart';

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
              child: TextFormField(
                maxLength: 280,
                decoration: InputDecoration(
                  hintText: UserNewsTabTexts.publishHint,
                  hintStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
            BotiFlatButton(
              text: UserNewsTabTexts.publishButton,
              onPressed: () {},
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
