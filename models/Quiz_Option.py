from appsettings import db
from utility.utility import toDictionaryArray


class Quiz_Option(db.Model):
    __tablename__ = "quiz_option"

    course_id = db.Column(db.Integer, primary_key=True)
    class_id = db.Column(db.Integer, primary_key=True)
    section_id = db.Column(db.Integer, primary_key=True)
    question_no = db.Column(db.Integer, primary_key=True)
    option_no = db.Column(db.Integer, primary_key=True)

    option = db.Column(db.String(100), nullable=False)
    is_correct = db.Column(db.Integer, nullable=False)

    def to_dict(self):
        columns = self.__mapper__.column_attrs.keys()

        result = {}

        for column in columns:
            result[column] = getattr(self, column)
        return result

    @staticmethod
    def addQuizOption(
        course_id,
        class_id,
        section_id,
        question_no,
        option_no,
        option,
        is_correct,
    ):
        new_quiz_option = Quiz_Option(
            course_id=course_id,
            class_id=class_id,
            section_id=section_id,
            question_no=question_no,
            option_no=option_no,
            option=option,
            is_correct=is_correct,
        )

        db.session.add(new_quiz_option)
        db.session.commit()

    @staticmethod
    def getQuizOptions(course_id, class_id, section_id, question_no):
        quiz_options = Quiz_Option.query.filter(
            Quiz_Option.course_id == course_id,
            Quiz_Option.class_id == class_id,
            Quiz_Option.section_id == section_id,
            Quiz_Option.question_no == question_no,
        ).all()
        return toDictionaryArray(quiz_options)

    @staticmethod
    def checkQuizOption(
        course_id, class_id, section_id, question_no, option_no
    ):
        result = (
            Quiz_Option.query.filter(
                Quiz_Option.course_id == course_id,
                Quiz_Option.class_id == class_id,
                Quiz_Option.section_id == section_id,
                Quiz_Option.question_no == question_no,
                Quiz_Option.option_no == option_no,
            )
            .first()
            .is_correct
        )
        return result
