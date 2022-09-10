from appsettings import db
from utility.utility import toDictionaryArray


class Quiz_Question(db.Model):
    __tablename__ = "quiz_question"

    course_id = db.Column(db.Integer, primary_key=True)
    class_id = db.Column(db.Integer, primary_key=True)
    section_id = db.Column(db.Integer, primary_key=True)
    question_no = db.Column(db.Integer, primary_key=True)

    type = db.Column(db.String(30), nullable=False)
    question = db.Column(db.String(150), nullable=False)
    marks = db.Column(db.Integer, nullable=False)

    def to_dict(self):
        columns = self.__mapper__.column_attrs.keys()

        result = {}

        for column in columns:
            result[column] = getattr(self, column)
        return result

    @staticmethod
    def addQuizQuestion(
        course_id, class_id, section_id, question_no, question, type, marks
    ):
        new_quiz_question = Quiz_Question(
            course_id=course_id,
            class_id=class_id,
            section_id=section_id,
            question_no=question_no,
            question=question,
            type=type,
            marks=marks,
        )

        db.session.add(new_quiz_question)
        db.session.commit()

    @staticmethod
    def getQuizQuestions(course_id, class_id, section_id):
        quiz_questions = Quiz_Question.query.filter(
            Quiz_Question.course_id == course_id,
            Quiz_Question.class_id == class_id,
            Quiz_Question.section_id == section_id,
        ).all()
        return toDictionaryArray(quiz_questions)

    @staticmethod
    def getMarks(course_id, class_id, section_id, question_no):
        marks = (
            Quiz_Question.query.filter(
                Quiz_Question.course_id == course_id,
                Quiz_Question.class_id == class_id,
                Quiz_Question.section_id == section_id,
                Quiz_Question.question_no == question_no,
            )
            .first()
            .marks
        )
        return marks
