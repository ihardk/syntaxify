import 'package:example/syntaxify/design_system/design_system.dart';
import 'package:syntaxify/syntaxify.dart';

/// Home screen definition - main dashboard after login
final homeScreen = ScreenDefinition(
  id: 'home',
  appBar: const App.appBar(title: 'Dashboard'),
  layout: App.column(
    children: [
      App.text(
        text: 'Welcome Back!',
        variant: TextVariant.headlineMedium,
      ),
      App.text(
        text: 'Here\'s your overview for today',
        variant: TextVariant.bodyMedium,
      ),
      App.spacer(size: SpacerSize.lg),

      // Stats Row
      App.row(
        mainAxisAlignment: MainAlignment.spaceEvenly,
        children: [
          App.column(
            children: [
              App.text(text: '12', variant: TextVariant.headlineMedium),
              App.text(text: 'Tasks', variant: TextVariant.labelSmall),
            ],
          ),
          App.column(
            children: [
              App.text(text: '5', variant: TextVariant.headlineMedium),
              App.text(text: 'Completed', variant: TextVariant.labelSmall),
            ],
          ),
          App.column(
            children: [
              App.text(text: '3', variant: TextVariant.headlineMedium),
              App.text(text: 'Pending', variant: TextVariant.labelSmall),
            ],
          ),
        ],
      ),
      App.spacer(size: SpacerSize.xl),

      // Action Buttons
      App.button(
        label: 'View All Tasks',
        onPressed: 'navigateToTasks',
      ),
      App.spacer(size: SpacerSize.md),
      App.button(
        label: 'Add New Task',
        variant: ButtonVariant.outlined.name,
        onPressed: 'addNewTask',
      ),
      App.spacer(size: SpacerSize.md),
      App.button(
        label: 'Settings',
        variant: ButtonVariant.text.name,
        onPressed: 'openSettings',
      ),
    ],
  ),
);
