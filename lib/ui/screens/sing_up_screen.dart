import 'package:login_page_1/utils/net/model/response.dart';
import 'package:login_page_1/utils/net/requester.dart';
import 'package:login_page_1/ui/dialog/dialog.dart';
import 'package:flutter/material.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen(
      {super.key,
      required this.controller,
      required this.setEmail,
      required this.setID,
      required this.setPassword,
      required this.setIdNum,
      required this.setPhNum,
      required this.setName});
  final PageController controller;
  final Function(String) setEmail;
  final Function(String) setID;
  final Function(String) setPassword;
  final Function(String) setIdNum;
  final Function(String) setPhNum;
  final Function(String) setName;

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phnumContoroller = TextEditingController();
  final TextEditingController _idnumContoroller = TextEditingController();
  final TextEditingController _repassController = TextEditingController();

  bool checkedID = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Image.asset(
                "assets/images/vector-2.png",
                width: 428,
                height: 457,
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                textDirection: TextDirection.ltr,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '회원가입',
                    style: TextStyle(
                      color: Color(0xFF755DC1),
                      fontSize: 27,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 170,
                        height: 56,
                        child: TextField(
                          controller: _idController,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF393939),
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: const InputDecoration(
                            labelText: '아이디',
                            hintText: '아이디를 입력하세요',
                            labelStyle: TextStyle(
                              color: Color(0xFF755DC1),
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(0xFF837E93),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(0xFF9F7BFF),
                              ),
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: SizedBox(
                            height: 56,
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () async {
                                ResponseWithMessage response =
                                    await checkDuplicateID(_idController.text);

                                String responseTitle = "";
                                String responseContent = response.message;

                                switch (response.status) {
                                  case 200:
                                    responseTitle = "축하합니다";
                                    setState(() {
                                      checkedID = true;
                                    });

                                    break;
                                  case 409:
                                    responseTitle = "죄송합니다";
                                    checkedID = false;
                                    break;
                                  case 500:
                                    responseTitle = "에러 발생";
                                    break;
                                }

                                // ignore: use_build_context_synchronously
                                createSmoothDialog(
                                  context,
                                  responseTitle,
                                  Text(responseContent),
                                  TextButton(
                                    child: const Text("닫기"),
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      try {
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
                                      } catch (e) {
                                        return;
                                      }
                                      return;
                                    },
                                  ),
                                  null,
                                  false,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF9F7BFF)),
                              child: const Text(
                                '중복 확인',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),

                  const SizedBox(
                    height: 17,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 135,
                        height: 56,
                        child: TextField(
                          controller: _passController,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF393939),
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: '비밀번호',
                            hintText: '비밀번호를 입력하세요',
                            hintStyle: TextStyle(
                              color: Color(0xFF837E93),
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                            labelStyle: TextStyle(
                              color: Color(0xFF755DC1),
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(0xFF837E93),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(0xFF9F7BFF),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 135,
                        height: 56,
                        child: TextField(
                          controller: _repassController,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF393939),
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: '비밀번호 확인',
                            hintText: '같은 비밀번호를 입력하세요',
                            hintStyle: TextStyle(
                              color: Color(0xFF837E93),
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                            labelStyle: TextStyle(
                              color: Color(0xFF755DC1),
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(0xFF837E93),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(0xFF9F7BFF),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 17),

                  SizedBox(
                    height: 56,
                    child: TextField(
                      controller: _emailController,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF393939),
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const InputDecoration(
                        labelText: '이메일',
                        hintText: 'example@email.com',
                        labelStyle: TextStyle(
                          color: Color(0xFF755DC1),
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xFF837E93),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xFF9F7BFF),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  SizedBox(
                    height: 56,
                    child: TextField(
                      controller: _idnumContoroller,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF393939),
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const InputDecoration(
                        labelText: '주민번호',
                        hintText: 'ex)xxxxxxxx-xxxxxxxx',
                        labelStyle: TextStyle(
                          color: Color(0xFF755DC1),
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xFF837E93),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xFF9F7BFF),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  //이름 전화번호 태그
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 135,
                        height: 56,
                        child: TextField(
                          controller: _nameController,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF393939),
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: const InputDecoration(
                            labelText: '이름',
                            hintText: '이름을 입력하세요',
                            hintStyle: TextStyle(
                              color: Color(0xFF837E93),
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                            labelStyle: TextStyle(
                              color: Color(0xFF755DC1),
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(0xFF837E93),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(0xFF9F7BFF),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 135,
                        height: 56,
                        child: TextField(
                          controller: _phnumContoroller,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF393939),
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: const InputDecoration(
                            labelText: '전화번호',
                            hintText: 'ex)000-0000-0000',
                            hintStyle: TextStyle(
                              color: Color(0xFF837E93),
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                            labelStyle: TextStyle(
                              color: Color(0xFF755DC1),
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(0xFF837E93),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(0xFF9F7BFF),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: SizedBox(
                        width: 329,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: checkedID
                              ? () async {
                                  String alertmsg = '';
                                  bool checkpw = true;
                                  bool checkid = true;
                                  bool checkemail = true;
                                  bool checkidnum = true;
                                  bool checkname = true;
                                  bool checkphnum = true;
                                  if (_passController.text.isEmpty) {
                                    alertmsg = '비밀번호 입력안됨';
                                    checkpw = false;
                                  }

                                  if (_passController.text.length < 8 &&
                                      _passController.text.length >= 15) {
                                    alertmsg = '비밀번호를 8자리 이상 15자리 이하로 입력해주세요';
                                    checkpw = false;
                                  }

                                  if (_passController.text !=
                                      _repassController.text) {
                                    alertmsg = '비밀번호 확인값이 일치하지 않습니다';
                                    checkpw = false;
                                  }

                                  if (!_passController.text
                                          .contains(RegExp(r'[0-9]')) ||
                                      !_passController.text
                                          .contains(RegExp(r'[a-zA-Z]'))) {
                                    checkpw = false;

                                    alertmsg = '비밀번호는 문자와 숫자를 모두 포함해야 합니다';
                                  }

                                  if (_emailController.text.isEmpty) {
                                    print('이메일 널값');
                                    checkemail = false;

                                    alertmsg = '이메일이 비어 있습니다';
                                  }

                                  if (!isValidEmail(_emailController.text)) {
                                    checkemail = false;
                                    alertmsg = '이메일 형식이 잘못 되었습니다';
                                  }

                                  if (!isValidIdnum(_idnumContoroller.text)) {
                                    alertmsg = '주민등록번호가 올바르지 않습니다';
                                    checkidnum = false;
                                  }

                                  if (_nameController.text.isEmpty) {
                                    alertmsg = '이름을 입력해주세요';
                                    checkname = false;
                                  }

                                  if (!isValidPhnum(_phnumContoroller.text)) {
                                    alertmsg = '올바른 전화번호 형식을 입력해 주세요';
                                    checkphnum = false;
                                  }

                                  if (checkid == true &&
                                      checkpw == true &&
                                      checkemail == true &&
                                      checkphnum == true &&
                                      checkidnum == true &&
                                      checkname == true) {
                                    widget.controller.animateToPage(4,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.ease);
                                  } else {
                                    createSmoothDialog(
                                      context,
                                      "회원가입 작성 오류",
                                      Text(alertmsg),
                                      TextButton(
                                        child: Text("닫기"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          try {
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();
                                          } catch (e) {
                                            return;
                                          }
                                          return;
                                        },
                                      ),
                                      null,
                                      false,
                                    );
                                  }
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: checkedID
                                  ? const Color(0xFF9F7BFF)
                                  : Colors.grey // 활성화된 버튼 배경색
                              ),
                          child: const Text(
                            '이메일 인증',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text(
                        ' 이미 계정이 있으십니까?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF837E93),
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 2.5,
                      ),
                      InkWell(
                        onTap: () {
                          widget.controller.animateToPage(0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        child: const Text(
                          '로그인 ',
                          style: TextStyle(
                            color: Color(0xFF755DC1),
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    // 이메일이 비어 있지 않고, 정규 표현식을 사용하여 형식을 확인합니다.
    if (email.isEmpty) {
      return false;
    }

    const emailPattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
    return RegExp(emailPattern).hasMatch(email);
  }

  bool isValidIdnum(String idnum) {
    if (idnum.isEmpty) {
      return false;
    }

    const idnumPattern = r'^\d{6}-[1-4]\d{6}$';
    return RegExp(idnumPattern).hasMatch(idnum);
  }

  bool isValidPhnum(String phnum) {
    if (phnum.isEmpty) {
      return false;
    }

    const phnumPattern = r'^010-?([0-9]{4})-?([0-9]{4})$';
    return RegExp(phnumPattern).hasMatch(phnum);
  }
}
