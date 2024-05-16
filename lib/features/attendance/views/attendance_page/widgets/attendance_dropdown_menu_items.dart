import 'package:flutter/material.dart';
import 'package:schuldaten_hub/common/constants/colors.dart';

// items for the missedType dropdown
List<DropdownMenuItem<String>> missedTypeMenuItems = [
  DropdownMenuItem(
      value: 'none',
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: const BoxDecoration(
          color: presentColor,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text("A",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
        ),
      )),
  DropdownMenuItem(
      value: 'late',
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: const BoxDecoration(
          color: lateColor,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text("V",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
        ),
      )),
  DropdownMenuItem(
      value: 'missed',
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: const BoxDecoration(
          color: missedColor,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text("F",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
        ),
      )),
  // DropdownMenuItem(
  //     value: 'home',
  //     child: Container(
  //       width: 30.0,
  //       height: 30.0,
  //       decoration: const BoxDecoration(
  //         color: homeColor,
  //         shape: BoxShape.circle,
  //       ),
  //       child: const Center(
  //         child: Text("H",
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontWeight: FontWeight.bold,
  //               fontSize: 18,
  //             )),
  //       ),
  //     )),
];

List<DropdownMenuItem<String>> dropdownContactedMenuItems = [
  DropdownMenuItem(
      value: '0',
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: const BoxDecoration(
          color: contactedQuestionColor,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text("?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
        ),
      )),
  DropdownMenuItem(
      value: '1',
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: const BoxDecoration(
          color: contactedSuccessColor, // Colors.green[100],
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(Icons.local_phone_rounded),
        ),
      )),
  DropdownMenuItem(
      value: '2',
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: const BoxDecoration(
          color: contactedCalledBackColor,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(
            Icons.phone_callback_rounded,
          ),
        ),
      )),
  DropdownMenuItem(
      value: '3',
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: const BoxDecoration(
          color: contactedFailedColor,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(Icons.phone_disabled_rounded),
        ),
      )),
];
