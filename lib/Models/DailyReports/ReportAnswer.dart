class ReportAnswers {
  List<Answers> answers;
  bool activeLearningEnabled;

  ReportAnswers({this.answers, this.activeLearningEnabled});

  ReportAnswers.fromJson(Map<String, dynamic> json) {
    if (json['answers'] != null) {
      answers = new List<Answers>();
      json['answers'].forEach((v) {
        answers.add(new Answers.fromJson(v));
      });
    }
    activeLearningEnabled = json['activeLearningEnabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.answers != null) {
      data['answers'] = this.answers.map((v) => v.toJson()).toList();
    }
    data['activeLearningEnabled'] = this.activeLearningEnabled;
    return data;
  }
}

class Answers {
  List<String> questions;
  String answer;
  double score;
  int id;
  String source;
  Context context;

  Answers(
      {this.questions,
      this.answer,
      this.score,
      this.id,
      this.source,
      this.context});

  Answers.fromJson(Map<String, dynamic> json) {
    questions = json['questions'].cast<String>();
    answer = json['answer'];
    score = json['score'];
    id = json['id'];
    source = json['source'];
    context =
        json['context'] != null ? new Context.fromJson(json['context']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questions'] = this.questions;
    data['answer'] = this.answer;
    data['score'] = this.score;
    data['id'] = this.id;
    data['source'] = this.source;
    if (this.context != null) {
      data['context'] = this.context.toJson();
    }
    return data;
  }
}

class Context {
  bool isContextOnly;
  List<Prompts> prompts;

  Context({this.isContextOnly, this.prompts});

  Context.fromJson(Map<String, dynamic> json) {
    isContextOnly = json['isContextOnly'];
    if (json['prompts'] != null) {
      prompts = new List<Prompts>();
      json['prompts'].forEach((v) {
        prompts.add(new Prompts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isContextOnly'] = this.isContextOnly;
    if (this.prompts != null) {
      data['prompts'] = this.prompts.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Prompts {
  int displayOrder;
  int qnaId;
  String displayText;

  Prompts({this.displayOrder, this.qnaId, this.displayText});

  Prompts.fromJson(Map<String, dynamic> json) {
    displayOrder = json['displayOrder'];
    qnaId = json['qnaId'];
    displayText = json['displayText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayOrder'] = this.displayOrder;
    data['qnaId'] = this.qnaId;
    data['displayText'] = this.displayText;
    return data;
  }
}
