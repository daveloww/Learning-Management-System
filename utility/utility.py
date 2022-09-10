from flask import make_response, jsonify
from datetime import datetime, timedelta


def toDictionaryArray(data):
    array = [obj.to_dict() for obj in data]
    return array


def sendResponse(result, code):
    response = make_response(jsonify(result), code)
    response.mimetype = "application/json"
    return response


def removeKeysFromDict(d, keys):
    for key in keys:
        d.pop(key, None)
    return d


# If comparing enrolment dates, enrol = "enrol_"
# If comparing normal dates, exclude argument
# Check if current datetime falls within Start and End DateTime
# Returns boolean
def compareStartAndEndDateTimeWithNow(class_dict, enrol=""):
    start_date = enrol + "start_date"
    end_date = enrol + "end_date"
    start_time = enrol + "start_time"
    end_time = enrol + "end_time"

    # Spilt the date strings into year, month, day
    start_date_list = class_dict[start_date].split("-")
    end_date_list = class_dict[end_date].split("-")

    # Split the time strings into hour, min, sec
    start_time_list = class_dict[start_time].split(":")
    end_time_list = class_dict[end_time].split(":")

    # Create datetime objects to be used to compare with current time
    start_datetime = createDatetimeObject(start_date_list, start_time_list)
    end_datetime = createDatetimeObject(end_date_list, end_time_list)

    # Get current datetime
    current_datetime = datetime.now()

    return start_datetime <= current_datetime <= end_datetime


def compareStartDateTimeWithNow(class_dict):
    # Spilt the date strings into year, month, day
    start_date_list = class_dict["start_date"].split("-")
    end_date_list = class_dict["end_date"].split("-")

    # Split the time strings into hour, min, sec
    start_time_list = class_dict["start_time"].split(":")
    end_time_list = class_dict["end_time"].split(":")

    # Create datetime objects to be used to compare with current time
    start_datetime = createDatetimeObject(start_date_list, start_time_list)
    end_datetime = createDatetimeObject(end_date_list, end_time_list)

    # Get current datetime
    current_datetime = datetime.now()

    if start_datetime > current_datetime:
        return True

    return start_datetime <= current_datetime <= end_datetime


def checkClassHasNotStarted(class_dict):
    # Spilt the date strings into year, month, day
    start_date_list = class_dict["start_date"].split("-")

    # Split the time strings into hour, min, sec
    start_time_list = class_dict["start_time"].split(":")

    # Create datetime objects to be used to compare with current time
    start_datetime = createDatetimeObject(start_date_list, start_time_list)

    # Get current datetime
    current_datetime = datetime.now()

    return start_datetime > current_datetime


def compareEnrolStartDateTimeWithNow(class_dict):
    # Spilt the date strings into year, month, day
    start_date_list = class_dict["enrol_start_date"].split("-")

    # Split the time string into hour, min, sec
    start_time_list = class_dict["enrol_start_time"].split(":")

    # Create datetime objects to be used to compare with current time
    start_datetime = createDatetimeObject(start_date_list, start_time_list)

    # Get current datetime
    current_datetime = datetime.now()

    return current_datetime < start_datetime


def compareEnrolEndDateTimeWithNow(class_dict):
    # Spilt the date strings into year, month, day
    end_date_list = class_dict["enrol_end_date"].split("-")

    # Split the time string into hour, min, sec
    end_time_list = class_dict["enrol_end_time"].split(":")

    # Create datetime objects to be used to compare with current time
    end_datetime = createDatetimeObject(end_date_list, end_time_list)

    # Get current datetime
    current_datetime = datetime.now()

    return current_datetime <= end_datetime


def compareOneDayBeforeStartDateWithNow(class_dict):
    # Spilt the date strings into year, month, day
    start_date_list = class_dict["start_date"].split("-")

    # Split the time string into hour, min, sec
    # Modifying for explanation below
    start_time_list = ["23", "59", "59"]

    # Create datetime objects to be used to compare with current time
    # - 1 day, as admin shouldn't accept/reject on start date itself
    one_day_before_start_date = createDatetimeObject(
        start_date_list, start_time_list
    ) - timedelta(days=1)

    # Get current datetime
    current_datetime = datetime.now()

    return current_datetime <= one_day_before_start_date


# Returns datetime object to be used for comparison of dates
def createDatetimeObject(date_list, time_list):
    year = int(date_list[0])

    # Removing leading 0, if exist
    # e.g. 02 --> 2
    if date_list[1][0] == "0":
        month = int(date_list[1][1])
    else:
        month = int(date_list[1])

    if date_list[2][0] == "0":
        day = int(date_list[2][1])
    else:
        day = int(date_list[2])

    if time_list[0][0] == "0":
        hour = int(time_list[0][1])
    else:
        hour = int(time_list[0])

    if time_list[1][0] == "0":
        min = int(time_list[1][1])
    else:
        min = int(time_list[1])

    if time_list[2][0] == "0":
        sec = int(time_list[2][1])
    else:
        sec = int(time_list[2])

    return datetime(year, month, day, hour, min, sec)
