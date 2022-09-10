from flask import Blueprint, request
from utility.utility import sendResponse, removeKeysFromDict
from models.Quiz import Quiz
from models.Quiz_Question import Quiz_Question
from models.Quiz_Option import Quiz_Option
from models.Section_Progress import Section_Progress
from models.Enrolment import Enrolment

take_quiz = Blueprint("take_quiz", __name__)


@take_quiz.route("/getQuiz", methods=["GET"])
def getQuiz():
    quiz_identifiers = request.args
    course_id = quiz_identifiers["course_id"]
    class_id = quiz_identifiers["class_id"]
    section_id = quiz_identifiers["section_id"]

    quiz = Quiz.getQuiz(course_id, class_id, section_id)
    if quiz:

        quiz_questions = Quiz_Question.getQuizQuestions(
            course_id, class_id, section_id
        )

        if len(quiz_questions):
            for i, question in enumerate(quiz_questions):
                quiz_questions[i] = removeKeysFromDict(
                    question, ["course_id", "class_id", "section_id"]
                )
                question_no = question["question_no"]

                quiz_options = Quiz_Option.getQuizOptions(
                    course_id, class_id, section_id, question_no
                )

                if len(quiz_options):
                    for j, option in enumerate(quiz_options):
                        quiz_options[j] = removeKeysFromDict(
                            option,
                            [
                                "course_id",
                                "class_id",
                                "section_id",
                                "question_no",
                            ],
                        )
                question["options"] = quiz_options

        quiz["quiz_questions"] = quiz_questions

        result = {
            "data": quiz,
        }
        return sendResponse(result, 200)

    result = {"message": "Quiz not found."}
    return sendResponse(result, 404)


@take_quiz.route("/submitQuiz", methods=["POST"])
def submitQuiz():
    if request.is_json:
        quiz_attempt = request.get_json()

        engineer_id = quiz_attempt["engineer_id"]
        course_id = quiz_attempt["course_id"]
        class_id = quiz_attempt["class_id"]
        section_id = quiz_attempt["section_id"]
        question_ans = quiz_attempt["question_ans"]

        score = 0
        for i, ans in enumerate(question_ans):
            if ans == 0:
                continue
            question_no = i + 1
            result = Quiz_Option.checkQuizOption(
                course_id, class_id, section_id, question_no, ans
            )
            if result:
                score += Quiz_Question.getMarks(
                    course_id, class_id, section_id, question_no
                )

        total_marks = Quiz.getTotalMarks(course_id, class_id, section_id)
        passing_mark = total_marks * 0.85

        if int(section_id) == 0 and score >= passing_mark:
            try:
                Section_Progress.updateFinalSectionProgressToComplete(
                    engineer_id, course_id, class_id, score
                )

                Enrolment.updateEnrolmentToComplete(
                    engineer_id, course_id, class_id
                )

                result = {
                    "message": "Successfully passed quiz.",
                    "score": score,
                }
                return sendResponse(result, 200)

            except Exception as e:
                print(e)
                result = {
                    "message": "An error occured when updating"
                    + " section progress and/or enrolment."
                }
                return sendResponse(result, 500)

        elif int(section_id) == 0 and score < passing_mark:
            result = {
                "message": "Failed the quiz.",
                "score": score,
            }
            return sendResponse(result, 200)

        else:
            try:
                Section_Progress.updateSectionProgressToComplete(
                    engineer_id, course_id, class_id, section_id
                )

                result = {
                    "message": "Successfully completed quiz.",
                    "score": score,
                }
                return sendResponse(result, 200)

            except Exception as e:
                print(e)
                result = {
                    "message": "An error occured when updating"
                    + " section progress."
                }
                return sendResponse(result, 500)

    result = {"message": "Input is not in JSON format."}
    return sendResponse(result, 500)
