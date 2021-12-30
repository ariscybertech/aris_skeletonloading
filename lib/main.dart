import 'package:flutter/material.dart';
import 'package:skeleton_loading_example/widget/skeleton_container.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String title = 'Skeleton Loading Screen';

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: title,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: MainPage(title: title),
      );
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    @required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool loading = true;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future loadData() async {
    setState(() {
      loading = true;
    });

    await Future.delayed(Duration(seconds: 4), () {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: loadData,
            ),
          ],
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(12),
          scrollDirection: Axis.vertical,
          separatorBuilder: (context, index) => Divider(),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) =>
              loading ? buildSkeleton(context) : buildResult(),
        ),
      );

  Widget buildSkeleton(BuildContext context) => Row(
        children: <Widget>[
          SkeletonContainer.circular(
            width: 70,
            height: 70,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SkeletonContainer.rounded(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 25,
              ),
              const SizedBox(height: 8),
              SkeletonContainer.rounded(
                width: 60,
                height: 13,
              ),
            ],
          ),
        ],
      );

  Widget buildResult() => Row(
        children: <Widget>[
          Container(
            child: Image.network(
              'https://images.unsplash.com/photo-1508697014387-db70aad34f4d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=400&q=80',
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Hello',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 8),
              Text(
                'Hello',
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
        ],
      );
}
