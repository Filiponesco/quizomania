import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quizomania/models/category.dart';
import 'package:quizomania/models/question_model.dart';

class Repository {
  Future<List<Category>> getAllCategories() async {
    var url = "https://opentdb.com/api_category.php";
    var response = await http.get(url);
    var xd = json.decode(response.body);
    List<Category> result = Category.listFromJson(xd['trivia_categories']);
    return result;
  }

  Future<List<QuestionModel>> getQuestions(int quantity, String difficulty, int categoryId) async{
    var url = "https://opentdb.com/api.php?amount=$quantity&category=$categoryId&difficulty=$difficulty&type=multiple&encode=base64";
    var response = await http.get(url);
    var xd = json.decode(response.body);
    List<QuestionModel> result = QuestionModel.listFromJsonBase64(xd['results']);
    return result;
  }

}
