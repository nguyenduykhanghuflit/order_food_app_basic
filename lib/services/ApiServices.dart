import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class ApiServices {
  String apiEndpoint = 'http://172.20.54.215:3051';

  //----------AUTHENTICATION----------------
  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$apiEndpoint/api/user/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': username, 'password': password}),
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    return data;
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    return token;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  //----------CATEGORIES----------------
  Future<Map<String, dynamic>> getCategories() async {
    try {
      String apiUrl = '$apiEndpoint/api/categories';

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Server error: Failed to load data');
      }
    } catch (err) {
      throw Exception('Syntax error: Failed to load data');
    }
  }

  //---------------PRODUCT----------------------

  Future<Map<String, dynamic>> getProduct() async {
    try {
      String defaultCategory = '644a300ee9681884f25e510a';
      String apiUrl =
          '$apiEndpoint/api/products/filter?category=$defaultCategory&pageSize=12';
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Server error: Failed to load data');
      }
    } catch (err) {
      throw Exception('Syntax error: Failed to load data');
    }
  }

  Future<Map<String, dynamic>> getProductDetail(String productId) async {
    try {
      String apiUrl = '$apiEndpoint/api/products?productId=$productId';
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Server error: Failed to load data');
      }
    } catch (err) {
      throw Exception('Syntax error: Failed to load data');
    }
  }

  Future<Map<String, dynamic>> addToCart(String productId, int amount) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final response = await http.post(
      Uri.parse('$apiEndpoint/api/cart/add'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'productId': productId, 'amount': amount}),
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    return data;
  }

  // //----------POST----------------
  // Future<Map<String, dynamic>> fetchPost(String catalog) async {
  //   try {
  //     String apiUrl = '$url/post';
  //     if (catalog != 'all') {
  //       apiUrl += '?catalog=$catalog';
  //     }
  //    // final response = await dio.Dio().get(apiUrl);
  //
  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> data = response.data;
  //       return data;
  //     } else {
  //    //   Functions.showDialog("Thông báo", "Lỗi server: Không tải được dữ liệu :(((" );
  //       throw Exception('Failed to load data');
  //     }
  //   } catch (err) {
  //   //  Functions.showDialog("Thông báo", "Lỗi server: Không tải được dữ liệu :(((" );
  //   //  print(err);
  //     throw Exception('Failed to load data');
  //   }
  // }
  //
  // Future<APIResponse> createPost(PostDTO data) async{
  //   try {
  //     String? token=await getToken();
  //     String endpoint= '$url/post';
  //     dio.FormData formData = dio.FormData.fromMap({
  //       'placeId': data.placeId,
  //       'title': data.title,
  //       'content': data.content,
  //       'star': data.rating,
  //     });
  //     List<XFile> listImage=data.listImages;
  //     for (int i = 0; i < listImage.length; i++) {
  //       formData.files.add(
  //         MapEntry(
  //           'images',
  //           await dio.MultipartFile.fromFile(
  //             listImage[i].path,
  //           ),
  //         ),
  //       );
  //     }
  //
  //     await dio.Dio().post(
  //       endpoint,
  //       data: formData,
  //       options: dio.Options(
  //         headers: {
  //           'Authorization': 'Bearer $token',
  //         },
  //       ),
  //     ) ;
  //     return successResponse(null);
  //
  //   } catch (error) {
  //     return errorResponse(error);
  //
  //   }
  //
  //
  //
  //
  //
  // }
  //
  // Future<Map<String, dynamic>> searchPost(String keyword) async{
  //   try {
  //     String apiUrl = '$url/post/?search=$keyword';
  //     final response = await dio.Dio().get(apiUrl);
  //
  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> data = response.data;
  //       return data;
  //     } else {
  //       Functions.showDialog("Thông báo", "Lỗi server: Không tải được dữ liệu :(((" );
  //       throw Exception('Failed to load data');
  //     }
  //   } catch (err) {
  //     Functions.showDialog("Thông báo", "Lỗi server: Không tải được dữ liệu :(((" );
  //     print(err);
  //     throw Exception('Failed to load data');
  //   }
  // }
  //
  // Future<Map<String, dynamic>> getPostById(String postId) async{
  //   try {
  //     String apiUrl = '$url/post/?postId=$postId';
  //     final response = await dio.Dio().get(apiUrl);
  //
  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> data = response.data;
  //       return data;
  //     } else {
  //       Functions.showDialog("Thông báo", "Lỗi server: Không tải được dữ liệu :(((" );
  //       throw Exception('Failed to load data');
  //     }
  //   } catch (err) {
  //     Functions.showDialog("Thông báo", "Lỗi server: Không tải được dữ liệu :(((" );
  //     print(err);
  //     throw Exception('Failed to load data');
  //   }
  // }
  //
  // //get comment
  // Future<Map<String, dynamic>> fetchComment(String postId) async {
  //   try {
  //     String apiUrl = '$url/comment?postId=$postId';
  //
  //     final response = await dio.Dio().get(apiUrl);
  //
  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> data = response.data;
  //       return data;
  //     } else {
  //       Functions.showDialog("Thông báo", "Lỗi server: Không tải được dữ liệu :(((" );
  //       throw Exception('Failed to load data');
  //     }
  //   } catch (err) {
  //     Functions.showDialog("Thông báo", "Lỗi server: Không tải được dữ liệu :(((" );
  //     print(err);
  //     throw Exception('Failed to load data');
  //   }
  // }
  //
  // Future<APIResponse> commentPost(String postId, String content) async{
  //   try {
  //     String? token=await getToken();
  //     String endpoint= '$url/comment';
  //     await dio.Dio().post(
  //       endpoint,
  //       data: {
  //         'postId': postId,
  //         'content': content,
  //       },
  //       options: dio.Options(
  //         headers: {
  //           'Authorization': 'Bearer $token',
  //         },
  //       ),
  //     ) ;
  //     return successResponse(null);
  //   } catch (error) {
  //     return errorResponse(error);
  //   }
  //
  //
  // }
  //
  // APIResponse errorResponse(dynamic error){
  //   if (error is dio.DioError) {
  //     final response = error.response;
  //     if (response != null) {
  //       int? code = response.statusCode;
  //       final message = response.data["error"]["message"]?? response.statusMessage ;
  //
  //       return APIResponse(code, message.toString(),null);
  //     }
  //   }
  //   print("=======API err $error");
  //   return APIResponse(1, "Dev error: ${error}",null);
  // }
  //
  // APIResponse successResponse(dynamic data){
  //   return APIResponse(-1,'Success',data);
  // }
}
