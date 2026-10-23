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
Using pygame, you will be creating a GUI for the logic you have already implemented. You will have the liberty to choose how to implement most of it but there are a couple things you must have:
*	

### Example Output
```python
>>> secret_word = 'apple'
>>> letters_guessed = ['e', 'i', 'k', 'p', 'r', 's']
>>> print(is_word_guessed(secret_word, letters_guessed))
False
```

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
5. Confirm on your GitHub account, might take ~1 or 2 minutes to update on GitHub website
