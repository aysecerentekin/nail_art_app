// lib/features/nail/presentation/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../cubits/nail_home_cubit.dart';
import '../widgets/nail_design_card.dart';
import '../widgets/category_filter_chip.dart';
import '../widgets/nail_loading_shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NailHomeCubit>().loadDesigns();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackground,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildAppBar(context),
            _buildCategoryFilter(),
            _buildDesignGrid(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 130,
      floating: true,
      pinned: true,
      backgroundColor: AppTheme.softWhite,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Merhaba 💅',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Nail Art Tasarımları',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontSize: 24),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: AppTheme.lightPink,
                    radius: 24,
                    child: const Icon(
                      Icons.spa_rounded,
                      color: AppTheme.deepPink,
                      size: 26,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
            ],
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: AppTheme.primaryPink.withOpacity(0.2),
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return SliverToBoxAdapter(
      child: BlocBuilder<NailHomeCubit, NailHomeState>(
        builder: (context, state) {
          final selected = state is NailHomeLoaded
              ? state.selectedCategory
              : 'Tümü';

          return SizedBox(
            height: 52,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: AppConstants.categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final cat = AppConstants.categories[index];
                return CategoryFilterChip(
                  label: cat,
                  isSelected: selected == cat,
                  onTap: () =>
                      context.read<NailHomeCubit>().filterByCategory(cat),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildDesignGrid() {
    return BlocBuilder<NailHomeCubit, NailHomeState>(
      builder: (context, state) {
        if (state is NailHomeLoading || state is NailHomeInitial) {
          return const SliverToBoxAdapter(child: NailLoadingShimmer());
        }

        if (state is NailHomeError) {
          return SliverFillRemaining(
            child: _ErrorView(
              message: state.message,
              onRetry: () => context.read<NailHomeCubit>().loadDesigns(),
            ),
          );
        }

        if (state is NailHomeLoaded) {
          if (state.designs.isEmpty) {
            return SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.search_off_rounded,
                        size: 64, color: AppTheme.greyText),
                    const SizedBox(height: 16),
                    Text(
                      'Bu kategoride tasarım bulunamadı',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            );
          }

          return SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final design = state.designs[index];
                  return NailDesignCard(
                    design: design,
                    onTap: () =>
                        context.pushNamed('detail',
                            pathParameters: {'id': design.id},
                            extra: design),
                    onFavoriteTap: () => context
                        .read<NailHomeCubit>()
                        .onToggleFavorite(design.id, design.isFavorite),
                  );
                },
                childCount: state.designs.length,
              ),
            ),
          );
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.softWhite,
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryPink.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) context.pushNamed('favorites');
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Keşfet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded),
            label: 'Favoriler',
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline_rounded,
                size: 64, color: AppTheme.deepPink),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Tekrar Dene'),
            ),
          ],
        ),
      ),
    );
  }
}
