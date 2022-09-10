from flask import Blueprint, render_template

learner_view = Blueprint("learner_view", __name__)


@learner_view.route("/")
def index():
    return render_template("index.html")


@learner_view.route("/courses")
def course():
    return render_template("courses.html")


@learner_view.route("/classes")
def classes():
    return render_template("classes.html")


@learner_view.route("/create_quiz")
def create_quiz():
    return render_template("create-quiz.html")


@learner_view.route("/take_quiz")
def take_quiz():
    return render_template("take-quiz.html")


@learner_view.route("/select_class")
def select_classes():
    return render_template("select_class.html")


@learner_view.route("/enrol")
def enrol_class():
    return render_template("enrolment_status.html")


@learner_view.route("/enrolled_courses")
def view_enrolled_class():
    return render_template("course_enrolled.html")


@learner_view.route("/view_course_material")
def view_course_material():
    return render_template("view_course_material.html")
