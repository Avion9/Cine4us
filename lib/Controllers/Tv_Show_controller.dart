import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
//Api
import 'package:movie_app/Api/Api_Client.dart';
import 'package:movie_app/Api/Api_Config.dart';
//Models
import 'package:movie_app/Models/Cast_model.dart';
import 'package:movie_app/Models/Tv_Shows_Model.dart';
import 'package:movie_app/Models/Tv_Show_detail_Model.dart';

class ShowController extends GetxController {
  ApiClient apiClient = ApiClient();
  ShowDetail? showDetail;

  List<TvModel> airingShows = <TvModel>[].obs;
  List<TvModel> topratedShows = <TvModel>[].obs;
  List<TvModel> popularShows = <TvModel>[].obs;
  List<TvModel> similarshows = <TvModel>[].obs;
  List<CastModel> showCast = <CastModel>[].obs;

  RxString showtrailerUrl = ''.obs;

  var isLoadingDetail = false.obs;

//Fetch Airing Shows
  void getAiring() async {
    var onAir = await apiClient.getAiringTvShows();
    if (onAir.isNotEmpty) {
      airingShows = onAir;
    }
    update();
  }

//Fetch toprated Shows
  void getToprated() async {
    var toprated = await apiClient.getTopRatedTvShows();
    if (toprated.isNotEmpty) {
      topratedShows = toprated;
    }
    update();
  }

//Fetch Popular Shows
  void getPopular() async {
    var popular = await apiClient.getPopularTvShows();
    if (popular.isNotEmpty) {
      popularShows = popular;
    }
    update();
  }

  //This method gets the details of the Show.
  void fetchDataDetailShow(int id) async {
    try {
      isLoadingDetail(true);
      http.Response response = await http.get(
          Uri.tryParse('${ApiConfig.baseUrl}/tv/$id?${ApiConfig.apiKey}')!);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        showDetail = ShowDetail.fromJson(result);
        /*  dbC.getIdMovie(id); */
      } else {
        print("Error Fetching Data");
      }
    } catch (e) {
      e.printError();
    } finally {
      isLoadingDetail(false);
    }
  }

//Fetching  The selected Show  Trailer Url
  void getCastList(int id) async {
    var cast = await apiClient.getShowCast(id);
    if (cast.isNotEmpty) {
      showCast = cast;
    }
    update();
  }

//Fetching  The Similar Shows for the selected Show
  void getSimilarList(int id) async {
    var similar = await apiClient.getSimilarShows(id);
    if (similar.isNotEmpty) {
      similarshows = similar;
    }
    update();
  }

//Fetching  The Trailer Url for the selected Show
  void fetchTrailerUrl(int id) async {
    var url = await apiClient.getShowTrailer(id);
    if (url.isNotEmpty) {
      showtrailerUrl = url;
    }

    update();
  }

  @override
  void onInit() {
    super.onInit();
    getAiring();
    getToprated();
    getPopular();
  }
}
