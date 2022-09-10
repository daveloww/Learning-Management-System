// URLs

var DNSLocal = "http://localhost:5000"

// LEARNERS//
var getAllCourses_url = DNSLocal + "/coursesPrereqEligibility?engineer_id="; // for engineer dave
var getAllClasses_url = DNSLocal + "/getClassesForSelfEnrol?course_id=";
var getClassDetails = DNSLocal + "/viewClassDetails?"
var getEnrolmentEmployee = DNSLocal + "/getEngineerEnrolment?"
var getClassEnrolled = DNSLocal + "/getEnrolledClasses?"
var getCourseMaterials = DNSLocal + "/getAllCourseMaterials?"
var updateSectionMaterialsCompletion = DNSLocal + "/updateMaterialCompleted?"
var withdrawEnrolment = DNSLocal + "/withdrawEnrolment?"

// ADMINISTRATORS//
var admin_getAllCourse = DNSLocal + "/getAllCourses";
var admin_getAllClass = DNSLocal + "/getAllClassesForCourse?course_id=";
var admin_getAllLearners = DNSLocal + "/getEligibleLearnersForCourse?";
var assignLearners_url = DNSLocal + "/assignLearners";
var admin_getAllClass_noEnrollDate = DNSLocal + "/getAllClassesWithNoEnrolDates";
var admin_getAllPendingClasses = DNSLocal + "/getListOfPendingEnrolments?"
var admin_approve_reject_enrollment = DNSLocal + "/updateEnrolmentStatus?";

//ENROL
var enrolInClass = DNSLocal + "/enrolInClass";
var updateEnrolmentStatus = DNSLocal + "/updateEnrolmentStatus";
var updateEnrolmentDates = DNSLocal + "/updateEnrolmentDates";

// Take Quiz 
var getQuiz_url = DNSLocal + "/getQuiz?";
var submit_quiz_url = DNSLocal + "/submitQuiz?";

// Create Quiz 
var get_dropdown_fields_url = DNSLocal + "/getCoursesClassesAndSectionsByTrainer?";
var course_selected = 1;
var class_selected = 1;
var section_selected = 0;
var max_number_of_questions = 1000000;
var total_number_of_questions = 0

// API request 
async function makeAPIRequest(endpoint, method) {
    let properties = {};

    if (method == 'POST') {
        properties = {
            method: 'POST',
            body: JSON.stringify({}),
            headers: { 'Content-type': 'application/json;' }
        }
    }

    try {
        const response = await fetch(endpoint, properties);
        const parsedJson = await response.json();

        console.log(response); // response object
        console.log(parsedJson) // parsing json body of response object to become a JavaScript object
        return parsedJson;
    } catch (error) {
        console.log(error);
        // do some error handling here
        return error;
    }
}
// login 
async function login() {
    var userName = document.getElementById("userName").value;
    var pw = document.getElementById("password").value;


    // Check if its agent 
    if (document.forms['login_form']['admin'].checked) {
        const data = {
            "admin_id": userName,
            "admin_password": pw
        };
        localStorage['admin_id'] = userName
        window.location.replace("assign_learners");
    } else {
        const data = {
            "engineer_id": userName,
            "engineer_password": pw
        };
        localStorage['engineer_id'] = userName
        window.location.replace("courses");
    }

}
// Create Quiz 
$(document).ready(function () {


    var counter = 0; //Initial field counter
    var counter_max = max_number_of_questions; //Input fields increment limitation

    // Once "add true/false" button is clicked
    $('.tf_add_button').click(function () {
        // Check maximum number of input fields, e.g. number of questions
        if (counter < counter_max) {
            // Increment field counter
            counter++;
            total_number_of_questions++;

            // New input field html
            var tf_additional_qn = `
            <div class="row">
                <div class="col-xs-11 col-sm-11 col-md-11">
                    <h4 class="mb-3">Question: ${counter} (<span id="type_question_${counter}">T/F</span>)</h4>
                    <div class="form-group">
                        <h5>Marks for this Question</h3><input type="number" class="form-control mb-3" id="qn_${counter}_mark" name="qn_${counter}_mark" placeholder="e.g. 2, 3 or 5" min="0" max="100">
                    </div>
                    <div class="mb-4">
                        <h5>Question</h3>
                        <input type="text" class="form-control mb-3" id="qn${counter}_qn" name="qn${counter}_qn" placeholder="Type your question here">
                        <h5>Answer</h3>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="qn${counter}_ans" id="qn${counter}_ans_true" value="True">
                            <label class="form-check-label" for="qn${counter}_ans_true">True</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="qn${counter}_ans" id="qn${counter}_ans_false" value="False">
                            <label class="form-check-label" for="qn${counter}_ans_false">False</label>
                        </div>
                    </div>
                </div>
            </div>
            `;
            //Add field html
            $('.list_wrapper').append(tf_additional_qn);
        }
    });

    // Once "add mcq" button is clicked
    $('.mcq_add_button').click(function () {
        // Check maximum number of input fields, e.g. number of questions
        if (counter < counter_max) {
            // Increment field counter
            counter++;
            total_number_of_questions++;

            // New input field html
            var mcq_additional_qn = `
            <div class="row">
                <div class="col-xs-11 col-sm-11 col-md-11">
                    <h4 class="mb-3">Question: ${counter} (<span id="type_question_${counter}">MCQ</span>)</h4>
                    <div class="form-group">
                        <h5>Marks for this Question</h3>
                        <input type="number" class="form-control mb-3" id="qn_${counter}_mark" name="qn_${counter}_mark" placeholder="e.g. 2, 3 or 5" min="0" max="100">
                    </div>
                    <div class="mb-4">
                        <h5>Question</h3>
                        <input type="text" class="form-control mb-3" id="qn${counter}_qn" name="qn${counter}_qn" placeholder="Type your question here">
                        <h5>Type all the answers and select the correct answer</h3>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <div class="input-group-text">
                                    <input type="radio" name="qn${counter}_ans" id="qn${counter}_ans_option_1">
                                </div>
                            </div>
                            <input type="text" class="form-control" id="qn${counter}_ans_option_1_text" placeholder="Type your answer here">
                        </div>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <div class="input-group-text">
                                    <input type="radio" name="qn${counter}_ans" id="qn${counter}_ans_option_2">
                                </div>
                            </div>
                            <input type="text" class="form-control" id="qn${counter}_ans_option_2_text" placeholder="Type your answer here">
                        </div>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <div class="input-group-text">
                                    <input type="radio" name="qn${counter}_ans" id="qn${counter}_ans_option_3">
                                </div>
                            </div>
                            <input type="text" class="form-control" id="qn${counter}_ans_option_3_text" placeholder="Type your answer here">
                        </div>
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <div class="input-group-text">
                                    <input type="radio" name="qn${counter}_ans" id="qn${counter}_ans_option_4">
                                </div>
                            </div>
                            <input type="text" class="form-control" id="qn${counter}_ans_option_4_text" placeholder="Type your answer here">
                        </div>
                    </div>
                </div>
            </div>
            `;
            //Add field html
            $('.list_wrapper').append(mcq_additional_qn);
        }
    });
});

async function loadDropdownFields() {
    let engineer_id = localStorage['engineer_id'];


    let dropdown_details = await makeAPIRequest(get_dropdown_fields_url + `engineer_id=${engineer_id}`, 'GET');

    // initialize empty course list to get unique courses
    var course_list = [];
    total_num_classes = Object.keys(dropdown_details).length;

    // to get unique courses for course list to add into dropdown
    for (var i = 0; i < total_num_classes; i++) {
        if (course_list.includes(dropdown_details[i]["course_id"])) {
            // pass
        } else {
            course_list.push(dropdown_details[i]["course_id"])
        }
    }

    // to add courses into course dropdown
    for (each_course in course_list) {
        $("#dropdownOptionsCourse").append(`<a class="dropdown-item">${course_list[each_course]}</a>`);
    }

    // course selected, change dropdown text
    $("#dropdownOptionsCourse").find('.dropdown-item').click(function () {
        $("#create_quiz_form").attr("hidden", true);
        $("#dropdownMenuButtonCourse").text($(this).text());
        $("#dropdownMenuButtonClass").text("Class");
        $("#dropdownMenuButtonSection").text("Section");

        course_selected = $(this).text();

        // reset class and section list when new course selected
        let class_list = [];
        let section_list = [];

        // reset class and section dropdown when new course selected
        $("#dropdownOptionsClass").empty();
        $("#dropdownOptionsSection").empty();

        // show classes the selected course has
        for (var i = 0; i < total_num_classes; i++) {
            // for value of course chosen, show the class
            if (dropdown_details[i]["course_id"] == course_selected) {
                // now to add classes into a class list
                class_list.push(dropdown_details[i]["class_id"])
            }
        }

        // to add classes into class dropdown
        for (each_class in class_list) {
            $("#dropdownOptionsClass").append(`<a class="dropdown-item">${class_list[each_class]}</a>`);
        }

        // class selected, change dropdown text
        $("#dropdownOptionsClass").find('.dropdown-item').click(function () {
            $("#create_quiz_form").attr("hidden", true);
            $("#dropdownMenuButtonClass").text($(this).text());
            $("#dropdownMenuButtonSection").text("Section");
            $("#dropdownOptionsSection").empty();

            // reset class and section list when new course selected
            let section_list = [];

            class_selected = $(this).text();

            for (var i = 0; i < total_num_classes; i++) {
                // if course and class selected, add sections into section list
                if (dropdown_details[i]["course_id"] == course_selected && dropdown_details[i]["class_id"] == class_selected) {

                    // get number of sections
                    total_num_sections = Object.keys(dropdown_details[i]["sections"]).length;

                    // create section list
                    for (var j = 0; j < total_num_sections; j++) {
                        // for value of course chosen, show the class
                        section_list.push(dropdown_details[i]["sections"][j])
                    }
                }
            }

            // to add sections into sections dropdown
            for (each_section in section_list) {
                $("#dropdownOptionsSection").append(`<a class="dropdown-item">${section_list[each_section]}</a>`);
            }

            // section selected, change dropdown text 
            $("#dropdownOptionsSection").find('.dropdown-item').click(function () {
                $("#dropdownMenuButtonSection").text($(this).text());
                section_selected = $(this).text();
                $("#create_quiz_form").removeAttr('hidden');
            });
        })
    });
}

function confirm_save_quiz() {
    alert("\nConfirm creation of quiz?");
}

$('#create_quiz_form').submit(async (event) => {
    event.preventDefault();

    var number_of_qns_plus_one = total_number_of_questions + 1;
    var create_quiz_url = DNSLocal + "/addQuiz";
    var course_id = course_selected;
    var class_id = class_selected;
    var section_id = section_selected;
    var time_limit = $('#quiz_duration').val();
    var total_marks = $('#quiz_total_marks').val();
    var quiz_questions = []

    console.log(course_id);
    console.log(class_id);
    console.log(section_id);

    for (let num = 1; num < number_of_qns_plus_one; num++) {

        // if true false question
        if ($('#type_question_' + num).html() == "T/F") {
            let question_to_add = {
                "question_no": num,
                "question": $('#qn' + num + '_qn').val(),
                "type": "T/F",
                "marks": parseInt($('#qn_' + num + '_mark').val()),
                "options": [
                    {
                        "option_no": 1,
                        "option": "True",
                        "is_correct": ($('#qn' + num + '_ans_true').is(":checked") ? 1 : 0)
                    },
                    {
                        "option_no": 2,
                        "option": "False",
                        "is_correct": ($('#qn' + num + '_ans_false').is(":checked") ? 1 : 0)
                    }
                ]
            }
            quiz_questions.push(question_to_add)
        }
        else {
            // for mcq questions
            let question_to_add = {
                "question_no": num,
                "question": $('#qn' + num + '_qn').val(),
                "type": "MCQ",
                "marks": parseInt($('#qn_' + num + '_mark').val()),
                "options": [
                    {
                        "option_no": 1,
                        "option": $('#qn' + num + '_ans_option_1_text').val(),
                        "is_correct": ($('#qn' + num + '_ans_option_1').is(":checked") ? 1 : 0)
                    },
                    {
                        "option_no": 2,
                        "option": $('#qn' + num + '_ans_option_2_text').val(),
                        "is_correct": ($('#qn' + num + '_ans_option_2').is(":checked") ? 1 : 0)
                    },
                    {
                        "option_no": 3,
                        "option": $('#qn' + num + '_ans_option_3_text').val(),
                        "is_correct": ($('#qn' + num + '_ans_option_3').is(":checked") ? 1 : 0)
                    },
                    {
                        "option_no": 4,
                        "option": $('#qn' + num + '_ans_option_4_text').val(),
                        "is_correct": ($('#qn' + num + '_ans_option_4').is(":checked") ? 1 : 0)
                    }
                ]
            }
            quiz_questions.push(question_to_add)
        }
    }

    let data = {
        "course_id": course_id,
        "class_id": class_id,
        "section_id": section_id,
        "time_limit": time_limit,
        "total_marks": total_marks,
        "quiz_questions": quiz_questions
    }

    try {
        const response = await fetch(create_quiz_url, {
            method: 'POST',
            mode: 'cors',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        });

        const status_code = await response["status"];
        const content = await response.json();

        if (status_code == 200) {
            // redirect with success alert\
            alert("\n" + content.message)
            window.location.replace("/create_quiz");
        } else {
            // no redirect but still have alert with error message
            alert("\n" + content.message)
        }

    } catch (error) {
        console.log(error)
    }
});

// Self-enrolment of learners
async function displayAllCourses() {

    let courses = await makeAPIRequest(getAllCourses_url + localStorage['engineer_id'], 'GET');
    console.log(courses[1]);
    // sessionStorage.setItem("engineerId", 345678);
    // courses[1]

    for (var i = 0; i < courses["data"].length; i++) {
        let course = courses["data"][i];
        // console.log(course);
        prereq_str = `<ol>`
            
        for(let i =0; i < course['prequisites'].length; i++){
            prereq_str +=`
            <li>${course['prequisites'][i][1]}</li>
            `
        }
        
        
        prereq_str += `</ol>`;
        if(course['prequisites'].length == 0){
            prereq_str = "<br> No Prerequisites needed";
        }


        if (course.status == "Completed") {

            
            let course_card_str = `
                <div class="col-lg-4 col-sm-6 mb-5">
                    <div class="card p-0 border-primary rounded-0 hover-shadow h-100">
                        <div class="card-body">
                            Course ID: ${course["course_id"]}
                            <h4 class="card-title" >${course["course_name"]}</h4>
                            <p class="card-text mb-4"> 
                                ${course["description"]}
                            </p>
                            <p>
                                <h6>Prerequisites course:</h6>
                                ${prereq_str}
                            </p>
                            <a href="classes" class="btn btn-light btn-sm disabled " aria-disabled="true" style="color:green">You have completed this course</a>
                        </div>
                    </div>  
                </div>
              `;
            document.getElementById("displayCourses").innerHTML += course_card_str;
        } else if (course.status == "Enrolled") {
            let course_card_str = `
                <div class="col-lg-4 mb-5">
                    <div class="card p-0 border-primary rounded-0 hover-shadow h-100">
                        <div class="card-body">
                            Course ID: ${course["course_id"]}
                            <h4 class="card-title" >${course["course_name"]}</h4>
                            <p class="card-text mb-4"> 
                                ${course["description"]}
                            </p>
                            <p>
                                <h6>Prerequisites course:</h6>
                                ${prereq_str}
                            </p>
                            <a href="classes" class="btn btn-light btn-sm disabled" tabindex="-1" role="button" aria-disabled="true">currently enrolled in this course</a>
                        </div>
                    </div>  
                </div>
              `;
            document.getElementById("displayCourses").innerHTML += course_card_str;

        } else if (course.status == "Pending Approval") {
            let course_card_str = `
                <div class="col-lg-4 mb-5">
                    <div class="card p-0 border-primary rounded-0 hover-shadow h-100">
                        <div class="card-body">
                            Course ID: ${course["course_id"]}
                            <h4 class="card-title" >${course["course_name"]}</h4>
                            <p class="card-text mb-4"> 
                                ${course["description"]}
                            </p>
                            <p>
                                <h6>Prerequisites course:</h6>
                                ${prereq_str}
                            </p>
                            <a href="classes" class="btn btn-light btn-sm disabled" tabindex="-1" role="button" aria-disabled="true">Pending Approval</a>
                        </div>
                    </div>  
                </div>
              `;
            document.getElementById("displayCourses").innerHTML += course_card_str;

        } else if (course.status == "Prerequisites not fulfilled") {
            let course_card_str = `
                <div class="col-lg-4 mb-5">
                    <div class="card p-0 border-primary rounded-0 hover-shadow h-100">
                        <div class="card-body">
                            Course ID: ${course["course_id"]}
                            <h4 class="card-title" >${course["course_name"]}</h4>
                            <p class="card-text mb-4"> 
                                ${course["description"]}
                            </p>
                            <p>
                                <h6>Prerequisites course:</h6>
                                ${prereq_str}
                            </p>
                            <a href="classes" class="btn btn-light btn-sm disabled" tabindex="-1" role="button" aria-disabled="true">Prerequisites not fulfilled</a>
                        </div>
                    </div>  
                </div>
              `;
            document.getElementById("displayCourses").innerHTML += course_card_str;

        } else {
            let courseId = course["course_id"];
            let course_name = course["course_name"];
            let courseDesc = course["description"]
            let course_card_str = `
                <div class="col-lg-4 col-sm-6 mb-5">
                    <div class="card p-0 border-primary rounded-0 hover-shadow h-100">
                        <div class="card-body">
                            Course ID: ${course["course_id"]}
                            <h4 class="card-title" >${course["course_name"]}</h4>
                            <p class="card-text mb-4"> 
                                ${course["description"]}
                            </p>
                            <p>
                                <h6>Prerequisites course:</h6>
                                ${prereq_str}
                            </p>
                            <a href='classes' class="btn btn-primary btn-sm" onclick='chosen_course(${courseId}, "${course_name}", "${courseDesc}")'>Enrol Now</a>
                        </div>
                    </div>  
                </div>
              `;
            document.getElementById("displayCourses").innerHTML += course_card_str;

        }


    }
}
function chosen_course(courseId, courseName, courseDesc) {

    sessionStorage.setItem("courseId", courseId);
    sessionStorage.setItem("courseName", courseName)
    sessionStorage.setItem("courseDesc", courseDesc)

    // location.href("courses.html");
    // console.log(sessionStorage.getItem("courseId"));
    location.href("select_class.html");
}
// Display all classes of a Course 
async function displayAllClasses() {
    let course_id = sessionStorage.getItem("courseId");

    let course_name = sessionStorage.getItem("courseName");
    let course_description = sessionStorage.getItem("3")

    // console.log(course_id);
    // console.log(course_name);

    document.getElementById("courseName").innerHTML = course_name;
    document.getElementById("courseDescription").innerHTML = course_description
    console.log(course_name);
    console.log(course_description);
    let selected_getAllClasses_url = getAllClasses_url + course_id;
    console.log(selected_getAllClasses_url);
    let classes = await makeAPIRequest(selected_getAllClasses_url, 'GET');
    console.log(classes);

    for (var i = 0; i < classes["data"].length; i++) {

        let each_class = classes["data"][i];
        console.log(each_class);

        if (!each_class['within_enrol_period']) {
            let class_card_str = `
                <div class="col-lg-4 col-sm-6 mb-5">
                    <div class="card p-0 border-primary rounded-0 hover-shadow h-100">
                        <div class="card-body">
                            <h4 class="card-title">Class No:${each_class["class_id"]}</h4>
                            Slots Available: <h4>${each_class['avail_slots_left']}` + "/" + `${each_class['class_size']}</h4>
                            <p class="card-text mb-4"> 
                                Enrollment Period is opened from ${each_class['enrol_start_date']} to ${each_class['enrol_end_date']} 
                            </p>
                            <a href="select_class" class="btn btn-light btn-sm disabled " aria-disabled="true" style="color:red">Enrolment Period not open</a>
                        </div>
                    </div>  
                </div>
              `;
            document.getElementById("displayClasses").innerHTML += class_card_str;
        } else {
            if(each_class['avail_slots_left'] == 0){
                let class_card_str = `
                <div class="col-lg-4 col-sm-6 mb-5">
                    <div class="card p-0 border-primary rounded-0 hover-shadow h-100">
                        <div class="card-body">
                            <h4 class="card-title">Class No: <span class="classId">${each_class["class_id"]}</span></h4>
                            Slots Available: <h4>${each_class['avail_slots_left']}` + "/" + `${each_class['class_size']}</h4>
                            <p class="card-text mb-4"> 
                                Enrollment Period is opened from ${each_class['enrol_start_date']} to ${each_class['enrol_end_date']} 
                            </p>
                            <a href="select_class" class="btn btn-light btn-sm disabled" aria-disabled="true" onclick="chosen_class(${each_class["class_id"]})">Class full</a>
                        </div>
                    </div>  
                </div>
              `;
              document.getElementById("displayClasses").innerHTML += class_card_str;
            }else{
                let class_card_str = `
                <div class="col-lg-4 col-sm-6 mb-5">
                    <div class="card p-0 border-primary rounded-0 hover-shadow h-100">
                        <div class="card-body">
                            <h4 class="card-title">Class No: <span class="classId">${each_class["class_id"]}</span></h4>
                            Slots Available: <h4>${each_class['avail_slots_left']}` + "/" + `${each_class['class_size']}</h4>
                            <p class="card-text mb-4"> 
                                Enrollment Period is opened from ${each_class['enrol_start_date']} to ${each_class['enrol_end_date']} 
                            </p>
                            <a href="select_class" class="btn btn-primary btn-sm" onclick="chosen_class(${each_class["class_id"]})">Enrol Now</a>
                        </div>
                    </div>  
                </div>
              `;
              document.getElementById("displayClasses").innerHTML += class_card_str;
            }    
        }
    }
}
function chosen_class(classId) {

    let class_id = classId;
    sessionStorage.setItem("class_id", class_id);
    location.href("select_class.html");
}

// Display details of selected class 
async function displaySelectedClass() {
    let course_id = sessionStorage.getItem("courseId");
    let classId = sessionStorage.getItem("class_id");

    let details = await makeAPIRequest(getClassDetails + `course_id=${course_id}&class_id=${classId}`, 'GET');
    console.log(details);

    let courseName = details['data']["course_name"];
    console.log(courseName);
    document.getElementById('courseName').innerHTML = courseName;

    document.getElementById("duration").innerHTML = `${details['data']["class_start_date"]} to ${details['data']["class_end_date"]}`;
    document.getElementById("course_desc").innerHTML = details['data']['course_description'];

    let prereqs = details['data']['prereqs'];
    let prereq_str = "";
    for (var i = 0; i < prereqs.length; i++) {
        prereq_str += `
        <li>
            Users are required to clear <b>${prereqs['data'][i]}</b>.
        </li>
        `;
    }
    document.getElementById("pre_req").innerHTML = prereq_str;

    if (details['data']['trainer_name'] != "No Trainer Assigned") {
        let trainer_str = `
        <h4 class="mt-0">${details['data']['trainer_name']}</h4>
        Senior Engineer
        `
        document.getElementById("trainer_profile").innerHTML = trainer_str;

    } else {
        document.getElementById("trainer_profile").innerHTML = `
        <h6 style="color:red">No Trainers Yet</h6>
        `
    }

    document.getElementById("class_size").innerHTML = `
    <h6>Class Size:</h6>
    ${details['class_availability']}/${details['class_size']}
    `
}

// self enroll for users 
async function add_enrollment() {

    let engineer_id = localStorage['engineer_id'];
    let course_id = sessionStorage.getItem("courseId");
    let classId = sessionStorage.getItem("class_id");

    console.log(engineer_id);
    console.log(course_id);
    console.log(classId);

    let data = {
        "engineer_id": engineer_id,
        "course_id": course_id,
        "class_id": classId
    };

    try {
        // sendPostRequest("http://localhost:5000/enrolInClass",JSON.stringify(data));
        const response = await fetch(enrolInClass, {
            method: 'POST',
            mode: 'cors',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        });
    } catch (error) {
        console.log(error)
    }
    // console.log(response);
    window.location.replace("enrol");

}

async function getEnrolment() {



    let engineer_id = localStorage['engineer_id'];

    let enrolment = await makeAPIRequest(getEnrolmentEmployee + `engineer_id=${engineer_id}`, 'GET');
    console.log(enrolment);
    let enrolment_str = ``;
    let count = 1;

    document.getElementById("enrolment_head").innerHTML = `
            <tr>
              <th scope="col">#</th>
              <th scope="col">Course Name</th>
              <th scope="col">Course ID</th>
              <th scope="col">Class ID</th>
              <th scope="col">Enrollment Status</th>
              <th scope="col">Withdrawal</th>
            </tr>`
    // console.log(enrolment[0]);
    for (let each in enrolment['data']) {
        let row = enrolment['data'][each];
        console.log(row);

        if (row['status'] == "Approved") {

            if (row['enrolment_period_not_over'] == true) {
                enrolment_str += `
                <tr>
                    <th scope="row">${count}</th>
                    <td>${row['course_name']}</td>
                    <td>${row['course_id']}</td>
                    <td>${row['class_id']}</td>
                    <td style='color:green'>${row['status']}</td>
                    <td><a ><button type="button"  class="btn btn-outline-primary" onclick="self_withdrawal(${row['engineer_id']}, ${row['course_id']}, ${row['class_id']})">Withdraw</button></a></td>
                </tr>  
            `
            } else {
                enrolment_str += `
                <tr>
                    <th scope="row">${count}</th>
                    <td>${row['course_name']}</td>
                    <td>${row['course_id']}</td>
                    <td>${row['class_id']}</td>
                    <td style='color:green'>${row['status']}</td>
                    <td style="color:#d3d3d3">Withdrawal period over</td>
                </tr>  
            `
            }


        } else if (row['status'] == "Pending") {

            if (row['enrolment_period_not_over'] == true) {
                enrolment_str += `
                <tr>
                    <th scope="row">${count}</th>
                    <td>${row['course_name']}</td>
                    <td>${row['course_id']}</td>
                    <td>${row['class_id']}</td>
                    <td class="text-warning">${row['status']}</td>
                    <td><a ><button type="button"  class="btn btn-outline-primary" onclick="self_withdrawal(${row['engineer_id']}, ${row['course_id']}, ${row['class_id']})">Withdraw</button></a></td>
                </tr>  
                `
            } else {
                enrolment_str += `
                <tr>
                    <th scope="row">${count}</th>
                    <td>${row['course_name']}</td>
                    <td>${row['course_id']}</td>
                    <td>${row['class_id']}</td>
                    <td class="text-warning">${row['status']}</td>
                    <td style="color:#d3d3d3">Withdrawal period over</td>
                </tr>  
                `
            }
        } else {
            enrolment_str += `
            <tr>
                <th scope="row">${count}</th>
                <td>${row['course_name']}</td>
                <td>${row['course_id']}</td>
                <td>${row['class_id']}</td>
                <td style="color:red">${row['status']}</td>
                <td style="color:#d3d3d3">Withdrawal period over</td>
            </tr>  
            `
        }

        count++;
    }
    document.getElementById("enrollment_table").innerHTML = enrolment_str;
}

// Access course materials 
async function get_enrolled_classes() {

    let engineer_id = localStorage['engineer_id'];

    let classes_enrolled = await makeAPIRequest(getClassEnrolled + `engineer_id=${engineer_id}`, 'GET');
    console.log(classes_enrolled);

    document.getElementById("class_enrolled_head").innerHTML =`
        <tr>
              <th scope="col">Course Name</th>
              <th scope="col">Course ID</th>
              <th scope="col">Class ID</th>
              <th scope="col">Start Date</th>
              <th scope ="col">End Date</th>
              <th scope="col">Course Completion Status</th>
              <th scope="col">View course materials</th>
            </tr>`;

    let classes = classes_enrolled['data'];
    let final_str = '';
    for (let i = 0; i < classes.length; i++) {
        if (classes[i]['status'] == "Completed") {
            final_str += `
            <tr>
                <td>${classes[i]['course_name']}</td>
                <td>${classes[i]['course_id']}</td>
                <td>${classes[i]['class_id']}</td>
                <td>${classes[i]['start_date']}</td>
                <td>${classes[i]['end_date']}</td>
                <td style="color:green">${classes[i]['status']}</td>
                <td><a href="view_course_material"><button type="button"  href="view_course_material"  class="btn btn-outline-primary" onclick="select_course(${classes[i]['course_id']}, ${classes[i]['class_id']}, 'Completed')">View course materials</button></a></td>
            </tr>
            
            `;

        } else if (classes[i]['status'] == "Not Completed") {
            final_str += `
            <tr>
                <td>${classes[i]['course_name']}</td>
                <td>${classes[i]['course_id']}</td>
                <td>${classes[i]['class_id']}</td>
                <td>${classes[i]['start_date']}</td>
                <td>${classes[i]['end_date']}</td>
                <td style="color:red">${classes[i]['status']}</td>
                <td><a href="view_course_material"><button type="button"  href="view_course_material" class="btn btn-outline-primary" onclick="select_course(${classes[i]['course_id']}, ${classes[i]['class_id']}, 'Not Completed')">View course materials</button></a></td>
            </tr>
            
            `;
        } else if (classes[i]['status'] == "Not Started") {
            final_str += `
            <tr>
                <td>${classes[i]['course_name']}</td>
                <td>${classes[i]['course_id']}</td>
                <td>${classes[i]['class_id']}</td>
                <td>${classes[i]['start_date']}</td>
                <td>${classes[i]['end_date']}</td>
                <td style="color:grey">${classes[i]['status']}</td>
                <td><a href="view_course_material"><button type="button"  href="view_course_material" class="btn btn-outline-primary" onclick="select_course(${classes[i]['course_id']}, ${classes[i]['class_id']}, 'Not Completed')">View course materials</button></a></td>
            </tr>
            
            `;
        } else {
            final_str += `
            <tr>
                <td>${classes[i]['course_name']}</td>
                <td>${classes[i]['course_id']}</td>
                <td>${classes[i]['class_id']}</td>
                <td>${classes[i]['start_date']}</td>
                <td>${classes[i]['end_date']}</td>
                <td style="color:orange">${classes[i]['status']}</td>
                <td><a href="view_course_material"><button type="button"   class="btn btn-outline-primary" onclick="select_course(${classes[i]['course_id']}, ${classes[i]['class_id']}, 'Ongoing')">View course materials</button></a></td>
            </tr>
            
            `;
        }
    }
    document.getElementById("class_enrolled_table").innerHTML = final_str;

}
async function get_course_materials() {
    let course_id = sessionStorage.getItem("course_id");
    let class_id = sessionStorage.getItem("class_id");
    let engineer_id = localStorage["engineer_id"];
    let status = sessionStorage.getItem("class_status");
    // console.log(engineer_id);
    console.log(course_id);
    console.log(class_id);
    let course_materials = await makeAPIRequest(getCourseMaterials + `engineer_id=${engineer_id}&course_id=${course_id}&class_id=${class_id}`, 'GET');
    console.log(course_materials)

    let course_materials_card_str = "";
    if (status == "Not Completed") {
        for (let i = 0; i < course_materials['data'].length; i++) {
            let each_section_material = course_materials['data'][i];
            if (each_section_material['is_eligible']) {
                if (each_section_material['material_completed'] == 1) {
                    if (each_section_material['passed_quiz'] == "Completed" || each_section_material['passed_quiz'] == "Passed") {
                        if (each_section_material["section_id"] == 0) {
                            course_materials_card_str += `
                            <div class="col-lg-4 col-sm-6 mb-5">
                                <div class="card p-0 border-primary rounded-0 hover-shadow h-100">
                                    <div class="card-body">
                                        <h6 class="card-title">Final Quiz</h6>
                                        <h6>Description: </h6>${each_section_material["description"]}
                                        <br>
                                        <br>
                                        <h6>Section Content:</h6>
            
                                        <p class="card-text mb-4"> 
                                            ${each_section_material["content"]}
                                        </p>

                                        <h6>Section Content Status:</h6><span style="color:green">Completed</span><br><br>
                                        <h6>Quiz Status:</h6><span style="color:green">${each_section_material["passed_quiz"]}</span>
                                    </div>
                                </div>  
                            </div>
                            `;

                        } else {
                            course_materials_card_str += `
                            <div class="col-lg-4 col-sm-6 mb-5">
                                <div class="card p-0 border-primary rounded-0 hover-shadow h-100">
                                    <div class="card-body">
                                        <h6 class="card-title">Section ID: ${each_section_material["section_id"]}</h6>
                                        <h6>Description: </h6>${each_section_material["description"]}
                                        <br>
                                        <br>
                                        <h6>Section Content:</h6>
            
                                        <p class="card-text mb-4"> 
                                            ${each_section_material["content"]}
                                        </p>

                                        <h6>Section Content Status:</h6><span style="color:green">Completed</span><br><br>
                                        <h6>Quiz Status:</h6><span style="color:green">${each_section_material["passed_quiz"]}</span>
                                    </div>
                                </div>  
                            </div>
                            `;
                        }

                    } else {
                        if (each_section_material["section_id"] == 0) {

                            course_materials_card_str += `
                            <div class="col-lg-4 col-sm-6 mb-5">
                                <div class="card p-0 border-primary rounded-0 hover-shadow h-100">
                                    <div class="card-body">
                                        <h6 class="card-title">Final Quiz</h6>
                                        <h6>Description: </h6>${each_section_material["description"]}
                                        <br>
                                        <br>
                                        <h6>Section Content:</h6>
            
                                        <p class="card-text mb-4"> 
                                            ${each_section_material["content"]}
                                        </p>

                                        <h6>Section Content Status:</h6><span style="color:green">Completed</span><br><br>
                                        <h6>Quiz Status:</h6><span style="color:red">${each_section_material["passed_quiz"]}</span>
                                    </div>
                                </div>  
                            </div>
                             `;

                        } else {
                            course_materials_card_str += `
                            <div class="col-lg-4 col-sm-6 mb-5">
                                <div class="card p-0 border-primary rounded-0 hover-shadow h-100">
                                    <div class="card-body">
                                        <h6 class="card-title">Section ID: ${each_section_material["section_id"]}</h6>
                                        <h6>Description: </h6>${each_section_material["description"]}
                                        <br>
                                        <br>
                                        <h6>Section Content:</h6>
            
                                        <p class="card-text mb-4"> 
                                            ${each_section_material["content"]}
                                        </p>

                                        <h6>Section Content Status:</h6><span style="color:green">Completed</span><br><br>
                                        <h6>Quiz Status:</h6><span style="color:red">${each_section_material["passed_quiz"]}</span>
                                    </div>
                                </div>  
                            </div>
                             `;
                        }


                    }

                } else {
                    if (each_section_material["section_id"] == 0) {
                        course_materials_card_str += `
                        <div class="col-lg-4 col-sm-6 mb-5">
                            <div class="card p-0 border-primary rounded-0 hover-shadow h-100">
                                <div class="card-body">
                                    <h6 class="card-title">Final Quiz</h6>
                                    <h6>Description: </h6>${each_section_material["description"]}
                                    <br>
                                    <br>
                                    <h6>Section Content:</h6>
        
                                    <p class="card-text mb-4"> 
                                        ${each_section_material["content"]}
                                    </p>

                                    <h6>Section Content Status:</h6><span style="color:red">Not Completed</span><br><br>
                                    <h6>Quiz Status:</h6><span style="color:red">${each_section_material["passed_quiz"]}</span>
                                    
                                </div>
                            </div>  
                        </div>
                        `;

                    } else {
                        course_materials_card_str += `
                        <div class="col-lg-4 col-sm-6 mb-5">
                            <div class="card p-0 border-primary rounded-0 hover-shadow h-100">
                                <div class="card-body">
                                    <h6 class="card-title">Section ID: ${each_section_material["section_id"]}</h6>
                                    <h6>Description: </h6>${each_section_material["description"]}
                                    <br>
                                    <br>
                                    <h6>Section Content:</h6>
        
                                    <p class="card-text mb-4"> 
                                        ${each_section_material["content"]}
                                    </p>

                                    <h6>Section Content Status:</h6><span style="color:red">Not Completed</span><br><br>
                                    <h6>Quiz Status:</h6><span style="color:red">${each_section_material["passed_quiz"]}</span>
                                    
                                </div>
                            </div>  
                        </div>
                        `;

                    }



                }




            } else {
                if (each_section_material["section_id"] == 0) {
                    course_materials_card_str += `
                    <div class="col-lg-4 col-sm-6 mb-5">
                        <div class="card p-0 border-primary rounded-0 hover-shadow h-100">
                            <div class="card-body">
                                <h6 class="card-title">Final Quiz</h6>
                                <h6>Description: </h6>${each_section_material["description"]}
                                <br>
                                <br>
                                <h6>Section Content:</h6>
        
                                <p class="card-text mb-4" style="color:red"> 
                                    You have not passed the previous section's quiz. Not eligible to view this section's content yet
                                </p>
                                <h6>Quiz Status:</h6><span style="color:red">${each_section_material["passed_quiz"]}</span>

                                <h6><a href=""class="btn btn-light btn-sm disabled mt-4 " aria-disabled="true" style="color:red">Not Eligible</a></h6>
                                
                            </div>
                        </div>  
                    </div>
                    `;

                } else {
                    course_materials_card_str += `
                    <div class="col-lg-4 col-sm-6 mb-5">
                        <div class="card p-0 border-primary rounded-0 hover-shadow h-100">
                            <div class="card-body">
                                <h6 class="card-title">Section ID: ${each_section_material["section_id"]}</h6>
                                <h6>Description: </h6>${each_section_material["description"]}
                                <br>
                                <br>
                                <h6>Section Content:</h6>
        
                                <p class="card-text mb-4" style="color:red"> 
                                    You have not passed the previous section's quiz. Not eligible to view this section's content yet
                                </p>
                                <h6>Quiz Status:</h6><span style="color:red">${each_section_material["passed_quiz"]}</span>

                                <h6><a href=""class="btn btn-light btn-sm disabled mt-4 " aria-disabled="true" style="color:red">Not Eligible</a></h6>
                                
                            </div>
                        </div>  
                    </div>
                    `;

                }


            }

        }

    } else {
        for (let i = 0; i < course_materials['data'].length; i++) {
            let each_section_material = course_materials['data'][i];
            if (each_section_material['is_eligible']) {
                if (each_section_material['material_completed'] == 1) {
                    if (each_section_material['passed_quiz'] == "Completed" || each_section_material['passed_quiz'] == "Passed") {
                        if (each_section_material["section_id"] == 0) {
                            course_materials_card_str += `
                            <div class="col-lg-4 col-sm-6 mb-5">
                                <div class="card p-0 border-primary rounded-0 hover-shadow h-100">
                                    <div class="card-body">
                                        <h6 class="card-title">Final Quiz</h6>
                                        <h6>Description: </h6>${each_section_material["description"]}
                                        <br>
                                        <br>
                                        <h6>Section Content:</h6>
            
                                        <p class="card-text mb-4"> 
                                            ${each_section_material["content"]}
                                        </p>

                                        <h6>Section Content Status:</h6> <span style="color:green">Completed</span><br><br>
                                        <h6>Quiz Status:</h6><span style="color:green">${each_section_material["passed_quiz"]}</span>
                                        
                                        <h6><a href="take_quiz" class="btn btn-primary btn-sm mt-4" onclick="section_selector(${each_section_material['section_id']}),displayQuiz()">Take Section's Quiz</a></h6>
                                    </div>
                                </div>  
                            </div>
                            `;
                        } else {
                            course_materials_card_str += `
                            <div class="col-lg-4 col-sm-6 mb-5">
                                <div class="card p-0 border-primary rounded-0 hover-shadow h-100">
                                    <div class="card-body">
                                        <h6 class="card-title">Section ID: ${each_section_material["section_id"]}</h6>
                                        <h6>Description: </h6>${each_section_material["description"]}
                                        <br>
                                        <br>
                                        <h6>Section Content:</h6>
            
                                        <p class="card-text mb-4"> 
                                            ${each_section_material["content"]}
                                        </p>

                                        <h6>Section Content Status:</h6> <span style="color:green">Completed</span><br><br>
                                        <h6>Quiz Status:</h6><span style="color:green">${each_section_material["passed_quiz"]}</span>
                                        
                                        <h6><a href="take_quiz" class="btn btn-primary btn-sm mt-4" onclick="section_selector(${each_section_material['section_id']}),displayQuiz()">Take Section's Quiz</a></h6>
                                    </div>
                                </div>  
                            </div>
                            `;

                        }

                    } else {
                        if (each_section_material["section_id"] == 0) {
                            course_materials_card_str += `
                            <div class="col-lg-4 col-sm-6 mb-5">
                                <div class="card p-0 border-primary rounded-0 hover-shadow h-100">
                                    <div class="card-body">
                                        <h6 class="card-title">Final Quiz</h6>
                                        <h6>Description: </h6>${each_section_material["description"]}
                                        <br>
                                        <br>
                                        <h6>Section Content:</h6>
            
                                        <p class="card-text mb-4"> 
                                            ${each_section_material["content"]}
                                        </p>

                                        <h6>Section Content Status:</h6><span style="color:green">Completed</span><br><br>
                                        <h6>Quiz Status:</h6><span style="color:red">${each_section_material["passed_quiz"]}</span>
                                        
                                        <h6><a href="take_quiz" class="btn btn-primary btn-sm mt-4" onclick="section_selector(${each_section_material['section_id']}),displayQuiz()">Take Section's Quiz</a></h6>
                                    </div>
                                </div>  
                            </div>
                            `;

                        } else {
                            course_materials_card_str += `
                            <div class="col-lg-4 col-sm-6 mb-5">
                                <div class="card p-0 border-primary rounded-0 hover-shadow h-100">
                                    <div class="card-body">
                                        <h6 class="card-title">Section ID: ${each_section_material["section_id"]}</h6>
                                        <h6>Description: </h6>${each_section_material["description"]}
                                        <br>
                                        <br>
                                        <h6>Section Content:</h6>
            
                                        <p class="card-text mb-4"> 
                                            ${each_section_material["content"]}
                                        </p>

                                        <h6>Section Content Status:</h6><span style="color:green">Completed</span><br><br>
                                        <h6>Quiz Status:</h6><span style="color:red">${each_section_material["passed_quiz"]}</span>
                                        
                                        <h6><a href="take_quiz" class="btn btn-primary btn-sm mt-4" onclick="section_selector(${each_section_material['section_id']}),displayQuiz()">Take Section's Quiz</a></h6>
                                    </div>
                                </div>  
                            </div>
                            `;

                        }

                    }

                } else {
                    if (each_section_material["section_id"] == 0) {
                        course_materials_card_str += `
                        <div class="col-lg-4 col-sm-6 mb-5">
                            <div class="card p-0 border-primary rounded-0 hover-shadow h-100">
                                <div class="card-body">
                                    <h6 class="card-title">Final Quiz</h6>
                                    <h6>Description: </h6>${each_section_material["description"]}
                                    <br>
                                    <br>
                                    <h6>Section Content:</h6>
        
                                    <p class="card-text mb-4"> 
                                        ${each_section_material["content"]}
                                    </p>

                                    <h6><a href=""class="btn btn-primary btn-sm mt-4" onclick="complete_section_materials(${each_section_material["course_id"]},${each_section_material["class_id"]},${each_section_material["section_id"]})">Completed the Section's reading</a></h6>

                                    <h6>Section Content Status:</h6><span style="color:red">Not Completed</span><br><br>
                                    <h6>Quiz Status:</h6><span style="color:red">${each_section_material["passed_quiz"]}</span>
                                    
                                </div>
                            </div>  
                        </div>
                      `;

                    } else {
                        course_materials_card_str += `
                        <div class="col-lg-4 col-sm-6 mb-5">
                            <div class="card p-0 border-primary rounded-0 hover-shadow h-100">
                                <div class="card-body">
                                    <h6 class="card-title">Section ID: ${each_section_material["section_id"]}</h6>
                                    <h6>Description: </h6>${each_section_material["description"]}
                                    <br>
                                    <br>
                                    <h6>Section Content:</h6>
        
                                    <p class="card-text mb-4"> 
                                        ${each_section_material["content"]}
                                    </p>

                                    <h6><a href=""class="btn btn-primary btn-sm mt-4" onclick="complete_section_materials(${each_section_material["course_id"]},${each_section_material["class_id"]},${each_section_material["section_id"]})">Completed the Section's reading</a></h6>

                                    <h6>Section Content Status:</h6><span style="color:red">Not Completed</span><br><br>
                                    <h6>Quiz Status:</h6><span style="color:red">${each_section_material["passed_quiz"]}</span>
                                    
                                </div>
                            </div>  
                        </div>
                      `;
                    }

                }
            } else {
                if (each_section_material["section_id"] == 0) {
                    course_materials_card_str += `
                    <div class="col-lg-4 col-sm-6 mb-5">
                        <div class="card p-0 border-primary rounded-0 hover-shadow h-100">
                            <div class="card-body">
                                <h6 class="card-title">Final Quiz</h6>
                                <h6>Description: </h6>${each_section_material["description"]}
                                <br>
                                <br>
                                <h6>Section Content:</h6>
        
                                <p class="card-text mb-4" style="color:red"> 
                                    You have not passed the previous section's quiz. Not eligible to view this section's content yet
                                </p>
                                <h6>Quiz Status:</h6><span style="color:red">${each_section_material["passed_quiz"]}</span>
                                
                                <h6><a href=""class="btn btn-light btn-sm disabled mt-4 " aria-disabled="true" style="color:red">Not Eligible</a></h6>
                            </div>
                        </div>  
                    </div>
                    `;

                } else {
                    course_materials_card_str += `
                    <div class="col-lg-4 col-sm-6 mb-5">
                        <div class="card p-0 border-primary rounded-0 hover-shadow h-100">
                            <div class="card-body">
                                <h6 class="card-title">Section ID: ${each_section_material["section_id"]}</h6>
                                <h6>Description: </h6>${each_section_material["description"]}
                                <br>
                                <br>
                                <h6>Section Content:</h6>
        
                                <p class="card-text mb-4" style="color:red"> 
                                    You have not passed the previous section's quiz. Not eligible to view this section's content yet
                                </p>
                                <h6>Quiz Status:</h6><span style="color:red">${each_section_material["passed_quiz"]}</span>
                                
                                <h6><a href=""class="btn btn-light btn-sm disabled mt-4 " aria-disabled="true" style="color:red">Not Eligible</a></h6>
                            </div>
                        </div>  
                    </div>
                    `;

                }

            }

        }

    }

    document.getElementById("displayCourseMaterials").innerHTML = course_materials_card_str;
    document.getElementById("courseDesc").innerHTML = `Course Name: ${course_materials['data'][0]['course_name']}`;
}

async function select_course(course_id, class_id, status) {

    sessionStorage.setItem("course_id", course_id);
    sessionStorage.setItem("class_id", class_id);
    sessionStorage.setItem("class_status", status);

    console.log(course_id);
    console.log(class_id);
    // location.href("view_course_material.html");

}
async function complete_section_materials(course_id, class_id, section_id) {
    let engineer_id = localStorage["engineer_id"];

    let update = await makeAPIRequest(updateSectionMaterialsCompletion + `engineer_id=${engineer_id}&course_id=${course_id}&class_id=${class_id}&section_id=${section_id}`, 'GET');
    // window.location.replace("view_course_material");    



    // location.href("view_course_material.html");

}

function section_selector(section_id) {
    sessionStorage.setItem('section_id', section_id)
}

// Take and create Quiz
async function displayQuiz() {
    let course_id = sessionStorage.getItem("course_id");
    let class_id = sessionStorage.getItem("class_id");
    let section_id = sessionStorage.getItem("section_id");


    console.log(course_id);
    console.log(class_id);
    console.log(section_id);

    sessionStorage.setItem("section_id", section_id);
    let quiz_details = await makeAPIRequest(getQuiz_url + `course_id=${course_id}&class_id=${class_id}&section_id=${section_id}`, 'GET');

    // display time
    var time_limit_in_mins = quiz_details["data"]["time_limit"]
    var display_time = time_limit_in_mins.toString() + ":01";
    // var display_time = "0:06";

    var interval = setInterval(function () {

        var timer = display_time.split(':');
        var minutes = parseInt(timer[0], 10);
        var seconds = parseInt(timer[1], 10);
        --seconds;
        minutes = (seconds < 0) ? --minutes : minutes;
        if (minutes < 0) clearInterval(interval);
        seconds = (seconds < 0) ? 59 : seconds;
        seconds = (seconds < 10) ? '0' + seconds : seconds;
        $('.countdown').html(minutes + ':' + seconds);
        display_time = minutes + ':' + seconds;

        if (display_time == "0:00") {
            quiz_submission(course_id, class_id, section_id)
        }

    }, 1000);

    // display quiz details
    for (var i = 0; i < quiz_details["data"]["quiz_questions"].length; i++) {

        selected_question = quiz_details["data"]["quiz_questions"][i];
        question_no = selected_question["question_no"]
        question_type = selected_question["type"]
        question_marks = selected_question["marks"]
        question = selected_question["question"]
        questions_options = selected_question["options"]

        if (selected_question["type"] == "T/F") {
            let true_false_qn = `
                <div class="row mb-20">
                    <div class="col-xs-11 col-sm-11 col-md-11">
                        <h3 class="mb-4 d-inline">Question ${question_no} - ${question_type}</h3>
                        <div class="mb-4 d-inline"><em>(Marks: ${question_marks})</em></div>
                        <h6 class="my-4">Question:</h6>
                        <div>
                            <div class="mb-4">${question}</div>
                            <h6 class="mb-4">Select the correct answer:</h6>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="qn${question_no}_ans" id="qn${question_no}_option${questions_options[0]["option_no"]}">
                                <label class="form-check-label" for="qn${selected_question["question_no"]}_option${questions_options[0]["option_no"]}">${questions_options[0]["option"]}</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="qn${question_no}_ans" id="qn${question_no}_option${questions_options[1]["option_no"]}">
                                <label class="form-check-label" for="qn${question_no}_option${questions_options[1]["option_no"]}">${questions_options[1]["option"]}</label>
                            </div>
                        </div>
                    </div>
                </div>
                <hr>
            `;
            document.getElementById("displayQuizQuestions").innerHTML += true_false_qn;

        } else {
            let mcq_qn = `
                <div class="row mb-20">
                    <div class="col-xs-11 col-sm-11 col-md-11">
                        <h3 class="mb-4 d-inline">Question ${question_no} - ${selected_question["type"]}</h3>
                        <div class="mb-4 d-inline"><em>(Marks: ${question_marks})</em></div>
                        <h6 class="my-4">Question:</h6>
                        <div>
                            <div class="mb-4">${question}</div>
                            <h6 class="mb-4">Select the correct answer:</h6>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="qn${question_no}_ans" id="qn${question_no}_option${questions_options[0]["option_no"]}" value="${questions_options[0]["option_no"]}">
                                <label class="form-check-label" for="qn${question_no}_option${questions_options[0]["option_no"]}">${questions_options[0]["option"]}</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="qn${question_no}_ans" id="qn${question_no}_option${questions_options[1]["option_no"]}" value="${questions_options[1]["option_no"]}">
                                <label class="form-check-label" for="qn${question_no}_option${questions_options[1]["option_no"]}">${questions_options[1]["option"]}</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="qn${question_no}_ans" id="qn${question_no}_option${questions_options[2]["option_no"]}" value="${questions_options[2]["option_no"]}">
                                <label class="form-check-label" for="qn${question_no}_option${questions_options[2]["option_no"]}">${questions_options[2]["option"]}</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="qn${question_no}_ans" id="qn${question_no}_option${questions_options[3]["option_no"]}" value="${questions_options[3]["option_no"]}">
                                <label class="form-check-label" for="qn${question_no}_option${questions_options[3]["option_no"]}">${questions_options[3]["option"]}</label>
                            </div>
                        </div>
                    </div>
                </div>
                <hr>
            `;
            document.getElementById("displayQuizQuestions").innerHTML += mcq_qn;
        }
    }
}

$('#take_quiz_form').submit(async (event) => {
    event.preventDefault();

    let course_id = sessionStorage.getItem("course_id");
    let class_id = sessionStorage.getItem("class_id");
    let section_id = sessionStorage.getItem("section_id");

    quiz_submission(course_id, class_id, section_id);
});

async function quiz_submission(course_id, classId, section_id) {
    let engineer_id = localStorage['engineer_id'];
    let quiz_details = await makeAPIRequest(getQuiz_url + `course_id=${course_id}&class_id=${classId}&section_id=${section_id}`, 'GET');
    let question_ans = [];



    for (var i = 0; i < quiz_details["data"]["quiz_questions"].length; i++) {

        selected_question = quiz_details["data"]["quiz_questions"][i];
        selected_question_no = selected_question["question_no"];

        if (selected_question["type"] == "T/F") {
            // To get option number for true or false qns
            if ($('#qn' + selected_question_no + '_option' + 1).is(':checked')) {
                selected_option_no = 1;
            } else if ($('#qn' + selected_question_no + '_option' + 2).is(':checked')) {
                selected_option_no = 2;
            } else {
                selected_option_no = 0;
            }
        } else if (selected_question["type"] == "MCQ") {
            // To get option number for mcq qns
            if ($('#qn' + selected_question_no + '_option' + 1).is(':checked')) {
                selected_option_no = 1;
            } else if ($('#qn' + selected_question_no + '_option' + 2).is(':checked')) {
                selected_option_no = 2;
            } else if ($('#qn' + selected_question_no + '_option' + 3).is(':checked')) {
                selected_option_no = 3;
            } else if ($('#qn' + selected_question_no + '_option' + 4).is(':checked')) {
                selected_option_no = 4;
            } else {
                selected_option_no = 0;
            }
        }
        question_ans.push(selected_option_no);
    }

    let data = {
        "engineer_id": engineer_id,
        "course_id": course_id,
        "class_id": classId,
        "section_id": section_id,
        "question_ans": question_ans
    }

    try {
        const response = await fetch(submit_quiz_url, {
            method: 'POST',
            mode: 'cors',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        });

        const status_code = await response["status"];
        const content = await response.json();

        if (status_code == 200) {
            // redirect with success alert
            alert("\nYou have achieved a score of " + content.score + ".\n\nResult: \n" + content.message);
            window.location.replace("/view_course_material");
        } else {
            // no redirect but still have alert with error message
            alert("\n" + content.message)
        }

    } catch (error) {
        console.log(error)
    }
}

function confirm_submit_quiz() {
    alert("\nConfirm submission of quiz?");
}



//  Administrator:  Assign Learners to classes //
async function admin_selectCourse(course_id) {

    let courseId = course_id;


    let classes = await makeAPIRequest(admin_getAllClass + courseId, 'GET');
    let final_str = `
        <table class="table w-100">
            <thead class="thead-dark">
                <tr>            
                    <th scope="col">Course ID</th>
                    <th scope="col">Class ID</th>
                    <th scope="col">Available Slots Left</th>
                    <th scope="col">Class Size</th>
                    <th scope="col">Enrol Start Date</th>
                    <th scope="col">Enrol End Date</th>
                    <th scope ="col> select </th>
                </tr>
            </thead>
            <tbody id="enrollment_table"></tbody>`
    for (var i = 0; i < classes['data'].length; i++) {
        let each_class = classes['data'][i];
        console.log(each_class);

        final_str += `
        <tr>
            <td>${courseId}</td>
            <td>${each_class['class_id']}</td>
            <td>${each_class['avail_slots_left']}</td>
            <td>${each_class['class_size']}</td>
            <td>${each_class['enrol_start_date']}</td>
            <td>${each_class['enrol_end_date']}</td>
            <td><button type="button" class="btn btn-outline-primary" onclick="getAllStudents(${courseId},${each_class['class_id']})">See Available Learners</button></td>
        </tr>
        `

    }

    final_str += `
        </tbody>
    </table>  
    `

    document.getElementById('renderedTable').innerHTML = final_str;

}



async function getAllStudents(courseId, classId) {
    let students = await makeAPIRequest(admin_getAllLearners + `course_id=${courseId}&class_id=${classId}`, 'GET');
    console.log(students);
    let final_str = `
        <table class="table w-100">
            <thead class="thead-dark">
                <tr>            
                    <th scope="col">Engineer ID</th>
                    <th scope="col">Engineer Name</th>
                    <th scope="col">Department</th>
                    <th scope ="col> select </th>
                </tr>
            </thead>
            <tbody id="enrollment_table"></tbody>`;

    let count = 0;
    for (var i = 0; i < students['data'].length; i++) {
        let engineer = students['data'][i];
        let button_id = "button" + count;
        console.log(engineer);

        final_str += `
        <tr>
            <td>${engineer['engineer_id']}</td>
            <td>${engineer['employee_name']}</td>
            <td>${engineer['dept']}</td>
            <td id=${button_id}><button type="button"  class="btn btn-outline-primary" onclick="assignLearner(${engineer['engineer_id']},${courseId},${classId}, ${count})">Enroll Students</button></td>
        </tr>
        `;
        count += 1;
    }

    final_str += `
        </tbody>
    </table>  
    `

    document.getElementById('renderedTable').innerHTML = final_str;


}

async function assignLearner(engineer_id, course_id, class_id, button_count) {
    console.log(button_count);

    let data = [{
        "engineer_id": engineer_id,
        "course_id": course_id,
        "class_id": class_id
    }];

    try {
        // sendPostRequest("http://localhost:5000/enrolInClass",JSON.stringify(data));
        const response = await fetch(assignLearners_url, {
            method: 'POST',
            mode: 'cors',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        });

        let result = await response.json();
        console.log(result);
        if (result["message"] != "Not enough slots to assign 1 learners") {
            document.getElementById("button" + button_count).innerHTML = `
                <a href=""class="btn btn-light btn-sm disabled mt-4 "aria-disabled="true" style="color:green">Enrolled</a>
            `;
        } else {
            alert("There are no more available slots for this class")
        }


    } catch (error) {
        console.log(error)
    }




    // document.getElementById('success').innerHTML = `
    // <div class="alert alert-success" role="alert">
    //     Success
    // </div>`;
}


// window.location.replace("assign_learners")


async function admin_display_all_course() {

    let courses = await makeAPIRequest(admin_getAllCourse, 'GET');
    console.log(courses)


    for (var i = 0; i < courses['data'].length; i++) {
        let course = courses['data'][i];

        console.log(course['course_id']);
        document.getElementById("listOfCourses").innerHTML += `
            <a class="dropdown-item" onclick="admin_selectCourse(${course['course_id']})">${course['course_name']}</a>
        `;
    }



}
async function admin_display_all_class_no_enroll_date() {

    let classes = await makeAPIRequest(admin_getAllClass_noEnrollDate, 'GET');
    console.log(classes)

    let today = new Date();
    let date = today.getFullYear() + '-' + (today.getMonth() + 1) + '-' + today.getDate();

    let datetime = date + "T00:00";
    console.log(datetime);

    for (var i = 0; i < classes['data'].length; i++) {
        let class1 = classes['data'][i];

        // console.log(course['course_id']);
        document.getElementById("assign_date_table").innerHTML += `
            <tr>
                <td>${class1['course_id']}</td>
                <td>${class1['class_id']}</td>
                <td>
                    <input type="datetime-local" id="start-meeting-time" name="meeting-time" value="${datetime}" min="${datetime}" >
                </td>
                <td>
                    <input type="datetime-local" id="end-meeting-time" name="meeting-time" value="${datetime}" min="${datetime}" disabled>
                </td>
                <td>
                    <button type="button" class="btn btn-outline-primary" onclick="assignTime(${class1['course_id']},${class1['class_id']})">Assign dates</button>
                </td>
            </tr>
        `;
    }
    let selectStart = document.getElementById("start-meeting-time");
    selectStart.addEventListener('change', (event) => {
        let selectEnd = document.getElementById('end-meeting-time');
        selectEnd.disabled = false;
        let min_datetime = selectStart.value;
        selectEnd.min = min_datetime;
    });

}

async function assignTime(course_id, class_id) {
    let start_date_time = document.getElementById('start-meeting-time').value;
    let end_date_time = document.getElementById('end-meeting-time').value;



    let start_date_time_arr = start_date_time.split("T");
    let end_date_time_arr = end_date_time.split("T");

    console.log(start_date_time_arr);
    let start_date = start_date_time_arr[0];
    let start_time = start_date_time_arr[1] + ":00";
    console.log(end_date_time_arr);
    let end_date = end_date_time_arr[0];
    let end_time = end_date_time_arr[1] + ":00";

    let data = {
        "course_id": course_id,
        "class_id": class_id,
        "start_date": start_date,
        "end_date": end_date,
        "start_time": start_time,
        "end_time": end_time,
    };

    try {
        // sendPostRequest("http://localhost:5000/enrolInClass",JSON.stringify(data));
        const response = await fetch(updateEnrolmentDates, {
            method: 'POST',
            mode: 'cors',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        });

    } catch (error) {
        console.log(error)
    }

    document.getElementById('success').innerHTML = `
    <div class="alert alert-success" role="alert">
        Success
    </div>`;
    window.location.replace("assign_enrol_date")

}

async function admin_display_pending_classes() {

    let pending_classes = await makeAPIRequest(admin_getAllPendingClasses, 'GET');
    console.log(pending_classes)

    pending = pending_classes['data'];
    let final_str = "";
    for (let i = 0; i < pending.length; i++) {
        if (pending[i]['is_class_full'] == false) {
            final_str += `
            <tr>
                <td>${pending[i]['course_name']}</td>
                <td>${pending[i]['course_id']}</td>
                <td>${pending[i]['class_id']}</td>
                <td>${pending[i]['engineer_id']}</td>
                <td style="color:green">Available</td>
                <td style="color:orange">${pending[i]['status']}</td>
                <td>
                    <a class="btn btn-success btn-sm" onclick="approve_learner(${pending[i]['engineer_id']},${pending[i]['course_id']},${pending[i]['class_id']} )")'>Approve</a>
                    <a class="btn btn-danger btn-sm" onclick="reject_learner(${pending[i]['engineer_id']},${pending[i]['course_id']},${pending[i]['class_id']} )")'>Reject</a>
                </td>
            </tr>
            `
        } else {
            final_str += `
            <tr>
                <td>${pending[i]['course_name']}</td>
                <td>${pending[i]['course_id']}</td>
                <td>${pending[i]['class_id']}</td>
                <td>${pending[i]['engineer_id']}</td>
                <td style="color:red">Full</td>
                <td style="color:orange">${pending[i]['status']}</td>
                <td>
                    <a class="btn btn-danger btn-sm" onclick="reject_learner(${pending[i]['engineer_id']},${pending[i]['course_id']},${pending[i]['class_id']} )")'>Reject</a>
                </td>
            </tr>
            `

        }

    }
    document.getElementById("approve_reject_table").innerHTML = final_str;

}

async function approve_learner(engineer_id, course_id, class_id) {

    let data = {
        "engineer_id": engineer_id,
        "course_id": course_id,
        "class_id": class_id,
        "is_approved": 1
    };

    try {
        // sendPostRequest("http://localhost:5000/enrolInClass",JSON.stringify(data));
        const response = await fetch(updateEnrolmentStatus, {
            method: 'POST',
            mode: 'cors',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        });

    } catch (error) {
        console.log(error)
    }

    document.getElementById('success').innerHTML = `
    <div class="alert alert-success" role="alert">
        Success
    </div>`;
    window.location.replace("approve_reject_request")

}
async function self_withdrawal(engineer_id, course_id, class_id) {
    let url = withdrawEnrolment + "engineer_id=" + engineer_id + "&course_id=" + course_id + "&class_id=" + class_id;

    try {
        const response = await fetch(url, {
            method: 'DELETE',
            mode: 'cors',
            headers: {
                'Content-Type': 'application/json'
            },
        });

    } catch (error) {
        console.log(error)
    }
    window.location.replace("enrol");

}
async function reject_learner(engineer_id, course_id, class_id) {

    let data = {
        "engineer_id": engineer_id,
        "course_id": course_id,
        "class_id": class_id,
        "is_approved": 0
    };

    try {
        // sendPostRequest("http://localhost:5000/enrolInClass",JSON.stringify(data));
        const response = await fetch(updateEnrolmentStatus, {
            method: 'POST',
            mode: 'cors',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        });

    } catch (error) {
        console.log(error)
    }

    document.getElementById('success').innerHTML = `
    <div class="alert alert-success" role="alert">
        Success
    </div>`;
    window.location.replace("approve_reject_request")

}



