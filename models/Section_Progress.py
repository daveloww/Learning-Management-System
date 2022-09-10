from appsettings import db
from utility.utility import toDictionaryArray


class Section_Progress(db.Model):
    __tablename__ = "section_progress"

    engineer_id = db.Column(db.Integer, primary_key=True)
    course_id = db.Column(db.Integer, primary_key=True)
    class_id = db.Column(db.Integer, primary_key=True)
    section_id = db.Column(db.Integer, primary_key=True)

    material_completed = db.Column(db.Integer, nullable=False, default=0)
    quiz_score = db.Column(db.Integer, nullable=True)

    is_completed = db.Column(db.Integer, nullable=False, default=0)

    def to_dict(self):
        columns = self.__mapper__.column_attrs.keys()

        result = {}

        for column in columns:
            result[column] = getattr(self, column)
        return result

    @staticmethod
    def updateSectionProgressToComplete(
        engineer_id, course_id, class_id, section_id
    ):
        section_progress = Section_Progress.query.filter(
            Section_Progress.engineer_id == engineer_id,
            Section_Progress.course_id == course_id,
            Section_Progress.class_id == class_id,
            Section_Progress.section_id == section_id,
        ).first()
        section_progress.is_completed = 1
        db.session.commit()

    @staticmethod
    def updateFinalSectionProgressToComplete(
        engineer_id, course_id, class_id, score
    ):
        final_section_progress = Section_Progress.query.filter(
            Section_Progress.engineer_id == engineer_id,
            Section_Progress.course_id == course_id,
            Section_Progress.class_id == class_id,
            Section_Progress.section_id == 0,
        ).first()
        final_section_progress.quiz_score = score
        final_section_progress.is_completed = 1
        db.session.commit()

    @staticmethod
    def getAllSectionProgressByIds(engineer_id, course_id, class_id):
        section_progress_list = (
            Section_Progress.query.filter(
                Section_Progress.engineer_id == engineer_id,
                Section_Progress.course_id == course_id,
                Section_Progress.class_id == class_id,
            )
            .order_by(Section_Progress.section_id.asc())
            .all()
        )
        return toDictionaryArray(section_progress_list)

    @staticmethod
    def addSectionProgress(sp_object):
        db.session.add(sp_object)
        db.session.commit()

    @staticmethod
    def updateMaterialCompleted(engineer_id, course_id, class_id, section_id):
        section_progress = Section_Progress.query.filter(
            Section_Progress.engineer_id == engineer_id,
            Section_Progress.course_id == course_id,
            Section_Progress.class_id == class_id,
            Section_Progress.section_id == section_id,
        ).first()
        section_progress.material_completed = 1
        db.session.commit()

        return section_progress.to_dict()
