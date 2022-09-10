import unittest
from models.Assignment import Assignment
from models.Class import Class
from models.Course import Course
from models.Course_Material import Course_Material
from models.Employee import Engineer, Administrator
from models.Enrolment import Enrolment
from models.Prerequisite import Prerequisite
from models.Quiz import Quiz
from models.Quiz_Question import Quiz_Question
from models.Quiz_Option import Quiz_Option
from models.Section_Progress import Section_Progress
from models.Section import Section


# Leonard Siah Tian Long
class TestAssignment(unittest.TestCase):
    def setUp(self):
        self.assignment = Assignment(
            engineer_id=345678, course_id=1, class_id=1
        )

    def tearDown(self):
        self.assignment = None

    def test_to_dict(self):
        self.assertEqual(
            self.assignment.to_dict(),
            {"engineer_id": 345678, "course_id": 1, "class_id": 1},
        )


# Leonard Siah Tian Long
class TestClass(unittest.TestCase):
    def setUp(self):
        self.class1 = Class(
            course_id=1,
            class_id=1,
            start_date="2021-02-10",
            end_date="2021-03-10",
            start_time="09:00:00",
            end_time="11:00:00",
            class_size=15,
            enrol_start_date="2021-01-15",
            enrol_end_date="2021-01-30",
            enrol_start_time="08:00:00",
            enrol_end_time="12:00:00",
        )

    def tearDown(self):
        self.class1 = None

    def test_to_dict(self):
        self.assertEqual(
            self.class1.to_dict(),
            {
                "course_id": 1,
                "class_id": 1,
                "start_date": "2021-02-10",
                "end_date": "2021-03-10",
                "start_time": "09:00:00",
                "end_time": "11:00:00",
                "class_size": 15,
                "enrol_start_date": "2021-01-15",
                "enrol_end_date": "2021-01-30",
                "enrol_start_time": "08:00:00",
                "enrol_end_time": "12:00:00",
            },
        )


# Leonard Siah Tian Long
class TestCourseMaterialds(unittest.TestCase):
    def setUp(self):
        self.course_materials = Course_Material(
            course_id=1,
            class_id=1,
            section_id=1,
            course_material_id=1,
            type="PDF",
            content="Printer for electrical...",
            description="there are 4 key of electrical printers..",
        )

    def tearDown(self):
        self.course_materials = None

    def test_to_dict(self):
        self.assertEqual(
            self.course_materials.to_dict(),
            {
                "course_id": 1,
                "class_id": 1,
                "section_id": 1,
                "course_material_id": 1,
                "type": "PDF",
                "content": "Printer for electrical...",
                "description": "there are 4 key of electrical printers..",
            },
        )


# Sim Zhi Han, Samuel
class TestQuiz(unittest.TestCase):
    def setUp(self):
        self.q1 = Quiz(
            course_id=1,
            class_id=1,
            section_id=1,
            time_limit=10,
            total_marks=10,
        )
        self.q2 = Quiz(
            course_id=1,
            class_id=2,
            section_id=3,
            time_limit=20,
            total_marks=20,
        )

    def tearDown(self):
        self.q1 = None
        self.q2 = None

    def test_to_dict(self):
        self.assertEqual(
            self.q1.to_dict(),
            {
                "course_id": 1,
                "class_id": 1,
                "section_id": 1,
                "time_limit": 10,
                "total_marks": 10,
            },
        )
        self.assertEqual(
            self.q2.to_dict(),
            {
                "course_id": 1,
                "class_id": 2,
                "section_id": 3,
                "time_limit": 20,
                "total_marks": 20,
            },
        )


# Sim Zhi Han, Samuel
class TestQuizQuestion(unittest.TestCase):
    def setUp(self):
        self.qn1 = Quiz_Question(
            course_id=1,
            class_id=1,
            section_id=1,
            question_no=1,
            type="MCQ",
            question="What is agile?",
            marks=5,
        )
        self.qn2 = Quiz_Question(
            course_id=1,
            class_id=1,
            section_id=1,
            question_no=2,
            type="T/F",
            question="A Scrum team should have a Scrum Master.",
            marks=5,
        )

    def tearDown(self):
        self.qn1 = None
        self.qn2 = None

    def test_to_dict(self):
        self.assertEqual(
            self.qn1.to_dict(),
            {
                "course_id": 1,
                "class_id": 1,
                "section_id": 1,
                "question_no": 1,
                "type": "MCQ",
                "question": "What is agile?",
                "marks": 5,
            },
        )
        self.assertEqual(
            self.qn2.to_dict(),
            {
                "course_id": 1,
                "class_id": 1,
                "section_id": 1,
                "question_no": 2,
                "type": "T/F",
                "question": "A Scrum team should have a Scrum Master.",
                "marks": 5,
            },
        )


# Sim Zhi Han, Samuel
class TestQuizOption(unittest.TestCase):
    def setUp(self):
        self.opt1 = Quiz_Option(
            course_id=1,
            class_id=1,
            section_id=1,
            question_no=2,
            option_no=1,
            option="True",
            is_correct=1,
        )
        self.opt2 = Quiz_Option(
            course_id=1,
            class_id=1,
            section_id=1,
            question_no=2,
            option_no=2,
            option="False",
            is_correct=0,
        )

    def tearDown(self):
        self.opt1 = None
        self.opt2 = None

    def test_to_dict(self):
        self.assertEqual(
            self.opt1.to_dict(),
            {
                "course_id": 1,
                "class_id": 1,
                "section_id": 1,
                "question_no": 2,
                "option_no": 1,
                "option": "True",
                "is_correct": 1,
            },
        )
        self.assertEqual(
            self.opt2.to_dict(),
            {
                "course_id": 1,
                "class_id": 1,
                "section_id": 1,
                "question_no": 2,
                "option_no": 2,
                "option": "False",
                "is_correct": 0,
            },
        )


# Dave Low
class TestSectionProgress(unittest.TestCase):
    def test_to_dict(self):
        sp1 = Section_Progress(
            engineer_id=123456,
            course_id=1,
            class_id=1,
            section_id=1,
            material_completed=1,
            quiz_score=100,
            is_completed=1,
        )

        self.assertEqual(
            sp1.to_dict(),
            {
                "engineer_id": 123456,
                "course_id": 1,
                "class_id": 1,
                "section_id": 1,
                "material_completed": 1,
                "quiz_score": 100,
                "is_completed": 1,
            },
        )

        sp2 = Section_Progress(
            course_id=9,
            class_id=8,
            section_id=7,
            material_completed=1,
            quiz_score=100,
            is_completed=1,
        )

        self.assertEqual(
            sp2.to_dict(),
            {
                "engineer_id": None,
                "course_id": 9,
                "class_id": 8,
                "section_id": 7,
                "material_completed": 1,
                "quiz_score": 100,
                "is_completed": 1,
            },
        )


# Dave Low
class TestSection(unittest.TestCase):
    def test_to_dict(self):
        s1 = Section(course_id=1, class_id=2, section_id=3)

        self.assertEqual(
            s1.to_dict(), {"course_id": 1, "class_id": 2, "section_id": 3}
        )

        s2 = Section(course_id=8, class_id=8)

        self.assertEqual(
            s2.to_dict(), {"course_id": 8, "class_id": 8, "section_id": None}
        )


# Ian Koh
class TestCourse(unittest.TestCase):
    def setUp(self):
        self.course1 = Course(
            course_id=1,
            course_name="Mechanics 1",
            description="Test Description for Mechanics 1",
        )
        self.course2 = Course(
            course_id=2,
            course_name="Mechanics 2",
            description="Test Description for Mechanics 2",
        )

    def tearDown(self):
        self.course1 = None
        self.course2 = None

    def test_to_dict(self):
        self.assertEqual(
            self.course1.to_dict(),
            {
                "course_id": 1,
                "course_name": "Mechanics 1",
                "description": "Test Description for Mechanics 1",
            },
        )
        self.assertEqual(
            self.course2.to_dict(),
            {
                "course_id": 2,
                "course_name": "Mechanics 2",
                "description": "Test Description for Mechanics 2",
            },
        )


class TestPrerequisite(unittest.TestCase):
    def setUp(self):
        self.course1 = Prerequisite(course_id=2, prereq_course_id=1)
        self.course2 = Prerequisite(course_id=3, prereq_course_id=2)

    def tearDown(self):
        self.course1 = None
        self.course2 = None

    def test_to_dict(self):
        self.assertEqual(
            self.course1.to_dict(),
            {"course_id": 2, "prereq_course_id": 1},
        )
        self.assertEqual(
            self.course2.to_dict(),
            {"course_id": 3, "prereq_course_id": 2},
        )


# Damian Ng
class TestEmployee(unittest.TestCase):
    def setUp(self):
        self.employee_engineer = Engineer(
            employee_name="Dave Low",
            username="daveloww",
            password="davepwd",
            dept="Field Engineering",
            designation="Engineer",
            engineer_id=345678,
        )
        self.employee_administrator = Administrator(
            employee_name="Leonard Siah",
            username="leoking",
            password="leopwd",
            dept="Human Resources",
            designation="Senior Executive",
            admin_id=123456,
        )

    def tearDown(self):
        self.employee_engineer = None
        # self.employee_administrator = None

    def test_to_dict(self):
        self.assertEqual(
            self.employee_engineer.to_dict(),
            {
                "employee_name": "Dave Low",
                "username": "daveloww",
                "password": "davepwd",
                "dept": "Field Engineering",
                "designation": "Engineer",
                "engineer_id": 345678,
            },
        )
        self.assertEqual(
            self.employee_administrator.to_dict(),
            {
                "employee_name": "Leonard Siah",
                "username": "leoking",
                "password": "leopwd",
                "dept": "Human Resources",
                "designation": "Senior Executive",
                "admin_id": 123456,
            },
        )


# Damian Ng
class TestEnrolment(unittest.TestCase):
    def setUp(self):
        # Went through course before and completed
        self.enrolment1 = Enrolment(
            engineer_id=345678,
            course_id=1,
            class_id=1,
            status="Approved",
            is_completed=1,
        )
        # Went through course before but did not complete
        self.enrolment2 = Enrolment(
            engineer_id=345678,
            course_id=2,
            class_id=1,
            status="Approved",
            is_completed=0,
        )
        # Applied for same course again and class in-progress
        self.enrolment3 = Enrolment(
            engineer_id=345678,
            course_id=2,
            class_id=2,
            status="Approved",
            is_completed=0,
        )
        # Applied but rejected by HR
        self.enrolment4 = Enrolment(
            engineer_id=345678,
            course_id=3,
            class_id=3,
            status="Rejected",
            is_completed=0,
        )
        # Applied for same course but diff class
        self.enrolment5 = Enrolment(
            engineer_id=345678,
            course_id=3,
            class_id=4,
            status="Pending",
            is_completed=0,
        )

    def tearDown(self):
        self.enrolment1 = None
        self.enrolment2 = None
        self.enrolment3 = None
        self.enrolment4 = None
        self.enrolment5 = None

    def test_to_dict(self):
        self.assertEqual(
            self.enrolment1.to_dict(),
            {
                "engineer_id": 345678,
                "course_id": 1,
                "class_id": 1,
                "status": "Approved",
                "is_completed": 1,
            },
        )
        self.assertEqual(
            self.enrolment2.to_dict(),
            {
                "engineer_id": 345678,
                "course_id": 2,
                "class_id": 1,
                "status": "Approved",
                "is_completed": 0,
            },
        )
        self.assertEqual(
            self.enrolment3.to_dict(),
            {
                "engineer_id": 345678,
                "course_id": 2,
                "class_id": 2,
                "status": "Approved",
                "is_completed": 0,
            },
        )
        self.assertEqual(
            self.enrolment4.to_dict(),
            {
                "engineer_id": 345678,
                "course_id": 3,
                "class_id": 3,
                "status": "Rejected",
                "is_completed": 0,
            },
        )
        self.assertEqual(
            self.enrolment5.to_dict(),
            {
                "engineer_id": 345678,
                "course_id": 3,
                "class_id": 4,
                "status": "Pending",
                "is_completed": 0,
            },
        )


if __name__ == "__main__":
    unittest.main()
