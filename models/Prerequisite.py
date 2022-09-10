from appsettings import db
from utility.utility import toDictionaryArray


class Prerequisite(db.Model):
    __tablename__ = "prerequisite"

    course_id = db.Column(db.Integer, primary_key=True)
    prereq_course_id = db.Column(db.Integer, primary_key=True)

    def to_dict(self):
        columns = self.__mapper__.column_attrs.keys()

        result = {}

        for column in columns:
            result[column] = getattr(self, column)
        return result

    @staticmethod
    def getPrerequisitesForCourse(course_id):
        prerequisites = Prerequisite.query.filter(
            Prerequisite.course_id == course_id
        ).all()
        return toDictionaryArray(prerequisites)

    @staticmethod
    def getAllPrerequisites():
        prereqs = Prerequisite.query.all()
        return toDictionaryArray(prereqs)
