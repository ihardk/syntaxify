// GENERATED CODE - DO NOT MODIFY BY HAND
// Analyzed by Syntaxify

import 'package:flutter/material.dart';
import 'package:example/syntaxify/index.dart';
import 'package:example/syntaxify/design_system/design_system.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    this.navigateToTasks,
    this.addNewTask,
    this.openSettings,
  });

  final VoidCallback? navigateToTasks;

  final VoidCallback? addNewTask;

  final VoidCallback? openSettings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Column(
        children: [
          AppText(text: 'Welcome Back!', variant: TextVariant.headlineMedium),
          AppText(
            text: 'Here\'s your overview for today',
            variant: TextVariant.bodyMedium,
          ),
          Spacer(),
          Row(
            children: [
              Column(
                children: [
                  AppText(text: '12', variant: TextVariant.headlineMedium),
                  AppText(text: 'Tasks', variant: TextVariant.labelSmall),
                ],
              ),
              Column(
                children: [
                  AppText(text: '5', variant: TextVariant.headlineMedium),
                  AppText(text: 'Completed', variant: TextVariant.labelSmall),
                ],
              ),
              Column(
                children: [
                  AppText(text: '3', variant: TextVariant.headlineMedium),
                  AppText(text: 'Pending', variant: TextVariant.labelSmall),
                ],
              ),
            ],
          ),
          Spacer(),
          AppButton(label: 'View All Tasks', onPressed: navigateToTasks),
          Spacer(),
          AppButton(
            label: 'Add New Task',
            onPressed: addNewTask,
            variant: ButtonVariant.outlined,
          ),
          Spacer(),
          AppButton(
            label: 'Settings',
            onPressed: openSettings,
            variant: ButtonVariant.text,
          ),
        ],
      ),
    );
  }
}
