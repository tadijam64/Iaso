import 'package:dio/dio.dart';
import 'package:iaso/Models/DailyReports/ReportAnswer.dart';
import 'package:iaso/Models/DailyReports/ReportQuery.dart';

class GetDailyReportInteractor {
  static Map<String, String> headers = {
    "Authorization": "EndpointKey 7bae6efb-4483-429e-bde9-0d401dcd5a8f",
    "Content-type": "application/json"
  };

  static BaseOptions options = new BaseOptions(
      baseUrl:
          "https://codevscovid19.azurewebsites.net/qnamaker/knowledgebases/8a3ce91f-31e8-4ca2-84b3-96642087dfb4",
      connectTimeout: 10000,
      receiveTimeout: 10000,
      headers: headers);
  Dio dio = new Dio(options);

  Future<ReportAnswers> getReport(ReportQuery query) {
    return dio.post("/generateAnswer", data: query.toJson()).then((response) {
      return ReportAnswers.fromJson(response.data);
    });
  }
}
