--Users
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at DATETIME NULL
);
--Categories
CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at DATETIME NULL
);
--Movies
CREATE TABLE Movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    release_date DATE,
    category_id INT,
    created_by INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at DATETIME NULL,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id),
    FOREIGN KEY (created_by) REFERENCES Users(user_id)
);
--Subscriptions
CREATE TABLE Subscriptions (
    subscription_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    start_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    end_date DATETIME,
    status ENUM('active', 'inactive') DEFAULT 'active',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
--WatchHistory
CREATE TABLE WatchHistory (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    movie_id INT,
    watched_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

INSERT INTO Users (username, password_hash, email, created_at, updated_at) VALUES
('john_doe', 'hashed_password_1', 'john@example.com', NOW(), NOW()),
('jane_smith', 'hashed_password_2', 'jane@example.com', NOW(), NOW()),
('alice_wonder', 'hashed_password_3', 'alice@example.com', NOW(), NOW()),
('alex_kelvin', 'hashed_password_4', 'alexkel@example.com', NOW(), NOW()),
('ilya_kharin','hashed_password_5','ilya@example.com', NOW(), NOW()),
('david_guetta','hashed_password_6','david@example.com', NOW(), NOW());

INSERT INTO Categories (name, created_at, updated_at) VALUES
('Action', NOW(), NOW()),
('Drama', NOW(), NOW()),
('Comedy', NOW(), NOW()),
('Documentary', NOW(), NOW()),
('Thriller', NOW(), NOW()),
('Horror', NOW(), NOW());

INSERT INTO Movies (title, description, release_date, category_id, created_by, created_at, updated_at) VALUES
('Action Movie 1', 'An exciting action movie with thrilling scenes.', '2023-01-15', 1, 1, NOW(), NOW()),
('Drama Movie 1', 'A touching drama about life and relationships.', '2022-05-20', 2, 2, NOW(), NOW()),
('Comedy Movie 1', 'A hilarious comedy that will make you laugh.', '2021-11-10', 3, 3, NOW(), NOW()),
('Documentary Movie 1', 'An insightful documentary about nature.', '2020-07-30', 4, 1, NOW(), NOW()),
('Thriller Movie 1', 'A suspenseful thriller that keeps you on the edge.', '2022-03-12', 5, 2, NOW(), NOW()),
('Horror Movie 1', 'An extensive and diverse range of films designed to evoke a sense of fear, anxiety and uncertainty in the audience.', '2016-10-30', 3, 5, NOW(), NOW());

INSERT INTO Subscriptions (user_id, start_date, end_date, status, created_at, updated_at) VALUES
(1, NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY), 'active', NOW(), NOW()),
(2, NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY), 'active', NOW(), NOW()),
(3, NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY), 'inactive', NOW(), NOW()),
(4, NOW(), DATE_ADD(NOW(), INTERVAL 15 DAY), 'active', NOW(), NOW()),
(5, NOW(), DATE_ADD(NOW(), INTERVAL 60 DAY), 'active', NOW(), NOW()),
(6, NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY), 'inactive', NOW(), NOW());

INSERT INTO WatchHistory (user_id, movie_id, watched_at) VALUES
(1, 1, NOW()),
(1, 3, NOW()),
(2, 2, NOW()),
(2, 5, NOW()),
(3, 4, NOW()),
(2, 3, NOW());
