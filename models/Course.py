from appsettings import db
from utility.utility import toDictionaryArray


class Course(db.Model):
    __tablename__ = "course"

    course_id = db.Column(db.Integer, primary_key=True)
    course_name = db.Column(db.String(80), nullable=False)
    description = db.Column(db.String(1000), nullable=False)

    def to_dict(self):
        """
        'to_dict' converts the object into a dictionary,
        in which the keys correspond to database columns
        """

        columns = self.__mapper__.column_attrs.keys()

        result = {}

        for column in columns:
            result[column] = getattr(self, column)
        return result

    @staticmethod
    def getAllCourses():
        courses = Course.query.all()
        return toDictionaryArray(courses)

    @staticmethod
    def getCourseById(search_course_id):
        course = Course.query.filter_by(course_id=search_course_id).first()
        return course
