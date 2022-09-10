# Learning-Management-System

## Table of contents
1. [Introduction](#Introduction)
2. [Technical Overview](#Technical-Overview)
    1. [Technologies, Frameworks, Libraries Used](#tech)
3. [Prerequisites](#Prerequisites)
4. [Getting Started](#Getting-Started)
    1. [Clone Repository](#Clone-Repository)
    2. [Database Setup](#Database-Setup)
5. [Running the Application](#Running-the-Application)
6. [Navigating the Application](#Navigating-the-Application)
    1. [Assign engineers to courses](#Assign-engineers-to-courses)
    2. [Self-enrol in courses](#Self-enrol-in-courses)
    3. [Take the courses assigned](#Take-the-courses-assigned)
    4. [Have trainers create quizzes for the courses](#Have-trainers-create-quizzes-for-the-courses)

<br>

## Introduction
To address the issue of lack of training and proficiency of the engineers for a company, a Learning Management System has been created to allow learning at one’s own pace and to refer to the courses they have completed. This project has not been fully completed yet - but it has been rolled out with 4 core features:
- Assign engineers to courses
- Self-enrol in courses
- Take the courses assigned
- Have trainers create quizzes for the courses (MCQs or True/False questions)

This repository contains instructions of setting up and running the application on localhost, meant for **Windows** or **Mac** OS. Ensure that you also have all the [prerequisites](#Prerequisites) covered before you [get started](#Getting-Started).

[Back To The Top](#Learning-Management-System)

<br>

## Technical Overview
The application follows a monolithic architecture. My team chose this architecture as we wanted to experience firsthand the pros and cons of this tradional development method. 

And indeed, one of its perks is that it makes deployment easier - we only need to deploy one executable to run the application. Also, if you're a building a small application, the monolithic architecture might be easier to develop and maintain.

However, we noticed more downsides. As the single code base grows larger, developing new features or making changes to existing ones might become very complicated and development may be slower as compared to microservices. This is not ideal especially for companies in fast-paced industries. Also, if there's an error in any module, it could bring down the entire application - unlike microservices where each unit runs independently. Another disadvantage worth mentioning is that a monolith lacks flexibility. A monolith is constrained by the technologies already used in the monolith. For example, your monolith uses Python currently. But as time passes, you find that a new feature could be better developed in another programming language. But unfortunately, you do not luxury to incorporate new programming languages to your existing code base.

### Technologies, Frameworks, Libraries Used <a name="tech"></a>
- Python Flask
- Flask SQLAlchemy
- MySQL
- UI Template from [Themefisher](https://themefisher.com/)
- HTML
- CSS
- JavaScript

[Back To The Top](#Learning-Management-System)

<br>

## Prerequisites
- [Python](https://www.python.org/downloads/) >= 3.8
- [Git](https://git-scm.com/downloads) >= 2.21
- [WAMP](https://www.wampserver.com/en/download-wampserver-64bits/) (Windows) / [MAMP](https://www.mamp.info/en/downloads/) (Mac)
- [Python Flask](https://flask.palletsprojects.com/en/2.2.x/installation/)
- [Flask_cors](https://flask-cors.readthedocs.io/en/latest/)
- [Flask-SQLAlchemy](https://flask-sqlalchemy.palletsprojects.com/en/2.x/quickstart/#installation)
- [mysql-connector-python](https://dev.mysql.com/doc/connector-python/en/connector-python-installation-binary.html)

[Back To The Top](#Learning-Management-System)

<br>

## Getting Started
To get things started, you need to:
1. [Clone this repository](#Clone-Repository) into your local machine
2. [Set up database](#Database-Setup)

<br>

### Clone Repository
You may clone this repository into a directory of your choice.

<br>

Using your command-line interface/terminal window, navigate to your desired directory and run the following command:
```
git clone <to be updated>
```
You may be prompted to log in to a Github account. Please log in to your Github account and you will be able to access this public repository.

<br>

### Database Setup
1. Start WAMP/MAMP
2. Launch your web browser and log in to [phpMyAdmin](http://localhost/phpmyadmin/)
3. At the homepage:
   - Click the "Import" tab
   - Click the "Choose File" button
   - Navigate to the "Learning-Management-System" directory ([previously cloned](#Clone-Repository)) > "db" directory > "lms_db.sql" file
   - Click the "Go" button at the bottom
   - Upon completion, you should see a green prompt stating that "*Import has been successfully finished..*" and the newly created database schema "lms_db" should appear at the left
4. Check the port number that phpMyAdmin is running on. You can check the port number via the homepage after you've logged in. The port number is shown at the top level corner, beside the logo, in the form of "**Server: MySQL: *XXXX***". ***XXXX*** is the port number
5. Launch an IDE of your choice
6. Navigate to the "Learning-Management-System" directory and open the "config.py" file
7. In line 4, replace <username> and <password> with the credentials you used in step 2. Then replace <port_no> with the port number that your phpMyAdmin is running on.

<br>

You're now ready to [run the application](#Running-The-Application)!

[Back To The Top](#Learning-Management-System)

<br>

## Running the Application
Please ensure that you have fulfilled the [prerequisites](#Prerequisites) and accomplished the steps in [getting started](#Getting-Started) above before you proceed.

<br>

To run the application, you need to:
1. Start WAMP/MAMP

2. Use your command-line interface/terminal window to navigate to the "Learning-Management-System" directory ([previously cloned](#Clone-Repository)). Once done, run the following command:
```
python application.py
```

3. Launch your web browser and type in http://localhost:5000/ and you may start [navigating the application](#Navigating-The-Application)!

[Back To The Top](#Learning-Management-System)

<br>

## Navigating the Application

### Assign engineers to courses
1. On the [homepage](http://localhost:5000/), log in the dummy administrator account using the following credentials. You will be re-directed to another page
   - Username: **123456**
   - Password: **leopwd**
   - **Tick** the checkbox "I am an administrator"

2. Click on the dropdown and select any of the courses

3. Click on the "See Available Learners" button for any of the classes

4. Enrol a learner by clicking on the "Enroll Students" button. If successful, the button should change to green text - "Enrolled"

<br>

### Self-enrol in courses
1. On the [homepage](http://localhost:5000/), log in the dummy engineer account using the following credentials. You will be re-directed to another page
   - Username: **345678**
   - Password: **davepwd**

2. Scroll down and you should see that "Course ID 4 (Printer Funamentals)" is available for enrollment. Click on the "Enrol Now" button

3. Click on the "Enrol Now" button again for "Class No: 2"

4. You should be able to see details about this course. Click on the "Confirm Enrollment" button

5. Self-enrolment have to be approved by administrators. Therefore, you should see that your new request is "Pending" under the "Enrollment Status" column

<br>

### Take the courses assigned
1. On the [homepage](http://localhost:5000/), log in the dummy engineer account using the following credentials. You will be re-directed to another page
   - Username: **345678**
   - Password: **davepwd**

2. On the navigation bar at the top, click on the "VIEW ENROLLED COURSES" tab

3. Click on the "View Course Materials" button for the "Mechanics 2, Course ID = 2, Class ID = 2" row

4. You should be able to see different sections for the course. Sections are like topics/lessons. To complete a section, you are required to read that section's reading and click on the "Completed The Section's Reading" button once you're done. After which, you need to complete the quiz for that section in order to move on to the next section

<br>

### Have trainers create quizzes for the courses
1. On the [homepage](http://localhost:5000/), log in the dummy trainer account using the following credentials. You will be re-directed to another page
   - Username: **456789**
   - Password: **sampwd**

2. On the navigation bar at the top, click on the "CREATE QUIZ" tab

3. Select the desired course, class, and section which you wish to create the quiz for

4. Enter the duration and total marks for the quiz

5. If you wish to add a True/False question, click on the "Add True/False Question" button. Do the same for MCQ questions

6. Once you're satisfied with the quiz, click the "Create Quiz" button

[Back To The Top](#Learning-Management-System)

<br>
