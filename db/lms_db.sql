-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 10, 2022 at 11:11 AM
-- Server version: 5.7.26
-- PHP Version: 7.3.8
SET
  SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET
  time_zone = "+00:00";
  /*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
  /*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
  /*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
  /*!40101 SET NAMES utf8mb4 */;
--
  -- Database: `lms_db`
  --
  DROP DATABASE if EXISTS `lms_db`;
CREATE DATABASE IF NOT EXISTS `lms_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `lms_db`;
-- --------------------------------------------------------
  --
  -- Table structure for table `administrator`
  --
  DROP TABLE IF EXISTS `administrator`;
CREATE TABLE `administrator` (
    `employee_name` varchar(80) NOT NULL,
    `username` varchar(80) NOT NULL,
    `password` varchar(80) NOT NULL,
    `dept` varchar(80) NOT NULL,
    `designation` varchar(80) NOT NULL,
    `admin_id` int(11) NOT NULL
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8;
--
  -- Dumping data for table `administrator`
  --
INSERT INTO
  `administrator` (
    `employee_name`,
    `username`,
    `password`,
    `dept`,
    `designation`,
    `admin_id`
  )
VALUES
  (
    'Leonard Siah',
    'leoking',
    'leopwd',
    'Human Resources',
    'Senior Executive',
    123456
  ),
  (
    'Damian Ng',
    'damian',
    'dampwd',
    'Human Resources',
    'Senior Associate',
    234567
  );
-- --------------------------------------------------------
  --
  -- Table structure for table `assignment`
  --
  DROP TABLE IF EXISTS `assignment`;
CREATE TABLE `assignment` (
    `engineer_id` int(11) NOT NULL,
    `course_id` int(11) NOT NULL,
    `class_id` int(11) NOT NULL
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8;
--
  -- Dumping data for table `assignment`
  --
INSERT INTO
  `assignment` (`engineer_id`, `course_id`, `class_id`)
VALUES
  (111222, 1, 1),
  (456789, 1, 2),
  (567891, 1, 3),
  (456789, 1, 4),
  (567891, 1, 5),
  (222333, 2, 1),
  (456789, 2, 2),
  (567891, 2, 3),
  (456789, 2, 4),
  (111222, 3, 1),
  (456789, 3, 2),
  (567891, 3, 3),
  (456789, 3, 4),
  (222333, 4, 1),
  (456789, 4, 2),
  (567891, 4, 3),
  (111222, 5, 1),
  (456789, 5, 2),
  (567891, 5, 3),
  (222333, 6, 1),
  (456789, 6, 2),
  (567891, 6, 3),
  (456789, 6, 5);
-- --------------------------------------------------------
  --
  -- Table structure for table `class`
  --
  DROP TABLE IF EXISTS `class`;
CREATE TABLE `class` (
    `course_id` int(11) NOT NULL,
    `class_id` int(11) NOT NULL,
    `start_date` varchar(10) NOT NULL,
    `end_date` varchar(10) NOT NULL,
    `start_time` varchar(8) NOT NULL,
    `end_time` varchar(8) NOT NULL,
    `class_size` int(11) NOT NULL,
    `enrol_start_date` varchar(10) DEFAULT NULL,
    `enrol_end_date` varchar(10) DEFAULT NULL,
    `enrol_start_time` varchar(8) DEFAULT NULL,
    `enrol_end_time` varchar(8) DEFAULT NULL
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8;
--
  -- Dumping data for table `class`
  --
INSERT INTO
  `class` (
    `course_id`,
    `class_id`,
    `start_date`,
    `end_date`,
    `start_time`,
    `end_time`,
    `class_size`,
    `enrol_start_date`,
    `enrol_end_date`,
    `enrol_start_time`,
    `enrol_end_time`
  )
VALUES
  -- Past
  (
    1,
    1,
    '2022-02-10',
    '2022-02-25',
    '09:00:00',
    '23:59:59',
    10,
    '2022-01-15',
    '2022-01-30',
    '09:00:00',
    '23:59:59'
  ),
  -- Current on-going
  (
    1,
    2,
    '2022-10-10',
    '2022-12-10',
    '09:00:00',
    '23:59:59',
    10,
    '2022-09-09',
    '2022-10-01',
    '09:00:00',
    '23:59:59'
  ),
  (
    1,
    3,
    '2022-10-10',
    '2022-12-10',
    '09:00:00',
    '23:59:59',
    10,
    '2022-09-09',
    '2022-10-01',
    '09:00:00',
    '23:59:59'
  ),
  -- For upcoming enrolment
  (
    1,
    4,
    '2022-12-01',
    '2022-12-31',
    '09:00:00',
    '23:59:59',
    2,
    '2022-10-16',
    '2022-11-30',
    '09:00:00',
    '23:59:59'
  ),
  -- For selfEnrolment - to have 1 class to enrol
  (
    1,
    5,
    '2022-12-01',
    '2022-12-31',
    '09:00:00',
    '23:59:59',
    10,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    1,
    6,
    '2023-01-01',
    '2022-01-31',
    '09:00:00',
    '23:59:59',
    3,
    '2022-12-01',
    '2022-12-15',
    '09:00:00',
    '23:59:59'
  ),
  -- For assignLearners - to have 1 class to assign
  -- Past
  (
    2,
    1,
    '2022-02-10',
    '2022-02-25',
    '09:00:00',
    '23:59:59',
    10,
    '2022-01-15',
    '2022-01-30',
    '09:00:00',
    '23:59:59'
  ),
  -- Current on-going
  (
    2,
    2,
    '2022-09-09',
    '2022-12-31',
    '09:00:00',
    '23:59:59',
    10,
    '2022-08-01',
    '2022-09-01',
    '09:00:00',
    '23:59:59'
  ),
  -- For upcoming enrolment
  (
    2,
    3,
    '2022-12-01',
    '2022-12-31',
    '09:00:00',
    '23:59:59',
    10,
    '2022-10-16',
    '2022-11-30',
    '09:00:00',
    '23:59:59'
  ),
  -- For selfEnrolment - to have 1 class to enrol
  (
    2,
    4,
    '2022-12-01',
    '2022-12-31',
    '09:00:00',
    '23:59:59',
    10,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    2,
    5,
    '2023-01-01',
    '2022-01-31',
    '09:00:00',
    '23:59:59',
    10,
    '2022-12-01',
    '2022-12-15',
    '09:00:00',
    '23:59:59'
  ),
  -- For assignLearners - to have 1 class to assign
  -- Past
  (
    3,
    1,
    '2022-02-10',
    '2022-02-25',
    '09:00:00',
    '23:59:59',
    10,
    '2022-01-15',
    '2022-01-30',
    '09:00:00',
    '23:59:59'
  ),
  -- Current on-going
  (
    3,
    2,
    '2022-10-10',
    '2022-12-10',
    '09:00:00',
    '23:59:59',
    10,
    '2022-09-09',
    '2022-10-01',
    '09:00:00',
    '23:59:59'
  ),
  -- For upcoming enrolment
  (
    3,
    3,
    '2022-12-01',
    '2022-12-31',
    '09:00:00',
    '23:59:59',
    10,
    '2022-10-16',
    '2022-11-30',
    '09:00:00',
    '23:59:59'
  ),
  -- For selfEnrolment - to have 1 class to enrol
  (
    3,
    4,
    '2022-12-01',
    '2022-12-31',
    '09:00:00',
    '23:59:59',
    10,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    3,
    5,
    '2023-01-01',
    '2022-01-31',
    '09:00:00',
    '23:59:59',
    10,
    '2022-12-01',
    '2022-12-15',
    '09:00:00',
    '23:59:59'
  ),
  -- For assignLearners - to have 1 class to assign
  -- Past
  (
    4,
    1,
    '2022-02-10',
    '2022-02-25',
    '09:00:00',
    '23:59:59',
    10,
    '2022-01-15',
    '2022-01-30',
    '09:00:00',
    '23:59:59'
  ),
  -- Current on-going
  (
    4,
    2,
    '2022-10-10',
    '2022-12-10',
    '09:00:00',
    '23:59:59',
    10,
    '2022-09-09',
    '2022-10-01',
    '09:00:00',
    '23:59:59'
  ),
  -- For upcoming enrolment
  (
    4,
    3,
    '2022-12-01',
    '2022-12-31',
    '09:00:00',
    '23:59:59',
    10,
    '2022-10-16',
    '2022-11-30',
    '09:00:00',
    '23:59:59'
  ),
  -- For selfEnrolment - to have 1 class to enrol
  (
    4,
    4,
    '2022-12-01',
    '2022-12-31',
    '09:00:00',
    '23:59:59',
    10,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    4,
    5,
    '2023-01-01',
    '2023-01-31',
    '09:00:00',
    '23:59:59',
    10,
    '2022-12-01',
    '2022-12-15',
    '09:00:00',
    '23:59:59'
  ),
  -- For assignLearners - to have 1 class to assign
  -- Past
  (
    5,
    1,
    '2022-02-10',
    '2022-02-25',
    '09:00:00',
    '23:59:59',
    10,
    '2022-01-15',
    '2022-01-30',
    '09:00:00',
    '23:59:59'
  ),
  -- Current on-going
  (
    5,
    2,
    '2022-10-10',
    '2022-12-10',
    '09:00:00',
    '23:59:59',
    10,
    '2022-09-09',
    '2022-10-01',
    '09:00:00',
    '23:59:59'
  ),
  -- For upcoming enrolment
  (
    5,
    3,
    '2022-12-01',
    '2022-12-31',
    '09:00:00',
    '23:59:59',
    10,
    '2022-10-16',
    '2022-11-30',
    '09:00:00',
    '23:59:59'
  ),
  -- For selfEnrolment - to have 1 class to enrol
  (
    5,
    4,
    '2022-12-01',
    '2022-12-31',
    '09:00:00',
    '23:59:59',
    10,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    5,
    5,
    '2023-01-01',
    '2022-01-31',
    '09:00:00',
    '23:59:59',
    10,
    '2022-12-01',
    '2022-12-15',
    '09:00:00',
    '23:59:59'
  ),
  -- For assignLearners - to have 1 class to assign
  -- Past
  (
    6,
    1,
    '2022-02-10',
    '2022-02-25',
    '09:00:00',
    '23:59:59',
    10,
    '2022-01-15',
    '2022-01-30',
    '09:00:00',
    '23:59:59'
  ),
  -- Current on-going
  (
    6,
    2,
    '2022-10-10',
    '2022-12-10',
    '09:00:00',
    '23:59:59',
    10,
    '2022-09-09',
    '2022-10-01',
    '09:00:00',
    '23:59:59'
  ),
  -- For upcoming enrolment
  (
    6,
    3,
    '2022-12-01',
    '2022-12-31',
    '09:00:00',
    '23:59:59',
    10,
    '2022-10-16',
    '2022-11-30',
    '09:00:00',
    '23:59:59'
  ),
  -- For selfEnrolment - to have 1 class to enrol
  (
    6,
    4,
    '2022-12-01',
    '2022-12-31',
    '09:00:00',
    '23:59:59',
    10,
    NULL,
    NULL,
    NULL,
    NULL
  ),
  (
    6,
    5,
    '2023-01-01',
    '2022-01-31',
    '09:00:00',
    '23:59:59',
    10,
    '2022-12-01',
    '2022-12-15',
    '09:00:00',
    '23:59:59'
  );
-- For assignLearners - to have 1 class to assign
  -- --------------------------------------------------------
  --
  -- Table structure for table `course`
  --
  DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
    `course_id` int(11) NOT NULL,
    `course_name` varchar(80) NOT NULL,
    `description` varchar(1000) NOT NULL
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8;
--
  -- Dumping data for table `course`
  --
INSERT INTO
  `course` (`course_id`, `course_name`, `description`)
VALUES
  (
    1,
    'Mechanics 1',
    'In this course, we will study physics from the ground up, learning the basic principles of physical laws, their application to the behavior of objects, and the use of the scientific method in driving advances in this knowledge. This first of two courses (the subsequent course is Introduction to Electromagnetism) will cover the area of physics known as classical mechanics. Classical mechanics is the study of motion based on the physics of Galileo Galilei and Isaac Newton. While mathematics is the language of physics, you will only need to be familiar with high school level algebra, geometry, and trigonometry. The small amount of additional math and calculus that we need will be developed during the course.'
  ),
  (
    2,
    'Mechanics 2',
    'Historically, a set of core concepts—space, time, mass, force, momentum, torque, and angular momentum—were introduced in classical mechanics in order to solve the most famous physics problem, the motion of the planets. The principles of mechanics successfully described many other phenomena encountered in the world. Conservation laws involving energy, momentum and angular momentum provided a second parallel approach to solving many of the same problems. In this course, we will investigate both approaches: Force and conservation laws. Our goal is to develop a conceptual understanding of the core concepts, a familiarity with the experimental verification of our theoretical laws, and an ability to apply the theoretical framework to describe and predict the motions of bodies.'
  ),
  (
    3,
    'Basic Engineering',
    'What is the most efficient way to approach a problem? How are electric motors designed? What went into the design of the Boeing 777 commercial airplane? Is it ethical to design a product with a short lifespan to increase sales for a company? Who are engineers? This course is designed for any student wishing to learn more about the field of engineering and some of the fundamental concepts from various engineering disciplines. A general knowledge of engineering and a number of design projects emphasizing team work, problem solving, and decision making in engineering design will be incorporated throughout the class. Students will be required to present designs using various communication techniques.'
  ),
  (
    4,
    'Printer Fundamentals',
    'What types of printers are we concerned about? In this course, We will cover the advantages and disadvantages of the different types of printers on the market. At the end of the course, you will know the advantages and disadvantages of Laser Printers, Solid Ink Printers, LED Printers, Business Inkjet Printers, Home Inkjet Printers, Multifunction Printers, Dot Matrix Printers, and 3D Printers.'
  ),
  (
    5,
    'Advanced Engineering 1',
    'An introduction to the practice of engineering design. Students will complete a project that exposes them to the conceptualization, analysis, synthesis, testing, and documentation of an engineering system. Students will consider such design issues as modularity, testability, reliability, and economy, and they will learn to use computer-aided design tools. They will use laboratory instruments and develop hands-on skills that will support further project work.'
  ),
  (
    6,
    'Advanced Engineering 2',
    'The study of electric circuits in response to steady state, transient, sinusoidally varying, and aperiodic input signals. Basic network theorems, solutions of linear differential equations, LaPlace transform, frequency response, Fourier series, and Fourier transforms are covered. Both analysis and design approaches are discussed. Lecture and laboratory. This course meets the Writing Part II requirement for the engineering major.'
  );
-- --------------------------------------------------------
  --
  -- Table structure for table `course_material`
  --
  DROP TABLE IF EXISTS `course_material`;
CREATE TABLE `course_material` (
    `course_id` int(11) NOT NULL,
    `class_id` int(11) NOT NULL,
    `section_id` int(11) NOT NULL,
    `course_material_id` int(11) NOT NULL,
    `type` varchar(30) NOT NULL,
    `content` varchar(1000) NOT NULL,
    `description` varchar(80) NOT NULL
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8;
--
  -- Dumping data for table `course_material`
  --
INSERT INTO
  `course_material` (
    `course_id`,
    `class_id`,
    `section_id`,
    `course_material_id`,
    `type`,
    `content`,
    `description`
  )
VALUES
  (
    1,
    1,
    0,
    1,
    'NIL',
    'Final Quiz',
    'Get ready for Final Quiz.'
  ),
  (
    1,
    1,
    1,
    1,
    'PDF',
    'Mechanical engineering is a diverse subject that derives its breadth from the need to design and manufacture everything from small individual parts and devices (e.g. microscale sensors and inkjet printer nozzles) to large systems (e.g. spacecraft and machine tools). The role of a mechanical engineer is to take a product from an idea to the marketplace.',
    'Read through chapter 1 materials.'
  ),
  (
    1,
    1,
    2,
    1,
    'PDF',
    'There are four fundamental forces in the universe: the gravity force, the nuclear weak force, the electromagnetic force, and the nuclear strong force in ascending order of strength. In mechanics, forces are seen as the causes of linear motion, whereas the cause of rotational motion is called a torque. The action of forces in causing motion is described by Newton’s Laws.',
    'Read through chapter 2 materials.'
  ),
  (
    1,
    2,
    0,
    1,
    'NIL',
    'Final Quiz',
    'Get ready for Final Quiz.'
  ),
  (
    1,
    2,
    1,
    1,
    'PDF',
    'A foundation concepts in physics, a force may be thought of as any influence which tends to change the motion of an object. A force can be described as the push or pull upon an object resulting from the object’s interaction with another object. Whenever there is an interaction between two objects, there is a force upon each of the objects. When the interaction ceases, the two objects no longer experience the force. Forces only exist as a result of an interaction.',
    'Read through chapter 1 materials.'
  ),
  (
    1,
    2,
    2,
    1,
    'PDF',
    'Mechanical energy is the energy which is possessed by an object due to its motion or due to its position. Mechanical energy can be either kinetic energy (energy of motion) or potential energy (stored energy of position). Objects have mechanical energy if they are in motion and/or if they are at some position relative to a zero potential energy position.',
    'Read through chapter 2 materials.'
  ),
  (
    1,
    2,
    3,
    1,
    'PDF',
    'Mechanical Engineering deals with mechanics of operation on different systems. The various functions that fall within the scope of this branch are designing, manufacturing and maintenance. For this purpose it uses laws of physics and applies them to analyze their performance. Friction is a force which is created when two surfaces move across each other. It plays very important role in some situations like walking, writing, etc. where you could not do without the force of friction. In some cases friction is less required, so compromise is required.',
    'Read through chapter 3 materials.'
  ),
  (
    1,
    3,
    0,
    1,
    'NIL',
    'Final Quiz',
    'Get ready for Final Quiz.'
  ),
  (
    1,
    3,
    1,
    1,
    'PDF',
    'Maintenance is a necessary part of life. Preventive maintenance is perhaps the most important maintenance of all. This may sound simplistic, but the best way to avoid having to repair equipment is not to have anything break down in the first place.',
    'Read through chapter 1 materials.'
  ),
  (
    1,
    3,
    2,
    1,
    'PDF',
    'Establishing an effective predictive maintenance program that utilizes powerful and accurate technologies such as Ultrasound and Infrared, enables maximum profitability through the ability to see and hear areas of concern we never could before – with precise, timely results, granting an enormous advantage over standard predictive maintenance practices.',
    'Read through chapter 2 materials.'
  ),
  (
    1,
    3,
    3,
    1,
    'PDF',
    'Most machines follow a probability of failure pattern called the bathtub curve (Figure 9.2). The bathtub curve simply displays a machines probability of failure over time. It has three distinct regions: the premature failure region, the random failure region and the wearout failure region.',
    'Read through chapter 3 materials.'
  ),
  (
    1,
    4,
    0,
    1,
    'NIL',
    'Final Quiz',
    'Get ready for Final Quiz.'
  ),
  (
    1,
    4,
    1,
    1,
    'PDF',
    'New and rebuilt systems enter their lives in the premature failure region. The probability of failure during this period is high because of all the variables associated with manufacturing, machining, assembling and installing a new or rebuilt system.',
    'Read through chapter 1 materials.'
  ),
  (
    1,
    4,
    2,
    1,
    'PDF',
    'At some point, all mechanical systems enter a wearout period during which the probability of failure increases. If a machine is rebuilt on a schedule, it is removed from the random failure region where the probability of failure is at its lowest, to the premature failure period where the probability of failure is at its highest.',
    'Read through chapter 2 materials.'
  ),
  (
    1,
    5,
    0,
    1,
    'NIL',
    'Final Quiz',
    'Get ready for Final Quiz.'
  ),
  (
    1,
    5,
    1,
    1,
    'PDF',
    'Monitoring the ‘health’ of a machine for the earliest signs of impending failure results in thousands of plants worldwide saves billions of dollars annually. Early predictions of machine illness is essential for reducing energy waste and eliminating downtime whilst increasing production output and asset availability.',
    'Read through chapter 1 materials.'
  ),
  (
    1,
    5,
    2,
    1,
    'PDF',
    'Mechanical engineering is a diverse subject that derives its breadth from the need to design and manufacture everything from small individual parts and devices (e.g. microscale sensors and inkjet printer nozzles) to large systems (e.g. spacecraft and machine tools). The role of a mechanical engineer is to take a product from an idea to the marketplace.',
    'Read through chapter 2 materials.'
  ),
  (
    2,
    1,
    0,
    1,
    'NIL',
    'Final Quiz',
    'Get ready for Final Quiz.'
  ),
  (
    2,
    1,
    1,
    1,
    'PDF',
    'To a certain extent, each metal generally possesses mechanical properties such as elasticity, plasticity, ductility, malleability, toughness, brittleness, hardness, wear resistance, fatigue resistance, corrosion resistance and heat resistance.',
    'Read through chapter 1 materials.'
  ),
  (
    2,
    1,
    2,
    1,
    'PDF',
    'When some external forces act on a body, the internal forces in the material resist any deformation from these external forces. When the external forces are removed, the material regains original shape and size, this property is known as elasticity.',
    'Read through chapter 2 materials.'
  ),
  (
    2,
    2,
    0,
    1,
    'NIL',
    'Final Quiz',
    'Get ready for Final Quiz.'
  ),
  (
    2,
    2,
    1,
    1,
    'PDF',
    'To a certain extent, each metal generally possesses mechanical properties such as elasticity, plasticity, ductility, malleability, toughness, brittleness, hardness, wear resistance, fatigue resistance, corrosion resistance and heat resistance.',
    'Read through chapter 1 materials.'
  ),
  (
    2,
    2,
    2,
    1,
    'PDF',
    'When we load a material with a tensile load, the length of the material increases. The higher the load, the higher the extension will be. But a stage comes when the material extension becomes disproportionately large even for small increase of load.',
    'Read through chapter 2 materials.'
  ),
  (
    2,
    2,
    3,
    1,
    'PDF',
    'Each metal generally possesses to certain extent the mechanical properties such as elasticity, plasticity, ductility, malleability, toughness brittleness, hardness, wear resistance, fatigue resistance, corrosion resistance, heat resistance etc.',
    'Read through chapter 3 materials.'
  ),
  (
    2,
    3,
    0,
    1,
    'NIL',
    'Final Quiz',
    'Get ready for Final Quiz.'
  ),
  (
    2,
    3,
    1,
    1,
    'PDF',
    'Sometimes there is more than one material which will satisfy all the requirements of design and cost may be the consideration for choosing one amongst them. Sometimes none of the material would meet all requirements and then selection of material becomes a compromise between what is required and what is available.',
    'Read through chapter 1 materials.'
  ),
  (
    2,
    3,
    2,
    1,
    'PDF',
    'This is the most common type of corrosion that takes place at room temperature. This is the result of reaction of metals with water or aqueous solution of salts, acids or bases.',
    'Read through chapter 2 materials.'
  ),
  (
    2,
    4,
    0,
    1,
    'NIL',
    'Final Quiz',
    'Get ready for Final Quiz.'
  ),
  (
    2,
    4,
    1,
    1,
    'PDF',
    'Corrosion is deterioration of a material as a result of an unintentional chemical or electrochemical reaction that occurs between the environment (external conditions) and the surface of the material.',
    'Read through chapter 1 materials.'
  ),
  (
    2,
    4,
    2,
    1,
    'PDF',
    ' Corrosion is deterioration of a material as a result of an unintentional chemical or electrochemical reaction that occurs between the environment (external conditions) and the surface of the material. Corrosion is a serious concern in chemical industries.',
    'Read through chapter 2 materials.'
  ),
  (
    3,
    1,
    0,
    1,
    'NIL',
    'Final Quiz',
    'Get ready for Final Quiz.'
  ),
  (
    3,
    1,
    1,
    1,
    'PDF',
    'To a certain extent, each metal generally possesses mechanical properties such as elasticity, plasticity, ductility, malleability, toughness, brittleness, hardness, wear resistance, fatigue resistance, corrosion resistance and heat resistance.',
    'Read through chapter 1 materials.'
  ),
  (
    3,
    1,
    2,
    1,
    'PDF',
    'When some external forces act on a body, the internal forces in the material resist any deformation from these external forces. When the external forces are removed, the material regains original shape and size, this property is known as elasticity.',
    'Read through chapter 2 materials.'
  ),
  (
    3,
    2,
    0,
    1,
    'NIL',
    'Final Quiz',
    'Get ready for Final Quiz.'
  ),
  (
    3,
    2,
    1,
    1,
    'PDF',
    'To a certain extent, each metal generally possesses mechanical properties such as elasticity, plasticity, ductility, malleability, toughness, brittleness, hardness, wear resistance, fatigue resistance, corrosion resistance and heat resistance.',
    'Read through chapter 1 materials.'
  ),
  (
    3,
    2,
    2,
    1,
    'PDF',
    'When we load a material with a tensile load, the length of the material increases. The higher the load, the higher the extension will be. But a stage comes when the material extension becomes disproportionately large even for small increase of load.',
    'Read through chapter 2 materials.'
  ),
  (
    3,
    2,
    3,
    1,
    'PDF',
    'Each metal generally possesses to certain extent the mechanical properties such as elasticity, plasticity, ductility, malleability, toughness brittleness, hardness, wear resistance, fatigue resistance, corrosion resistance, heat resistance etc.',
    'Read through chapter 3 materials.'
  ),
  (
    3,
    3,
    0,
    1,
    'NIL',
    'Final Quiz',
    'Get ready for Final Quiz.'
  ),
  (
    3,
    3,
    1,
    1,
    'PDF',
    'Thermodynamics is the field that deals with the relationship between heat and other properties such as pressure, density and temperature in a substance .It focuses on how heat transfer is related to various energy changes within a physical system.',
    'Read through chapter 1 materials.'
  ),
  (
    3,
    3,
    2,
    1,
    'PDF',
    'Heat energy (or just heat) is a form of energy which transfers among particles in a substance (or system) by means of kinetic energy of those particles. In other words, under kinetic theory, the heat is transferred by particles bouncing into each other.',
    'Read through chapter 2 materials.'
  ),
  (
    3,
    4,
    0,
    1,
    'NIL',
    'Final Quiz',
    'Get ready for Final Quiz.'
  ),
  (
    3,
    4,
    1,
    1,
    'PDF',
    'Heat is a form of energy associated with the motion of atoms or molecules and capable of being transmitted through solid and fluid media by conduction, through fluid media by convection, and through empty space by radiation.',
    'Read through chapter 1 materials.'
  ),
  (
    3,
    4,
    2,
    1,
    'PDF',
    'The basic effect of heat transfer is that the particles of one substance collide with the particles of another substance. The more energetic substance will typically lose internal energy (i.e. ‘cool down’) while the less energetic substance will gain internal energy (i.e. ‘heat up’).',
    'Read through chapter 2 materials.'
  ),
  (
    4,
    1,
    0,
    1,
    'NIL',
    'Final Quiz',
    'Get ready for Final Quiz.'
  ),
  (
    4,
    1,
    1,
    1,
    'PDF',
    'Heat is a form of energy, and when it comes into contact with matter (anything that you can touch physically) it makes the atoms and molecules move.',
    'Read through chapter 1 materials.'
  ),
  (
    4,
    1,
    2,
    1,
    'PDF',
    'Once atoms or molecules are moving, they collide with other atoms or molecules, making them move too. These molecules then bump into other molecules and make them move, too. In this way, the heat is transferred through matter. In such collisions the faster atoms lose some speed and the slower ones gain speed; thus, the fast ones transfer some of their kinetic energy to the slow ones.',
    'Read through chapter 2 materials.'
  ),
  (
    4,
    2,
    0,
    1,
    'NIL',
    'Final Quiz',
    'Get ready for Final Quiz.'
  ),
  (
    4,
    2,
    1,
    1,
    'PDF',
    'To a certain extent, each metal generally possesses mechanical properties such as elasticity, plasticity, ductility, malleability, toughness, brittleness, hardness, wear resistance, fatigue resistance, corrosion resistance and heat resistance.',
    'Read through chapter 1 materials.'
  ),
  (
    4,
    2,
    2,
    1,
    'PDF',
    'When we load a material with a tensile load, the length of the material increases. The higher the load, the higher the extension will be. But a stage comes when the material extension becomes disproportionately large even for small increase of load.',
    'Read through chapter 2 materials.'
  ),
  (
    4,
    2,
    3,
    1,
    'PDF',
    'Each metal generally possesses to certain extent the mechanical properties such as elasticity, plasticity, ductility, malleability, toughness brittleness, hardness, wear resistance, fatigue resistance, corrosion resistance, heat resistance etc.',
    'Read through chapter 3 materials.'
  ),
  (
    4,
    3,
    0,
    1,
    'NIL',
    'Final Quiz',
    'Get ready for Final Quiz.'
  ),
  (
    4,
    3,
    1,
    1,
    'PDF',
    'Maintenance is a necessary part of life. Preventive maintenance is perhaps the most important maintenance of all. This may sound simplistic, but the best way to avoid having to repair equipment is not to have anything break down in the first place.',
    'Read through chapter 1 materials.'
  ),
  (
    4,
    3,
    2,
    1,
    'PDF',
    'Establishing an effective predictive maintenance program that utilizes powerful and accurate technologies such as Ultrasound and Infrared, enables maximum profitability through the ability to see and hear areas of concern we never could before – with precise, timely results, granting an enormous advantage over standard predictive maintenance practices.',
    'Read through chapter 2 materials.'
  ),
  (
    5,
    1,
    0,
    1,
    'NIL',
    'Final Quiz',
    'Get ready for Final Quiz.'
  ),
  (
    5,
    1,
    1,
    1,
    'PDF',
    'Convection is a very important way that heat moves on Earth, but is not very important in space. Convection happens when a substance that can flow, like water or air is heated in the presence of gravity.',
    'Read through chapter 1 materials.'
  ),
  (
    5,
    1,
    2,
    1,
    'PDF',
    'When there is heat at the bottom of this air or water column, the air or water molecules in contact with the heat start to move, and the molecules spread apart. The heated air or water becomes less dense. It rises up until it gets to air or water with the same density as it has, and when it gets there, it pushes the air or water that was there out of the way.',
    'Read through chapter 2 materials.'
  ),
  (
    5,
    2,
    0,
    1,
    'NIL',
    'Final Quiz',
    'Get ready for Final Quiz.'
  ),
  (
    5,
    2,
    1,
    1,
    'PDF',
    'Convection is a very important way that heat moves on Earth, but is not very important in space. Convection happens when a substance that can flow, like water or air is heated in the presence of gravity.',
    'Read through chapter 1 materials.'
  ),
  (
    5,
    2,
    2,
    1,
    'PDF',
    'When there is heat at the bottom of this air or water column, the air or water molecules in contact with the heat start to move, and the molecules spread apart. The heated air or water becomes less dense. It rises up until it gets to air or water with the same density as it has, and when it gets there, it pushes the air or water that was there out of the way.',
    'Read through chapter 2 materials.'
  ),
  (
    5,
    2,
    3,
    1,
    'PDF',
    'At the same time, new air or water fills the space that was vacated when the heated molecules rose up. The air or water that gets pushed out of the way descends. This sets up a circular motion which is shown in Figure 10.3. Air or water is heated at the bottom, travels to the top, cools, gets denser, falls, is heated again and the whole cycle starts again. Convection does not occur in space because there is no gravity.',
    'Read through chapter 2 materials.'
  ),
  (
    5,
    3,
    0,
    1,
    'NIL',
    'Final Quiz',
    'Get ready for Final Quiz.'
  ),
  (
    5,
    3,
    1,
    1,
    'PDF',
    'Convection is a very important way that heat moves on Earth, but is not very important in space. Convection happens when a substance that can flow, like water or air is heated in the presence of gravity.',
    'Read through chapter 1 materials.'
  ),
  (
    5,
    3,
    2,
    1,
    'PDF',
    'When there is heat at the bottom of this air or water column, the air or water molecules in contact with the heat start to move, and the molecules spread apart. The heated air or water becomes less dense. It rises up until it gets to air or water with the same density as it has, and when it gets there, it pushes the air or water that was there out of the way.',
    'Read through chapter 2 materials.'
  ),
  (
    6,
    1,
    0,
    1,
    'NIL',
    'Final Quiz',
    'Get ready for Final Quiz.'
  ),
  (
    6,
    1,
    1,
    1,
    'PDF',
    'Convection is a very important way that heat moves on Earth, but is not very important in space. Convection happens when a substance that can flow, like water or air is heated in the presence of gravity.',
    'Read through chapter 1 materials.'
  ),
  (
    6,
    1,
    2,
    1,
    'PDF',
    'When there is heat at the bottom of this air or water column, the air or water molecules in contact with the heat start to move, and the molecules spread apart. The heated air or water becomes less dense. It rises up until it gets to air or water with the same density as it has, and when it gets there, it pushes the air or water that was there out of the way.',
    'Read through chapter 2 materials.'
  ),
  (
    6,
    2,
    0,
    1,
    'NIL',
    'Final Quiz',
    'Get ready for Final Quiz.'
  ),
  (
    6,
    2,
    1,
    1,
    'PDF',
    'Radiation happens when heat moves as energy waves (infrared waves) directly from its source to something else. This is how the heat from the Sun gets to Earth.',
    'Read through chapter 1 materials.'
  ),
  (
    6,
    2,
    2,
    1,
    'PDF',
    'All hot things radiate heat to cooler things. When the heat waves hit the cooler thing, they make the molecules of the cooler object speed up. When the molecules of that object speed up, the object becomes hotter.',
    'Read through chapter 2 materials.'
  ),
  (
    6,
    2,
    3,
    1,
    'PDF',
    'Infrared waves are part of a spectrum of energy waves known as the electromagnetic spectrum which is shown in Figure 10.4. The electromagnetic spectrum includes all kinds of energy that can travel in waves, including light, heat, x-rays, radio waves, ultraviolet waves and microwaves.',
    'Read through chapter 2 materials.'
  ),
  (
    6,
    3,
    0,
    1,
    'NIL',
    'Final Quiz',
    'Get ready for Final Quiz.'
  ),
  (
    6,
    3,
    1,
    1,
    'PDF',
    'Radiation happens when heat moves as energy waves (infrared waves) directly from its source to something else. This is how the heat from the Sun gets to Earth.',
    'Read through chapter 1 materials.'
  ),
  (
    6,
    3,
    2,
    1,
    'PDF',
    'All hot things radiate heat to cooler things. When the heat waves hit the cooler thing, they make the molecules of the cooler object speed up. When the molecules of that object speed up, the object becomes hotter.',
    'Read through chapter 2 materials.'
  );
-- --------------------------------------------------------
  --
  -- Table structure for table `engineer`
  --
  DROP TABLE IF EXISTS `engineer`;
CREATE TABLE `engineer` (
    `employee_name` varchar(80) NOT NULL,
    `username` varchar(80) NOT NULL,
    `password` varchar(80) NOT NULL,
    `dept` varchar(80) NOT NULL,
    `designation` varchar(80) NOT NULL,
    `engineer_id` int(11) NOT NULL
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8;
--
  -- Dumping data for table `engineer`
  --
INSERT INTO
  `engineer` (
    `employee_name`,
    `username`,
    `password`,
    `dept`,
    `designation`,
    `engineer_id`
  )
VALUES
  (
    'Dave Low',
    'daveloww',
    'davepwd',
    'Field Engineering',
    'Engineer',
    345678
  ),
  (
    'Ian Koh',
    'iankoh',
    'ianpwd',
    'Site Engineering',
    'Senior Engineer',
    456789
  ),
  (
    'Samuel Sim',
    'samsim',
    'sampwd',
    'Site Engineering',
    'Expert Engineer',
    567891
  ),
  -- New Dummy
  (
    'James Bond',
    'jbond',
    'jbpwd',
    'Site Engineering',
    'Engineer',
    111111
  ),
  (
    'Vanessa Lee',
    'vanlee',
    'vlpwd',
    'Site Engineering',
    'Engineer',
    222222
  ),
  (
    'Sebastian Kee',
    'sebaskee',
    'skwd',
    'Site Engineering',
    'Engineer',
    333333
  ),
  (
    'Andrew Sim',
    'andrewsim',
    'aswd',
    'Field Engineering',
    'Engineer',
    444444
  ),
  (
    'Yong Jie',
    'yongjie',
    'yjpwd',
    'Field Engineering',
    'Engineer',
    555555
  ),
  (
    'Justin Bieber',
    'justinbieber',
    'jbpwd',
    'Field Engineering',
    'Engineer',
    666666
  ),
  (
    'Christopher Ng',
    'chrisng',
    'cnwd',
    'Field Engineering',
    'Engineer',
    777777
  ),
  (
    'Mary Loo',
    'ml',
    'mlpwd',
    'Site Engineering',
    'Senior Engineer',
    888888
  ),
  (
    'Jessica Alba',
    'jessalba',
    'abpwd',
    'Field Engineering',
    'Senior Engineer',
    999999
  ),
  (
    'Harry Koh',
    'harrykoh',
    'hpwd',
    'Site Engineering',
    'Expert Engineer',
    111222
  ),
  (
    'Bryan Lim',
    'bryanlim',
    'blpwd',
    'Field Engineering',
    'Expert Engineer',
    222333
  );
-- --------------------------------------------------------
  --
  -- Table structure for table `enrolment`
  --
  DROP TABLE IF EXISTS `enrolment`;
CREATE TABLE `enrolment` (
    `engineer_id` int(11) NOT NULL,
    `course_id` int(11) NOT NULL,
    `class_id` int(11) NOT NULL,
    `status` varchar(20) NOT NULL,
    `is_completed` int(11) NOT NULL
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8;
--
  -- Dumping data for table `enrolment`
  --
INSERT INTO
  `enrolment` (
    `engineer_id`,
    `course_id`,
    `class_id`,
    `status`,
    `is_completed`
  )
VALUES
  (345678, 1, 1, 'Approved', 1),
  (345678, 2, 1, 'Approved', 0),
  -- Went through course before but did not complete
  (345678, 2, 2, 'Approved', 0),
  -- Applied for same course again and class in-progress
  (345678, 3, 1, 'Rejected', 0),
  -- Applied but rejected by HR
  (345678, 3, 3, 'Pending', 0),
  -- Applied for same course but diff class (make sure doesn't appear for self-enrolment and HR assign)
  (456789, 1, 1, 'Approved', 1),
  (456789, 2, 1, 'Approved', 1),
  (456789, 3, 1, 'Approved', 1),
  (456789, 4, 1, 'Approved', 1),
  (456789, 5, 1, 'Approved', 1),
  (456789, 6, 1, 'Approved', 1),
  (567891, 1, 1, 'Approved', 1),
  (567891, 2, 1, 'Approved', 1),
  (567891, 3, 1, 'Approved', 1),
  (567891, 4, 1, 'Approved', 1),
  (567891, 5, 1, 'Approved', 1),
  (567891, 6, 1, 'Approved', 1),
  (111111, 1, 1, 'Approved', 1),
  (111111, 2, 1, 'Rejected', 0),
  (111111, 2, 3, 'Rejected', 0), -- got rejected this round, but going to apply again (make sure self-enrolment and HR assign will modify this record)
  (111111, 4, 1, 'Approved', 0),
  (222333, 4, 1, 'Pending', 0),
  (111222, 1, 4, 'Approved', 0),
  (222222, 1, 4, 'Approved', 0),
  (777777, 1, 4, 'Pending', 0),
  (555555, 4, 3, 'Pending', 0);
  -- --------------------------------------------------------
  --
  -- Table structure for table `prerequisite`
  --
  DROP TABLE IF EXISTS `prerequisite`;
CREATE TABLE `prerequisite` (
    `course_id` int(11) NOT NULL,
    `prereq_course_id` int(11) NOT NULL
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8;
--
  -- Dumping data for table `prerequisite`
  --
INSERT INTO
  `prerequisite` (`course_id`, `prereq_course_id`)
VALUES
  (2, 1),
  (3, 1),
  -- (4, 1), -- No prereq
  (5, 1),
  (6, 1),
  -- (3, 2), -- course_id (3) only requires course_id (1)
  -- (4, 2), -- No prereq
  (5, 2),
  (6, 2),
  -- (4, 3), -- No prereq
  (5, 3),
  (6, 3),
  (5, 4),
  (6, 4),
  (6, 5);
-- --------------------------------------------------------
  --
  -- Table structure for table `quiz`
  --
  DROP TABLE IF EXISTS `quiz`;
CREATE TABLE `quiz` (
    `course_id` int(11) NOT NULL,
    `class_id` int(11) NOT NULL,
    `section_id` int(11) NOT NULL,
    `time_limit` int(11) NOT NULL,
    `total_marks` int(11) NOT NULL
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8;
--
  -- Dumping data for table `quiz`
  --
INSERT INTO
  `quiz` (
    `course_id`,
    `class_id`,
    `section_id`,
    `time_limit`,
    `total_marks`
  )
VALUES
  (1, 1, 0, 30, 10),
  (1, 1, 1, 30, 10),
  (1, 1, 2, 30, 10),
  (1, 2, 0, 30, 10),
  (1, 2, 1, 30, 10),
  (1, 2, 2, 30, 10),
  (1, 2, 3, 30, 10),
  (1, 3, 0, 30, 10),
  (1, 3, 1, 30, 10),
  (1, 3, 2, 30, 10),
  (1, 3, 3, 30, 10),
  (2, 1, 0, 30, 10),
  (2, 1, 1, 30, 10),
  (2, 1, 2, 30, 10),
  (2, 2, 0, 30, 10),
  (2, 2, 1, 30, 10),
  (2, 2, 2, 30, 10),
  (2, 2, 3, 30, 10),
  (3, 1, 0, 30, 10),
  (3, 1, 1, 30, 10),
  (3, 1, 2, 30, 10),
  (3, 2, 0, 30, 10),
  (3, 2, 1, 30, 10),
  (3, 2, 2, 30, 10),
  (3, 2, 3, 30, 10),
  (4, 1, 0, 30, 10),
  (4, 1, 1, 30, 10),
  (4, 1, 2, 30, 10),
  (4, 2, 0, 30, 10),
  (4, 2, 1, 30, 10),
  (4, 2, 2, 30, 10),
  (4, 2, 3, 30, 10),
  (5, 1, 0, 30, 10),
  (5, 1, 1, 30, 10),
  (5, 1, 2, 30, 10),
  (5, 2, 0, 30, 10),
  (5, 2, 1, 30, 10),
  (5, 2, 2, 30, 10),
  (5, 2, 3, 30, 10),
  (6, 1, 0, 30, 10),
  (6, 1, 1, 30, 10),
  (6, 1, 2, 30, 10),
  (6, 2, 0, 30, 10),
  (6, 2, 1, 30, 10),
  (6, 2, 2, 30, 10),
  (6, 2, 3, 30, 10);
-- --------------------------------------------------------
  --
  -- Table structure for table `quiz_option`
  --
  DROP TABLE IF EXISTS `quiz_option`;
CREATE TABLE `quiz_option` (
    `course_id` int(11) NOT NULL,
    `class_id` int(11) NOT NULL,
    `section_id` int(11) NOT NULL,
    `question_no` int(11) NOT NULL,
    `option_no` int(11) NOT NULL,
    `option` varchar(100) NOT NULL,
    `is_correct` int(11) NOT NULL
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8;
--
  -- Dumping data for table `quiz_option`
  --
INSERT INTO
  `quiz_option` (
    `course_id`,
    `class_id`,
    `section_id`,
    `question_no`,
    `option_no`,
    `option`,
    `is_correct`
  )
VALUES
  (1, 1, 0, 1, 1, 'Eat', 0),
  (1, 1, 0, 1, 2, 'Sleep', 0),
  (1, 1, 0, 1, 3, 'Heck care', 0),
  (1, 1, 0, 1, 4, 'FIX IT!', 1),
  (1, 1, 0, 2, 1, 'True', 0),
  (1, 1, 0, 2, 2, 'False', 1),
  (1, 1, 0, 3, 1, 'Nothing', 0),
  (1, 1, 0, 3, 2, 'Stare at the client', 0),
  (1, 1, 0, 3, 3, 'Try to troubleshoot', 1),
  (1, 1, 0, 3, 4, 'Go to toilet', 0),
  (1, 1, 0, 4, 1, 'True', 0),
  (1, 1, 0, 4, 2, 'False', 1),
  (1, 1, 1, 1, 1, 'Nothing', 0),
  (1, 1, 1, 1, 2, 'Stare at the client', 0),
  (1, 1, 1, 1, 3, 'Remove the ink cartridge', 1),
  (1, 1, 1, 1, 4, 'Go to toilet', 0),
  (1, 1, 1, 2, 1, 'True', 1),
  (1, 1, 1, 2, 2, 'False', 0),
  (1, 1, 2, 1, 1, 'Call the ambulance', 0),
  (
    1,
    1,
    2,
    1,
    2,
    'Check the manual and try to troubleshoot',
    1
  ),
  (1, 1, 2, 1, 3, 'Nothing', 0),
  (1, 1, 2, 1, 4, 'Go back office', 0),
  (1, 1, 2, 2, 1, 'True', 1),
  (1, 1, 2, 2, 2, 'False', 0),
  --
  (1, 2, 0, 1, 1, 'Eat', 0),
  (1, 2, 0, 1, 2, 'Sleep', 0),
  (1, 2, 0, 1, 3, 'Heck care', 0),
  (1, 2, 0, 1, 4, 'FIX IT!', 1),
  (1, 2, 0, 2, 1, 'True', 0),
  (1, 2, 0, 2, 2, 'False', 1),
  (1, 2, 0, 3, 1, 'Nothing', 0),
  (1, 2, 0, 3, 2, 'Stare at the client', 0),
  (1, 2, 0, 3, 3, 'Try to troubleshoot', 1),
  (1, 2, 0, 3, 4, 'Go to toilet', 0),
  (1, 2, 0, 4, 1, 'True', 0),
  (1, 2, 0, 4, 2, 'False', 1),
  (1, 2, 1, 1, 1, 'Nothing', 0),
  (1, 2, 1, 1, 2, 'Stare at the client', 0),
  (1, 2, 1, 1, 3, 'Remove the ink cartridge', 1),
  (1, 2, 1, 1, 4, 'Go to toilet', 0),
  (1, 2, 1, 2, 1, 'True', 1),
  (1, 2, 1, 2, 2, 'False', 0),
  (1, 2, 2, 1, 1, 'Call the ambulance', 0),
  (
    1,
    2,
    2,
    1,
    2,
    'Check the manual and try to troubleshoot',
    1
  ),
  (1, 2, 2, 1, 3, 'Nothing', 0),
  (1, 2, 2, 1, 4, 'Go back office', 0),
  (1, 2, 2, 2, 1, 'True', 1),
  (1, 2, 2, 2, 2, 'False', 0),
  (1, 2, 3, 1, 1, 'True', 1),
  (1, 2, 3, 1, 2, 'False', 0),
  (1, 2, 3, 2, 1, 'True', 1),
  (1, 2, 3, 2, 2, 'False', 0),
  --
  (1, 3, 0, 1, 1, 'Eat', 0),
  (1, 3, 0, 1, 2, 'Sleep', 0),
  (1, 3, 0, 1, 3, 'Heck care', 0),
  (1, 3, 0, 1, 4, 'FIX IT!', 1),
  (1, 3, 0, 2, 1, 'True', 0),
  (1, 3, 0, 2, 2, 'False', 1),
  (1, 3, 0, 3, 1, 'Nothing', 0),
  (1, 3, 0, 3, 2, 'Stare at the client', 0),
  (1, 3, 0, 3, 3, 'Try to troubleshoot', 1),
  (1, 3, 0, 3, 4, 'Go to toilet', 0),
  (1, 3, 0, 4, 1, 'True', 0),
  (1, 3, 0, 4, 2, 'False', 1),
  (1, 3, 1, 1, 1, 'Nothing', 0),
  (1, 3, 1, 1, 2, 'Stare at the client', 0),
  (1, 3, 1, 1, 3, 'Remove the ink cartridge', 1),
  (1, 3, 1, 1, 4, 'Go to toilet', 0),
  (1, 3, 1, 2, 1, 'True', 1),
  (1, 3, 1, 2, 2, 'False', 0),
  (1, 3, 2, 1, 1, 'Call the ambulance', 0),
  (
    1,
    3,
    2,
    1,
    2,
    'Check the manual and try to troubleshoot',
    1
  ),
  (1, 3, 2, 1, 3, 'Nothing', 0),
  (1, 3, 2, 1, 4, 'Go back office', 0),
  (1, 3, 2, 2, 1, 'True', 1),
  (1, 3, 2, 2, 2, 'False', 0),
  (1, 3, 3, 1, 1, 'True', 1),
  (1, 3, 3, 1, 2, 'False', 0),
  (1, 3, 3, 2, 1, 'True', 1),
  (1, 3, 3, 2, 2, 'False', 0),
  --
  (2, 1, 0, 1, 1, 'Eat', 0),
  (2, 1, 0, 1, 2, 'Sleep', 0),
  (2, 1, 0, 1, 3, 'Heck care', 0),
  (2, 1, 0, 1, 4, 'FIX IT!', 1),
  (2, 1, 0, 2, 1, 'True', 0),
  (2, 1, 0, 2, 2, 'False', 1),
  (2, 1, 0, 3, 1, 'Nothing', 0),
  (2, 1, 0, 3, 2, 'Stare at the client', 0),
  (2, 1, 0, 3, 3, 'Try to troubleshoot', 1),
  (2, 1, 0, 3, 4, 'Go to toilet', 0),
  (2, 1, 0, 4, 1, 'True', 0),
  (2, 1, 0, 4, 2, 'False', 1),
  (2, 1, 1, 1, 1, 'Nothing', 0),
  (2, 1, 1, 1, 2, 'Stare at the client', 0),
  (2, 1, 1, 1, 3, 'Remove the ink cartridge', 1),
  (2, 1, 1, 1, 4, 'Go to toilet', 0),
  (2, 1, 1, 2, 1, 'True', 1),
  (2, 1, 1, 2, 2, 'False', 0),
  (2, 1, 2, 1, 1, 'Call the ambulance', 0),
  (
    2,
    1,
    2,
    1,
    2,
    'Check the manual and try to troubleshoot',
    1
  ),
  (2, 1, 2, 1, 3, 'Nothing', 0),
  (2, 1, 2, 1, 4, 'Go back office', 0),
  (2, 1, 2, 2, 1, 'True', 1),
  (2, 1, 2, 2, 2, 'False', 0),
  --
  (2, 2, 0, 1, 1, 'Eat', 0),
  (2, 2, 0, 1, 2, 'Sleep', 0),
  (2, 2, 0, 1, 3, 'Heck care', 0),
  (2, 2, 0, 1, 4, 'FIX IT!', 1),
  (2, 2, 0, 2, 1, 'True', 0),
  (2, 2, 0, 2, 2, 'False', 1),
  (2, 2, 0, 3, 1, 'Nothing', 0),
  (2, 2, 0, 3, 2, 'Stare at the client', 0),
  (2, 2, 0, 3, 3, 'Try to troubleshoot', 1),
  (2, 2, 0, 3, 4, 'Go to toilet', 0),
  (2, 2, 0, 4, 1, 'True', 0),
  (2, 2, 0, 4, 2, 'False', 1),
  (2, 2, 1, 1, 1, 'Nothing', 0),
  (2, 2, 1, 1, 2, 'Stare at the client', 0),
  (2, 2, 1, 1, 3, 'Remove the ink cartridge', 1),
  (2, 2, 1, 1, 4, 'Go to toilet', 0),
  (2, 2, 1, 2, 1, 'True', 1),
  (2, 2, 1, 2, 2, 'False', 0),
  (2, 2, 2, 1, 1, 'Call the ambulance', 0),
  (
    2,
    2,
    2,
    1,
    2,
    'Check the manual and try to troubleshoot',
    1
  ),
  (2, 2, 2, 1, 3, 'Nothing', 0),
  (2, 2, 2, 1, 4, 'Go back office', 0),
  (2, 2, 2, 2, 1, 'True', 1),
  (2, 2, 2, 2, 2, 'False', 0),
  (2, 2, 3, 1, 1, 'True', 1),
  (2, 2, 3, 1, 2, 'False', 0),
  (2, 2, 3, 2, 1, 'True', 1),
  (2, 2, 3, 2, 2, 'False', 0),
  --
  (3, 1, 0, 1, 1, 'Eat', 0),
  (3, 1, 0, 1, 2, 'Sleep', 0),
  (3, 1, 0, 1, 3, 'Heck care', 0),
  (3, 1, 0, 1, 4, 'FIX IT!', 1),
  (3, 1, 0, 2, 1, 'True', 0),
  (3, 1, 0, 2, 2, 'False', 1),
  (3, 1, 0, 3, 1, 'Nothing', 0),
  (3, 1, 0, 3, 2, 'Stare at the client', 0),
  (3, 1, 0, 3, 3, 'Try to troubleshoot', 1),
  (3, 1, 0, 3, 4, 'Go to toilet', 0),
  (3, 1, 0, 4, 1, 'True', 0),
  (3, 1, 0, 4, 2, 'False', 1),
  (3, 1, 1, 1, 1, 'Nothing', 0),
  (3, 1, 1, 1, 2, 'Stare at the client', 0),
  (3, 1, 1, 1, 3, 'Remove the ink cartridge', 1),
  (3, 1, 1, 1, 4, 'Go to toilet', 0),
  (3, 1, 1, 2, 1, 'True', 1),
  (3, 1, 1, 2, 2, 'False', 0),
  (3, 1, 2, 1, 1, 'Call the ambulance', 0),
  (
    3,
    1,
    2,
    1,
    2,
    'Check the manual and try to troubleshoot',
    1
  ),
  (3, 1, 2, 1, 3, 'Nothing', 0),
  (3, 1, 2, 1, 4, 'Go back office', 0),
  (3, 1, 2, 2, 1, 'True', 1),
  (3, 1, 2, 2, 2, 'False', 0),
  --
  (3, 2, 0, 1, 1, 'Eat', 0),
  (3, 2, 0, 1, 2, 'Sleep', 0),
  (3, 2, 0, 1, 3, 'Heck care', 0),
  (3, 2, 0, 1, 4, 'FIX IT!', 1),
  (3, 2, 0, 2, 1, 'True', 0),
  (3, 2, 0, 2, 2, 'False', 1),
  (3, 2, 0, 3, 1, 'Nothing', 0),
  (3, 2, 0, 3, 2, 'Stare at the client', 0),
  (3, 2, 0, 3, 3, 'Try to troubleshoot', 1),
  (3, 2, 0, 3, 4, 'Go to toilet', 0),
  (3, 2, 0, 4, 1, 'True', 0),
  (3, 2, 0, 4, 2, 'False', 1),
  (3, 2, 1, 1, 1, 'Nothing', 0),
  (3, 2, 1, 1, 2, 'Stare at the client', 0),
  (3, 2, 1, 1, 3, 'Remove the ink cartridge', 1),
  (3, 2, 1, 1, 4, 'Go to toilet', 0),
  (3, 2, 1, 2, 1, 'True', 1),
  (3, 2, 1, 2, 2, 'False', 0),
  (3, 2, 2, 1, 1, 'Call the ambulance', 0),
  (
    3,
    2,
    2,
    1,
    2,
    'Check the manual and try to troubleshoot',
    1
  ),
  (3, 2, 2, 1, 3, 'Nothing', 0),
  (3, 2, 2, 1, 4, 'Go back office', 0),
  (3, 2, 2, 2, 1, 'True', 1),
  (3, 2, 2, 2, 2, 'False', 0),
  (3, 2, 3, 1, 1, 'True', 1),
  (3, 2, 3, 1, 2, 'False', 0),
  (3, 2, 3, 2, 1, 'True', 1),
  (3, 2, 3, 2, 2, 'False', 0),
  --
  (4, 1, 0, 1, 1, 'Eat', 0),
  (4, 1, 0, 1, 2, 'Sleep', 0),
  (4, 1, 0, 1, 3, 'Heck care', 0),
  (4, 1, 0, 1, 4, 'FIX IT!', 1),
  (4, 1, 0, 2, 1, 'True', 0),
  (4, 1, 0, 2, 2, 'False', 1),
  (4, 1, 0, 3, 1, 'Nothing', 0),
  (4, 1, 0, 3, 2, 'Stare at the client', 0),
  (4, 1, 0, 3, 3, 'Try to troubleshoot', 1),
  (4, 1, 0, 3, 4, 'Go to toilet', 0),
  (4, 1, 0, 4, 1, 'True', 0),
  (4, 1, 0, 4, 2, 'False', 1),
  (4, 1, 1, 1, 1, 'Nothing', 0),
  (4, 1, 1, 1, 2, 'Stare at the client', 0),
  (4, 1, 1, 1, 3, 'Remove the ink cartridge', 1),
  (4, 1, 1, 1, 4, 'Go to toilet', 0),
  (4, 1, 1, 2, 1, 'True', 1),
  (4, 1, 1, 2, 2, 'False', 0),
  (4, 1, 2, 1, 1, 'Call the ambulance', 0),
  (
    4,
    1,
    2,
    1,
    2,
    'Check the manual and try to troubleshoot',
    1
  ),
  (4, 1, 2, 1, 3, 'Nothing', 0),
  (4, 1, 2, 1, 4, 'Go back office', 0),
  (4, 1, 2, 2, 1, 'True', 1),
  (4, 1, 2, 2, 2, 'False', 0),
  --
  (4, 2, 0, 1, 1, 'Eat', 0),
  (4, 2, 0, 1, 2, 'Sleep', 0),
  (4, 2, 0, 1, 3, 'Heck care', 0),
  (4, 2, 0, 1, 4, 'FIX IT!', 1),
  (4, 2, 0, 2, 1, 'True', 0),
  (4, 2, 0, 2, 2, 'False', 1),
  (4, 2, 0, 3, 1, 'Nothing', 0),
  (4, 2, 0, 3, 2, 'Stare at the client', 0),
  (4, 2, 0, 3, 3, 'Try to troubleshoot', 1),
  (4, 2, 0, 3, 4, 'Go to toilet', 0),
  (4, 2, 0, 4, 1, 'True', 0),
  (4, 2, 0, 4, 2, 'False', 1),
  (4, 2, 1, 1, 1, 'Nothing', 0),
  (4, 2, 1, 1, 2, 'Stare at the client', 0),
  (4, 2, 1, 1, 3, 'Remove the ink cartridge', 1),
  (4, 2, 1, 1, 4, 'Go to toilet', 0),
  (4, 2, 1, 2, 1, 'True', 1),
  (4, 2, 1, 2, 2, 'False', 0),
  (4, 2, 2, 1, 1, 'Call the ambulance', 0),
  (
    4,
    2,
    2,
    1,
    2,
    'Check the manual and try to troubleshoot',
    1
  ),
  (4, 2, 2, 1, 3, 'Nothing', 0),
  (4, 2, 2, 1, 4, 'Go back office', 0),
  (4, 2, 2, 2, 1, 'True', 1),
  (4, 2, 2, 2, 2, 'False', 0),
  (4, 2, 3, 1, 1, 'True', 1),
  (4, 2, 3, 1, 2, 'False', 0),
  (4, 2, 3, 2, 1, 'True', 1),
  (4, 2, 3, 2, 2, 'False', 0),
  --
  (5, 1, 0, 1, 1, 'Eat', 0),
  (5, 1, 0, 1, 2, 'Sleep', 0),
  (5, 1, 0, 1, 3, 'Heck care', 0),
  (5, 1, 0, 1, 4, 'FIX IT!', 1),
  (5, 1, 0, 2, 1, 'True', 0),
  (5, 1, 0, 2, 2, 'False', 1),
  (5, 1, 0, 3, 1, 'Nothing', 0),
  (5, 1, 0, 3, 2, 'Stare at the client', 0),
  (5, 1, 0, 3, 3, 'Try to troubleshoot', 1),
  (5, 1, 0, 3, 4, 'Go to toilet', 0),
  (5, 1, 0, 4, 1, 'True', 0),
  (5, 1, 0, 4, 2, 'False', 1),
  (5, 1, 1, 1, 1, 'Nothing', 0),
  (5, 1, 1, 1, 2, 'Stare at the client', 0),
  (5, 1, 1, 1, 3, 'Remove the ink cartridge', 1),
  (5, 1, 1, 1, 4, 'Go to toilet', 0),
  (5, 1, 1, 2, 1, 'True', 1),
  (5, 1, 1, 2, 2, 'False', 0),
  (5, 1, 2, 1, 1, 'Call the ambulance', 0),
  (
    5,
    1,
    2,
    1,
    2,
    'Check the manual and try to troubleshoot',
    1
  ),
  (5, 1, 2, 1, 3, 'Nothing', 0),
  (5, 1, 2, 1, 4, 'Go back office', 0),
  (5, 1, 2, 2, 1, 'True', 1),
  (5, 1, 2, 2, 2, 'False', 0),
  --
  (5, 2, 0, 1, 1, 'Eat', 0),
  (5, 2, 0, 1, 2, 'Sleep', 0),
  (5, 2, 0, 1, 3, 'Heck care', 0),
  (5, 2, 0, 1, 4, 'FIX IT!', 1),
  (5, 2, 0, 2, 1, 'True', 0),
  (5, 2, 0, 2, 2, 'False', 1),
  (5, 2, 0, 3, 1, 'Nothing', 0),
  (5, 2, 0, 3, 2, 'Stare at the client', 0),
  (5, 2, 0, 3, 3, 'Try to troubleshoot', 1),
  (5, 2, 0, 3, 4, 'Go to toilet', 0),
  (5, 2, 0, 4, 1, 'True', 0),
  (5, 2, 0, 4, 2, 'False', 1),
  (5, 2, 1, 1, 1, 'Nothing', 0),
  (5, 2, 1, 1, 2, 'Stare at the client', 0),
  (5, 2, 1, 1, 3, 'Remove the ink cartridge', 1),
  (5, 2, 1, 1, 4, 'Go to toilet', 0),
  (5, 2, 1, 2, 1, 'True', 1),
  (5, 2, 1, 2, 2, 'False', 0),
  (5, 2, 2, 1, 1, 'Call the ambulance', 0),
  (
    5,
    2,
    2,
    1,
    2,
    'Check the manual and try to troubleshoot',
    1
  ),
  (5, 2, 2, 1, 3, 'Nothing', 0),
  (5, 2, 2, 1, 4, 'Go back office', 0),
  (5, 2, 2, 2, 1, 'True', 1),
  (5, 2, 2, 2, 2, 'False', 0),
  (5, 2, 3, 1, 1, 'True', 1),
  (5, 2, 3, 1, 2, 'False', 0),
  (5, 2, 3, 2, 1, 'True', 1),
  (5, 2, 3, 2, 2, 'False', 0),
  --
  (6, 1, 0, 1, 1, 'Eat', 0),
  (6, 1, 0, 1, 2, 'Sleep', 0),
  (6, 1, 0, 1, 3, 'Heck care', 0),
  (6, 1, 0, 1, 4, 'FIX IT!', 1),
  (6, 1, 0, 2, 1, 'True', 0),
  (6, 1, 0, 2, 2, 'False', 1),
  (6, 1, 0, 3, 1, 'Nothing', 0),
  (6, 1, 0, 3, 2, 'Stare at the client', 0),
  (6, 1, 0, 3, 3, 'Try to troubleshoot', 1),
  (6, 1, 0, 3, 4, 'Go to toilet', 0),
  (6, 1, 0, 4, 1, 'True', 0),
  (6, 1, 0, 4, 2, 'False', 1),
  (6, 1, 1, 1, 1, 'Nothing', 0),
  (6, 1, 1, 1, 2, 'Stare at the client', 0),
  (6, 1, 1, 1, 3, 'Remove the ink cartridge', 1),
  (6, 1, 1, 1, 4, 'Go to toilet', 0),
  (6, 1, 1, 2, 1, 'True', 1),
  (6, 1, 1, 2, 2, 'False', 0),
  (6, 1, 2, 1, 1, 'Call the ambulance', 0),
  (
    6,
    1,
    2,
    1,
    2,
    'Check the manual and try to troubleshoot',
    1
  ),
  (6, 1, 2, 1, 3, 'Nothing', 0),
  (6, 1, 2, 1, 4, 'Go back office', 0),
  (6, 1, 2, 2, 1, 'True', 1),
  (6, 1, 2, 2, 2, 'False', 0),
  --
  (6, 2, 0, 1, 1, 'Eat', 0),
  (6, 2, 0, 1, 2, 'Sleep', 0),
  (6, 2, 0, 1, 3, 'Heck care', 0),
  (6, 2, 0, 1, 4, 'FIX IT!', 1),
  (6, 2, 0, 2, 1, 'True', 0),
  (6, 2, 0, 2, 2, 'False', 1),
  (6, 2, 0, 3, 1, 'Nothing', 0),
  (6, 2, 0, 3, 2, 'Stare at the client', 0),
  (6, 2, 0, 3, 3, 'Try to troubleshoot', 1),
  (6, 2, 0, 3, 4, 'Go to toilet', 0),
  (6, 2, 0, 4, 1, 'True', 0),
  (6, 2, 0, 4, 2, 'False', 1),
  (6, 2, 1, 1, 1, 'Nothing', 0),
  (6, 2, 1, 1, 2, 'Stare at the client', 0),
  (6, 2, 1, 1, 3, 'Remove the ink cartridge', 1),
  (6, 2, 1, 1, 4, 'Go to toilet', 0),
  (6, 2, 1, 2, 1, 'True', 1),
  (6, 2, 1, 2, 2, 'False', 0),
  (6, 2, 2, 1, 1, 'Call the ambulance', 0),
  (
    6,
    2,
    2,
    1,
    2,
    'Check the manual and try to troubleshoot',
    1
  ),
  (6, 2, 2, 1, 3, 'Nothing', 0),
  (6, 2, 2, 1, 4, 'Go back office', 0),
  (6, 2, 2, 2, 1, 'True', 1),
  (6, 2, 2, 2, 2, 'False', 0),
  (6, 2, 3, 1, 1, 'True', 1),
  (6, 2, 3, 1, 2, 'False', 0),
  (6, 2, 3, 2, 1, 'True', 1),
  (6, 2, 3, 2, 2, 'False', 0);
-- --------------------------------------------------------
  --
  -- Table structure for table `quiz_question`
  --
  DROP TABLE IF EXISTS `quiz_question`;
CREATE TABLE `quiz_question` (
    `course_id` int(11) NOT NULL,
    `class_id` int(11) NOT NULL,
    `section_id` int(11) NOT NULL,
    `question_no` int(11) NOT NULL,
    `type` varchar(30) NOT NULL,
    `question` varchar(150) NOT NULL,
    `marks` int(11) NOT NULL
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8;
--
  -- Dumping data for table `quiz_question`
  --
INSERT INTO
  `quiz_question` (
    `course_id`,
    `class_id`,
    `section_id`,
    `question_no`,
    `type`,
    `question`,
    `marks`
  )
VALUES
  (
    1,
    1,
    0,
    1,
    'MCQ',
    'What should you do when the printer breaks down?',
    3
  ),
  (
    1,
    1,
    0,
    2,
    'T/F',
    'If the printer does not respond, simply just switch on and off the power source and everything will be fine.',
    3
  ),
  (
    1,
    1,
    0,
    3,
    'MCQ',
    'What to do when you encounter scenario ABC?',
    3
  ),
  (
    1,
    1,
    0,
    4,
    'T/F',
    'When unable to fix the printer, just leave for lunch.',
    1
  ),
  (
    1,
    1,
    1,
    1,
    'MCQ',
    'If the printer is leaking ink, what do you do?',
    5
  ),
  (
    1,
    1,
    1,
    2,
    'T/F',
    'To fix the printer, we should always troubleshoot first.',
    5
  ),
  (
    1,
    1,
    2,
    1,
    'MCQ',
    'When unsure how to fix the printer, what do you do?',
    5
  ),
  (
    1,
    1,
    2,
    2,
    'T/F',
    'If printer is emitting a burnt smell, off the power immediately.',
    5
  ),
  --
  (
    1,
    2,
    0,
    1,
    'MCQ',
    'What should you do when the printer breaks down?',
    3
  ),
  (
    1,
    2,
    0,
    2,
    'T/F',
    'If the printer does not respond, simply just switch on and off the power source and everything will be fine.',
    3
  ),
  (
    1,
    2,
    0,
    3,
    'MCQ',
    'What to do when you encounter scenario ABC?',
    3
  ),
  (
    1,
    2,
    0,
    4,
    'T/F',
    'When unable to fix the printer, just leave for lunch.',
    1
  ),
  (
    1,
    2,
    1,
    1,
    'MCQ',
    'If the printer is leaking ink, what do you do?',
    5
  ),
  (
    1,
    2,
    1,
    2,
    'T/F',
    'To fix the printer, we should always troubleshoot first.',
    5
  ),
  (
    1,
    2,
    2,
    1,
    'MCQ',
    'When unsure how to fix the printer, what do you do?',
    5
  ),
  (
    1,
    2,
    2,
    2,
    'T/F',
    'If printer is emitting a burnt smell, off the power immediately.',
    5
  ),
  (
    1,
    2,
    3,
    1,
    'T/F',
    'To fix the printer, we should always troubleshoot first.',
    5
  ),
  (
    1,
    2,
    3,
    2,
    'T/F',
    'If printer is emitting a burnt smell, off the power immediately.',
    5
  ),
  --
  (
    1,
    3,
    0,
    1,
    'MCQ',
    'What should you do when the printer breaks down?',
    3
  ),
  (
    1,
    3,
    0,
    2,
    'T/F',
    'If the printer does not respond, simply just switch on and off the power source and everything will be fine.',
    3
  ),
  (
    1,
    3,
    0,
    3,
    'MCQ',
    'What to do when you encounter scenario ABC?',
    3
  ),
  (
    1,
    3,
    0,
    4,
    'T/F',
    'When unable to fix the printer, just leave for lunch.',
    1
  ),
  (
    1,
    3,
    1,
    1,
    'MCQ',
    'If the printer is leaking ink, what do you do?',
    5
  ),
  (
    1,
    3,
    1,
    2,
    'T/F',
    'To fix the printer, we should always troubleshoot first.',
    5
  ),
  (
    1,
    3,
    2,
    1,
    'MCQ',
    'When unsure how to fix the printer, what do you do?',
    5
  ),
  (
    1,
    3,
    2,
    2,
    'T/F',
    'If printer is emitting a burnt smell, off the power immediately.',
    5
  ),
  (
    1,
    3,
    3,
    1,
    'T/F',
    'To fix the printer, we should always troubleshoot first.',
    5
  ),
  (
    1,
    3,
    3,
    2,
    'T/F',
    'If printer is emitting a burnt smell, off the power immediately.',
    5
  ),
  --
  (
    2,
    1,
    0,
    1,
    'MCQ',
    'What should you do when the printer breaks down?',
    3
  ),
  (
    2,
    1,
    0,
    2,
    'T/F',
    'If the printer does not respond, simply just switch on and off the power source and everything will be fine.',
    3
  ),
  (
    2,
    1,
    0,
    3,
    'MCQ',
    'What to do when you encounter scenario ABC?',
    3
  ),
  (
    2,
    1,
    0,
    4,
    'T/F',
    'When unable to fix the printer, just leave for lunch.',
    1
  ),
  (
    2,
    1,
    1,
    1,
    'MCQ',
    'If the printer is leaking ink, what do you do?',
    5
  ),
  (
    2,
    1,
    1,
    2,
    'T/F',
    'To fix the printer, we should always troubleshoot first.',
    5
  ),
  (
    2,
    1,
    2,
    1,
    'MCQ',
    'When unsure how to fix the printer, what do you do?',
    5
  ),
  (
    2,
    1,
    2,
    2,
    'T/F',
    'If printer is emitting a burnt smell, off the power immediately.',
    5
  ),
  --
  (
    2,
    2,
    0,
    1,
    'MCQ',
    'What should you do when the printer breaks down?',
    3
  ),
  (
    2,
    2,
    0,
    2,
    'T/F',
    'If the printer does not respond, simply just switch on and off the power source and everything will be fine.',
    3
  ),
  (
    2,
    2,
    0,
    3,
    'MCQ',
    'What to do when you encounter scenario ABC?',
    3
  ),
  (
    2,
    2,
    0,
    4,
    'T/F',
    'When unable to fix the printer, just leave for lunch.',
    1
  ),
  (
    2,
    2,
    1,
    1,
    'MCQ',
    'If the printer is leaking ink, what do you do?',
    5
  ),
  (
    2,
    2,
    1,
    2,
    'T/F',
    'To fix the printer, we should always troubleshoot first.',
    5
  ),
  (
    2,
    2,
    2,
    1,
    'MCQ',
    'When unsure how to fix the printer, what do you do?',
    5
  ),
  (
    2,
    2,
    2,
    2,
    'T/F',
    'If printer is emitting a burnt smell, off the power immediately.',
    5
  ),
  (
    2,
    2,
    3,
    1,
    'T/F',
    'To fix the printer, we should always troubleshoot first.',
    5
  ),
  (
    2,
    2,
    3,
    2,
    'T/F',
    'If printer is emitting a burnt smell, off the power immediately.',
    5
  ),
  --
  (
    3,
    1,
    0,
    1,
    'MCQ',
    'What should you do when the printer breaks down?',
    3
  ),
  (
    3,
    1,
    0,
    2,
    'T/F',
    'If the printer does not respond, simply just switch on and off the power source and everything will be fine.',
    3
  ),
  (
    3,
    1,
    0,
    3,
    'MCQ',
    'What to do when you encounter scenario ABC?',
    3
  ),
  (
    3,
    1,
    0,
    4,
    'T/F',
    'When unable to fix the printer, just leave for lunch.',
    1
  ),
  (
    3,
    1,
    1,
    1,
    'MCQ',
    'If the printer is leaking ink, what do you do?',
    5
  ),
  (
    3,
    1,
    1,
    2,
    'T/F',
    'To fix the printer, we should always troubleshoot first.',
    5
  ),
  (
    3,
    1,
    2,
    1,
    'MCQ',
    'When unsure how to fix the printer, what do you do?',
    5
  ),
  (
    3,
    1,
    2,
    2,
    'T/F',
    'If printer is emitting a burnt smell, off the power immediately.',
    5
  ),
  --
  (
    3,
    2,
    0,
    1,
    'MCQ',
    'What should you do when the printer breaks down?',
    3
  ),
  (
    3,
    2,
    0,
    2,
    'T/F',
    'If the printer does not respond, simply just switch on and off the power source and everything will be fine.',
    3
  ),
  (
    3,
    2,
    0,
    3,
    'MCQ',
    'What to do when you encounter scenario ABC?',
    3
  ),
  (
    3,
    2,
    0,
    4,
    'T/F',
    'When unable to fix the printer, just leave for lunch.',
    1
  ),
  (
    3,
    2,
    1,
    1,
    'MCQ',
    'If the printer is leaking ink, what do you do?',
    5
  ),
  (
    3,
    2,
    1,
    2,
    'T/F',
    'To fix the printer, we should always troubleshoot first.',
    5
  ),
  (
    3,
    2,
    2,
    1,
    'MCQ',
    'When unsure how to fix the printer, what do you do?',
    5
  ),
  (
    3,
    2,
    2,
    2,
    'T/F',
    'If printer is emitting a burnt smell, off the power immediately.',
    5
  ),
  (
    3,
    2,
    3,
    1,
    'T/F',
    'To fix the printer, we should always troubleshoot first.',
    5
  ),
  (
    3,
    2,
    3,
    2,
    'T/F',
    'If printer is emitting a burnt smell, off the power immediately.',
    5
  ),
  --
  (
    4,
    1,
    0,
    1,
    'MCQ',
    'What should you do when the printer breaks down?',
    3
  ),
  (
    4,
    1,
    0,
    2,
    'T/F',
    'If the printer does not respond, simply just switch on and off the power source and everything will be fine.',
    3
  ),
  (
    4,
    1,
    0,
    3,
    'MCQ',
    'What to do when you encounter scenario ABC?',
    3
  ),
  (
    4,
    1,
    0,
    4,
    'T/F',
    'When unable to fix the printer, just leave for lunch.',
    1
  ),
  (
    4,
    1,
    1,
    1,
    'MCQ',
    'If the printer is leaking ink, what do you do?',
    5
  ),
  (
    4,
    1,
    1,
    2,
    'T/F',
    'To fix the printer, we should always troubleshoot first.',
    5
  ),
  (
    4,
    1,
    2,
    1,
    'MCQ',
    'When unsure how to fix the printer, what do you do?',
    5
  ),
  (
    4,
    1,
    2,
    2,
    'T/F',
    'If printer is emitting a burnt smell, off the power immediately.',
    5
  ),
  --
  (
    4,
    2,
    0,
    1,
    'MCQ',
    'What should you do when the printer breaks down?',
    3
  ),
  (
    4,
    2,
    0,
    2,
    'T/F',
    'If the printer does not respond, simply just switch on and off the power source and everything will be fine.',
    3
  ),
  (
    4,
    2,
    0,
    3,
    'MCQ',
    'What to do when you encounter scenario ABC?',
    3
  ),
  (
    4,
    2,
    0,
    4,
    'T/F',
    'When unable to fix the printer, just leave for lunch.',
    1
  ),
  (
    4,
    2,
    1,
    1,
    'MCQ',
    'If the printer is leaking ink, what do you do?',
    5
  ),
  (
    4,
    2,
    1,
    2,
    'T/F',
    'To fix the printer, we should always troubleshoot first.',
    5
  ),
  (
    4,
    2,
    2,
    1,
    'MCQ',
    'When unsure how to fix the printer, what do you do?',
    5
  ),
  (
    4,
    2,
    2,
    2,
    'T/F',
    'If printer is emitting a burnt smell, off the power immediately.',
    5
  ),
  (
    4,
    2,
    3,
    1,
    'T/F',
    'To fix the printer, we should always troubleshoot first.',
    5
  ),
  (
    4,
    2,
    3,
    2,
    'T/F',
    'If printer is emitting a burnt smell, off the power immediately.',
    5
  ),
  --
  (
    5,
    1,
    0,
    1,
    'MCQ',
    'What should you do when the printer breaks down?',
    3
  ),
  (
    5,
    1,
    0,
    2,
    'T/F',
    'If the printer does not respond, simply just switch on and off the power source and everything will be fine.',
    3
  ),
  (
    5,
    1,
    0,
    3,
    'MCQ',
    'What to do when you encounter scenario ABC?',
    3
  ),
  (
    5,
    1,
    0,
    4,
    'T/F',
    'When unable to fix the printer, just leave for lunch.',
    1
  ),
  (
    5,
    1,
    1,
    1,
    'MCQ',
    'If the printer is leaking ink, what do you do?',
    5
  ),
  (
    5,
    1,
    1,
    2,
    'T/F',
    'To fix the printer, we should always troubleshoot first.',
    5
  ),
  (
    5,
    1,
    2,
    1,
    'MCQ',
    'When unsure how to fix the printer, what do you do?',
    5
  ),
  (
    5,
    1,
    2,
    2,
    'T/F',
    'If printer is emitting a burnt smell, off the power immediately.',
    5
  ),
  --
  (
    5,
    2,
    0,
    1,
    'MCQ',
    'What should you do when the printer breaks down?',
    3
  ),
  (
    5,
    2,
    0,
    2,
    'T/F',
    'If the printer does not respond, simply just switch on and off the power source and everything will be fine.',
    3
  ),
  (
    5,
    2,
    0,
    3,
    'MCQ',
    'What to do when you encounter scenario ABC?',
    3
  ),
  (
    5,
    2,
    0,
    4,
    'T/F',
    'When unable to fix the printer, just leave for lunch.',
    1
  ),
  (
    5,
    2,
    1,
    1,
    'MCQ',
    'If the printer is leaking ink, what do you do?',
    5
  ),
  (
    5,
    2,
    1,
    2,
    'T/F',
    'To fix the printer, we should always troubleshoot first.',
    5
  ),
  (
    5,
    2,
    2,
    1,
    'MCQ',
    'When unsure how to fix the printer, what do you do?',
    5
  ),
  (
    5,
    2,
    2,
    2,
    'T/F',
    'If printer is emitting a burnt smell, off the power immediately.',
    5
  ),
  (
    5,
    2,
    3,
    1,
    'T/F',
    'To fix the printer, we should always troubleshoot first.',
    5
  ),
  (
    5,
    2,
    3,
    2,
    'T/F',
    'If printer is emitting a burnt smell, off the power immediately.',
    5
  ),
  --
  (
    6,
    1,
    0,
    1,
    'MCQ',
    'What should you do when the printer breaks down?',
    3
  ),
  (
    6,
    1,
    0,
    2,
    'T/F',
    'If the printer does not respond, simply just switch on and off the power source and everything will be fine.',
    3
  ),
  (
    6,
    1,
    0,
    3,
    'MCQ',
    'What to do when you encounter scenario ABC?',
    3
  ),
  (
    6,
    1,
    0,
    4,
    'T/F',
    'When unable to fix the printer, just leave for lunch.',
    1
  ),
  (
    6,
    1,
    1,
    1,
    'MCQ',
    'If the printer is leaking ink, what do you do?',
    5
  ),
  (
    6,
    1,
    1,
    2,
    'T/F',
    'To fix the printer, we should always troubleshoot first.',
    5
  ),
  (
    6,
    1,
    2,
    1,
    'MCQ',
    'When unsure how to fix the printer, what do you do?',
    5
  ),
  (
    6,
    1,
    2,
    2,
    'T/F',
    'If printer is emitting a burnt smell, off the power immediately.',
    5
  ),
  --
  (
    6,
    2,
    0,
    1,
    'MCQ',
    'What should you do when the printer breaks down?',
    3
  ),
  (
    6,
    2,
    0,
    2,
    'T/F',
    'If the printer does not respond, simply just switch on and off the power source and everything will be fine.',
    3
  ),
  (
    6,
    2,
    0,
    3,
    'MCQ',
    'What to do when you encounter scenario ABC?',
    3
  ),
  (
    6,
    2,
    0,
    4,
    'T/F',
    'When unable to fix the printer, just leave for lunch.',
    1
  ),
  (
    6,
    2,
    1,
    1,
    'MCQ',
    'If the printer is leaking ink, what do you do?',
    5
  ),
  (
    6,
    2,
    1,
    2,
    'T/F',
    'To fix the printer, we should always troubleshoot first.',
    5
  ),
  (
    6,
    2,
    2,
    1,
    'MCQ',
    'When unsure how to fix the printer, what do you do?',
    5
  ),
  (
    6,
    2,
    2,
    2,
    'T/F',
    'If printer is emitting a burnt smell, off the power immediately.',
    5
  ),
  (
    6,
    2,
    3,
    1,
    'T/F',
    'To fix the printer, we should always troubleshoot first.',
    5
  ),
  (
    6,
    2,
    3,
    2,
    'T/F',
    'If printer is emitting a burnt smell, off the power immediately.',
    5
  );
-- --------------------------------------------------------
  --
  -- Table structure for table `section`
  --
  DROP TABLE IF EXISTS `section`;
CREATE TABLE `section` (
    `course_id` int(11) NOT NULL,
    `class_id` int(11) NOT NULL,
    `section_id` int(11) NOT NULL
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8;
--
  -- Dumping data for table `section`
  --
INSERT INTO
  `section` (`course_id`, `class_id`, `section_id`)
VALUES
  -- Past
  (1, 1, 0),
  (1, 1, 1),
  (1, 1, 2),
  -- Ongoing
  (1, 2, 0),
  (1, 2, 1),
  (1, 2, 2),
  (1, 2, 3),
  (1, 3, 0),
  (1, 3, 1),
  (1, 3, 2),
  (1, 3, 3),
  -- Upcoming
  (1, 4, 0),
  (1, 4, 1),
  (1, 4, 2),
  (1, 5, 0),
  (1, 5, 1),
  (1, 5, 2),
  (1, 6, 0),
  (1, 6, 1),
  (1, 6, 2),
  -- Past
  (2, 1, 0),
  (2, 1, 1),
  (2, 1, 2),
  -- Ongoing
  (2, 2, 0),
  (2, 2, 1),
  (2, 2, 2),
  (2, 2, 3),
  -- Upcoming
  (2, 3, 0),
  (2, 3, 1),
  (2, 3, 2),
  (2, 4, 0),
  (2, 4, 1),
  (2, 4, 2),
  (2, 5, 0),
  (2, 5, 1),
  (2, 5, 2),
  -- Past
  (3, 1, 0),
  (3, 1, 1),
  (3, 1, 2),
  -- Ongoing
  (3, 2, 0),
  (3, 2, 1),
  (3, 2, 2),
  (3, 2, 3),
  -- Upcoming
  (3, 3, 0),
  (3, 3, 1),
  (3, 3, 2),
  (3, 4, 0),
  (3, 4, 1),
  (3, 4, 2),
  (3, 5, 0),
  (3, 5, 1),
  (3, 5, 2),
  -- Past
  (4, 1, 0),
  (4, 1, 1),
  (4, 1, 2),
  -- Ongoing
  (4, 2, 0),
  (4, 2, 1),
  (4, 2, 2),
  (4, 2, 3),
  -- Upcoming
  (4, 3, 0),
  (4, 3, 1),
  (4, 3, 2),
  (4, 4, 0),
  (4, 4, 1),
  (4, 4, 2),
  (4, 5, 0),
  (4, 5, 1),
  (4, 5, 2),
  -- Past
  (5, 1, 0),
  (5, 1, 1),
  (5, 1, 2),
  -- Ongoing
  (5, 2, 0),
  (5, 2, 1),
  (5, 2, 2),
  (5, 2, 3),
  -- Upcoming
  (5, 3, 0),
  (5, 3, 1),
  (5, 3, 2),
  (5, 4, 0),
  (5, 4, 1),
  (5, 4, 2),
  (5, 5, 0),
  (5, 5, 1),
  (5, 5, 2),
  -- Past
  (6, 1, 0),
  (6, 1, 1),
  (6, 1, 2),
  -- Ongoing
  (6, 2, 0),
  (6, 2, 1),
  (6, 2, 2),
  (6, 2, 3),
  -- Upcoming
  (6, 3, 0),
  (6, 3, 1),
  (6, 3, 2),
  (6, 4, 0),
  (6, 4, 1),
  (6, 4, 2),
  (6, 5, 0),
  (6, 5, 1),
  (6, 5, 2);
-- --------------------------------------------------------
  --
  -- Table structure for table `section_progress`
  --
  DROP TABLE IF EXISTS `section_progress`;
CREATE TABLE `section_progress` (
    `engineer_id` int(11) NOT NULL,
    `course_id` int(11) NOT NULL,
    `class_id` int(11) NOT NULL,
    `section_id` int(11) NOT NULL,
    `material_completed` int(11) NOT NULL,
    `quiz_score` int(11) DEFAULT NULL,
    `is_completed` int(11) NOT NULL
  ) ENGINE = InnoDB DEFAULT CHARSET = utf8;
--
  -- Dumping data for table `section_progress`
  --
INSERT INTO
  `section_progress` (
    `engineer_id`,
    `course_id`,
    `class_id`,
    `section_id`,
    `material_completed`,
    `quiz_score`,
    `is_completed`
  )
VALUES
  (345678, 1, 1, 0, 1, 10, 1),
  (345678, 1, 1, 1, 1, 10, 1),
  (345678, 1, 1, 2, 1, 10, 1),
  (456789, 1, 1, 0, 1, 10, 1),
  (456789, 1, 1, 1, 1, 10, 1),
  (456789, 1, 1, 2, 1, 10, 1),
  (567891, 1, 1, 0, 1, 10, 1),
  (567891, 1, 1, 1, 1, 10, 1),
  (567891, 1, 1, 2, 1, 10, 1),
  (111111, 1, 1, 0, 1, 10, 1),
  (111111, 1, 1, 1, 1, 10, 1),
  (111111, 1, 1, 2, 1, 10, 1),
  (111222, 1, 4, 0, 0, NULL, 0),
  (111222, 1, 4, 1, 0, NULL, 0),
  (111222, 1, 4, 2, 0, NULL, 0),
  (222222, 1, 4, 0, 0, NULL, 0),
  (222222, 1, 4, 1, 0, NULL, 0),
  (222222, 1, 4, 2, 0, NULL, 0),
  
  --
  (345678, 2, 1, 0, 1, NULL, 0),
  -- Didn't take final test (by default, when first created, should be null)
  (345678, 2, 1, 1, 1, 10, 1),
  (345678, 2, 1, 2, 1, 10, 1),
  (456789, 2, 1, 0, 1, 9, 1),
  (456789, 2, 1, 1, 1, 10, 1),
  (456789, 2, 1, 2, 1, 10, 1),
  (567891, 2, 1, 0, 1, 9, 1),
  (567891, 2, 1, 1, 1, 10, 1),
  (567891, 2, 1, 2, 1, 10, 1),
  --
  (345678, 2, 2, 0, 0, NULL, 0),
  (345678, 2, 2, 1, 1, 10, 1),
  (345678, 2, 2, 2, 0, 10, 0),
  (345678, 2, 2, 3, 0, NULL, 0),
  --
  (456789, 3, 1, 0, 1, 9, 1),
  (456789, 3, 1, 1, 1, 10, 1),
  (456789, 3, 1, 2, 1, 10, 1),
  (567891, 3, 1, 0, 1, 9, 1),
  (567891, 3, 1, 1, 1, 10, 1),
  (567891, 3, 1, 2, 1, 10, 1),
  --
  (111111, 4, 1, 0, 1, NULL, 0),
  (111111, 4, 1, 1, 1, 10, 1),
  (111111, 4, 1, 2, 1, NULL, 0),
  (456789, 4, 1, 0, 1, 10, 1),
  (456789, 4, 1, 1, 1, 10, 1),
  (456789, 4, 1, 2, 1, 10, 1),
  (567891, 4, 1, 0, 1, 10, 1),
  (567891, 4, 1, 1, 1, 10, 1),
  (567891, 4, 1, 2, 1, 10, 1),
  --
  (456789, 5, 1, 0, 1, 10, 1),
  (456789, 5, 1, 1, 1, 10, 1),
  (456789, 5, 1, 2, 1, 10, 1),
  (567891, 5, 1, 0, 1, 10, 1),
  (567891, 5, 1, 1, 1, 10, 1),
  (567891, 5, 1, 2, 1, 10, 1),
  --
  (456789, 6, 1, 0, 1, 10, 1),
  (456789, 6, 1, 1, 1, 10, 1),
  (456789, 6, 1, 2, 1, 10, 1),
  (567891, 6, 1, 0, 1, 10, 1),
  (567891, 6, 1, 1, 1, 10, 1),
  (567891, 6, 1, 2, 1, 10, 1);
--
  -- Indexes for dumped tables
  --
  --
  -- Indexes for table `administrator`
  --
ALTER TABLE
  `administrator`
ADD
  PRIMARY KEY (`admin_id`);
--
  -- Indexes for table `assignment`
  --
ALTER TABLE
  `assignment`
ADD
  PRIMARY KEY (`engineer_id`, `course_id`, `class_id`),
ADD
  KEY `course_id` (`course_id`, `class_id`);
--
  -- Indexes for table `class`
  --
ALTER TABLE
  `class`
ADD
  PRIMARY KEY (`course_id`, `class_id`);
--
  -- Indexes for table `course`
  --
ALTER TABLE
  `course`
ADD
  PRIMARY KEY (`course_id`);
--
  -- Indexes for table `course_material`
  --
ALTER TABLE
  `course_material`
ADD
  PRIMARY KEY (
    `course_id`,
    `class_id`,
    `section_id`,
    `course_material_id`
  );
--
  -- Indexes for table `engineer`
  --
ALTER TABLE
  `engineer`
ADD
  PRIMARY KEY (`engineer_id`);
--
  -- Indexes for table `enrolment`
  --
ALTER TABLE
  `enrolment`
ADD
  PRIMARY KEY (`engineer_id`, `course_id`, `class_id`),
ADD
  KEY `course_id` (`course_id`, `class_id`);
--
  -- Indexes for table `prerequisite`
  --
ALTER TABLE
  `prerequisite`
ADD
  PRIMARY KEY (`course_id`, `prereq_course_id`),
ADD
  KEY `prereq_course_id` (`prereq_course_id`);
--
  -- Indexes for table `quiz`
  --
ALTER TABLE
  `quiz`
ADD
  PRIMARY KEY (`course_id`, `class_id`, `section_id`);
--
  -- Indexes for table `quiz_option`
  --
ALTER TABLE
  `quiz_option`
ADD
  PRIMARY KEY (
    `course_id`,
    `class_id`,
    `section_id`,
    `question_no`,
    `option_no`
  );
--
  -- Indexes for table `quiz_question`
  --
ALTER TABLE
  `quiz_question`
ADD
  PRIMARY KEY (
    `course_id`,
    `class_id`,
    `section_id`,
    `question_no`
  );
--
  -- Indexes for table `section`
  --
ALTER TABLE
  `section`
ADD
  PRIMARY KEY (`course_id`, `class_id`, `section_id`);
--
  -- Indexes for table `section_progress`
  --
ALTER TABLE
  `section_progress`
ADD
  PRIMARY KEY (
    `engineer_id`,
    `course_id`,
    `class_id`,
    `section_id`
  ),
ADD
  KEY `course_id` (`course_id`, `class_id`, `section_id`);
--
  -- Constraints for dumped tables
  --
  --
  -- Constraints for table `assignment`
  --
ALTER TABLE
  `assignment`
ADD
  CONSTRAINT `assignment_ibfk_1` FOREIGN KEY (`course_id`, `class_id`) REFERENCES `class` (`course_id`, `class_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD
  CONSTRAINT `assignment_ibfk_2` FOREIGN KEY (`engineer_id`) REFERENCES `engineer` (`engineer_id`) ON DELETE CASCADE ON UPDATE CASCADE;
--
  -- Constraints for table `class`
  --
ALTER TABLE
  `class`
ADD
  CONSTRAINT `class_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE;
--
  -- Constraints for table `course_material`
  --
ALTER TABLE
  `course_material`
ADD
  CONSTRAINT `course_material_ibfk_1` FOREIGN KEY (`course_id`, `class_id`, `section_id`) REFERENCES `section` (`course_id`, `class_id`, `section_id`) ON DELETE CASCADE ON UPDATE CASCADE;
--
  -- Constraints for table `enrolment`
  --
ALTER TABLE
  `enrolment`
ADD
  CONSTRAINT `enrolment_ibfk_1` FOREIGN KEY (`course_id`, `class_id`) REFERENCES `class` (`course_id`, `class_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD
  CONSTRAINT `enrolment_ibfk_2` FOREIGN KEY (`engineer_id`) REFERENCES `engineer` (`engineer_id`) ON DELETE CASCADE ON UPDATE CASCADE;
--
  -- Constraints for table `prerequisite`
  --
ALTER TABLE
  `prerequisite`
ADD
  CONSTRAINT `prerequisite_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD
  CONSTRAINT `prerequisite_ibfk_2` FOREIGN KEY (`prereq_course_id`) REFERENCES `course` (`course_id`) ON DELETE CASCADE ON UPDATE CASCADE;
--
  -- Constraints for table `quiz`
  --
ALTER TABLE
  `quiz`
ADD
  CONSTRAINT `quiz_ibfk_1` FOREIGN KEY (`course_id`, `class_id`, `section_id`) REFERENCES `section` (`course_id`, `class_id`, `section_id`) ON DELETE CASCADE ON UPDATE CASCADE;
--
  -- Constraints for table `quiz_option`
  --
ALTER TABLE
  `quiz_option`
ADD
  CONSTRAINT `quiz_option_ibfk_1` FOREIGN KEY (
    `course_id`,
    `class_id`,
    `section_id`,
    `question_no`
  ) REFERENCES `quiz_question` (
    `course_id`,
    `class_id`,
    `section_id`,
    `question_no`
  ) ON DELETE CASCADE ON UPDATE CASCADE;
--
  -- Constraints for table `quiz_question`
  --
ALTER TABLE
  `quiz_question`
ADD
  CONSTRAINT `quiz_question_ibfk_1` FOREIGN KEY (`course_id`, `class_id`, `section_id`) REFERENCES `quiz` (`course_id`, `class_id`, `section_id`) ON DELETE CASCADE ON UPDATE CASCADE;
--
  -- Constraints for table `section`
  --
ALTER TABLE
  `section`
ADD
  CONSTRAINT `section_ibfk_1` FOREIGN KEY (`course_id`, `class_id`) REFERENCES `class` (`course_id`, `class_id`) ON DELETE CASCADE ON UPDATE CASCADE;
--
  -- Constraints for table `section_progress`
  --
ALTER TABLE
  `section_progress`
ADD
  CONSTRAINT `section_progress_ibfk_1` FOREIGN KEY (`course_id`, `class_id`, `section_id`) REFERENCES `section` (`course_id`, `class_id`, `section_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD
  CONSTRAINT `section_progress_ibfk_2` FOREIGN KEY (`engineer_id`) REFERENCES `engineer` (`engineer_id`) ON DELETE CASCADE ON UPDATE CASCADE;
  /*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
  /*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
  /*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;