import 'package:flutter/material.dart';
import 'package:mark_example/data/dto/model/feature_model.dart';

class ItemFeatureWidget extends StatelessWidget {
  final FeatureModel feature;
  final VoidCallback onTap;

  const ItemFeatureWidget({
    super.key,
    required this.feature,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.45),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.12),
          child: Icon(feature.icon, color: Theme.of(context).colorScheme.primary),
        ),
        title: Text(
          feature.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(feature.desc),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}