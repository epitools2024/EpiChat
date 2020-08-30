enum endPoint {
  all,
  alert,
  message,
  notes,
  missed,
  nextRdv,
}

extension endPointExt on endPoint {
  static const names = {
    endPoint.all: '/?format=json',
    endPoint.alert: '/notification/alert?format=json',
    endPoint.message: '/notification/message?format=json',
    endPoint.notes: '/notes?format=json',
    endPoint.missed: '/notification/missed?format=json',
    endPoint.nextRdv: '/notification/coming?format=json',
  };

  String get value => names[this];
}

main(List<String> args) {
  endPoint req = endPoint.all;
  print(req.value);
}
