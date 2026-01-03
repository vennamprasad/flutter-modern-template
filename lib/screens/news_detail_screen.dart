import 'package:flutter/material.dart';
import '../features/news/domain/entities/news_article.dart';

class NewsDetailScreen extends StatefulWidget {
  final NewsArticle article;

  const NewsDetailScreen({super.key, required this.article});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;
  late ScrollController _scrollController;
  bool _showAppBarTitle = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));

    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Show title when expandedHeight (300) - kToolbarHeight (56) is reached
    // Adding a buffer so it switches a bit earlier or exactly when collapsed
    if (_scrollController.hasClients &&
        _scrollController.offset > (300 - kToolbarHeight)) {
      if (!_showAppBarTitle) {
        setState(() {
          _showAppBarTitle = true;
        });
      }
    } else {
      if (_showAppBarTitle) {
        setState(() {
          _showAppBarTitle = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Unique tag for Hero animation matching the one in the list
    final heroTag = 'news-image-${widget.article.id}';

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            title: _showAppBarTitle
                ? Text(
                    widget.article.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : null,
            // Ensure back button is white to match potential dark gradient/image background
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: heroTag,
                    child: widget.article.imageUrl != null
                        ? Image.network(
                            widget.article.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(color: Colors.grey.shade300),
                          )
                        : Container(
                            color: Colors.blue.shade100,
                            child: const Icon(Icons.newspaper,
                                size: 100, color: Colors.blue),
                          ),
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.center,
                        colors: [
                          Colors.black54,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: FadeTransition(
                opacity: _opacity,
                child: SlideTransition(
                  position: _slide,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        widget.article.title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 16),

                      // Metadata
                      Row(
                        children: [
                          Icon(Icons.access_time,
                              size: 16,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant),
                          const SizedBox(width: 8),
                          Text(
                            _formatDate(widget.article.publishedAt),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Description / Body (Repeated to simulate long content)
                      Text(
                        widget.article.description ?? 'No details available.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              height: 1.6,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        (widget.article.description ?? '') *
                            3, // Simulate longer content
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              height: 1.6,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    // Simple formatter, in real app use intl package
    return '${date.day}/${date.month}/${date.year}';
  }
}
