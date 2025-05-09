from PIL import Image, ImageEnhance
import pytesseract
import cv2
import numpy as np

def process_captcha(image_path):
    image = Image.open(image_path)
    gray_image = image.convert('L')
    # Cải thiện độ tương phản của ảnh
    enhancer = ImageEnhance.Contrast(gray_image)
    enhanced_image = enhancer.enhance(2)  # Điều chỉnh độ tương phản 
    # Chuyển ảnh thành numpy array để xử lý với OpenCV 
    np_image = np.array(enhanced_image)
    # Áp dụng Thresholding (cải thiện độ rõ của văn bản)
    _, thresholded_image = cv2.threshold(np_image, 150, 255, cv2.THRESH_BINARY)
    # Chạy Tesseract trên ảnh đã tiền xử lý
    text = pytesseract.image_to_string(thresholded_image, config='--psm 6') 
    # Xử lý chữ hoa và chữ thường
    return text.strip()
