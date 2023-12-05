import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:login_page_1/utils/net/model/response.dart';
import 'package:login_page_1/utils/net/requester.dart';
import 'package:image_picker/image_picker.dart';

class myPage extends StatefulWidget {
  myPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<myPage> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  String userId = "";
  String imageUri = "";
  XFile? _image;

  final ImagePicker picker = ImagePicker();

  Future<void> getImage(ImageSource imageSource) async {
    //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path); //가져온 이미지를 _image에 저장
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    String? storedUserId = await storage.read(key: "login");
    setState(() {
      // 불러온 사용자 ID를 변수에 할당
      userId = storedUserId ?? "Default User";
    });
    try {
      // 사용자 프로필을 가져오고 결과를 처리합니다.
      ResponseWithModel result = await searchProfile(userId);

      if (result.status == 200) {
        print("User profile loaded successfully: ${result.data['name']}");
        print("User profile loaded successfully: ${result.data['profile']}");
        imageUri = result.data['profile'];
        print(imageUri);
      } else {
        // 서버 응답이 성공이 아닐 때의 처리
        print("Error loading user profile: ${result.data}");
      }
    } catch (error) {
      // 함수 호출 도중 예외가 발생했을 때의 처리
      print("Error during profile search: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 300,
          width: double.infinity,
          child: Column(children: [
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                    builder: (BuildContext) => AlertDialog(
                        title: const Text('프로필 변경'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildButton(),

                            // TextButton(
                            //   onPressed: () {
                            //     getImage(ImageSource.gallery);
                            //   },
                            //   child: const Text('사진 선택하기'),
                            // ),
                            // const SizedBox(
                            //   width: double.infinity,
                            //   height: 30,
                            // ),
                            // TextButton(
                            //     onPressed: () {
                            //       getImage(ImageSource.camera);
                            //     },
                            //     child: Text('사진 촬영하기')),
                            // SizedBox(
                            //   width: double.infinity,
                            //   height: 30,
                            // ),
                            // TextButton(onPressed: null, child: Text('기본이미지 선택'))
                          ],
                        )));
              },
              child: CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(
                    'http://3.39.231.7/user/profile?path=' + '$imageUri'),
              ),
            ),
            Text(
              "$userId 님",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            )
          ]),
        ),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 100,
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              const Padding(padding: EdgeInsets.all(10)),
              const Icon(Icons.person),
              const Padding(padding: EdgeInsets.all(35)),
              InkWell(
                  onTap: () {},
                  child: const Text('회원정보 수정',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Color(0xFF9F7BFF))))
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 100,
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              const Padding(padding: EdgeInsets.all(10)),
              const Icon(Icons.sell_sharp),
              const Padding(padding: EdgeInsets.all(45)),
              InkWell(
                  onTap: () {},
                  child: const Text('구매내역',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Color(0xFF9F7BFF))))
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 100,
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              const Padding(padding: EdgeInsets.all(10)),
              const Icon(Icons.sell_rounded),
              const Padding(padding: EdgeInsets.all(45)),
              InkWell(
                  onTap: () {},
                  child: const Text('판매내역',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Color(0xFF9F7BFF))))
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildPhotoArea() {
    return _image != null
        ? Container(
            width: 300,
            height: 300,
            child: Image.file(File(_image!.path)), //가져온 이미지를 화면에 띄워주는 코드
          )
        : Container(
            width: 300,
            height: 300,
            color: Colors.grey,
          );
  }

  Widget _buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            getImage(ImageSource.camera); //getImage 함수를 호출해서 카메라로 찍은 사진 가져오기
          },
          child: Text("카메라"),
        ),
        const SizedBox(width: 30),
        ElevatedButton(
          onPressed: () {
            getImage(ImageSource.gallery); //getImage 함수를 호출해서 갤러리에서 사진 가져오기
          },
          child: Text("갤러리"),
        ),
        ElevatedButton(
            onPressed: () async {
              await write();
            },
            child: Text('완료'))
      ],
    );
  }

  write() async {
    try {
      String base64Image1 = "";

      // if (null != _image) {
      //   //_image1가 null 이 아니라면
      //   final bytes = File(_image!.path).readAsBytesSync(); //image 를 byte로 불러옴

      //   base64Image1 = base64Encode(
      //       bytes); //불러온 byte를 base64 압축하여 base64Image1 변수에 저장 만약 null이였다면 가장 위에 선언된것처럼 공백으로 처리됨
      //   print(bytes);
      // }

      ResponseWithMessage updateImageResult =
          await updateImage(userId, _image!.path);
      print('2');

      switch (updateImageResult.status) {
        case 200:
          print('성공');
          break;
        case 401:
          print('이미지 변경 실패');
      }
    } catch (e) {
      print("에러: $e");
    }
  }
}
