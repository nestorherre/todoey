class Task {
  Task({this.id, this.name, this.isDone = false});
  final int id;
  final String name;
  bool isDone;

  void toggleDone() {
    isDone = !isDone;
  }
}
