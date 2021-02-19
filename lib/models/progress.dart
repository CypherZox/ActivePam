class UserProgress {
  int currentWeek = 0, currentDay = 0, progressPrcntge = 0, noofweeks = 0;

  UserProgress(
      {this.currentWeek,
      this.currentDay,
      this.progressPrcntge,
      this.noofweeks});

  factory UserProgress.fromMap(
    Map data,
  ) {
    data = data ?? {};
    return UserProgress(
      currentDay: data['current_day'] ?? 0,
      currentWeek: data['current_week'] ?? 0,
      progressPrcntge: data['weekprctng'] ?? 0,
    );
  }

  int getcurrentDay() {
    return currentDay;
  }

  int getcurrentWeek() {
    return currentWeek;
  }

  int getprogressPrcntge() {
    return progressPrcntge;
  }
}
