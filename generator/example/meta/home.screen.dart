import 'package:syntaxify/syntaxify.dart';

/// Home screen definition - main dashboard after login
final homeScreen = ScreenDefinition(
  id: 'home',
  appBar: AstNode.appBar(title: 'Dashboard'),
  layout: AstNode.column(
    children: [
      AstNode.text(
        text: 'Welcome Back!',
        variant: TextVariant.headlineMedium,
      ),
      AstNode.text(
        text: 'Here\'s your overview for today',
        variant: TextVariant.bodyMedium,
      ),
      AstNode.spacer(size: SpacerSize.lg),

      // Stats Row
      AstNode.row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AstNode.column(
            children: [
              AstNode.text(text: '12', variant: TextVariant.headlineMedium),
              AstNode.text(text: 'Tasks', variant: TextVariant.labelSmall),
            ],
          ),
          AstNode.column(
            children: [
              AstNode.text(text: '5', variant: TextVariant.headlineMedium),
              AstNode.text(text: 'Completed', variant: TextVariant.labelSmall),
            ],
          ),
          AstNode.column(
            children: [
              AstNode.text(text: '3', variant: TextVariant.headlineMedium),
              AstNode.text(text: 'Pending', variant: TextVariant.labelSmall),
            ],
          ),
        ],
      ),
      AstNode.spacer(size: SpacerSize.xl),

      // Action Buttons
      AstNode.button(
        label: 'View All Tasks',
        variant: ButtonVariant.filled,
        onPressed: 'navigateToTasks',
      ),
      AstNode.spacer(size: SpacerSize.md),
      AstNode.button(
        label: 'Add New Task',
        variant: ButtonVariant.outlined,
        onPressed: 'addNewTask',
      ),
      AstNode.spacer(size: SpacerSize.md),
      AstNode.button(
        label: 'Settings',
        variant: ButtonVariant.text,
        onPressed: 'openSettings',
      ),
    ],
  ),
);
