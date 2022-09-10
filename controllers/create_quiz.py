from flask import Blueprint, request
from models.Assignment import Assignment
from models.Section import Section
from utility.utility import sendResponse
from models.Quiz import Quiz
from models.Quiz_Question import Quiz_Question
from models.Quiz_Option import Quiz_Option

create_quiz = Blueprint("create_quiz", __name__)


@create_quiz.route("/addQuiz", methods=["POST"])
def addQuiz():
    if request.is_json:
        quiz_details = request.get_json()

        course_id = quiz_details["course_id"]
        class_id = quiz_details["class_id"]
        section_id = quiz_details["section_id"]
        time_limit = quiz_details["time_limit"]
        total_marks = quiz_details["total_marks"]

        if Quiz.checkQuizExist(course_id, class_id, section_id):
            result = {"message": "Quiz already exist for this section."}
            return sendResponse(result, 409)

        try:
            Quiz.addQuiz(
                course_id, class_id, section_id, time_limit, total_marks
            )

            quiz_questions = quiz_details["quiz_questions"]
            for quiz_question in quiz_questions:
                question_no = quiz_question["question_no"]
                question = quiz_question["question"]
                type = quiz_question["type"]
                marks = quiz_question["marks"]

                try:
                    Quiz_Question.addQuizQuestion(
                        course_id,
                        class_id,
                        section_id,
                        question_no,
                        question,
                        type,
                        marks,
                    )

                    for quiz_option in quiz_question["options"]:
                        option_no = quiz_option["option_no"]
                        option = quiz_option["option"]
                        is_correct = quiz_option["is_correct"]

                        try:
                            Quiz_Option.addQuizOption(
                                course_id,
                                class_id,
                                section_id,
                                question_no,
                                option_no,
                                option,
                                is_correct,
                            )

                        except Exception as e:
                            print(e)
                            # raise Exception("add quiz_option error")
                            result = {
                                "message": "An error occured when adding"
                                + " quiz_option to database."
                            }
                            return sendResponse(result, 500)

                except Exception as e:
                    print(e)
                    # raise Exception("add quiz_question error")
                    result = {
                        "message": "An error occured when adding"
                        + " quiz_question to database."
                    }
                    return sendResponse(result, 500)

        except Exception as e:
            print(e)
            # raise Exception("add quiz error")
            result = {
                "message": "An error occured when adding quiz to database."
            }
            return sendResponse(result, 500)

        result = {
            "message": f"Successfully added quiz for Course {course_id},"
            + f" Class {class_id}, Section {section_id} to database."
        }
        return sendResponse(result, 200)

    result = {"message": "Input is not in JSON format."}
    return sendResponse(result, 500)


@create_quiz.route("/getCoursesClassesAndSectionsByTrainer", methods=["GET"])
def getCoursesClassesAndSectionsByTrainer():
    engineer_id = request.args.get("engineer_id")
    courses_and_classes = Assignment.get_classes_and_courses_by_trainer(
        engineer_id
    )

    assignment_dict = {}
    for i in range(len(courses_and_classes)):
        current = courses_and_classes[i]
        current_course_id = current["course_id"]
        current_class_id = current["class_id"]
        current_sections = Section.getSectionsByCourseAndClass(
            current_course_id, current_class_id
        )

        section_list = []
        for section in current_sections:
            section_list.append(section[0])
        current["sections"] = section_list
        assignment_dict[i] = current

    return sendResponse(assignment_dict, 200)
