class DayModel {
  final int day;
  final List<String> beginner;
  final List<String> thirty;
  final List<String> fortyFive;
  final List<String> fortyFiveSlow;
  DayModel(
      {this.day,
      this.beginner,
      this.thirty,
      this.fortyFive,
      this.fortyFiveSlow});

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'beginner': beginner,
      'thirty': thirty,
      'fortyFive': fortyFive,
      'fortyFiveSlow': fortyFiveSlow,
    };
  }

  factory DayModel.fromJson(Map<String, dynamic> data) => new DayModel(
        day: data["day"],
        beginner: data["beginner"],
        thirty: data["thirty"],
        fortyFive: data["fortyFive"],
        fortyFiveSlow: data["fortyFiveSlow"],
      );
}
