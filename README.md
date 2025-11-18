# Ogorodnik Adam 4cs-31

## 📘 Project Description
This project was created for the **Internet Technologies** lab work.  
The goal is to **automate web server deployment** using **bash scripts**.  
The project includes a main script `run.sh` that runs the process, and a secondary script `user-data.sh` responsible for configuring the system (such as installing packages, setting up users, or starting services).

---

## 📂 Project Structure
ihtLab2/
├── .gitignore # Ignored files for Git
├── README.md # Project description
├── run.sh # Main startup script
└── user-data.sh # Configuration script

---

## ⚙️ Requirements
Before running, make sure you have:
- Linux, macOS, or WSL environment  
- Bash (version 4.0 or higher)  
- Execution permissions for scripts  

---

## 🚀 How to Run
1. Clone the repository:
   git clone https://github.com/AdamT3H/ihtLab2.git
   cd ihtLab2
   
Grant execute permissions:
2. chmod +x run.sh user-data.sh

Run the main script:
3. ./run.sh

The script will automatically call user-data.sh, which will perform system configuration tasks.

Connect via ssh:
4. ssh -i iht-key-pair.pem ubuntu@PUBLIC_IP

Check packages:
5. mc --version # Midnight Commander

vim --version # Vim editor

git --version # Git
