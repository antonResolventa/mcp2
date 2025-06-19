-- Установка кодировки UTF-8
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- Создание демонстрационной базы данных с явным указанием кодировки
DROP DATABASE IF EXISTS demo;
CREATE DATABASE demo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE demo;

-- Создание таблицы сотрудников
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    last_name VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    position VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    hire_date DATE NOT NULL,
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES employees(id)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Создание таблицы проектов
CREATE TABLE projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    description TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    start_date DATE NOT NULL,
    end_date DATE,
    budget DECIMAL(15, 2),
    status ENUM('Not Started', 'In Progress', 'Completed', 'On Hold') DEFAULT 'Not Started'
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Создание таблицы для связи сотрудников и проектов (многие ко многим)
CREATE TABLE employee_projects (
    employee_id INT,
    project_id INT,
    role VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    hours_allocated INT DEFAULT 0,
    PRIMARY KEY (employee_id, project_id),
    FOREIGN KEY (employee_id) REFERENCES employees(id),
    FOREIGN KEY (project_id) REFERENCES projects(id)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Создание таблицы департаментов
CREATE TABLE departments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    location VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    budget DECIMAL(15, 2),
    head_id INT,
    FOREIGN KEY (head_id) REFERENCES employees(id)
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Создание таблицы клиентов
CREATE TABLE clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    contact_person VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    email VARCHAR(100),
    phone VARCHAR(20),
    address TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
    registration_date DATE NOT NULL
) ENGINE=InnoDB CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Заполнение таблицы сотрудников демонстрационными данными
INSERT INTO employees (first_name, last_name, email, department, position, salary, hire_date) VALUES
('Иван', 'Иванов', 'ivanov@example.com', 'Разработка', 'Старший разработчик', 150000.00, '2020-01-15'),
('Мария', 'Петрова', 'petrova@example.com', 'Маркетинг', 'Маркетинг-менеджер', 120000.00, '2019-05-20'),
('Алексей', 'Смирнов', 'smirnov@example.com', 'Разработка', 'Ведущий инженер', 180000.00, '2018-11-10'),
('Елена', 'Козлова', 'kozlova@example.com', 'HR', 'HR-директор', 140000.00, '2019-03-01'),
('Дмитрий', 'Соколов', 'sokolov@example.com', 'Разработка', 'Разработчик', 90000.00, '2021-02-15'),
('Анна', 'Новикова', 'novikova@example.com', 'Дизайн', 'UI/UX дизайнер', 110000.00, '2020-07-22'),
('Сергей', 'Морозов', 'morozov@example.com', 'Продажи', 'Менеджер по продажам', 95000.00, '2019-09-05'),
('Ольга', 'Волкова', 'volkova@example.com', 'Маркетинг', 'SMM-специалист', 85000.00, '2021-04-12'),
('Андрей', 'Лебедев', 'lebedev@example.com', 'Разработка', 'DevOps инженер', 160000.00, '2018-06-18'),
('Наталья', 'Кузнецова', 'kuznetsova@example.com', 'Финансы', 'Финансовый аналитик', 130000.00, '2019-11-01');

-- Обновляем manager_id для некоторых сотрудников
UPDATE employees SET manager_id = 1 WHERE id IN (3, 5);
UPDATE employees SET manager_id = 2 WHERE id IN (8);
UPDATE employees SET manager_id = 4 WHERE id IN (10);

-- Заполнение таблицы проектов демонстрационными данными
INSERT INTO projects (name, description, start_date, end_date, budget, status) VALUES
('Редизайн веб-сайта', 'Полное обновление корпоративного веб-сайта', '2023-01-10', '2023-05-15', 1500000.00, 'Completed'),
('Мобильное приложение', 'Разработка мобильного приложения для клиентов', '2023-03-01', '2023-09-30', 2500000.00, 'In Progress'),
('Внедрение CRM', 'Внедрение новой CRM системы', '2023-02-15', '2023-07-10', 1200000.00, 'In Progress'),
('Маркетинговая кампания Q3', 'Разработка и проведение маркетинговой кампании на третий квартал', '2023-07-01', '2023-09-30', 800000.00, 'Not Started'),
('Оптимизация базы данных', 'Оптимизация и реструктуризация корпоративной базы данных', '2023-04-10', '2023-06-15', 500000.00, 'Completed');

-- Связываем сотрудников с проектами
INSERT INTO employee_projects (employee_id, project_id, role, hours_allocated) VALUES
(1, 1, 'Технический руководитель', 120),
(3, 1, 'Разработчик', 160),
(5, 1, 'Разработчик', 160),
(6, 1, 'Дизайнер', 100),
(1, 2, 'Архитектор', 80),
(3, 2, 'Ведущий разработчик', 160),
(5, 2, 'Разработчик', 160),
(6, 2, 'UI/UX дизайнер', 120),
(9, 2, 'DevOps инженер', 80),
(2, 3, 'Консультант', 40),
(4, 3, 'HR-консультант', 60),
(7, 3, 'Руководитель проекта', 100),
(2, 4, 'Руководитель проекта', 120),
(8, 4, 'SMM-специалист', 160),
(9, 5, 'Руководитель проекта', 80),
(10, 5, 'Аналитик', 100);

-- Заполнение таблицы департаментов
INSERT INTO departments (name, location, budget, head_id) VALUES
('Разработка', 'Этаж 3, Офис 301', 5000000.00, 1),
('Маркетинг', 'Этаж 2, Офис 210', 3000000.00, 2),
('HR', 'Этаж 2, Офис 205', 1500000.00, 4),
('Дизайн', 'Этаж 3, Офис 305', 2000000.00, 6),
('Продажи', 'Этаж 1, Офис 110', 4000000.00, 7),
('Финансы', 'Этаж 4, Офис 405', 2500000.00, 10);

-- Заполнение таблицы клиентов
INSERT INTO clients (company_name, contact_person, email, phone, address, registration_date) VALUES
('ООО "ТехноПром"', 'Егор Белов', 'belov@technoprom.ru', '+7 (999) 123-4567', 'г. Москва, ул. Ленина, 42', '2019-01-15'),
('АО "МедиаГруп"', 'Светлана Игнатова', 'ignatova@mediagroup.ru', '+7 (999) 234-5678', 'г. Санкт-Петербург, пр. Невский, 110', '2019-03-22'),
('ИП Самойлов', 'Андрей Самойлов', 'samoilov@gmail.com', '+7 (999) 345-6789', 'г. Екатеринбург, ул. Гагарина, 15', '2020-05-10'),
('ООО "СтройМастер"', 'Наталья Романова', 'romanova@stroymaster.ru', '+7 (999) 456-7890', 'г. Новосибирск, ул. Кирова, 25', '2018-11-05'),
('ЗАО "Финансист"', 'Дмитрий Поляков', 'polyakov@financist.ru', '+7 (999) 567-8901', 'г. Казань, ул. Пушкина, 18', '2021-02-28');

-- Создание представления для просмотра проектов с участниками
CREATE VIEW project_team_view AS
SELECT 
    p.id AS project_id,
    p.name AS project_name,
    p.status AS project_status,
    e.id AS employee_id,
    e.first_name,
    e.last_name,
    e.position,
    ep.role AS project_role,
    ep.hours_allocated
FROM 
    projects p
JOIN 
    employee_projects ep ON p.id = ep.project_id
JOIN 
    employees e ON ep.employee_id = e.id
ORDER BY 
    p.id, e.id;
