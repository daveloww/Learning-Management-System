from appsettings import db
from utility.utility import toDictionaryArray


class Employee(db.Model):
    __abstract__ = True

    employee_name = db.Column(db.String(80), nullable=False)
    username = db.Column(db.String(80), nullable=False)
    password = db.Column(db.String(80), nullable=False)
    dept = db.Column(db.String(80), nullable=False)
    designation = db.Column(db.String(80), nullable=False)

    def to_dict(self):
        columns = self.__mapper__.column_attrs.keys()

        result = {}

        for column in columns:
            result[column] = getattr(self, column)
        return result


class Administrator(Employee):
    __tablename__ = "administrator"
    admin_id = db.Column(db.Integer, primary_key=True)


class Engineer(Employee):
    __tablename__ = "engineer"
    engineer_id = db.Column(db.Integer, primary_key=True)

    @staticmethod
    def getEngineerById(search_engineer_id):
        engineer = Engineer.query.filter_by(
            engineer_id=search_engineer_id
        ).first()
        return engineer

    @staticmethod
    def getAllEngineers():
        engineers = Engineer.query.all()
        return toDictionaryArray(engineers)
