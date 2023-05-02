#!/usr/bin/env python3
import sys
from PIL import Image, ImageDraw

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python3 main.py <input_image_path> <output_image_path>")
        sys.exit(1)
    else:
        png_path = sys.argv[1]    # 'optechx/library.apps/Microsoft-365/img/microsoft365.png'
        png_output = sys.argv[2]  # 'optechx/library.apps/Microsoft-365/img/microsoft365_scaled.png'

        # Create a transparent canvas with dimensions 300x200
        canvas = Image.new('RGBA', (300, 200), color=(0, 0, 0, 0))

        # Load the PNG file
        img = Image.open(png_path)

        # Get the size of the loaded image
        img_width, img_height = img.size

        # Calculate the maximum size that the image can be scaled to while still fitting within the canvas
        max_size = min(200, min(canvas.size) - 20)

        # Calculate the scaling factor based on the maximum size
        scale_factor = min(max_size / img_width, max_size / img_height)

        # Scale the image using the calculated scaling factor
        img = img.resize((int(img_width * scale_factor), int(img_height * scale_factor)))

        # Calculate the coordinates for centering the image on the canvas
        x = (canvas.width - img.width) // 2
        y = (canvas.height - img.height) // 2

        # Paste the scaled image onto the canvas
        canvas.paste(img, (x, y))

        # Save the resulting image as a PNG file
        canvas.save(png_output)
