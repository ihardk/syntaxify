part of '../../design_system.dart';

mixin CupertinoSuperCardRenderer on DesignStyle {
  @override
  SuperCardTokens get superCardTokens =>
      SuperCardTokens.fromFoundation(foundation);

  @override
  Widget renderSuperCard({bool value = true}) {
    // STUB: Implement me!
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        border: Border.all(color: Colors.red),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SuperCard (Cupertino)',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          Text('value: $value'),
        ],
      ),
    );
  }
}
