import 'package:fitx_user/data_layer/models/category/category_page/result.dart';

class CategorieSort{
  List<Category>mostLikedSorting(List<Category> categories){
    int i=1;
    int j=0;
    while(i<categories.length){
      if(categories[i].likes!>categories[j].likes!){
     Category temp=categories[i];
     categories[i]=categories[j];
     categories[j]=temp;
      }i++;
      if(i==categories.length){
        j++;
        i=j+1;
      }
    }
    return categories;
  }
}