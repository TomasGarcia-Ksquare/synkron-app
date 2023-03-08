class EmployeeProjectModel {
  int? id;
  bool? isActive;
  ProjectPosition? projectPosition;

  EmployeeProjectModel({this.id, this.isActive, this.projectPosition});

  EmployeeProjectModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isActive = json['isActive'];
    projectPosition = json['projectPosition'] != null
        ? ProjectPosition.fromJson(json['projectPosition'])
        : null;
  }
}

class ProjectPosition {
  int? id;
  Project? project;

  ProjectPosition({this.id, this.project});

  ProjectPosition.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    project =
        json['project'] != null ? Project.fromJson(json['project']) : null;
  }
}

class Project {
  int? id;
  String? name;
  String? description;
  String? status;
  String? projectType;

  Project(
      {this.id, this.name, this.description, this.status, this.projectType});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    projectType = json['projectType'];
  }
}
