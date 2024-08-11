import cv2
import os

# Define paths
train_images_path = "D:\\repo-clone\\Datasets\\train_data\\images"
test_images_path = "D:\\repo-clone\\Datasets\\test_data\\images"

# Initialize the HOG descriptor/person detector
hog = cv2.HOGDescriptor()
hog.setSVMDetector(cv2.HOGDescriptor_getDefaultPeopleDetector())

def load_images(images_path):
    images = []
    for image_file in os.listdir(images_path):
        if image_file.endswith('.jpg'):
            image = cv2.imread(os.path.join(images_path, image_file))
            if image is not None:
                images.append(image)
            else:
                print(f"Warning: Could not read image {image_file}.")
        else:
            print(f"Skipping non-image file {image_file}")
    return images

def detect_and_count_people(images):
    counts = []
    for image in images:
        rects, _ = hog.detectMultiScale(image, winStride=(4, 4), padding=(8, 8), scale=1.05)
        counts.append(len(rects))  # Number of detected bounding boxes
    return counts

# Load training and testing data
train_images = load_images(train_images_path)
test_images = load_images(test_images_path)

# Detect and count people in the test images
predicted_counts = detect_and_count_people(test_images)

# Print results for the test images
for i, count in enumerate(predicted_counts):
    print(f"Image {i + 1} detected {count} people.")
