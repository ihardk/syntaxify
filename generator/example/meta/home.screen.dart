import 'package:syntaxify/syntaxify.dart';

/// Home screen definition - main dashboard after login
final homeScreen = ScreenDefinition(
  id: 'home',
  appBar: LayoutNode.appBar(title: 'Dashboard'),
  layout: LayoutNode.column(
    children: [
      LayoutNode.text(
        text: 'Welcome Back!',
        variant: TextVariant.headlineMedium,
      ),
      LayoutNode.text(
        text: 'Here\'s your overview for today',
        variant: TextVariant.bodyMedium,
      ),
      LayoutNode.spacer(size: SpacerSize.lg),

      // Stats Row
      LayoutNode.row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          LayoutNode.column(
            children: [
              LayoutNode.text(text: '12', variant: TextVariant.headlineMedium),
              LayoutNode.text(text: 'Tasks', variant: TextVariant.labelSmall),
            ],
          ),
          LayoutNode.column(
            children: [
              LayoutNode.text(text: '5', variant: TextVariant.headlineMedium),
              LayoutNode.text(text: 'Completed', variant: TextVariant.labelSmall),
            ],
          ),
          LayoutNode.column(
            children: [
              LayoutNode.text(text: '3', variant: TextVariant.headlineMedium),
              LayoutNode.text(text: 'Pending', variant: TextVariant.labelSmall),
            ],
          ),
        ],
      ),
      LayoutNode.spacer(size: SpacerSize.xl),

      // Action Buttons
      LayoutNode.button(
        label: 'View All Tasks',
        variant: ButtonVariant.filled,
        onPressed: 'navigateToTasks',
      ),
      LayoutNode.spacer(size: SpacerSize.md),
      LayoutNode.button(
        label: 'Add New Task',
        variant: ButtonVariant.outlined,
        onPressed: 'addNewTask',
      ),
      LayoutNode.spacer(size: SpacerSize.md),
      LayoutNode.button(
        label: 'Settings',
        variant: ButtonVariant.text,
        onPressed: 'openSettings',
      ),
    ],
  ),
);
