class RuleExpressions {
  static final Map<int, Function> expressions = {
    -1: () {},
    0: (int number) {
      return number == 1;
    },
    1: (int number) {
      return number.isEven;
    },
    2: (int number) {
      return number.isOdd;
    },
    3: (int number, int mustBeEqualNumber) {
      return number == mustBeEqualNumber;
    },
  };
}
