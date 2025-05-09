import schedule
import time
import os

def run_robot():
    os.system("robot phatnguoi.robot")

# Lên lịch 6h sáng và 12h trưa
schedule.every().day.at("13:24").do(run_robot)
schedule.every().day.at("12:00").do(run_robot)

while True:
    schedule.run_pending()
    time.sleep(10)

