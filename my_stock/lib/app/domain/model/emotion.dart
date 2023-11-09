enum EmotionEnum {
  happier,
  happy,
  neutral,
  sad,
  sadder,
  ;

  int get toInt {
    if (this == EmotionEnum.happier) {
      return 2;
    } else if (this == EmotionEnum.happy) {
      return 1;
    } else if (this == EmotionEnum.neutral) {
      return 0;
    } else if (this == EmotionEnum.sad) {
      return -1;
    } else {
      return -2;
    }
  }
}
