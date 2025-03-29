enum IconProvider {
  background(imageName: 'background.png'),
  back(imageName: 'back.svg'),
  delete(imageName: 'delete.svg'),
  minus(imageName: 'minus.svg'),
  plus(imageName: 'plus.svg'),
  box(imageName: 'box.png'),
  database(imageName: 'database.png'),
  favorites(imageName: 'favorites.png'),
  recommended(imageName: 'recomended.png'),
  share(imageName: 'share.png'),
  shop(imageName: 'shop.png'),
  unfavorite(imageName: 'unfavotire.png'),
  littleButton(imageName: 'little_but.png'),
  roundButton(imageName: 'round_but.png'),
  button(imageName: 'but.png'),
  logo(imageName: 'logo.png'),
  icon(imageName: 'icon.png'),
  masq(imageName: "masq.png"),
  mark(imageName: 'mark.svg'),
  cross(imageName: 'cross.svg'),
  dialog(imageName: 'Rectangle 37.png'),
  search(imageName: "search.png"),
  addphoto(imageName: "add photo.svg"),
  splash(imageName: "splash.png"),
  loader(imageName: "loader.svg"),
  help(imageName: "help.png"),
  unknown(imageName: '');

  const IconProvider({required this.imageName});

  final String imageName;
  static const _imageFolderPath = 'assets/images';

  String buildImageUrl() => '$_imageFolderPath/$imageName';
  static String buildImageByName(String name) => '$_imageFolderPath/$name';
}
