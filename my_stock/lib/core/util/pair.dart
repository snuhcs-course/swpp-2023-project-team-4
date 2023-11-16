class Pair<T1, T2> {
  T1 first;
  T2 second;

  Pair(this.first, this.second);
}

class ThirdPair<T1, T2, T3> {
  final T1 first;
  final T2 second;
  final T3 third;

  const ThirdPair(this.first, this.second, this.third);
}
