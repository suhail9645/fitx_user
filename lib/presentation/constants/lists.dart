import 'package:flutter/material.dart';

const List<String> pagesNames = [
  'IMAGES',
  'CATEGORIES',
  'EXERCISES',
  'TRAINER'
];

final TextEditingController fullName = TextEditingController();
final TextEditingController registerGmail = TextEditingController();
final TextEditingController dateOfBirth = TextEditingController();
final TextEditingController registerPassword = TextEditingController();
final TextEditingController loginEmail = TextEditingController();
final TextEditingController loginPassword = TextEditingController();
final TextEditingController userName = TextEditingController();
final TextEditingController exerciceDescription = TextEditingController();
final TextEditingController focused_area = TextEditingController();

final List<TextEditingController> registerPageTextEditingControllers = [
  fullName,
  registerGmail,
  dateOfBirth,
  userName,
  registerPassword
];

const List<String> categoryAddPageTextEditingControllerHint = [
  'Category name',
  'Description',
  'music Url'
];

final List<String> registerPageTextEditingControllerHint = [
  'Full name',
  'Email',
  'Date of Birth',
  'user name',
  'Password',
];

final List<String> loginPageTextEditingControllerHint = [
  'UserName',
  'Password',
];

final List<TextEditingController> loginPageTextEditingControllers = [
  loginEmail,
  loginPassword
];

final List<String> welcomeImages = [
  'assets/welcome1.jpg',
  'assets/welcome2.jpg',
  'assets/welcome3.jpg'
];
final List<String> welcomeTexts = [
  'FIT YOUR BODY\nThrough 20+ Categories',
  'BURN YOUR CALORY\nThrough 50+ Exercise',
  'ACTION IS THE\nKey To All Success'
];
