import 'package:bubadeira/Common/Constant.dart';
import 'package:bubadeira/Common/Rules.dart';
import 'package:bubadeira/Utils/rules/Rule.dart';
import 'package:bubadeira/Widgets/BottomNavBar.dart';
import 'package:flutter/material.dart';

class RuleListPage extends StatefulWidget {
  const RuleListPage({Key? key}) : super(key: key);

  @override
  _RuleListPageState createState() => _RuleListPageState();
}

class _RuleListPageState extends State<RuleListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.mainBackgroundColor,
      appBar: AppBar(
        backgroundColor: Constant.mainBackgroundColor,
        elevation: 0,
        title: Text(
          'Rules List',
          style: TextStyle(fontSize: 35),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: FutureBuilder(
          future: Rules.rules,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<Rule> rules = snapshot.data as List<Rule>;
              return ListView.separated(
                separatorBuilder: (_, __) => Divider(
                  color: Colors.black,
                ),
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(rules[index].name),
                    subtitle: Text(
                      rules[index].description,
                    ),
                  );
                },
                itemCount: rules.length,
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constant.buttonColor,
        child: Icon(
          Icons.add,
          size: 35,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomNavBar(
        activeIndex: 1,
      ),
    );
  }
}
