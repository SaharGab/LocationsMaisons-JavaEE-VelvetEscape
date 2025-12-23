# LocationMaisons – Java EE Web Application

## 📖 Project Overview
LocationMaisons is a Java EE web application designed for real estate rental management.  
The system supports multiple user roles (Admin, Agent, Client) and provides a structured workflow for property management and reservations.

This project was developed as an academic and practical application to demonstrate Java EE architecture, MVC design pattern, and role-based access control.

---

## 👥 User Roles & Features

### 🔑 Admin
- Authenticate securely
- Manage agents (add, update, delete)
- Access the administration dashboard

### 🧑‍💼 Agent
- Authenticate securely
- Add, modify, and delete properties
- Manage property listings

### 🧑 Client
- Register and authenticate
- Browse available properties
- Make reservations
- View personal reservations

---

## 🏗️ Architecture
The application follows the **MVC (Model–View–Controller)** architecture:

- **Model**: Java entity classes representing business data
- **DAO**: Data access layer using JDBC
- **Controller**: Servlets handling business logic and requests
- **View**: JSP pages for user interface

---

## 🛠 Technologies Used
- Java EE (Servlets, JSP)
- Maven
- JDBC
- MySQL
- Apache Tomcat
- HTML, CSS, Bootstrap

