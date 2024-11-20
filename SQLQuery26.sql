CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    username NVARCHAR(50) NOT NULL UNIQUE,
    email NVARCHAR(100) NOT NULL UNIQUE,
    password_hash NVARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);


CREATE TABLE Categories (
    category_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    name NVARCHAR(100) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    transaction_type NVARCHAR(10) CHECK (transaction_type IN ('income', 'expense')),
    category_id INT,
    transaction_date DATETIME NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE NO ACTION
);

CREATE TABLE Budgets (
    budget_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    category_id INT,
    limit_amount DECIMAL(10, 2) NOT NULL,
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE NO ACTION
);


INSERT INTO Users (username, email, password_hash)
VALUES 
('john_doe', 'john@example.com', 'hashed_password_1'),
('jane_smith', 'jane@example.com', 'hashed_password_2'),
('alex_brown', 'alex@example.com', 'hashed_password_3');


INSERT INTO Categories (user_id, name)
VALUES 
(1, 'Food'),
(1, 'Transport'),
(2, 'Entertainment'),
(2, 'Bills'),
(3, 'Savings');

INSERT INTO Transactions (user_id, amount, transaction_type, category_id, transaction_date)
VALUES 
(1, 50.00, 'expense', 1, CONVERT(datetime, '2023-10-01', 120)),  -- Формат: YYYY-MM-DD
(1, 20.00, 'expense', 2, CONVERT(datetime, '2023-10-02', 120)),  -- Формат: YYYY-MM-DD
(2, 100.00, 'income', NULL, CONVERT(datetime, '2023-10-03', 120)),  -- Формат: YYYY-MM-DD
(2, 30.00, 'expense', 3, CONVERT(datetime, '2023-10-04', 120)),  -- Формат: YYYY-MM-DD
(3, 200.00, 'income', NULL, CONVERT(datetime, '2023-10-05', 120));  -- Формат: YYYY-MM-DD

INSERT INTO Budgets (user_id, category_id, limit_amount, start_date, end_date)
VALUES 
(1, 1, 300.00, CONVERT(datetime, '2023-10-01', 120), CONVERT(datetime, '2023-10-31', 120)), 
(1, 2, 150.00, CONVERT(datetime, '2023-10-01', 120), CONVERT(datetime, '2023-10-31', 120)), 
(2, 3, 100.00, CONVERT(datetime, '2023-10-01', 120), CONVERT(datetime, '2023-10-31', 120)), 
(3, NULL, 500.00, CONVERT(datetime, '2023-10-01', 120), CONVERT(datetime, '2023-10-31', 120));
