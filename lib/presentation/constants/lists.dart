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
final TextEditingController exerciseGoal = TextEditingController();
final TextEditingController caloryGoal = TextEditingController();
final TextEditingController categoryGoal = TextEditingController();
final TextEditingController trainerPhoneNumber = TextEditingController();
final TextEditingController trainerExperience = TextEditingController();
final TextEditingController currentWeight = TextEditingController();
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
const List<String> names = ['Exercises', 'Calory', 'Category'];

const List<String> reportPageWeight = ['Current', 'Heaviest', 'Lightest'];

final List<TextEditingController> goalControllers = [
  exerciseGoal,
  caloryGoal,
  categoryGoal
];
const List<String> goalHints = ['Exercise', 'Calory', 'Category'];
const List<String> profileList = [
  'Invite Friends',
  'Privacy Policy',
  'Contact Us',
];
final List<TextEditingController> controllerListOfTrainerAddSection = [
  trainerPhoneNumber,
  trainerExperience
];
final List<String> hintListOfTrainerAddSection = ['Phone Number', 'Experience'];
const List<String> privacyPolicyList=['Your fullname','Your username','your images','your reports','your gmail'];