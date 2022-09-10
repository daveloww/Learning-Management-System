from flask import Blueprint, request
from utility.utility import (
    sendResponse,
    compareStartDateTimeWithNow,
    compareStartAndEndDateTimeWithNow,
    compareEnrolEndDateTimeWithNow,
    compareOneDayBeforeStartDateWithNow,
)
from models.Course import Course
from models.Prerequisite import Prerequisite
from models.Enrolment import Enrolment
from models.Employee import Engineer
from models.Assignment import Assignment
from models.Class import Class


self_enrolment = Blueprint("self_enrolment", __name__)


@self_enrolment.route("/getAllCourses", methods=["GET"])
def getAllCourses():
    course_list = Course.getAllCourses()

    if len(course_list):
        result = {"data": course_list}
        return sendResponse(result, 200)

    result = {"message": "There are no courses."}
    return sendResponse(result, 404)


@self_enrolment.route("/coursesPrereqEligibility", methods=["GET"])
def coursesPrereqEligibility():
    engineer_id = request.args.get("engineer_id")

    try:
        # Checking if engineer_id is valid
        engineer = Engineer.getEngineerById(engineer_id)

        if not engineer:
            result = {"message": "Invalid engineer_id (" + engineer_id + ")"}
            return sendResponse(result, 404)

        # Retrieving all courses
        course_list = Course.getAllCourses()

        if course_list:

            # Create Dictionary (Key = course_id, Value = course_name)
            # For inserting pre-quisites later
            course_dict = {}

            for course in course_list:
                course_dict[course["course_id"]] = course["course_name"]

            # Get engineer's list of completed courses
            completed_obj_list = Enrolment.getListOfCompletedCourses(
                engineer_id
            )

            completed_courses = [
                obj["course_id"] for obj in completed_obj_list
            ]

            for course in course_list:

                course_id = course["course_id"]

                # Get list of prerequisites for course_id
                prereq_obj_list = Prerequisite.getPrerequisitesForCourse(
                    course_id
                )

                # Used for comparison later
                prereq_list = [
                    obj["prereq_course_id"] for obj in prereq_obj_list
                ]

                # Pre-req list for front-end to display
                course["prequisites"] = []

                for prereq in prereq_list:
                    course["prequisites"].append([prereq, course_dict[prereq]])

                course["prequisites"].sort()

                # 1st check - Completed course before?
                if course_id in completed_courses:
                    course["status"] = "Completed"
                    continue

                # 2nd check - Fulfilled prequisites for course?
                fulfilled_prequisites = all(
                    (course in completed_courses for course in prereq_list)
                )

                if not fulfilled_prequisites:
                    course["status"] = "Prerequisites not fulfilled"
                    continue

                # Get list of engineer's uncompleted classes of a course
                uncompleted_list = (
                    Enrolment.getListOfUncompletedClassesForACourse(
                        engineer_id, course_id
                    )
                )

                # 3rd check - Enrolled before?
                if len(uncompleted_list) == 0:
                    course["status"] = "Eligible"

                else:
                    ongoing_or_future_classes = []

                    for uncompleted_class in uncompleted_list:
                        u_course_id = uncompleted_class["course_id"]
                        u_class_id = uncompleted_class["class_id"]

                        class_dict = Class.getClassByIds(
                            u_course_id, u_class_id
                        ).to_dict()

                        # Utility - check if class = past OR ongoing/future
                        # Returns boolean
                        is_ongoing_or_future = compareStartDateTimeWithNow(
                            class_dict
                        )

                        if is_ongoing_or_future:
                            ongoing_or_future_classes.append(uncompleted_class)

                    # 4th check - Any ongoing or future classes?
                    # If no, it means all are past failed classes
                    if len(ongoing_or_future_classes) == 0:
                        course["status"] = "Eligible"

                    else:
                        approved = False
                        pending = False

                        for cf_class in ongoing_or_future_classes:

                            if cf_class["status"] == "Approved":
                                approved = True

                            if cf_class["status"] == "Pending":
                                pending = True

                        # 5th check
                        # If "Approved" exists = Enrolled (ongoing/future)
                        # If NOT, and "Pending" exists = Pending approval
                        # If both does not exist = "Rejected" records only
                        if approved:
                            course["status"] = "Enrolled"

                        elif pending:
                            course["status"] = "Pending Approval"

                        else:
                            course["status"] = "Eligible"

        result = {"data": course_list}
        return sendResponse(result, 200)

    except Exception as e:
        print(e)
        result = {"message": "Internal server error. Try again."}
        return sendResponse(result, 500)


@self_enrolment.route("/getClassesForSelfEnrol", methods=["GET"])
def getClassesForSelfEnrol():
    course_id = request.args.get("course_id")

    # Checks if course_id is valid
    course = Course.getCourseById(course_id)

    if not course:
        result = {"message": "Invalid course_id (" + course_id + ")"}
        return sendResponse(result, 404)

    # Only retrieves classes with enrolment dates filled up
    class_list = Class.getClassesWithEnrolmentDates(course_id)

    if class_list:

        for class_dict in class_list:

            # Utility - check if it is enrolment period now
            # Returns boolean
            class_dict[
                "within_enrol_period"
            ] = compareStartAndEndDateTimeWithNow(class_dict, "enrol_")

            # Retrieve records from Enrolment table
            enrolment_list = Enrolment.getByCourseAndClass(
                course_id, class_dict["class_id"]
            )

            # Count number of people who are already enrolled
            currently_enrolled = len(enrolment_list)

            # Deduct from class size to find available slots left
            class_dict["avail_slots_left"] = (
                class_dict["class_size"] - currently_enrolled
            )

        result = {"data": class_list}
        return sendResponse(result, 200)

    result = {
        "message": "There are no classes for course_id (" + course_id + ")"
    }
    return sendResponse(result, 404)


@self_enrolment.route("/enrolInClass", methods=["POST"])
def enrolInClass():
    if request.is_json:
        enrolment_details = request.get_json()
        engineer_id = enrolment_details["engineer_id"]
        course_id = enrolment_details["course_id"]
        class_id = enrolment_details["class_id"]

        # Check if engineer has requested enrolment before
        enrolment_obj = Enrolment.getObjectByIds(
            engineer_id, course_id, class_id
        )

        try:
            if enrolment_obj:
                Enrolment.updateEnrolmentStatus(
                    engineer_id, course_id, class_id, "Pending"
                )

            else:
                enrolment = Enrolment(
                    engineer_id=enrolment_details["engineer_id"],
                    course_id=enrolment_details["course_id"],
                    class_id=enrolment_details["class_id"],
                    status="Pending",
                    is_completed=0,
                )

                Enrolment.enrol(enrolment)

        except Exception as e:
            print(e)
            result = {
                "message": "An error occurred during"
                + " submission of your enrolment request."
            }
            return sendResponse(result, 500)

        result = {"data": enrolment_details}
        return sendResponse(result, 201)


@self_enrolment.route("/viewClassDetails", methods=["GET"])
def viewClassDetails():
    try:
        course_id = request.args.get("course_id")
        class_id = request.args.get("class_id")
        course = Course.getCourseById(course_id)
        course_description = course.description
        course_name = course.course_name
        course_prereqs = Prerequisite.getPrerequisitesForCourse(course_id)
        prereq_list = []
        for prereq in course_prereqs:
            prereq_id = prereq["prereq_course_id"]
            prereqcourse_name = Course.getCourseById(prereq_id).course_name
            prereq_list.append(prereqcourse_name)

        # trainer_id = Assignment.get_assigned_engineer(
        #     course_id, class_id
        # ).to_dict()["engineer_id"]

        assignment_obj = Assignment.get_assigned_engineer(course_id, class_id)
        if assignment_obj:
            trainer_id = Assignment.get_assigned_engineer(
                course_id, class_id
            ).to_dict()["engineer_id"]
            trainer_name = Engineer.getEngineerById(trainer_id).to_dict()[
                "employee_name"
            ]
        else:
            trainer_name = "No Trainer Assigned"

        class_start_date = Class.getClassByIds(course_id, class_id).to_dict()[
            "start_date"
        ]
        class_end_date = Class.getClassByIds(course_id, class_id).to_dict()[
            "end_date"
        ]
        class_size = Class.getClassByIds(course_id, class_id).to_dict()[
            "class_size"
        ]
        classes = Enrolment.getByCourseAndClass(course_id, class_id)
        class_occupancy = 0
        for current_class in classes:
            class_occupancy += 1
        class_availability = class_size - class_occupancy
        class_details = {}
        class_details["course_id"] = course_id
        class_details["course_name"] = course_name
        class_details["course_description"] = course_description
        class_details["prereqs"] = prereq_list
        class_details["trainer_name"] = trainer_name
        class_details["class_id"] = class_id
        class_details["class_start_date"] = class_start_date
        class_details["class_end_date"] = class_end_date
        class_details["class_size"] = class_size
        class_details["class_availability"] = class_availability

        result = {"data": class_details}
        return sendResponse(result, 200)

    except Exception as e:
        print(e)
        result = {
            "message": "An error occurred during"
            + " retrieval of class details."
        }
        return sendResponse(result, 500)


@self_enrolment.route("/getEngineerEnrolment", methods=["GET"])
def getEngineerEnrolment():
    engineer_id = request.args.get("engineer_id")

    try:
        enrolment_list = Enrolment.getEnrolmentListByEngineer(engineer_id)

        for enrolment in enrolment_list:
            course_id = enrolment["course_id"]
            class_id = enrolment["class_id"]

            # Retrieve Course object to get course_name
            course_dict = Course.getCourseById(course_id).to_dict()
            enrolment["course_name"] = course_dict["course_name"]

            # Retrieve Class object to get enrolment dates
            class_dict = Class.getClassByIds(course_id, class_id).to_dict()

            # Utility - check if enrolment has passed based on today's datetime
            enrolment_period_not_over = compareEnrolEndDateTimeWithNow(
                class_dict
            )

            enrolment["enrolment_period_not_over"] = False

            if enrolment_period_not_over:
                enrolment["enrolment_period_not_over"] = True

        result = {"data": enrolment_list}
        return sendResponse(result, 200)

    except Exception as e:
        print(e)
        result = {
            "message": "An error occurred during"
            + " retrieval of enrolment list."
        }
        return sendResponse(result, 500)


@self_enrolment.route("/getListOfPendingEnrolments", methods=["GET"])
def getListOfPendingEnrolments():
    try:
        pending_list = Enrolment.getListOfPendingEnrolments()

        pending_class_not_started_list = []

        for pending_enrolment in pending_list:
            course_id = pending_enrolment["course_id"]
            class_id = pending_enrolment["class_id"]

            # Retrieve Class object to get start date
            class_dict = Class.getClassByIds(course_id, class_id).to_dict()

            # Utility - check if today is at least 1 day before start date
            one_day_before_start_date = compareOneDayBeforeStartDateWithNow(
                class_dict
            )

            if one_day_before_start_date:
                # Retrieve Course object to get course_name
                course_dict = Course.getCourseById(course_id).to_dict()
                pending_enrolment["course_name"] = course_dict["course_name"]

                # Retrieve class_size from class_dict
                class_size = class_dict["class_size"]

                # Retrieve engineers who are already enrolled in this class
                enrolled_list = Enrolment.getByCourseAndClass(
                    course_id, class_id
                )

                # Count number of enrolled engineers
                currently_enrolled = len(enrolled_list)

                pending_enrolment["is_class_full"] = False

                if class_size == currently_enrolled:
                    pending_enrolment["is_class_full"] = True

                pending_class_not_started_list.append(pending_enrolment)

        result = {"data": pending_class_not_started_list}
        return sendResponse(result, 200)

    except Exception as e:
        print(e)
        result = {
            "message": "An error occurred during"
            + " retrieval of pending requests."
        }
        return sendResponse(result, 500)


@self_enrolment.route("/updateEnrolmentStatus", methods=["POST"])
def updateEnrolmentStatus():
    if request.is_json:
        enrolment_details = request.get_json()

        engineer_id = enrolment_details["engineer_id"]
        course_id = enrolment_details["course_id"]
        class_id = enrolment_details["class_id"]
        approved = enrolment_details["is_approved"]

        enrolment = Enrolment.getObjectByIds(engineer_id, course_id, class_id)

        if not enrolment:
            result = {"message": "Enrolment record not found."}
            return sendResponse(result, 404)

        if approved:
            status = "Approved"
        else:
            status = "Rejected"

        try:
            Enrolment.updateEnrolmentStatus(
                engineer_id, course_id, class_id, status
            )

        except Exception as e:
            print(e)
            result = {
                "message": "An error occurred during"
                + " updating of your enrolment request."
            }
            return sendResponse(result, 500)

        result = {
            "message": "Successfully updated enrolment request"
            + " to "
            + status
            + "."
        }
        return sendResponse(result, 201)

    result = {"message": "Input is not JSON format."}
    return sendResponse(result, 500)


@self_enrolment.route("/withdrawEnrolment", methods=["DELETE"])
def withdrawEnrolment():
    engineer_id = request.args.get("engineer_id")
    course_id = request.args.get("course_id")
    class_id = request.args.get("class_id")

    enrolment = Enrolment.getObjectByIds(engineer_id, course_id, class_id)

    if not enrolment:
        result = {"message": "Enrolment record not found."}
        return sendResponse(result, 404)

    try:
        Enrolment.removeEnrolment(engineer_id, course_id, class_id)

    except Exception as e:
        print(e)
        result = {
            "message": "An error occurred during withdrawal of enrolment."
        }
        return sendResponse(result, 500)

    result = {"message": "Successfully withdrawed enrolment."}
    return sendResponse(result, 201)
