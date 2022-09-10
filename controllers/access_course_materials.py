from flask import Blueprint, request
from utility.utility import (
    sendResponse,
    compareStartAndEndDateTimeWithNow,
    checkClassHasNotStarted,
)
from models.Employee import Engineer
from models.Enrolment import Enrolment
from models.Course import Course
from models.Class import Class
from models.Course_Material import Course_Material
from models.Section_Progress import Section_Progress

access_course_materials = Blueprint("access_course_materials", __name__)


@access_course_materials.route("/getEnrolledClasses", methods=["GET"])
def getEnrolledClasses():
    engineer_id = request.args.get("engineer_id")

    try:
        engineer = Engineer.getEngineerById(engineer_id)

        if engineer:

            try:
                # Get approved list of learner
                approved_list = Enrolment.getApprovedListByEngineer(
                    engineer_id
                )

                if approved_list:

                    # List to store Classes
                    class_list = []

                    for approved_enrolment in approved_list:
                        course_id = approved_enrolment["course_id"]
                        class_id = approved_enrolment["class_id"]
                        is_completed = approved_enrolment["is_completed"]

                        try:
                            # Retrieve Class object and convert to dict
                            class_dict = Class.getClassByIds(
                                course_id, class_id
                            ).to_dict()

                            if is_completed == 1:
                                class_dict["status"] = "Completed"

                            else:
                                # Utility to check if class is ongoing now
                                # Returns boolean
                                class_is_ongoing = (
                                    compareStartAndEndDateTimeWithNow(
                                        class_dict
                                    )
                                )

                                if class_is_ongoing:
                                    class_dict["status"] = "Ongoing"

                                else:

                                    class_has_not_started = (
                                        checkClassHasNotStarted(class_dict)
                                    )

                                    if class_has_not_started:
                                        class_dict["status"] = "Not Started"

                                    else:
                                        # Class ended but failed
                                        class_dict["status"] = "Not Completed"

                            # Retrieve Course object and convert to dict
                            course_dict = Course.getCourseById(
                                course_id
                            ).to_dict()

                            class_dict["course_name"] = course_dict[
                                "course_name"
                            ]

                            class_list.append(class_dict)

                        except Exception as e:
                            print(e)
                            result = {
                                "message": "An error occurred when retrieving"
                                + " course_id ("
                                + str(course_id)
                                + ") and class_id ("
                                + str(class_id)
                                + ")"
                            }
                            return sendResponse(result, 500)

                    result = {"data": class_list}
                    return sendResponse(result, 200)

                # engineer_id exist but no enrolment yet
                result = {"data": []}
                return sendResponse(result, 200)

            except Exception as e:
                print(e)
                result = {
                    "message": "An error occurred when retrieving"
                    + " enrolment list."
                }
                return sendResponse(result, 500)

        result = {"message": "engineer_id (" + engineer_id + ") not found"}
        return sendResponse(result, 404)

    except Exception as e:
        print(e)
        result = {
            "message": "An error occurred when verifying engineer_id ("
            + engineer_id
            + ")"
        }
        return sendResponse(result, 500)


@access_course_materials.route("/getAllCourseMaterials", methods=["GET"])
def getAllCourseMaterials():
    engineer_id = request.args.get("engineer_id")
    course_id = request.args.get("course_id")
    class_id = request.args.get("class_id")

    try:
        # Retrieve all course materials
        materials_list = Course_Material.getAllMaterialsByIds(
            course_id, class_id
        )

        if materials_list:

            # Moving final quiz to last index of the list
            final_quiz_material = materials_list.pop(0)
            materials_list.append(final_quiz_material)

            try:
                # Retrieve section_progress list of learner
                section_progress_list = (
                    Section_Progress.getAllSectionProgressByIds(
                        engineer_id, course_id, class_id
                    )
                )

                if section_progress_list:

                    # Moving final quiz to last index of the list
                    final_quiz_progress = section_progress_list.pop(0)
                    section_progress_list.append(final_quiz_progress)

                    # Compiles completion status of all sections
                    completion_dict = {}

                    for section_progress in section_progress_list:
                        completion_dict[section_progress["section_id"]] = {
                            "is_completed": section_progress["is_completed"],
                            "material_completed": section_progress[
                                "material_completed"
                            ],
                        }

                    # Ensures only one uncompleted section is made available
                    next_section_eligible_yet = False

                    for material in materials_list:
                        material_section_id = material["section_id"]
                        is_completed = completion_dict[material_section_id][
                            "is_completed"
                        ]
                        material_completed = completion_dict[
                            material_section_id
                        ]["material_completed"]

                        material["material_completed"] = material_completed

                        if is_completed:
                            material["is_eligible"] = True

                            if material_section_id == 0:
                                material["passed_quiz"] = "Passed"
                            else:
                                material["passed_quiz"] = "Completed"

                        else:
                            if not next_section_eligible_yet:
                                material["is_eligible"] = True
                                next_section_eligible_yet = True
                            else:
                                material["is_eligible"] = False

                            if material_section_id == 0:
                                material["passed_quiz"] = "Not passed"
                            else:
                                material["passed_quiz"] = "Not completed"

                        # Retrieve Course object and convert to dict
                        course_dict = Course.getCourseById(course_id).to_dict()

                        material["course_name"] = course_dict["course_name"]

                    result = {"data": materials_list}
                    return sendResponse(result, 200)

                result = {"message": "No section progress list found."}
                return sendResponse(result, 404)

            except Exception as e:
                print(e)
                result = {
                    "message": "An error occurred when retrieving"
                    + " section progress list."
                }
                return sendResponse(result, 500)

        result = {"message": "No course materials found."}
        return sendResponse(result, 404)

    except Exception as e:
        print(e)
        result = {
            "message": "An error occurred when retrieving"
            + " course materials."
        }
        return sendResponse(result, 500)


@access_course_materials.route("/updateMaterialCompleted", methods=["GET"])
def updateMaterialCompleted():
    engineer_id = request.args.get("engineer_id")
    course_id = request.args.get("course_id")
    class_id = request.args.get("class_id")
    section_id = request.args.get("section_id")

    try:
        section_progress = Section_Progress.updateMaterialCompleted(
            engineer_id, course_id, class_id, section_id
        )

    except Exception as e:
        print(e)
        result = {
            "message": "An error occurred when updating"
            + " material_completed in section_progress."
        }
        return sendResponse(result, 500)

    result = {"data": section_progress}
    return sendResponse(result, 201)
