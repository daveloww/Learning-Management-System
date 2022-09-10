from appsettings import db
from utility.utility import toDictionaryArray


class Class(db.Model):
    __tablename__ = "class"

    course_id = db.Column(db.Integer, primary_key=True)
    class_id = db.Column(db.Integer, primary_key=True)

    start_date = db.Column(db.String(10), nullable=False)
    end_date = db.Column(db.String(10), nullable=False)
    start_time = db.Column(db.String(8), nullable=False)
    end_time = db.Column(db.String(8), nullable=False)

    class_size = db.Column(db.Integer, nullable=False)

    enrol_start_date = db.Column(db.String(10), nullable=True)
    enrol_end_date = db.Column(db.String(10), nullable=True)
    enrol_start_time = db.Column(db.String(8), nullable=True)
    enrol_end_time = db.Column(db.String(8), nullable=True)

    def to_dict(self):
        columns = self.__mapper__.column_attrs.keys()

        result = {}

        for column in columns:
            result[column] = getattr(self, column)
        return result

    @staticmethod
    def getAllClassesForCourse(course_id):
        classes = Class.query.filter(Class.course_id == course_id).all()
        return toDictionaryArray(classes)

    @staticmethod
    def getClassesWithEnrolmentDates(course_id):
        classes = Class.query.filter(
            Class.course_id == course_id,
            Class.enrol_start_date.isnot(None),
            Class.enrol_end_date.isnot(None),
            Class.enrol_start_time.isnot(None),
            Class.enrol_end_time.isnot(None),
        ).all()
        return toDictionaryArray(classes)

    @staticmethod
    def getAllClassesWithNoEnrolDates():
        classes = Class.query.filter(
            Class.enrol_start_date.is_(None),
            Class.enrol_end_date.is_(None),
            Class.enrol_start_time.is_(None),
            Class.enrol_end_time.is_(None),
        ).all()
        return toDictionaryArray(classes)

    @staticmethod
    def getClassByIds(search_course_id, search_class_id):
        class_obj = (
            Class.query.filter_by(course_id=search_course_id)
            .filter_by(class_id=search_class_id)
            .first()
        )
        return class_obj

    @staticmethod
    def updateEnrolmentDates(
        course_id,
        class_id,
        enrol_start_date,
        enrol_end_date,
        enrol_start_time,
        enrol_end_time,
    ):
        class_obj = Class.query.filter(
            Class.course_id == course_id, Class.class_id == class_id
        ).first()

        class_obj.enrol_start_date = enrol_start_date
        class_obj.enrol_end_date = enrol_end_date
        class_obj.enrol_start_time = enrol_start_time
        class_obj.enrol_end_time = enrol_end_time

        db.session.commit()
