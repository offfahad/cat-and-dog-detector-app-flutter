import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cat vs Dog',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   bool _loading = true;
  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    FilePickerResult? filePickerResult;
    File? image;
   

    chooseImage() async {
      if (Platform.isIOS || Platform.isAndroid) {
        final XFile? file = await picker.pickImage(source: ImageSource.gallery);
        if (file != null) {
          setState(() {
            image = File(file.path);
          });
        }
      } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
        // Use file_picker on web and desktop
        filePickerResult = await FilePicker.platform.pickFiles(
          type: FileType.image,
          allowMultiple: false,
        );

        if (filePickerResult != null) {
          setState(() {
            image = File(filePickerResult!.files.single.path!);
          });
        }
      }
    }

    captureImage() async {
      final XFile? file = await picker.pickImage(source: ImageSource.camera);
      if (file != null) {
        setState(() {
          image = File(file.path);
        });
      }
    }

    return Scaffold(
      backgroundColor: const Color(0XFF101010),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 85,
            ),
            const Text(
              'CNN Project',
              style: TextStyle(color: Color(0XFFEEDA28), fontSize: 18),
            ),
            const SizedBox(
              height: 6,
            ),
            const Text(
              'Detect Dogs and Cats',
              style: TextStyle(
                color: Color(0XFFE99600),
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: _loading
                  ? SizedBox(
                      width: 280,
                      child: Column(children: [
                        Image.asset('assets/cat.png'),
                        const SizedBox(
                          height: 50,
                        ),
                      ]),
                    )
                  : SizedBox(),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width - 150,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 17,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE99600),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text('Take a photo', style: TextStyle(color: Colors.white),),
                  ),
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width - 150,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 17,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE99600),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text('Camera roll', style: TextStyle(color: Colors.white),),
                  ),
                ),
              ]),
            )
            // image != null
            //     ? Image.file(image!)
            //     : const Icon(
            //         Icons.image,
            //         size: 150,
            //       ),
            // ElevatedButton(
            //   onPressed: () {
            //     chooseImage();
            //   },
            //   child: const Text('Gallary'),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // ElevatedButton(
            //     onPressed: () {
            //       captureImage();
            //     },
            //     child: const Text('Camera'))
          ],
        ),
      ),
    );
  }
}
