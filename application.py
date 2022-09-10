import os

from appsettings import application
from controllers.self_enrolment import self_enrolment
from controllers.assign_learners import assign_learners
from controllers.create_quiz import create_quiz
from controllers.take_quiz import take_quiz
from controllers.access_course_materials import access_course_materials
from views import learner_view
from admin_view import admin_view


application.register_blueprint(self_enrolment)
application.register_blueprint(assign_learners)
application.register_blueprint(create_quiz)
application.register_blueprint(take_quiz)
application.register_blueprint(access_course_materials)
application.register_blueprint(learner_view)
application.register_blueprint(admin_view)

if __name__ == "__main__":
    print(
        "This is flask for "
        + os.path.basename(__file__)
        + ": Starting Learning Management System..."
    )
    application.run(host="0.0.0.0", port=5000, debug=True)
