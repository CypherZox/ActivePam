class UserProgress {
  int _currentWeek, _currentDay, _progressPrcntge = 0;
  UserProgress(currentDay, currentWeek, progressPrcntge) {
    this._currentDay = currentDay;
    this._currentWeek = currentWeek;
    this._progressPrcntge = progressPrcntge;
  }
  int getcurrentDay() {
    return _currentDay;
  }

  setcurrentDay(currentDay) {
    this._currentDay = currentDay;
  }

  int getcurrentWeek() {
    return _currentWeek;
  }

  setcurrentWeek(currentWeek) {
    this._currentWeek = currentWeek;
  }

  int getprogressPrcntge() {
    return _progressPrcntge;
  }

  setprogressPrcntge(progressPrcntge) {
    this._progressPrcntge = progressPrcntge;
  }
}
