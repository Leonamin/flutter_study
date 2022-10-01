class Animal {
  late String _name;
  late AnimalState _state;

  Animal({required String name, required AnimalState state}) {
    _name = name;
    _state = state;
  }

  get name => _name;
  get state => _state;

  updateState(AnimalState state) {
    _state = state;
  }
}

enum AnimalState { SLEEP, RUN, WALK, EAT }
