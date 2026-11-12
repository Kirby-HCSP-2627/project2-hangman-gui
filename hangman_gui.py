import pygame
# Write your import statement below! 

pygame.init()

# Setup Display ( If your screen is too big or too small you can change these values.
#                 Unit is Pixels
#)
WIDTH, HEIGHT = 1280, 720
screen = pygame.display.set_mode((WIDTH, HEIGHT))
pygame.display.set_caption("Kirby Hangman")


# Colors
BG_COLOR = (245, 242, 235) # Off-white / Cream


# Fonts (Use SysFont to plugin your own fonts)
FONT_TITLE = pygame.font.SysFont("Helvetica", 36, bold=True)


#Rules Setup


def main(secret_word: str) -> None:
    running = True
    clock = pygame.time.Clock()
    # Define all the variables you need here for the loop

    while running:
        # You will be finding 
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False


        # Make an update to your variables here
        
        screen.fill(BG_COLOR)
        
        # Draw all of your Rect's here

        # Check for your exit

        pygame.display.flip()
        clock.tick(60)
    pygame.quit()
    return None

if __name__ == "__main__":
    #Call your function that gets the word here
    main("Hello")
