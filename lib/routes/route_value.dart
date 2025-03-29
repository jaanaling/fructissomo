enum RouteValue {
  splash(path: '/'),
  home(path: '/home'),
  base(path: 'base'),
  shop(path: 'shop'),
  storage(path: 'storage'),
  recommendation(path: 'recommendation'),
  recipe(path: 'recipe'),
  create(path: 'create'),
  description(path: "description"),

  unknown(path: '');

  final String path;
  const RouteValue({required this.path});
}
