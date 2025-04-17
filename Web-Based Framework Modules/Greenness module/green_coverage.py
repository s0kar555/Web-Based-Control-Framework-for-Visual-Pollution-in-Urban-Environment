import cv2
import numpy as np
import sys
import json

# Define the HSV range for green colors
lower_green = np.array([25, 40, 40])
upper_green = np.array([95, 255, 255])

# Function to calculate green coverage and save the mask
def calculate_green_coverage(image_path, mask_path, lower_green, upper_green):
    image = cv2.imread(image_path)
    if image is None:
        with open('debug.log', 'a') as f:
            f.write(f"Error: Unable to load image {image_path}\n")
        print(f"Error: Unable to load image {image_path}")
        return
    
    hsv_image = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
    green_mask = cv2.inRange(hsv_image, lower_green, upper_green)
    cv2.imwrite(mask_path, green_mask)
    
    # Calculate green percentage
    total_pixels = image.shape[0] * image.shape[1]
    green_pixels = cv2.countNonZero(green_mask)
    green_percentage = (green_pixels / total_pixels) * 100

    with open('debug.log', 'a') as f:
        f.write(f"Mask saved to {mask_path}\n")
        f.write(f"Green percentage: {green_percentage:.2f}%\n")
    
    # Save the green percentage to a JSON file
    with open(mask_path.replace('.png', '_percentage.json'), 'w') as f:
        json.dump({"green_percentage": green_percentage}, f)

    return green_percentage

if __name__ == "__main__":
    with open('debug.log', 'a') as f:
        f.write("Python script started.\n")

    if len(sys.argv) != 3:
        with open('debug.log', 'a') as f:
            f.write("Usage: python green_coverage.py <image_path> <mask_path>\n")
        print("Usage: python green_coverage.py <image_path> <mask_path>")
        sys.exit(1)
    
    image_path = sys.argv[1]
    mask_path = sys.argv[2]
    green_percentage = calculate_green_coverage(image_path, mask_path, lower_green, upper_green)

    with open('debug.log', 'a') as f:
        f.write(f"Python script finished. Green percentage: {green_percentage:.2f}%\n")
