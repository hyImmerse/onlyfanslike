import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:creator_platform_demo/presentation/providers/creator_providers.dart';
import 'package:creator_platform_demo/presentation/providers/auth_provider.dart';
import 'package:creator_platform_demo/presentation/providers/notification_provider.dart';
import 'package:creator_platform_demo/presentation/widgets/creator_card.dart';
import 'package:creator_platform_demo/domain/entities/creator.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onCreatorTap(Creator creator) {
    context.push('/home/creator/${creator.id}');
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final categories = ref.watch(creatorCategoriesProvider);
    
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // App Bar
          SliverAppBar(
            floating: true,
            pinned: false,
            snap: true,
            title: Text(
              currentUser != null 
                  ? '${currentUser.name}님, 안녕하세요!'
                  : 'Creator Platform',
            ),
            actions: [
              // 알림 아이콘
              Consumer(
                builder: (context, ref, child) {
                  final unreadCount = ref.watch(unreadNotificationCountProvider);
                  return IconButton(
                    onPressed: () {
                      context.push('/notifications');
                    },
                    icon: Badge(
                      isLabelVisible: unreadCount > 0,
                      label: unreadCount > 99 
                          ? const Text('99+') 
                          : Text('$unreadCount'),
                      child: Icon(
                        Icons.notifications_outlined,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    tooltip: '알림',
                  );
                },
              ),
              // 메시지 아이콘
              IconButton(
                onPressed: () {
                  context.push('/conversations');
                },
                icon: Badge(
                  // TODO: Show unread message count
                  child: Icon(
                    Icons.chat_bubble_outline,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                tooltip: '메시지',
              ),
              // 프로필 아이콘
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: InkWell(
                  onTap: () {
                    context.push('/profile');
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: currentUser?.profileImageUrl != null
                          ? Colors.transparent
                          : const Color(0xFF7C4DFF), // 보라색 배경
                      backgroundImage: currentUser?.profileImageUrl != null
                          ? NetworkImage(currentUser!.profileImageUrl!)
                          : null,
                      child: currentUser?.profileImageUrl == null
                          ? const Icon(
                              Icons.person,
                              size: 20,
                              color: Colors.white, // 흰색 아이콘
                            )
                          : null,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),

          // Search Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SearchBar(
                controller: _searchController,
                hintText: '크리에이터 검색...',
                leading: const Icon(Icons.search),
                onChanged: (query) {
                  ref.read(creatorSearchProvider.notifier).searchCreators(query);
                },
                trailing: [
                  if (_searchController.text.isNotEmpty)
                    IconButton(
                      onPressed: () {
                        _searchController.clear();
                        ref.read(creatorSearchProvider.notifier).clearSearch();
                      },
                      icon: const Icon(Icons.clear),
                    ),
                ],
              ),
            ),
          ),

          // Category Filter
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: const Text('전체'),
                        selected: selectedCategory == null,
                        onSelected: (selected) {
                          ref.read(selectedCategoryProvider.notifier).state = null;
                        },
                      ),
                    );
                  }
                  
                  final category = categories[index - 1];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(category),
                      selected: selectedCategory == category,
                      onSelected: (selected) {
                        ref.read(selectedCategoryProvider.notifier).state = 
                            selected ? category : null;
                      },
                    ),
                  );
                },
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // Search Results or Creator Grid
          Consumer(
            builder: (context, ref, child) {
              final searchState = ref.watch(creatorSearchProvider);
              
              // If there's a search query, show search results
              if (searchState.query.isNotEmpty) {
                if (searchState.isLoading) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                
                if (searchState.hasError) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '검색 중 오류가 발생했습니다',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            searchState.errorMessage ?? '알 수 없는 오류',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                
                if (searchState.results.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '검색 결과가 없습니다',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '다른 키워드로 검색해보세요',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                
                // Show search results in a list
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final creator = searchState.results[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: CompactCreatorCard(
                          creator: creator,
                          onTap: () => _onCreatorTap(creator),
                        ),
                      );
                    },
                    childCount: searchState.results.length,
                  ),
                );
              }
              
              // Show filtered creators grid
              final creatorsAsync = ref.watch(filteredCreatorsProvider);
              
              return creatorsAsync.when(
                loading: () => const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, stack) => SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '데이터 로드 실패',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          error.toString(),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            ref.invalidate(filteredCreatorsProvider);
                          },
                          child: const Text('다시 시도'),
                        ),
                      ],
                    ),
                  ),
                ),
                data: (creators) {
                  if (creators.isEmpty) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_off,
                              size: 64,
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '크리에이터가 없습니다',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '다른 카테고리를 선택해보세요',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _getCrossAxisCount(context),
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final creator = creators[index];
                          return CreatorCard(
                            creator: creator,
                            onTap: () => _onCreatorTap(creator),
                          );
                        },
                        childCount: creators.length,
                      ),
                    ),
                  );
                },
              );
            },
          ),

          // Bottom padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 32),
          ),
        ],
      ),
    );
  }

  /// Calculate grid cross axis count based on screen width
  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 5;
    if (width > 900) return 4;
    if (width > 600) return 3;
    return 2;
  }
}