import 'package:flutter/material.dart';
import 'package:example/syntaxify/index.dart';

class OverviewTab extends StatelessWidget {
  final String currentStyleName;
  final Function(DesignStyle, String) onStyleChanged;

  const OverviewTab({
    super.key,
    required this.currentStyleName,
    required this.onStyleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 📝 SYNTAXIFY: AppText component
          AppText(
            text: 'Welcome to Syntaxify!',
            variant: TextVariant.displayLarge,
          ),
          const SizedBox(height: 16),

          AppText(
            text:
                'A multi-style design system for Flutter. One component API, multiple visual styles. Now with 7 interactive components!',
            variant: TextVariant.bodyLarge,
          ),
          const SizedBox(height: 24),

          // 🎨 PROMINENT DESIGN STYLE SWITCHER
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.withOpacity(0.1),
                  Colors.purple.withOpacity(0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.palette,
                      color: Theme.of(context).colorScheme.primary,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    AppText(
                      text: 'Choose Your Design Style',
                      variant: TextVariant.titleMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                AppText(
                  text: 'Watch all components transform instantly!',
                  variant: TextVariant.bodyMedium,
                ),
                const SizedBox(height: 20),

                // Style Selection Buttons
                Row(
                  children: [
                    Expanded(
                      child: _StyleCard(
                        title: 'Material',
                        subtitle: 'Android',
                        icon: Icons.android,
                        color: Colors.green,
                        isSelected: currentStyleName == 'Material',
                        onTap: () =>
                            onStyleChanged(MaterialStyle(), 'Material'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StyleCard(
                        title: 'Cupertino',
                        subtitle: 'iOS',
                        icon: Icons.apple,
                        color: Colors.grey,
                        isSelected: currentStyleName == 'Cupertino',
                        onTap: () =>
                            onStyleChanged(CupertinoStyle(), 'Cupertino'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StyleCard(
                        title: 'Neo',
                        subtitle: 'Modern',
                        icon: Icons.auto_awesome,
                        color: Colors.purple,
                        isSelected: currentStyleName == 'Neo',
                        onTap: () => onStyleChanged(NeoStyle(), 'Neo'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Feature Cards
          AppText(
            text: 'Key Features',
            variant: TextVariant.headlineMedium,
          ),
          const SizedBox(height: 16),

          _FeatureCard(
            icon: Icons.auto_awesome,
            title: 'Screen Generation from .screen.dart',
            description:
                'Create login.screen.dart → Run build → Get a full screen! Define UI structure, let Syntaxify generate the code.',
            highlighted: true,
          ),
          const SizedBox(height: 16),
          _FeatureCard(
            icon: Icons.palette,
            title: 'Multi-Style Design System',
            description:
                'One component API, three visual styles. Switch between Material, Cupertino, and Neo instantly!',
          ),
          const SizedBox(height: 16),
          _FeatureCard(
            icon: Icons.code,
            title: 'Type-Safe Code Generation',
            description:
                'Define components in meta files, get type-safe Flutter code automatically.',
          ),
          const SizedBox(height: 32),

          AppText(text: 'Quick Start', variant: TextVariant.headlineMedium),
          const SizedBox(height: 16),
          _buildQuickStartStep('1', 'Choose a design style above'),
          _buildQuickStartStep(
              '2', 'Explore Buttons, Inputs, and Controls tabs'),
          _buildQuickStartStep('3', 'Check the generated screen demo'),
          const SizedBox(height: 32),

          Center(
            child: AppButton.primary(
              label: 'View Documentation',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Check the GitHub repository for full docs'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStartStep(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppText(
              text: text,
              variant: TextVariant.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}

// Style Selection Card
class _StyleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _StyleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withOpacity(0.2)
              : Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : Colors.grey.withOpacity(0.3),
            width: isSelected ? 3 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected ? color : Colors.grey,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? color : Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            if (isSelected) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'ACTIVE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Feature Card
class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool highlighted;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: highlighted
            ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.6)
            : Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: highlighted
              ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
              : Theme.of(context).colorScheme.primary.withOpacity(0.2),
          width: highlighted ? 2 : 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: title,
                  variant: TextVariant.titleMedium,
                ),
                const SizedBox(height: 4),
                AppText(
                  text: description,
                  variant: TextVariant.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
