CREATE DATABASE job_board;

USE job_board;

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    user_type ENUM('job_seeker', 'employer', 'admin') NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Job_Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Jobs (
    job_id INT AUTO_INCREMENT PRIMARY KEY,
    employer_id INT,
    title VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(100),
    salary DECIMAL(10, 2),
    post_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    category_id INT,
    FOREIGN KEY (employer_id) REFERENCES Users(user_id),
    FOREIGN KEY (category_id) REFERENCES Job_Categories(category_id)
);

CREATE TABLE Applications (
    application_id INT AUTO_INCREMENT PRIMARY KEY,
    job_id INT,
    user_id INT,
    application_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (job_id) REFERENCES Jobs(job_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Job_Category_Link (
    job_id INT,
    category_id INT,
    FOREIGN KEY (job_id) REFERENCES Jobs(job_id),
    FOREIGN KEY (category_id) REFERENCES Job_Categories(category_id)
);
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `job_board`.`joblistings` AS
    SELECT 
        `j`.`job_id` AS `job_id`,
        `j`.`title` AS `job_title`,
        `j`.`description` AS `job_description`,
        `j`.`location` AS `location`,
        `j`.`salary` AS `salary`,
        `j`.`post_date` AS `post_date`,
        `u`.`username` AS `employer_name`,
        `c`.`name` AS `category_name`
    FROM
        ((`job_board`.`jobs` `j`
        JOIN `job_board`.`users` `u` ON ((`j`.`employer_id` = `u`.`user_id`)))
        JOIN `job_board`.`job_categories` `c` ON ((`j`.`category_id` = `c`.`category_id`)))
        
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `job_board`.`userapplications` AS
    SELECT 
        `a`.`application_id` AS `application_id`,
        `a`.`application_date` AS `application_date`,
        `j`.`title` AS `job_title`,
        `j`.`description` AS `job_description`,
        `j`.`location` AS `location`,
        `j`.`salary` AS `salary`,
        `u`.`username` AS `employer_name`
    FROM
        ((`job_board`.`applications` `a`
        JOIN `job_board`.`jobs` `j` ON ((`a`.`job_id` = `j`.`job_id`)))
        JOIN `job_board`.`users` `u` ON ((`j`.`employer_id` = `u`.`user_id`)))
        
        CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `job_board`.`jobstatistics` AS
    SELECT 
        `c`.`name` AS `category_name`,
        COUNT(`j`.`job_id`) AS `total_jobs`
    FROM
        (`job_board`.`jobs` `j`
        JOIN `job_board`.`job_categories` `c` ON ((`j`.`category_id` = `c`.`category_id`)))
    GROUP BY `c`.`name`
        
        
        
        
        
        
