import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/news/presentation/providers/news_controller.dart';
import '../features/news/domain/entities/news_article.dart';
import '../features/news/presentation/providers/news_pagination_state.dart';
import 'package:flutter_modern_template/screens/news_detail_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to ensure the provider is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(newsControllerProvider.notifier).refresh();
    });

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Check if we are near the bottom (200 pixels threshold)
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(newsControllerProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch the News Stream
    final newsAsync = ref.watch(newsControllerProvider);
    // Watch Pagination State
    final hasMore = ref.watch(newsPaginationStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline News'),
      ),
      body: newsAsync.when(
        data: (articles) {
          if (articles.isEmpty) {
            // ... (Empty State Logic - Unchanged)
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(), // Show loader initially
                  const SizedBox(height: 16),
                  const Text('Fetching latest news...'),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      ref.read(newsControllerProvider.notifier).refresh();
                    },
                    child: const Text('Retry'),
                  )
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              await ref.read(newsControllerProvider.notifier).refresh();
            },
            child: ListView.separated(
              controller: _scrollController,
              // Only add +1 if there is more data to load
              itemCount: articles.length + (hasMore ? 1 : 0),
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                // Loader at the bottom (only reachable if hasMore is true from itemCount logic)
                if (index == articles.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                }

                final article = articles[index];

                // Staggered Animation Wrapper
                return StaggeredListItem(
                  index: index,
                  child: NewsCard(article: article),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

/// A Custom Animation Widget that slides and fades in items.
class StaggeredListItem extends StatefulWidget {
  final int index;
  final Widget child;

  const StaggeredListItem(
      {super.key, required this.index, required this.child});

  @override
  State<StaggeredListItem> createState() => _StaggeredListItemState();
}

class _StaggeredListItemState extends State<StaggeredListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _slide =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Calculate delay: capped at 5 items duration (250ms) to avoid long waits for deep lists
    // Using simple modulo to stagger batches
    final int delayMilliseconds = (widget.index % 10) * 50;

    Future.delayed(Duration(milliseconds: delayMilliseconds), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final NewsArticle article;

  const NewsCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final heroTag = 'news-image-${article.id}';

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NewsDetailScreen(article: article),
          ),
        );
      },
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: article.imageUrl != null
            ? Hero(
                tag: heroTag,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    article.imageUrl!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey.shade300,
                        child:
                            const Icon(Icons.broken_image, color: Colors.grey),
                      );
                    },
                  ),
                ),
              )
            : null,
        title: Text(
          article.title,
          style: Theme.of(context).textTheme.titleMedium,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            article.description ?? '',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
    );
  }
}
