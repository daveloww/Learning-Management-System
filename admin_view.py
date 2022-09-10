from flask import Blueprint, render_template


admin_view = Blueprint("admin_view", __name__)


@admin_view.route("/assign_learners")
def course():
    return render_template("assign_learners.html")


@admin_view.route("/assign_enrol_date")
def class_enrol_date():
    return render_template("class_enrolment_date_assignment.html")


@admin_view.route("/approve_reject_request")
def approve_reject_request():
    return render_template("approve_reject_request.html")
