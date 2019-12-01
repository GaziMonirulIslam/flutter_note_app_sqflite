

class Note {

  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;


  Note(this._title, this._date, this._priority, [this._description]);

  Note.withId(this._title, this._date, this._priority, [this._description]);

  int get id => _id;

  String get title => _title;

  String get description => _description;

  int get priority => _priority;

  String get date => _date;



  set priority(int newPriority) {
    if(newPriority >= 1 && newPriority <= 2) {
      _priority = newPriority;
    }
  }

  set date(String newDate) {
    _date = newDate;
  }


  set description(String newDescription) {
    if (newDescription.length <= 255) {
      _description = newDescription;
    }
  }


  set title(String newTitle) {
    if (newTitle.length <= 255) {
      _title = newTitle;
    }
  }

  // Convert Note Objects to a Map objects! important

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if(id != null) {
      map['id'] = _id;
    }

    map['title'] = _title;
    map['description'] = _description;
    map['priority'] =_priority;
    map['date'] = _date;

    return map;

  }



  // Extract a Note object from a Map object

  Note.fromMapObject(Map<String, dynamic> map) {
      _id = map['id'];
      _title = map['title'];
      _description = map['description'];
      _priority = map['priority'];
      _date = map['date'];

  }


}