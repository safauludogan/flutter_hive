import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hive/model/student.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  //runApp(const MyApp()); Yapısı çalışmadan önce yapılması gereken çoz fazla işlem varsa bu kodu ekliyoruz
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter('application');
  //encrypted(şifreleme hive)
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  var containsEncryptionKey = await secureStorage.containsKey(key: 'key');
  if(!containsEncryptionKey){
    var key = Hive.generateSecureKey();
    await secureStorage.write(key: 'key', value: base64UrlEncode(key));
  }

  var encryptionKey = base64Url.decode(await secureStorage.read(key: 'key')??'safa');
  print('Encryption key: $encryptionKey');

  var sifreliKutu = await Hive.openBox('ozel',encryptionCipher: HiveAesCipher(encryptionKey));
  await sifreliKutu.put('secret', 'Hive is cool');
  await sifreliKutu.put('sifre', '123456');

  print(sifreliKutu.get('secret'));
  print(sifreliKutu.get('sifre'));

  await Hive.initFlutter('application');
  await Hive.openBox('test');

  Hive.registerAdapter(StudentAdapter());
  Hive.registerAdapter(EyeColorAdapter());
  await Hive.openBox<Student>('students');

  await Hive.openLazyBox<int>('numbers');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

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
  int _counter = 0;

  void _incrementCounter() async{
    var box = Hive.box('test');
    await box.clear();
    box.add('safa');
    box.add('uludoğan');
    box.add(true);
    box.add(1234);
    //await box.addAll(['liste1','liste2',false,1233]);

    await box.put('tc', '12312313123');
    await box.put('tema', 'dark');
   /* await box.putAll({
      'araba':'mercedes',
      'yil':2012
    });*/

    // box.values.forEach((element) {
    //   debugPrint(element.toString());
    // });

    debugPrint(box.toMap().toString());
    debugPrint(box.get('tema'));
    debugPrint(box.getAt(0));
    debugPrint(box.get(0));

    debugPrint(box.get('tc'));
    debugPrint(box.getAt(4));
    debugPrint(box.length.toString());
    await box.delete('tc');
    await box.deleteAt(0);
    debugPrint(box.toMap().toString());
    await box.putAt(1, 'Yeni değer');
    debugPrint(box.toMap().toString());

    await box.put('isim', 'safa');
    await box.put('isim', 'hasan');
    debugPrint(box.toMap().toString());
  }

  void _lazyAndEncrytedBox() async {
    var numbers = Hive.lazyBox<int>('numbers');
    for(int i=0; i<50;i++){
     await numbers.add(i*50);
    }

    for(int i=0; i<50;i++){
      debugPrint((await numbers.get(i)).toString());
    }
  }

  void _customData() async{
    var safa = Student(5, 'Safa', EyeColor.MAVI);
    var ferhat = Student(6, 'Ferhat', EyeColor.SIYAH);

    var box = Hive.box<Student>('students');
    await box.clear();

    box.add(safa);
    box.add(ferhat);

    box.put('safa', safa);
    box.put('ferhat', ferhat);

    debugPrint(box.toMap().toString());
  }

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
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _lazyAndEncrytedBox,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
