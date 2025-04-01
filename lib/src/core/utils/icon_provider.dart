enum IconProvider {
  background(imageName: 'background.png'),
  bug(imageName: 'bug.png'),
  cloud(imageName: 'cloud.png'),
  diameter(imageName: 'diameter.png'),
  freque(imageName: 'freque.png'),
  grow1(imageName: 'grow1.webp'),
  grow2(imageName: 'grow2.webp'),
  grow3(imageName: 'grow3.webp'),
  grow4(imageName: 'grow4.webp'),
  grow5(imageName: 'grow5.webp'),
  growth(imageName: 'growth.png'),
  heart(imageName: 'heart.png'),
  infect(imageName: 'infect.png'),
  list(imageName: 'list.png'),
  protected(imageName: 'protected.png'),
  soil(imageName: 'soil.png'),
  sun(imageName: 'sun.png'),
  sunCloud(imageName: 'sun-cloud.png'),
  thermometer(imageName: 'thermometer.png'),
  water(imageName: 'waterr.png'),
  watering(imageName: 'watering.png'),
  logo(imageName: 'logo.png'),
  
  
  
  arrow(imageName: 'arrow.svg'),
  calc(imageName: 'calc.svg'),
  cross(imageName: 'cross.svg'),
  diary(imageName: 'diary.svg'),
  down(imageName: 'down.svg'),
  freq(imageName: 'freq.svg'),
  mark(imageName: 'mark.svg'),
  plus(imageName: 'plus.svg'),
  prod(imageName: 'prod.svg'),
  protect(imageName: 'protect.svg'),
  stat(imageName: 'stat.svg'),
  temp(imageName: 'temp.svg'),
  waterSvg(imageName: 'water.svg'),
  
  unknown(imageName: '');

  const IconProvider({required this.imageName});

  final String imageName;
  static const _imageFolderPath = 'assets/images';

  String buildImageUrl() => '$_imageFolderPath/$imageName';
  static String buildImageByName(String name) => '$_imageFolderPath/$name';
}
