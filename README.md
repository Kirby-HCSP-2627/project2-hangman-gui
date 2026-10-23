# Assignment #3 Hangman

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
This assignment is for you to practice functions, I/O, and flow control. 

### Relevant Info 
In general, when taking user input there are a few things we want to check: <br/>
1. Check the user input is what you want
2. Clean up the user input, remove extra blank spaces and convert to all lowercase


These might be some useful methods/functions. Google them to find the documentation
```python
isalpha()
string.strip() 
```
### The Program
You will implement a variation of the classic word game Hangman. If you are unfamiliar with the rules of the game, [read here](http://en.wikipedia.org/wiki/Hangman_(game)) . Don’t be intimidated by this problem it's actually easier than it looks! I will 'scaffold' this problem, guiding you through the creation of helper functions 
before you implement the actual game.

### Example Output
Example for is_word_guessed() helper function
```python
>>> secret_word = 'apple'
>>> letters_guessed = ['e', 'i', 'k', 'p', 'r', 's']
>>> print(is_word_guessed(secret_word, letters_guessed))
False
```
Example for get_guessed_word()
```python
>>> secret_word = 'apple'
>>> letters_guessed = ['e', 'i', 'k', 'p', 'r', 's']
>>> print(get_guessed_word(secret_word, letters_guessed))
'_ pp_ e'
```
Example for get_available_letters()
```python
>>> letters_guessed = ['e', 'i', 'k', 'p', 'r', 's']
>>> print(get_available_letters(letters_guessed))
abcdfghjlmnoqtuvwxyz # The alphabet with the letters guessed removed 
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
