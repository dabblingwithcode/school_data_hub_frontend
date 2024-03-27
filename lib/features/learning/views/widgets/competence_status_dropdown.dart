import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> categoryStatusItems = [
  DropdownMenuItem(
      value: 'white',
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      )),
  DropdownMenuItem(
      value: 'green',
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
      )),
  DropdownMenuItem(
      value: 'yellow',
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: const BoxDecoration(
          color: Colors.yellow,
          shape: BoxShape.circle,
        ),
      )),
  DropdownMenuItem(
      value: 'red',
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
      )),
];
