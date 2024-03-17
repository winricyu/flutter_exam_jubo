import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
      },tooltip: '新增住民',),
      body: Center(
        child: Text('UserScreen'),
      ),
    );
  }
}
