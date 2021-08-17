

class HistoryMove {

  HistoryMove({
    this.id,
    this.time,
    this.location,
    this.userID
  });

  String time;
  String id;
  String location;
  String userID;

  factory HistoryMove.fromJson(Map<String, dynamic> json) {
    return HistoryMove(
      id: json['ID'],
      time: json['TIME'],
      location: json['LOCATION'],
      userID: json['USER_ID'],
    );
  }

  static List<HistoryMove> HistTempList = <HistoryMove>[
    HistoryMove(
      time: '2021/08/15 12:11:32',
      location: '528 Hagidong',
      id: '01',
      userID: 'aaaa'
    ),
    HistoryMove(
        time: '2021/08/15 15:11:32',
        location: '528 Hagidong',
        id: '02',
        userID: 'aaaa'
    ),
    HistoryMove(
        time: '2021/08/15 16:11:32',
        location: '528 Hagidong',
        id: '03',
        userID: 'aaaa'
    ),
    HistoryMove(
        time: '2021/08/15 17:11:32',
        location: '528 Hagidong',
        id: '04',
        userID: 'aaaa'
    ),

  ];



}
