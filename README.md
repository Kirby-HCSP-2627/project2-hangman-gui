# Project #2 Hangman GUI

### INSTALL
Run each line individually <br/>
For MAC
```bash
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
```
For WINDOWS
```bash
python -m venv .venv
.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
pip install -r requirements.txt
```
### Intro
We are going to use [pygame](https://www.pygame.org/docs/), a python library built to make 2D games using python. <br/>

Compared to our last library, you will notice that pygame is a little more established with plenty of guides. My best advice is to look at the documentation and various examples the site provides. If you decide to go into programming, this is something you will be doing a lot! <br/>

A graphical user interface or GUI for short, can be defined as a visual system that enables users to interact with machines. You are looking at one right now. Whether it is on MacOS, any version of Windows, or even your phone, you are currently interacting with a GUI. GUI's allow users to give commands to computers through clicks or touch rather than the use of commands. Without them users would have to interact with computers solely through the command line.

### The Program
Using pygame, you will be creating a GUI for the logic you have already implemented. I suggest importing your file with your game logic and the template also has a line that will help you with doing that. You will be able to call all of the functions that you defined in your game logic file.<br/>

This will also be a test of how well you applied abstraction in your previous assignment. Don't worry if you find yourself having to write some extra functions to reuse your old code. Just remember the main point for your code is to be simple and concise. Most of the time, your functions should only do one single thing! <br/>

You will have the liberty to choose how to implement most of it but there are a couple things you must have:
- You will import the words from a text file.
  - There are 2 different files that your program must read from
    - words.txt is the same file from the last assignment. A text file comprised of words separated by spaces. (required)
    - phrases.txt is a new file of phrases, each on their own line. The phrases are up to 4 words long. (optional, extra challenge)
- The rules will stay the same.
  - 6 total guesses
  - 3 warnings, get warnings for non-alphabetical characters and repeat guesses, start losing a guess after they run out of warnings
  - Print out player score at the end of a successful game
In summary, the mechanics of the game should stay the same. 
- So what will change?
  - Have a visual for the remaining letters
  - Have a visual for their current progress on the word ( _ pp_ _ e )
  - Have a visual for the user to know how many guesses are left.
    - You will do this by having an unique image for each stage
    - Traditionally, this would look like drawing each part of the hangman but you can take it any direction as long as there is a unique image for each of the 6 stages (Ex. Building a snowman in 6 stages)
  - Give the user an option to guess the word early
    - If the user guesses correctly, multiply the player score by the amount of guesses left as a bonus
    - If the user guesses incorrectly, they lose
  - Have a game win and game loss screen
    - On game win, show the players their score
    - On game loss, show the players the word
    - In both, have a way for the user to choose to play again
#### OPTIONAL THINGS TO IMPLEMENT
Add some audio cues or background music. 
- Use .wav or .ogg file types for short and quick sound effects. There are pros and cons for both. 
- Use .mp3 for background music. 

### Example Output
Coming Soon

### Submitting 
To submit your project:<br/>
1. Open a terminal window in vscode in your project folder
2. Replace file_name with the name of the file you edited
```bash
git add file_name.py
```
3. Type short summary of what you added in between quotations
```bash
git commit -m "your message here"
```
4. Push it to your repository
```bash
git push
```
5. Confirm on your GitHub account
