# Example file showing a basic pygame "game loop"
import pygame
# import your_file_name_here # Replace this with the name of your python file that has all of your logic

# pygame setup
pygame.init()
screen = pygame.display.set_mode((1280, 720)) # You can change this depending on the size of the window you want the game to appear as
clock = pygame.time.Clock()
running = True

while running:
    # poll for events
    # here is where you will put all of your events
    # pygame.QUIT event means the user clicked X to close your window
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    # fill the screen with a color to wipe away anything from last frame
    screen.fill("purple")

    # Add your code between these two lines








  
    # Add your code between these two lines

    # flip() the display to put your work on screen
    pygame.display.flip()

    clock.tick(60)  # limits FPS to 60

pygame.quit()
