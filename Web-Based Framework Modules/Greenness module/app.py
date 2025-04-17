from flask import Flask, request, jsonify, send_file
from PIL import Image
import numpy as np
import cv2
import os

app = Flask(__name__)
UPLOAD_FOLDER = 'uploads'
RESULT_FOLDER = 'results'
os.makedirs(UPLOAD_FOLDER, exist_ok=True)
os.makedirs(RESULT_FOLDER, exist_ok=True)

# Define a broader HSV range for green colors
lower_green = np.array([25, 40, 40])
upper_green = np.array([95, 255, 255])

@app.route('/')
def index():
    return send_file('index.html')

@app.route('/upload', methods=['POST'])
def upload_image():
    if 'file' not in request.files:
        return jsonify({'error': 'No file part'}), 400
    file = request.files['file']
    if file.filename == '':
        return jsonify({'error': 'No selected file'}), 400
    if file:
        filename = os.path.join(UPLOAD_FOLDER, file.filename)
        file.save(filename)
        green_percentage, result_image_path = process_image(filename)
        return jsonify({'green_percentage': green_percentage, 'result_image_path': result_image_path}), 200

def process_image(image_path):
    image = cv2.imread(image_path)
    hsv_image = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
    green_mask = cv2.inRange(hsv_image, lower_green, upper_green)
    
    # Count green pixels
    green_area = np.count_nonzero(green_mask)
    total_area = image.shape[0] * image.shape[1]
    green_percentage = (green_area / total_area) * 100
    
    # Save the result image with green mask overlay
    green_image = cv2.bitwise_and(image, image, mask=green_mask)
    result_image_path = os.path.join(RESULT_FOLDER, 'result.png')
    cv2.imwrite(result_image_path, green_image)
    
    return green_percentage, result_image_path

if __name__ == '__main__':
    app.run(debug=True)
 