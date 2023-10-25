# ReformBudget

ReformBudget is a desktop application built with Python, leveraging PySide2 for its user interface and dotenv for environment configuration. It provides an intuitive solution for client and budget management.
This application saves the user data, clients, and budgets in SQLite3 DB

## Requirements:

- Python 3.6 or higher
- PySide2
- python-dotenv
- sqlite3

## Installation:

1. **Clone the Repository**

   ```bash
    git clone https://github.com/davidcastagnetoa/ReformBudget.git
    cd ReformBudget
   ```

2. **Set Up Virtual Environment (Optional, but Recommended)**

   ```bash
   python -m venv venv
   source venv/bin/activate # On Windows, use venv\Scripts\activate
   ```

3. **Install Dependencies**

   ```bash
   pip install -r requirements.txt
   ```

4. **Configure Environment Variables**

- Create a `.env` file in the root directory.
- Add your configuration:
  ```.env
  USERNAME_RB="your_username"
  PASSWORD_RB="your_password"
  ```

5. **Run the Application**

   ```bash
   python main.py
   ```

## Usage:

1. **Login Screen**

- Use the credentials defined in the `.env` file to access the application.

2. **Manage Clients & Budgets**

- From the main dashboard, you can manage your clients and their respective budgets.

3. **Search & Reports**

- Use the search functionality to quickly locate specific clients or budgets.
- Generate PDF reports via the integrated ReportLab library.
