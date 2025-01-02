part of 'rooms_list_screen.dart';

class _PromotionPageView extends StatefulWidget {
  final List<String> promotions;

  const _PromotionPageView({required this.promotions});

  @override
  State<_PromotionPageView> createState() => _PromotionPageViewState();
}

class _PromotionPageViewState extends State<_PromotionPageView> {
  final PageController _promotionsPageController =
      PageController(viewportFraction: 0.9);

  @override
  Widget build(BuildContext context) {
    final promotions = widget.promotions;
    final theme = Theme.of(context);
    return promotions.isEmpty
        ? SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  Localization.of(context).promotions,
                  style: theme.textTheme.titleSmall,
                ),
              ),
              SizedBox(
                height: 123,
                child: PageView(
                  controller: _promotionsPageController,
                  children: promotions
                      .mapIndexed<Widget>(
                        (i, e) => Padding(
                          padding: EdgeInsets.only(
                            left: i == 0 ? 0 : 4,
                            right: i == promotions.length - 1 ? 0 : 4,
                          ),
                          child: Image.asset(
                            e,
                            width: 358,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: 16),
            ],
          );
  }
}
