import string
import random 

def get_word(fname: str) -> str:
    """Gets random word from file. File must have """
    try:
        f = open(fname, "r")
        line = f.readline()                           # Currently one string with words separated by spaces
        list_of_words = line.split(" ")               # Make it a list with items split by empty spaces
        secret_word = random.choice(list_of_words)
    except:
        print(f"Failed to open file{fname}")
        secret_word = ""
    return secret_word

def start_of_round_message(num_guesses: int, remaining_letters: list) -> None:
    """Prints beginning of round message"""
    print("-"*10)
    print(f"You have {num_guesses} guesses left.")
    print(f"Available letters:{remaining_letters}")
    return None

def print_game_end(win: bool, secret_word: str, guesses_remaining: int) -> None:
    """Handles game over print"""
    unique_letters = len(set(secret_word))                                                # Secret shortcut
    print("-"*10)
    if win:
        print("Congratulations, you won!")
        print(f"Your total score for this game is: {guesses_remaining * unique_letters}")
    else:
        print("Sorry! You lost.")
        print(f"The secret word was {secret_word}.")

def get_guessed_word(secret_word: str, guessed_letters: list) -> str:
    """Gets word with only guessed letters printed """
    word = ""
    for letter in secret_word:
        if letter in guessed_letters:
            word += letter
        else:
            word += " _ "
    return word

def get_available_letters(guessed_letters: list) -> list:
    """Returns list of letters that have not been guessed yet"""
    remaining_letters = string.ascii_lowercase
    list_of_remaining_letters = list(remaining_letters)
    for letter in guessed_letters:
        if letter in list_of_remaining_letters:
            list_of_remaining_letters.remove(letter)
    return list_of_remaining_letters

def is_word_guessed(secret_word: str, guessed_letters: list) -> bool:
    """Checks if word has been guessed"""
    for letter in secret_word:
        if letter not in guessed_letters:
            return False
    return True

def check_game_state(num_guesses: int, is_word_guessed: bool) -> bool:
    """Checks for game state, false if game is over, true otherwise"""
    if (num_guesses == 0) or is_word_guessed:
        return False
    else:
        return True

def hangman(secret_word: str) -> None:
    """Our main function that runs the game"""
    num_guesses = 6
    num_warnings = 3
    vowels = ["a", "e", "i", "o", "u"]
    guessed_letters = []
    remaining_letters = get_available_letters(guessed_letters)
    game_running = True
    print("Loading word list from file ...")
    print("Welcome to the game Hangman!")
    print(f"I am thining of a word that is {len(secret_word)} letters long")
    while (game_running):
        valid_input = False
        remaining_letters = get_available_letters(guessed_letters)
        start_of_round_message(num_guesses, remaining_letters)
        while (not valid_input):
            guess = input("Please guess a letter: ").lower()
            if guess.isalpha():
                valid_input = True
                if guess in remaining_letters:
                    guessed_letters.append(guess)
                    if guess in secret_word:
                        print(f"Good guess: {get_guessed_word(secret_word, guessed_letters)}")
                    elif guess in vowels:
                        print(f"Oops! That letter is not in my word: {get_guessed_word(secret_word, guessed_letters)}")
                        num_guesses -= 2
                    else:  
                        print(f"Oops! That letter is not in my word: {get_guessed_word(secret_word, guessed_letters)}")
                        num_guesses -= 1 
                elif num_warnings == 0:
                    num_guesses -= 1
                    print(f"Oops! You already guessed that letter. You have no warnings left so you lose a guess: {get_guessed_word(secret_word, guessed_letters)}")
                else:
                    num_warnings -= 1
                    print(f"Oops! You already guessed that letter. You have {num_warnings} warnings left: {get_guessed_word(secret_word, guessed_letters)}")
            else:
                if num_warnings == 0:
                    print(f"Oops! That is not a valid letter. You have no warnings left so you lose a guess: {get_guessed_word(secret_word, guessed_letters)}")
                    num_guesses -= 1
                else:
                    num_warnings -= 1
                    print(f"Oops! That is not a valid letter. You have {num_warnings} warnings left: {get_guessed_word(secret_word, guessed_letters)}")
                start_of_round_message(num_guesses, remaining_letters)
            game_running = check_game_state(num_guesses, is_word_guessed(secret_word, guessed_letters))
    print_game_end(is_word_guessed(secret_word, guessed_letters), secret_word, num_guesses)
    return None

# if statment below will only run if we directly run this file
if __name__ == "__main__":
    secret_word = get_word("word_list.txt")
    if secret_word != "":
        hangman(secret_word)
    else:
        print("Failed to get word, check word file")