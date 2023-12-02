import 'package:flutter/material.dart';
import 'package:flutter_app/components/colors.dart';
import 'courses.dart';

class CourseCatDetail extends StatefulWidget {
  // final List<String> categories = [
  //   "All Topics",
  //   "Technology",
  //   "Arts",
  //   "Engineering",
  //   "Marketing",
  //   "Business",
  //   "Guitar",
  //   "AI",
  //   "Design",
  //   "Music"
  // ];

  final String selectedCategory;

  CourseCatDetail({required this.selectedCategory});

  @override
  _CourseCatDetailState createState() => _CourseCatDetailState();
}

class _CourseCatDetailState extends State<CourseCatDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: tuDarkBlue,
        title: Text(widget.selectedCategory,
            style: TextStyle(color: Colors.white)),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   color: Colors.white,
        //   onPressed: () {
        //     Navigator.of(context).popUntil((route) => route.isFirst);
        //   },
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              children: [
                Text(
                  widget.selectedCategory,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Handle "See All" button tap
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'See All',
                          style: TextStyle(
                            color: Color(0xFF4d4dbf),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Container(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(right: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: Offset(2.0, 2.0),
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        width: 180,
                        height: 180,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CourseCard(
                                courseTitle: index == 0
                                    ? 'Python Basics'
                                    : index == 1
                                        ? 'Teaching Strategies'
                                        : index == 2
                                            ? 'Java Fundamentals'
                                            : index == 3
                                                ? 'JavaScript Mastery'
                                                : index == 4
                                                    ? 'Vue.js Essentials'
                                                    : index == 5
                                                        ? 'HTML 5 '
                                                        : index == 6
                                                            ? 'CSS Styling'
                                                            : index == 7
                                                                ? 'PHP Web Dev'
                                                                : index == 8
                                                                    ? 'Ruby Programming'
                                                                    : index == 9
                                                                        ? 'React for Beginners'
                                                                        : 'Default Title',
                                authorName: 'Author Name',
                                imageAssetPath: 'images/CourseIntro$index.jpg',
                                description: index == 0
                                    ? 'Versatile and readable programming language'
                                    : index == 1
                                        ? 'Educational professional guiding student learning'
                                        : index == 2
                                            ? 'Object-oriented, platform-independent programming'
                                            : index == 3
                                                ? 'Dynamic scripting for web development'
                                                : index == 4
                                                    ? 'Progressive JavaScript framework for UIs'
                                                    : index == 5
                                                        ? 'Latest standard for web content and structure'
                                                        : index == 6
                                                            ? 'Stylesheet language for web page design'
                                                            : index == 7
                                                                ? 'Server-side scripting for dynamic web pages'
                                                                : index == 8
                                                                    ? 'Dynamic, object-oriented programming language'
                                                                    : index == 9
                                                                        ? 'JavaScript library for building UI components'
                                                                        : 'Default Description', // Default description if index is out of range
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // SizedBox(height: 10),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: widget.categories.map((category) {
            //       return Container(
            //         margin: EdgeInsets.only(right: 10),
            //         child: ElevatedButton(
            //           onPressed: () {
            //             // Handle category selection
            //             Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                 builder: (context) =>
            //                     CourseCatDetail(selectedCategory: category),
            //               ),
            //             );
            //           },
            //           child: Text(
            //             category,
            //             style: TextStyle(color: Colors.white),
            //           ),
            //           style: ElevatedButton.styleFrom(
            //             primary: widget.selectedCategory == category
            //                 ? Color(0xFF4d4dbf)
            //                 : Color(0xFF6b86f7),
            //           ),
            //         ),
            //       );
            //     }).toList(),
            //   ),
            // ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Recommendation',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Handle "See All" button tap
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'See All',
                          style: TextStyle(
                            color: Color(0xFF4d4dbf),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Container(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(right: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: Offset(2.0, 2.0),
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        width: 180,
                        height: 180,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CourseCard(
                                courseTitle: index == 0
                                    ? 'Python Basics'
                                    : index == 1
                                        ? 'Teaching Strategies'
                                        : index == 2
                                            ? 'Java Fundamentals'
                                            : index == 3
                                                ? 'JavaScript Mastery'
                                                : index == 4
                                                    ? 'Vue.js Essentials'
                                                    : index == 5
                                                        ? 'HTML 5 '
                                                        : index == 6
                                                            ? 'CSS Styling'
                                                            : index == 7
                                                                ? 'PHP Web Dev'
                                                                : index == 8
                                                                    ? 'Ruby Programming'
                                                                    : index == 9
                                                                        ? 'React for Beginners'
                                                                        : 'Default Title',
                                authorName: 'Author Name',
                                imageAssetPath: 'images/CourseIntro$index.jpg',
                                description: index == 0
                                    ? 'Versatile and readable programming language'
                                    : index == 1
                                        ? 'Educational professional guiding student learning'
                                        : index == 2
                                            ? 'Object-oriented, platform-independent programming'
                                            : index == 3
                                                ? 'Dynamic scripting for web development'
                                                : index == 4
                                                    ? 'Progressive JavaScript framework for UIs'
                                                    : index == 5
                                                        ? 'Latest standard for web content and structure'
                                                        : index == 6
                                                            ? 'Stylesheet language for web page design'
                                                            : index == 7
                                                                ? 'Server-side scripting for dynamic web pages'
                                                                : index == 8
                                                                    ? 'Dynamic, object-oriented programming language'
                                                                    : index == 9
                                                                        ? 'JavaScript library for building UI components'
                                                                        : 'Default Description', // Default description if index is out of range
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Latest',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Handle "See All" button tap
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'See All',
                          style: TextStyle(
                            color: Color(0xFF4d4dbf),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Container(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(right: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: Offset(2.0, 2.0),
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        width: 180,
                        height: 180,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CourseCard(
                                courseTitle: index == 0
                                    ? 'Python Basics'
                                    : index == 1
                                        ? 'Teaching Strategies'
                                        : index == 2
                                            ? 'Java Fundamentals'
                                            : index == 3
                                                ? 'JavaScript Mastery'
                                                : index == 4
                                                    ? 'Vue.js Essentials'
                                                    : index == 5
                                                        ? 'HTML 5'
                                                        : index == 6
                                                            ? 'CSS Styling'
                                                            : index == 7
                                                                ? 'PHP Web Dev'
                                                                : index == 8
                                                                    ? 'Ruby Programming'
                                                                    : index == 9
                                                                        ? 'React for Beginners'
                                                                        : 'Default Title',
                                authorName: 'Author Name',
                                imageAssetPath: 'images/CourseIntro$index.jpg',
                                description: index == 0
                                    ? 'Versatile and readable programming language'
                                    : index == 1
                                        ? 'Educational professional guiding student learning'
                                        : index == 2
                                            ? 'Object-oriented, platform-independent programming'
                                            : index == 3
                                                ? 'Dynamic scripting for web development'
                                                : index == 4
                                                    ? 'Progressive JavaScript framework for UIs'
                                                    : index == 5
                                                        ? 'Latest standard for web content and structure'
                                                        : index == 6
                                                            ? 'Stylesheet language for web page design'
                                                            : index == 7
                                                                ? 'Server-side scripting for dynamic web pages'
                                                                : index == 8
                                                                    ? 'Dynamic, object-oriented programming language'
                                                                    : index == 9
                                                                        ? 'JavaScript library for building UI components'
                                                                        : 'Default Description', // Default description if index is out of range
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
