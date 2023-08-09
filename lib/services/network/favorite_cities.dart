import 'package:shared_preferences/shared_preferences.dart';

class FavoriteCitiesService{
  late SharedPreferences prefs;
  bool isInit = false;
  FavoriteCitiesService(){
      // _init();
  }

  Future<void> _init() async {
      prefs = await SharedPreferences.getInstance();
      isInit = true;
      // await clearFavorites();
  }

  
  //  init() async {
  //     prefs = await SharedPreferences.getInstance();
  // }

  clearFavorites() async{
    await prefs.setStringList('favorites',[]);

  }

  Future<void> deleteFavoriteByName(String cityName) async {
         
     List<String>? listFavorites = prefs.getStringList('favorites');
      listFavorites!.removeWhere((element) => element == cityName);
       
     await prefs.setStringList('favorites',listFavorites);

  }
  

  List<String>? get favorites{
    final List<String>? listFavorites = prefs.getStringList('favorites');
    return listFavorites;
  }

  getFavorites() async{
    if(isInit == false){
      await _init();
    }
     final List<String>? listFavorites = prefs.getStringList('favorites');
    return listFavorites;
  }

  addFavorites(String newCity) async{
     if(isInit == false){
      await _init();
    }
     List<String>? listFavorites = prefs.getStringList('favorites');
    if(listFavorites != null){
      if(!listFavorites.contains(newCity)){
        //TODO lanciare errore
        listFavorites.add(newCity);
      }else {
        //TODO lanciare errore
      }
      

    }else {
      listFavorites = [newCity];
    }
     await prefs.setStringList('favorites',listFavorites);

  }

    deleteFavorites(String deletedCity)async {
     List<String>? listFavorites = prefs.getStringList('favorites');
     listFavorites!.removeWhere((nameCity) => nameCity == deletedCity);
     await prefs.setStringList('favorites',listFavorites);
  }


}