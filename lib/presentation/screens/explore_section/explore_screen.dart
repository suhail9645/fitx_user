import 'package:fitx_user/data_layer/models/category/category_page/result.dart';
import 'package:fitx_user/presentation/screens/home_section/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../logic/category_bloc/category_bloc.dart';
import '../../constants/colors.dart';
import '../../constants/sized_box.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ExplreScreen extends StatelessWidget {
  const ExplreScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const textStyle =
        TextStyle(fontSize: 18, color: Color.fromARGB(255, 163, 156, 156));
    int itemIndex = -1;
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    return Scaffold(
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryInitial) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  children: [
                    const Text(
                      'Most Liked Categories',
                      style: textStyle,
                    ),
                    spaceforHeight10,
                    ExploreMostLIkedCategories(
                      categories: state.catgories,
                    ),
                    spaceforHeight20,
                    const Text(
                      'All Categories',
                      style: textStyle,
                    ),
                    SizedBox(
                      height: screenHeight / 1.33,
                      child: AnimationLimiter(
                        child: GridView.builder(
                            itemCount: state.catgories.length * 3,
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              mainAxisExtent: 300,
                            ),
                            itemBuilder: (context, index) {
                              itemIndex++;
                              if (itemIndex == state.catgories.length) {
                                itemIndex = 0;
                              }
                              return AnimationConfiguration.staggeredGrid(
                                  position: index,
                                  duration: const Duration(milliseconds: 675),
                                  columnCount: state.catgories.length,
                                  child: ScaleAnimation(
                                    child: FadeInAnimation(
                                      child: CategoryContainer(
                                        category: state.catgories[itemIndex],
                                      ),
                                    ),
                                  ));
                            }),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (state is CategoryLoadingState) {
            return const CircularProgressIndicator();
          } else {
            return const Center(
              child: Text('Something wrong try again'),
            );
          }
        },
      ),
    );
  }
}

class CategoryContainer extends StatelessWidget {
  const CategoryContainer({super.key, required this.category});
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(category.image!),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spaceforHeight20,
            Text(
              category.name!,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              '${category.exercisesCount} Workouts',
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '0 People like this Category',
                  style: TextStyle(color: primaryColor),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.favorite))
              ],
            ),
            spaceforHeight10
          ],
        ),
      ),
    );
  }
}

class ExploreMostLIkedCategories extends StatelessWidget {
  const ExploreMostLIkedCategories({super.key, required this.categories});
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: List.generate(
          categories.length,
          (index) => Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: NetworkImage(categories[index].image!),
                    fit: BoxFit.fill)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spaceforHeight20,
                  Text(
                    categories[index].name!,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${categories[index].exercisesCount} Workouts',
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '0 People like this Category',
                        style: TextStyle(color: primaryColor),
                      ),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.favorite))
                    ],
                  ),
                  spaceforHeight10
                ],
              ),
            ),
          ),
        ),
        options: CarouselOptions(
            autoPlay: true, enlargeCenterPage: true, initialPage: 1));
  }
}

