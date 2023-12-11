from PIL import Image

def is_red(pixel):
    # Adjust the threshold of what is considered 'red' according to your image
    return (pixel[0] >= 200 and pixel[0] <= 255) and pixel[1] <= 55 and pixel[2] <= 55

def find_red_path(image_path, start_pos):
    # Load the image
    image = Image.open(image_path)
    pixels = image.load()

    # Size of the image
    width, height = image.size

    # Initialize variables
    x, y = start_pos
    path = [(x, y)]  # Starting position
    moves = []

    # Define the move directions
    directions = {
        'up': (0, -1),
        'down': (0, 1),
        'left': (-1, 0),
        'right': (1, 0),
    }

    # Function to get the next move
    def get_next_pos(x, y):
        for direction, (dx, dy) in directions.items():
            new_x, new_y = x + dx, y + dy
            if 0 <= new_x < width and 0 <= new_y < height and (new_x, new_y) not in path:
                if is_red(pixels[new_x, new_y]):
                    return direction, new_x, new_y
        return None, x, y

    # Find the path
    move, new_x, new_y = get_next_pos(x, y)
    while move:
        path.append((new_x, new_y))
        moves.append(move)
        x, y = new_x, new_y
        move, new_x, new_y = get_next_pos(x, y)

    return moves

# Example usage
image_path = 'level-solve.png'  # Update this path
start_pos = (0, 0)  # Starting position in the maze

# This function will return a list of moves that follow the red path
moves = find_red_path(image_path, start_pos)
print("Moves to solve the maze:", moves)
