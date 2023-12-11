from PIL import Image

def image_to_matrix(image_path, matrix_size):
    # Load the image
    image = Image.open(image_path)
    
    # Resize image to the desired matrix size
    image = image.resize(matrix_size)
    
    # Convert image to grayscale
    image = image.convert('L')
    
    # Threshold the image to convert to binary
    threshold = 128  # This may need to be adjusted
    image = image.point(lambda p: p > threshold and 1 or 0)
    
    # Convert to matrix
    matrix = []
    for y in range(image.height):
        row = []
        for x in range(image.width):
            pixel = image.getpixel((x, y))
            if pixel == 0:
                row.append(1)  # Wall
            else:
                print(pixel) 
                row.append(0)  # Path
        matrix.append(row)
    return matrix

# Example usage
image_path = 'level-solve.png'
matrix_size = (81, 57)  # Desired size of the matrix
matrix = image_to_matrix(image_path, matrix_size)

for row in matrix:
    print(', '.join(str(cell) for cell in row))
