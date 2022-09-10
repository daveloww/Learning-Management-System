from appsettings import db

# from utility.utility import toDictionaryArray


class Quiz(db.Model):
    __tablename__ = "quiz"

    course_id = db.Column(db.Integer, primary_key=True)
    class_id = db.Column(db.Integer, primary_key=True)
    section_id = db.Column(db.Integer, primary_key=True)
    time_limit = db.Column(db.Integer, nullable=False)
    total_marks = db.Column(db.Integer, nullable=False)

    def to_dict(self):
        columns = self.__mapper__.column_attrs.keys()

        result = {}

        for column in columns:
            result[column] = getattr(self, column)
        return result

    @staticmethod
    def addQuiz(course_id, class_id, section_id, time_limit, total_marks):
        new_quiz = Quiz(
            course_id=course_id,
            class_id=class_id,
            section_id=section_id,
            time_limit=time_limit,
            total_marks=total_marks,
        )

        db.session.add(new_quiz)
        db.session.commit()

    @staticmethod
    def getQuiz(course_id, class_id, section_id):
        quiz = Quiz.query.filter(
            Quiz.course_id == course_id,
            Quiz.class_id == class_id,
            Quiz.section_id == section_id,
        ).first()
        return quiz.to_dict()

    @staticmethod
    def checkQuizExist(course_id, class_id, section_id):
        quiz = Quiz.query.filter(
            Quiz.course_id == course_id,
            Quiz.class_id == class_id,
            Quiz.section_id == section_id,
        ).first()

        if quiz:
            return True
        return False

    @staticmethod
    def getTotalMarks(course_id, class_id, section_id):
        total_marks = (
            Quiz.query.filter(
                Quiz.course_id == course_id,
                Quiz.class_id == class_id,
                Quiz.section_id == section_id,
            )
            .first()
            .total_marks
        )
        return total_marks
