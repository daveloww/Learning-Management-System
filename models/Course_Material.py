from appsettings import db
from utility.utility import toDictionaryArray


class Course_Material(db.Model):
    __tablename__ = "course_material"

    course_id = db.Column(db.Integer, primary_key=True)
    class_id = db.Column(db.Integer, primary_key=True)
    section_id = db.Column(db.Integer, primary_key=True)
    course_material_id = db.Column(db.Integer, primary_key=True)

    type = db.Column(db.String(30), nullable=False)
    content = db.Column(db.String(1000), nullable=False)
    description = db.Column(db.String(80), nullable=False)

    def to_dict(self):
        columns = self.__mapper__.column_attrs.keys()

        result = {}

        for column in columns:
            result[column] = getattr(self, column)
        return result

    @staticmethod
    def getAllMaterialsByIds(course_id, class_id):
        materials = (
            Course_Material.query.filter(
                Course_Material.course_id == course_id,
                Course_Material.class_id == class_id,
            )
            .order_by(Course_Material.section_id.asc())
            .all()
        )
        return toDictionaryArray(materials)
