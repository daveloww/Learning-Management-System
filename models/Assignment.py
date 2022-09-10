from appsettings import db
from utility.utility import toDictionaryArray

# from utility.utility import toDictionaryArray


class Assignment(db.Model):
    __tablename__ = "assignment"

    engineer_id = db.Column(db.Integer, primary_key=True)
    course_id = db.Column(db.Integer, primary_key=True)
    class_id = db.Column(db.Integer, primary_key=True)

    def to_dict(self):
        columns = self.__mapper__.column_attrs.keys()

        result = {}

        for column in columns:
            result[column] = getattr(self, column)
        return result

    @staticmethod
    def get_assigned_engineer(course_id, class_id):
        assignment = (
            Assignment.query.filter(Assignment.course_id == course_id)
            .filter(Assignment.class_id == class_id)
            .first()
        )
        return assignment

    @staticmethod
    def get_classes_and_courses_by_trainer(engineer_id):
        assignments = Assignment.query.filter(
            Assignment.engineer_id == engineer_id
        ).all()
        return toDictionaryArray(assignments)
