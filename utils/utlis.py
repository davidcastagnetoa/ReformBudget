import keyboard
import os

PHI = 1.61803398875


def golden_ratio_width(height: float) -> float:
    width = height * PHI
    return width


def golden_ratio_height(width: float) -> float:
    height = width * PHI
    return height


print(os.name)
os.system("cls")


while True:
    os.system("cls")
    print("Press 'w' to calculate width, 'h' to calculate height, or 'Esc' to exit.")

    event = keyboard.read_event(suppress=True)

    if event.name == "esc":
        print("Exiting program.")
        break

    # get width
    elif event.name == "w":
        os.system("cls")
        height = float(input("Enter height: "))
        print(f"width : {golden_ratio_height(height)} ")
        break

    # get height
    elif event.name == "h":
        os.system("cls")
        width = float(input("Enter width: "))
        print(f"height : {golden_ratio_height(width)} ")
        break
