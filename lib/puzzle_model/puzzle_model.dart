class PuzzleState {
  final List<int?> tiles;
  final int moves;
  final bool hasWon;
  final Stopwatch stopwatch;

  PuzzleState({
    required this.tiles,
    this.moves = 0,
    this.hasWon = false,
    Stopwatch? stopwatch,
  }) : stopwatch = stopwatch ?? Stopwatch();

  PuzzleState copyWith({
    List<int?>? tiles,
    int? moves,
    bool? hasWon,
    Stopwatch? stopwatch,
  }) {
    return PuzzleState(
      tiles: tiles ?? this.tiles,
      moves: moves ?? this.moves,
      hasWon: hasWon ?? this.hasWon,
      stopwatch: stopwatch ?? this.stopwatch,
    );
  }
}
