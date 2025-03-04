# Flask_app
# MediHelp - Hospital Management System

## Overview

MediHelp is a web-based hospital management system built using Flask and MySQL. 
It enables users to book appointments, manage patient and nurse records, and track visit details efficiently.
The system includes user authentication, email notifications, and a secure database setup.

## Features

- **User Authentication:** Secure signup, login, and logout system using Flask-Login.
- **Appointment Booking:** Patients can book and manage their appointments.
- **Nurse Management:** Nurses can be registered and assigned tasks.
- **Visit Tracking:** Users can view and manage their visit history.
- **Email Notifications:** Automated appointment confirmations via SMTP.
- **Database Integration:** Uses MySQL with SQLAlchemy ORM.

## Installation

### Prerequisites

- Python 3.x
- MySQL
- Flask and required libraries

### Steps

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/MediHelp.git
   cd MediHelp
   ```

2. Install dependencies:

   ```bash
   pip install -r requirements.txt
   ```

3. Set up the MySQL database:

   - Import the `hospital.sql` file into your MySQL database.
   - Update the `config.json` file with your database credentials.

4. Run the application:

   ```bash
   python main.py
   ```

5. Open in your browser:

   ```
   http://127.0.0.1:5000/
   ```

## Configuration

Modify the `config.json` file to include:

```json
{
    "params": {
        "gmail-user": "your-email@gmail.com",
        "gmail-password": "your-email-password"
    }
}
```

⚠️ **Security Note:** Never expose sensitive credentials in public repositories. Use environment variables instead.

## Usage

- **Homepage (**``**)**: Access the main interface.
- **Nurse Registration (**``**)**: Register a nurse.
- **Patient Booking (**``**)**: Book and manage appointments.
- **Visit Records (**``**)**: View past appointments.
- **Admin (**``**)**: View system logs.

## License

This project is open-source under the MIT License.

