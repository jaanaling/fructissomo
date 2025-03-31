enum RouteValue {
  splash(path: '/'),
  home(path: '/home'),
  diary(path: 'diary'),
  articles(path: 'articles'),
  article(path: 'article'),
  edit(path: 'edit'),
  statistic(path: 'statistic'),

  unknown(path: '');

  final String path;
  const RouteValue({required this.path});
}
