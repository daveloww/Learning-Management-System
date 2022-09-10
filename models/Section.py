from appsettings import db
from utility.utility import toDictionaryArray


class Section(db.Model):
    __tablename__ = "section"

    course_id = db.Column(db.Integer, primary_key=True)
    class_id = db.Column(db.Integer, primary_key=True)
    section_id = db.Column(db.Integer, primary_key=True)

    def to_dict(self):
        columns = self.__mapper__.column_attrs.keys()

        result = {}

        for column in columns:
            result[column] = getattr(self, column)
        return result

    @staticmethod
    def getListByCourseAndClass(course_id, class_id):
        section_list = Section.query.filter(
            Section.course_id == course_id,
            Section.class_id == class_id,
        ).all()
        return toDictionaryArray(section_list)

    @staticmethod
    def getSectionsByCourseAndClass(course_id, class_id):
        section_list = (
            Section.query.filter(
                Section.course_id == course_id,
                Section.class_id == class_id,
            )
            .with_entities(Section.section_id)
            .all()
        )
        return section_list
