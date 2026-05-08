// lib/features/nail/presentation/screens/detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/nail_design.dart';
import '../cubits/nail_detail_cubit.dart';

class DetailScreen extends StatefulWidget {
  final NailDesign design;

  const DetailScreen({super.key, required this.design});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NailDetailCubit>().loadDesign(widget.design);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NailDetailCubit, NailDetailState>(
      builder: (context, state) {
        if (state is! NailDetailLoaded) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final design = state.design;

        return Scaffold(
          backgroundColor: AppTheme.scaffoldBackground,
          body: CustomScrollView(
            slivers: [
              _buildImageAppBar(context, design),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(context, design),
                      const SizedBox(height: 16),
                      _buildInfoRow(context, design),
                      const SizedBox(height: 20),
                      _buildColorPalette(context, design),
                      const SizedBox(height: 20),
                      _buildDescription(context, design),
                      const SizedBox(height: 20),
                      _buildSteps(context, design),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageAppBar(BuildContext context, NailDesign design) {
    return SliverAppBar(
      expandedHeight: 340,
      pinned: true,
      backgroundColor: AppTheme.softWhite,
      leading: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back_rounded, color: AppTheme.darkText),
        ),
      ),
      actions: [
        BlocBuilder<NailDetailCubit, NailDetailState>(
          builder: (context, state) {
            final isFav = state is NailDetailLoaded && state.design.isFavorite;
            return GestureDetector(
              onTap: () =>
                  context.read<NailDetailCubit>().onToggleFavorite(),
              child: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: AppTheme.deepPink,
                ),
              ),
            );
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'nail_${design.id}',
          child: Image.network(
            design.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: AppTheme.lightPink,
              child: const Icon(Icons.spa_rounded,
                  size: 80, color: AppTheme.primaryPink),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, NailDesign design) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                design.title,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontSize: 26),
              ),
              const SizedBox(height: 4),
              Text(
                'by ${design.artistName}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                const Icon(Icons.star_rounded,
                    color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(
                  design.rating.toStringAsFixed(1),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: AppTheme.darkText),
                ),
              ],
            ),
            Text(
              '${design.reviewCount} yorum',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, NailDesign design) {
    return Row(
      children: [
        _InfoChip(
          icon: Icons.category_rounded,
          label: design.category,
          color: AppTheme.accentPurple,
        ),
        const SizedBox(width: 10),
        _InfoChip(
          icon: Icons.bar_chart_rounded,
          label: design.difficulty,
          color: _difficultyColor(design.difficulty),
        ),
        const SizedBox(width: 10),
        _InfoChip(
          icon: Icons.timer_rounded,
          label: '${design.durationMinutes} dk',
          color: AppTheme.primaryPink,
        ),
      ],
    );
  }

  Color _difficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Kolay':
        return Colors.green;
      case 'Orta':
        return Colors.orange;
      case 'Zor':
        return Colors.red;
      default:
        return AppTheme.greyText;
    }
  }

  Widget _buildColorPalette(BuildContext context, NailDesign design) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kullanılan Renkler',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Row(
          children: design.colors
              .where((c) => c.startsWith('#') && !c.contains('TRANSPARENT'))
              .map((colorHex) {
            final color = Color(
                int.parse(colorHex.substring(1), radix: 16) + 0xFF000000);
            return Container(
              margin: const EdgeInsets.only(right: 8),
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                    color: AppTheme.greyText.withOpacity(0.3), width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.4),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context, NailDesign design) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Açıklama',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Text(
          design.description,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(height: 1.6, color: AppTheme.greyText),
        ),
      ],
    );
  }

  Widget _buildSteps(BuildContext context, NailDesign design) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Uygulama Adımları',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        ...design.steps.asMap().entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppTheme.deepPink,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${entry.key + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    entry.value,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(height: 1.5),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
