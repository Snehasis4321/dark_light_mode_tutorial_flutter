import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dark_light_mode_tutorial_flutter/theme_data.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final savedTheme=await AdaptiveTheme.getThemeMode();
  runApp( MyApp(savedTheme: savedTheme,));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedTheme;
  const MyApp({super.key, this.savedTheme});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(initial:savedTheme?? AdaptiveThemeMode.system,
    light:  lightTheme,
    dark: darkTheme,builder: (light, dark) => 
     MaterialApp(
        title: 'Dark Light Mode Tutorial',
        theme: light,
        darkTheme: dark,
        home: const MyHomePage(title: 'Dark Light Mode Tutorial'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text(
                  'You are using ${AdaptiveTheme.of(context).mode.toString().split(".")[1].toUpperCase()} MODE',
                  style: TextStyle(fontSize: 18),
                             ),
                             SizedBox(width: 10,),
                              AdaptiveTheme.of(context).mode==AdaptiveThemeMode.dark? Icon(Icons.dark_mode): Icon(Icons.light_mode,color: Colors.orange,)
               ],
             ),
             SizedBox(height: 10,),
            RadioListTile<AdaptiveThemeMode>(title: Text("Dark"),value: AdaptiveThemeMode.dark, groupValue: AdaptiveTheme.of(context).mode, onChanged: (value){
              setState(() {
                AdaptiveTheme.of(context).setDark();
              });
            }),
            RadioListTile<AdaptiveThemeMode>(title: Text("Light"),value: AdaptiveThemeMode.light, groupValue: AdaptiveTheme.of(context).mode, onChanged: (value){
              setState(() {
                AdaptiveTheme.of(context).setLight();
              });
            }),
            RadioListTile<AdaptiveThemeMode>(title: Text("System"),value: AdaptiveThemeMode.system, groupValue: AdaptiveTheme.of(context).mode, onChanged: (value){
              setState(() {
                AdaptiveTheme.of(context).setSystem();
              });
            }),
           
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          setState(() {
            AdaptiveTheme.of(context).mode==AdaptiveThemeMode.dark?
            AdaptiveTheme.of(context).setLight():AdaptiveTheme.of(context).setDark();
          });
        },
        tooltip: 'Change Theme',
        child:  AdaptiveTheme.of(context).mode==AdaptiveThemeMode.dark? Icon(Icons.light_mode): Icon(Icons.dark_mode),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
