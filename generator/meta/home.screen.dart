import 'package:syntaxify/syntaxify.dart';

/// Home screen definition - main dashboard after login
final homeScreen = ScreenDefinition(
  id: 'home',
  appBar: const App.appBar(title: 'Dashboard'),
  layout: App.column(
    children: [
      App.text(text: 'Welcome Back!', variant: 'headlineMedium'),
      App.text(text: 'Here\'s your overview for today', variant: 'bodyMedium'),
      App.spacer(size: SpacerSize.lg),

      // Stats Row
      App.row(
        mainAxisAlignment: MainAlignment.spaceEvenly,
        children: [
          App.column(
            children: [
              App.text(text: '12', variant: 'headlineMedium'),
              App.text(text: 'Tasks', variant: 'labelSmall'),
            ],
          ),
          App.column(
            children: [
              App.text(text: '5', variant: 'headlineMedium'),
              App.text(text: 'Completed', variant: 'labelSmall'),
            ],
          ),
          App.column(
            children: [
              App.text(text: '3', variant: 'headlineMedium'),
              App.text(text: 'Pending', variant: 'labelSmall'),
            ],
          ),
        ],
      ),
      App.spacer(size: SpacerSize.xl),

      // Action Buttons
      App.button(label: 'View All Tasks', onPressed: 'navigateToTasks'),
      App.spacer(size: SpacerSize.md),
      App.button(
        label: 'Add New Task',
        variant: 'outlined',
        onPressed: 'addNewTask',
      ),
      App.spacer(size: SpacerSize.md),
      App.button(label: 'Settings', variant: 'text', onPressed: 'openSettings'),
    ],
  ),
);
