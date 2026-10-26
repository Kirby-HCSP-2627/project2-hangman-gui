import pygame
# import your python files here by 

pygame.init()
# Initialize your settings, I suggest setting your colors, fonts, and window sizes
screen = pygame.display.set_mode(1280,720, pygame.SCALED)
pygame.display.set_caption("Insert your name here") # Name your window

# Lets create a background
background = pygame.Surface(screen.get_size())
background = background.convert()
background.fill(background_color) # Fills background with color you defined

# Let's add a title
title = font.render("This text is centered and using color (0,0,0)", True, (0,0,0))
textpos = title.get_rect(centerx=background.get_width() / 2, y=10)
# Think of blit as a copy and paste. Here we copy the rectangle from line above onto the background
background.blit(title, textpos)

# Rectangle objects take ((x,y), (width,height))
# The origin (0,0), is the top left most pixel on screen
# So passing (100,200) would create a Rectangle object with position (100,100) going 100 wide and 100 down
button1_rectangle = pygame.Rect((100,200), (100,200))
pygame.draw.rect(screen, (255,255,255), button1_rectangle)


# Finally let's update our screen 
screen.blit(background, (0, 0))
pygame.display.flip()
while running:
    # 1. Process game events first
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False
        
    # 2. Do all of your logic updates here




    screen.fill("purple")  # Fill the display with a solid color to start on a fresh screen
    # 3. Render any new visuals here
    
    
    
    
    pygame.display.flip()  # Refresh on-screen display with new changes
    clock.tick(60)         # Wait until next frame(at 60 FPS)
    
pygame.quit()
