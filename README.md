# Tự Động Tra Cứu Phạt Nguội 

### Các tính năng:
- Tự động nhập thông tin biển số xe và loại xe.
- Tự động nhận diện mã CAPTCHA để tra cứu vi phạm.
- Lưu kết quả tra cứu vào file `ket_qua.txt`.
## Yêu cầu hệ thống
- Python >= 3.8  
- Google Chrome + ChromeDriver (phiên bản tương thích)  
- Tesseract-OCR (để xử lý ảnh CAPTCHA)  
- Các thư viện Python: `robotframework`, `selenium`, `pytesseract`, `opencv-python`, `requests`
## Cài Đặt
### Bước 1: Tải source code
 - phatnguoi.robot
 - OCR.py
 - scheduler.py
 - requirements.txt
### 2. CCài đặt thư viện cần thiết
 - pip install -r requirements.txt
### 3.Cài đặt Tesseract OCR (Windows)
Tải trình cài đặt tại:
https://github.com/UB-Mannheim/tesseract/wiki
Sau khi cài đặt, ghi nhớ đường dẫn
 - C:\Program Files\Tesseract-OCR\tesseract.exe
 - Tích chọn “Add Tesseract to system PATH” (hoặc thêm thủ công).
### 4. chạy chương trình
python scheduler.py

