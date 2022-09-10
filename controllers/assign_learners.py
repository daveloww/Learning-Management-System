from flask import Blueprint, request
from utility.utility import (
    sendResponse,
    compareEnrolStartDateTimeWithNow,
    compareStartDateTimeWithNow,
)
from models.Class import Class
from models.Course import Course
from models.Section import Section
from models.Section_Progress import Section_Progress
from models.Enrolment import Enrolment
from models.Employee import Engineer
from models.Prerequisite import Prerequisite

assign_learners = Blueprint("assign_learners", __name__)


@assign_learners.route("/getAllClassesWithNoEnrolDates", methods=["GET"])
def getAllClassesWithNoEnrolDates():
    try:
        class_list = Class.getAllClassesWithNoEnrolDates()

        result = {"data": class_list}
        return sendResponse(result, 200)

    except Exception as e:
        print(e)
        result = {
            "message": "An error occurred when " + "retrieving class list."
        }
        return sendResponse(result, 500)


@assign_learners.route("/updateEnrolmentDates", methods=["POST"])
def updateEnrolmentDates():
    # POST request - expecting JSON
    # Start & End DATE in string and format of "YYYY-MM-DD"
    # Start & End TIME in string and format of "HH:MM:SS"

    if request.is_json:

        data = request.get_json()

        if not all(
            key in data.keys()
            for key in (
                "course_id",
                "class_id",
                "start_date",
                "end_date",
                "start_time",
                "end_time",
            )
        ):
            result = {"message": "Incorrect JSON object provided."}
            return sendResponse(result, 500)

        try:
            Class.updateEnrolmentDates(
                data["course_id"],
                data["class_id"],
                data["start_date"],
                data["end_date"],
                data["start_time"],
                data["end_time"],
            )

            result = {"data": data}
            return sendResponse(result, 201)

        except Exception as e:
            print(e)
            result = {
                "message": "An error occurred when "
                + "updating enrolment dates."
            }
            return sendResponse(result, 500)

    result = {"message": "Input is not in JSON format."}
    return sendResponse(result, 500)


@assign_learners.route("/getClassByIds", methods=["GET"])
def getClassByIds():
    course_id = request.args.get("course_id")
    class_id = request.args.get("class_id")

    class_obj = Class.getClassByIds(course_id, class_id)

    if class_obj:
        result = {"data": [class_obj.to_dict()]}
        return sendResponse(result, 200)

    result = {
        "message": "Invalid course_id ("
        + course_id
        + ") and class_id ("
        + class_id
        + ")"
    }
    return sendResponse(result, 404)


@assign_learners.route("/getAllClassesForCourse", methods=["GET"])
def getAllClassesForCourse():
    course_id = request.args.get("course_id")

    # Checks if course_id is valid
    course = Course.getCourseById(course_id)

    if not course:
        result = {"message": "Invalid course_id (" + course_id + ")"}
        return sendResponse(result, 404)

    class_list = Class.getClassesWithEnrolmentDates(course_id)

    output_class_list = []

    if class_list:

        for class_dict in class_list:

            # Utility - check if today is before enrolment start datetime
            # Returns boolean
            if compareEnrolStartDateTimeWithNow(class_dict):

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

                output_class_list.append(class_dict)

    result = {"data": output_class_list}
    return sendResponse(result, 200)


@assign_learners.route("/getEligibleLearnersForCourse", methods=["GET"])
def getEligibleLearnersForCourse():
    course_id = request.args.get("course_id")

    try:
        # Retrieving full list of engineers
        engineers_list = Engineer.getAllEngineers()

        output_engineers_list = []

        if engineers_list:

            # Get list of prerequisites for course_id
            prereq_obj_list = Prerequisite.getPrerequisitesForCourse(course_id)

            prereq_list = [obj["prereq_course_id"] for obj in prereq_obj_list]

            for engineer in engineers_list:
                engineer_id = engineer["engineer_id"]

                # Get engineer's list of completed courses
                completed_obj_list = Enrolment.getListOfCompletedCourses(
                    engineer_id
                )

                completed_courses = [
                    obj["course_id"] for obj in completed_obj_list
                ]

                # 1st check - Completed course before?
                if int(course_id) in completed_courses:
                    continue

                # 2nd check - Fulfilled prequisites for course?
                fulfilled_prequisites = all(
                    (course in completed_courses for course in prereq_list)
                )

                if not fulfilled_prequisites:
                    continue

                # Get list of engineer's uncompleted classes of a course
                uncompleted_list = (
                    Enrolment.getListOfUncompletedClassesForACourse(
                        engineer_id, course_id
                    )
                )

                # 3rd check - Enrolled before?
                if len(uncompleted_list) == 0:
                    output_engineers_list.append(engineer)

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
                        output_engineers_list.append(engineer)

                    else:
                        approved = False
                        pending = False

                        for cf_class in ongoing_or_future_classes:

                            if cf_class["status"] == "Approved":
                                approved = True

                            if cf_class["status"] == "Pending":
                                pending = True

                        # 5th check
                        # Are ongoing/future classes "Approved" or "Pending"?
                        # If don't have both, then all records are "Rejected"
                        if not approved and not pending:
                            output_engineers_list.append(engineer)

        result = {"data": output_engineers_list}
        return sendResponse(result, 200)

    except Exception as e:
        print(e)
        result = {"message": "Internal server error. Try again."}
        return sendResponse(result, 500)


@assign_learners.route("/assignLearners", methods=["POST"])
def assignLearners():
    # Expecting JSON to be in the format of a list of objects [{}, {}]
    # Each object should contain engineer_id, course_id, class_id
    data = request.get_json()

    # Count learners to be assigned
    to_be_assigned = len(data)

    # Getting first element's course_id and class_id
    # Should be the same across all learners
    course_id = data[0]["course_id"]
    class_id = data[0]["class_id"]

    try:
        # Retrieving class details to get class size
        class_obj = Class.getClassByIds(course_id, class_id)

        if class_obj:

            class_size = class_obj.to_dict()["class_size"]

            try:
                # Retrieve records from Enrolment table
                enrolment_list = Enrolment.getByCourseAndClass(
                    course_id, class_id
                )

                # Count people who are already enrolled
                currently_enrolled = len(enrolment_list)

                leftover_slots = (
                    class_size - currently_enrolled - to_be_assigned
                )

                # If enough slots after deduction, start assigning
                if leftover_slots >= 0:

                    try:
                        # Retrieve number of sections first
                        section_list = Section.getListByCourseAndClass(
                            course_id, class_id
                        )

                        num_of_sections = len(section_list)

                        # Creating records in Enrolment & Section_Progress
                        for obj in data:
                            e_id = obj["engineer_id"]
                            co_id = obj["course_id"]
                            cl_id = obj["class_id"]

                            # Check if engineer has requested enrolment before
                            enrolment_obj = Enrolment.getObjectByIds(
                                e_id, co_id, cl_id
                            )

                            # If requested before,
                            if enrolment_obj:

                                # Modify "Rejected" record
                                if enrolment_obj.status == "Rejected":
                                    try:
                                        Enrolment.updateEnrolmentStatus(
                                            e_id, co_id, cl_id, "Approved"
                                        )

                                    except Exception as e:
                                        print(e)
                                        result = {
                                            "message": "An error occurred when"
                                            + " assigning engineer_id ("
                                            + str(e_id)
                                            + ")"
                                        }
                                        return sendResponse(result, 500)

                            else:
                                new_enrol_object = Enrolment(
                                    engineer_id=e_id,
                                    course_id=co_id,
                                    class_id=cl_id,
                                    status="Approved",
                                    is_completed=0,
                                )

                                # Create new enrolment
                                try:
                                    Enrolment.enrol(new_enrol_object)

                                except Exception as e:
                                    print(e)
                                    result = {
                                        "message": "An error occurred when"
                                        + " assigning engineer_id ("
                                        + str(e_id)
                                        + ")"
                                    }
                                    return sendResponse(result, 500)

                            # Insert new Section_Progress records
                            for i in range(num_of_sections):

                                new_sp_object = Section_Progress(
                                    engineer_id=e_id,
                                    course_id=co_id,
                                    class_id=cl_id,
                                    section_id=i,
                                    material_completed=0,
                                    quiz_score=None,
                                    is_completed=0,
                                )

                                try:
                                    Section_Progress.addSectionProgress(
                                        new_sp_object
                                    )

                                except Exception as e:
                                    print(e)
                                    result = {
                                        "message": "An error occurred when "
                                        + "adding new section_progress."
                                    }
                                    return sendResponse(result, 500)

                        result = {"data": data}
                        return sendResponse(result, 201)

                    except Exception as e:
                        print(e)
                        result = {
                            "message": "An error occurred when "
                            + "retrieving section list."
                        }
                        return sendResponse(result, 500)

                else:
                    result = {
                        "message": "Not enough slots to "
                        + "assign "
                        + str(to_be_assigned)
                        + " learners"
                    }
                    return sendResponse(result, 500)

            except Exception as e:
                print(e)
                result = {
                    "message": "An error occurred when "
                    + "retrieving enrolment list."
                }
                return sendResponse(result, 500)

        else:
            result = {
                "message": "course_id ("
                + str(course_id)
                + ") and class_id ("
                + str(class_id)
                + ") not found."
            }
            return sendResponse(result, 404)

    except Exception as e:
        print(e)
        result = {
            "message": "An error occurred when " + "retrieving class details."
        }
        return sendResponse(result, 500)
