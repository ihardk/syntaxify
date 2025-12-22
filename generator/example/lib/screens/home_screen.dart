// GENERATED CODE - DO NOT MODIFY BY HAND
// Analyzed by Syntaxify

import 'package:flutter/material.dart';
import 'package:example/syntaxify/index.dart';

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
      appBar: AppBar(title: const AppText(text: 'Dashboard')),
      body: Column(
        children: [
          const AppText(text: 'Welcome Back!', variant: TextVariant.headlineMedium),
          const AppText(
            text: 'Here\'s your overview for today',
            variant: TextVariant.bodyMedium,
          ),
          const SizedBox(height: 16.0),
          const Row(
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
          const SizedBox(height: 16.0),
          AppButton(label: 'View All Tasks', onPressed: navigateToTasks),
          const SizedBox(height: 16.0),
          AppButton(label: 'Add New Task', onPressed: addNewTask),
          const SizedBox(height: 16.0),
          AppButton(label: 'Settings', onPressed: openSettings),
        ],
      ),
    );
  }
}
