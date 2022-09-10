from appsettings import db
from utility.utility import toDictionaryArray


class Enrolment(db.Model):
    __tablename__ = "enrolment"

    engineer_id = db.Column(db.Integer, primary_key=True)
    course_id = db.Column(db.Integer, primary_key=True)
    class_id = db.Column(db.Integer, primary_key=True)

    status = db.Column(db.String(20), nullable=False)
    is_completed = db.Column(db.Integer, nullable=False, default=0)

    def to_dict(self):
        columns = self.__mapper__.column_attrs.keys()

        result = {}

        for column in columns:
            result[column] = getattr(self, column)
        return result

    @staticmethod
    def getEnrolmentListByEngineer(search_engineer_id):
        enrolment_list = (
            Enrolment.query.filter_by(engineer_id=search_engineer_id)
            .order_by(Enrolment.course_id.asc(), Enrolment.class_id.asc())
            .all()
        )
        return toDictionaryArray(enrolment_list)

    # Get list of "Approved" only enrolment records
    # Using course_id and class_id
    @staticmethod
    def getByCourseAndClass(search_course_id, search_class_id):
        enrolment_list = (
            Enrolment.query.filter_by(course_id=search_course_id)
            .filter_by(class_id=search_class_id)
            .filter_by(status="Approved")
            .all()
        )
        return toDictionaryArray(enrolment_list)

    @staticmethod
    def getObjectByIds(search_engineer_id, search_course_id, search_class_id):
        enrolment_obj = (
            Enrolment.query.filter_by(engineer_id=search_engineer_id)
            .filter_by(course_id=search_course_id)
            .filter_by(class_id=search_class_id)
            .first()
        )
        return enrolment_obj

    @staticmethod
    def updateEnrolmentStatus(engineer_id, course_id, class_id, status):
        enrolment = Enrolment.query.filter(
            Enrolment.engineer_id == engineer_id,
            Enrolment.course_id == course_id,
            Enrolment.class_id == class_id,
        ).first()
        enrolment.status = status
        db.session.commit()

    @staticmethod
    def enrol(new_enrol_object):
        db.session.add(new_enrol_object)
        db.session.commit()

    @staticmethod
    def updateEnrolmentToComplete(engineer_id, course_id, class_id):
        enrolment = Enrolment.query.filter(
            Enrolment.engineer_id == engineer_id,
            Enrolment.course_id == course_id,
            Enrolment.class_id == class_id,
        ).first()
        enrolment.is_completed = 1
        db.session.commit()

    # Get list of "Approved" only enrolment records
    # Using engineer_id
    # Sorted by course_id, class_id ASC
    @staticmethod
    def getApprovedListByEngineer(engineer_id):
        approved_list = (
            Enrolment.query.filter(
                Enrolment.engineer_id == engineer_id,
                Enrolment.status == "Approved",
            )
            .order_by(Enrolment.course_id.asc(), Enrolment.class_id.asc())
            .all()
        )
        return toDictionaryArray(approved_list)

    @staticmethod
    def getListOfCompletedCourses(engineer_id):
        passed_list = Enrolment.query.filter(
            Enrolment.engineer_id == engineer_id,
            Enrolment.is_completed == 1,
        ).all()
        return toDictionaryArray(passed_list)

    @staticmethod
    def getListOfUncompletedClassesForACourse(engineer_id, course_id):
        uncompleted_list = Enrolment.query.filter(
            Enrolment.engineer_id == engineer_id,
            Enrolment.course_id == course_id,
            Enrolment.is_completed != 1,
        ).all()
        return toDictionaryArray(uncompleted_list)

    @staticmethod
    def getListOfPendingEnrolments():
        pending_list = (
            Enrolment.query.filter(Enrolment.status == "Pending")
            .order_by(Enrolment.course_id.asc(), Enrolment.class_id.asc())
            .all()
        )
        return toDictionaryArray(pending_list)

    @staticmethod
    def removeEnrolment(engineer_id, course_id, class_id):
        Enrolment.query.filter(
            Enrolment.engineer_id == engineer_id,
            Enrolment.course_id == course_id,
            Enrolment.class_id == class_id,
        ).delete()
        db.session.commit()
