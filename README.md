# WordleBot
 This program solves todays Wordle problem in Chrome using the Selenium WebDriver.

## Required gems
 - Selenium WebDriver'

## Installation
 1. **Clone the repo**
    In GIT Bash type: git clone https://github.com/ArvidMoller/WordleBot.git
 2. **Open in VS code or other perfered editor**
 3. **Install gems if not already installed**
    - gem install selenium-webdriver
 5. **You might have to change the path to the wordGuesser.rb file in the start of the wordleBot.rb file to match your file structure**
 
 ## Run script
  1. Navigate to the correct directory using cd in the terminal.
  2. Type ruby wordleBot.rb in the terminal

 ## Add words to sortedWords.txt
  Paste the words you want to add to the addWords.txt file on separate lines and leave a blank line at the end. Run the wordSort.rb script in the terminal.

 ## Included ruby files
  **wordleBot.rb**
   -This is the main program that opens a Chrome window with wordle. The enterWord() function enters a word in wordle, the word has to be all capitals. The getDataState() function scrapes the data state (correct, present or absent) for every letter in a enterd word. 
 **wordGuesser.rb**
  - This program guesses a word by matching correct letters present letters and exludes absent letters. The word can't contain present letters in the same place as previously guessed words. Furthermore the word can't have duplicate letters if less than three letters are correct. If multiple words pass all criteria the word with the most common letters is chosen. All words the program is able to guess is in the sortedWords.txt file.
 **wordSort.rb**
  - This program sorts all words in the words.txt file to the sortedWords.txt file based on how common the letters are using quickSort aswell as adding words from the addWords.txt file to words.txt if they aren't already included. The wordSort() function is the main function and gives all words point and then calls the sort() function which sorts all words based on their score. The checkWords() function adds new words to the words.txt file from addWords.txt.

## Included .txt files
 **words.txt**
  - Conatins all words the program is able to guess in the order they was added.
 **sortedWords.txt**
  - Conatins all words the program is able to guess in sorted order based on how common their letters are.
 **addWords.txt**
  - If you want to add any words you can add them to the addWords.txt file and when you run the sortWords.rb script they will be added and sorted if they don't already exist in words.txt.
