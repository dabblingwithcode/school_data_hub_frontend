import 'package:flutter/material.dart';

void informationDialog(context, title, text) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(text),
        actions: [
          TextButton(
            child: const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Text(
                'OK',
                style: TextStyle(
                  color: Color.fromRGBO(74, 76, 161, 1),
                ),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
