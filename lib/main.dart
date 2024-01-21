import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: MyQuizPage(),
    );
  }
}

class MyQuizPage extends StatefulWidget {
  @override
  _MyQuizPageState createState() => _MyQuizPageState();
}

class Quiz {
  String image;
  String question;
  bool isCorrect;

  Quiz(this.image, this.question, this.isCorrect);
}

class _MyQuizPageState extends State<MyQuizPage> {
  int quizID = 0; // Start from the first quiz question.

  final List<Quiz> quizzes = [
    Quiz("U+200B.jpg", "U+200B is used to create an empty post or comment on Facebook.", true),
    Quiz("BAT.jpg", "Basic Attention Token is a secure blockchain token.", false),
    Quiz("Rust.jpg", "Rust language enforces memory safety.", true),
  ];

  void nextQuiz() {
    setState(() {
      quizID = (quizID + 1) % quizzes.length;
    });
  }

  SnackBar feedbackSnackBar(bool isCorrect) {
    return SnackBar(
      content: Text(isCorrect ? "Correct answer :)" : "Wrong answer :("),
      backgroundColor: isCorrect ? Colors.green : Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quiz",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).accentColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset('images/${quizzes[quizID].image}'),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).accentColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(20),
              child: Text(
                quizzes[quizID].question,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    bool isCorrect = quizzes[quizID].isCorrect;
                    ScaffoldMessenger.of(context).showSnackBar(feedbackSnackBar(isCorrect));
                    nextQuiz();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  ),
                  child: Text(
                    "True",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    bool isCorrect = !quizzes[quizID].isCorrect;
                    ScaffoldMessenger.of(context).showSnackBar(feedbackSnackBar(isCorrect));
                    nextQuiz();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  ),
                  child: Text(
                    "False",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: nextQuiz,
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                shape: CircleBorder(),
                padding: EdgeInsets.all(15),
              ),
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
