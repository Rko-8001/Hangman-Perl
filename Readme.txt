Name :      Yadwinder Singh
Entry No.:  2020CSB1143

TicTacToe : CS202 Lab 3

Files included :
    Hangman.pl
    README.txt

How to run: 
 ->     open folder in Terminal
 ->     type perl Hangman.pl

Inputing the data:
    Firstly 
        You have to input a ap=lpha numeric charcater i.e. either a-z 0-9
        u have to guess a char until person dies i.e. 
        8 wrong guesses or u guess the word.

    After one game ends, 
        Enter 1 for playing more or 0 for exiting.if entered 
        other char, program will exit in this case also.


How to input for playing game/ Rules:
    For one game: 
        You are given a word. Your task is to guess a word to save 
        person's life. you can afford at most 8 wrong guesses.

        Now what program except as an input: 
            an alpha numeric character to be inputed.
                if(not an alpha numeric char)
                    program will take 1st char as its input.
        
        it is guarneteed that the word to be guessed is in lowercase
        if input a uppercase it will convert it into lowercase.

        if a wrong guess is inputed again, program will warn and
        life will be detuuded.

    After a game ends, enter 1 to play more and 0 to exit and 
    other keys will also lead to exit with a warning.


Subroutines Defined: 
    Hangman.pl
        sub instructions();
        sub driver_sub();
        sub win_lose();
        sub check_guess_letter();
        sub check_correct_input();
        sub print_array();
        sub ini_empty_array();
        sub give_random_word();
        sub hangman_display();


Implementation:
    Enough number of comments are there to ubderstand the logic and syntax is kept simple and 
    readiblilty of code is good.