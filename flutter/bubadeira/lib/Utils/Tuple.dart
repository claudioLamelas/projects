class Tuple<A, B> {
  A _item1;
  B? _item2;

  Tuple(this._item1, this._item2);

  A get item1 {
    return this._item1;
  }

  set item1(A newItem1) {
    this._item1 = newItem1;
  }

  B? get item2 {
    return _item2;
  }

  set item2(B? newItem2) {
    this._item2 = newItem2;
  }

  Map toJson() {
    return {'item1': item1, 'item2': item2};
  }
}
