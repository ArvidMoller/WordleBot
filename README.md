# WordleBot
This program solves today's Wordle problem in Chrome using the Selenium WebDriver.

## Required Gems
- `selenium-webdriver`

## Installation
1. **Clone the repo**  
   In GIT Bash, type:  
   `git clone https://github.com/ArvidMoller/WordleBot.git`
2. **Open in VS Code or another preferred editor**
3. **Install gems if not already installed**  
   Run:  
   `gem install selenium-webdriver`
4. **Update file paths if necessary**  
   You might need to update the path to the `wordGuesser.rb` file at the start of the `wordleBot.rb` file to match your file structure.

## Run Script
1. Navigate to the correct directory using `cd` in the terminal.
2. Run in terminal:  
   `ruby wordleBot.rb`

## Add Words to sortedWords.txt
1. Paste the words you want to add into the `addWords.txt` file, placing each word on a separate line.  
2. Leave a blank line at the end of the file.  
3. Run the `wordSort.rb` script in the terminal to update `sortedWords.txt`.

## Included Ruby Files
- **`wordleBot.rb`**  
  This is the main program that opens a Chrome window with Wordle.  
  - The `enterWord()` function enters a word in Wordle. The word must be in all capitals.  
  - The `getDataState()` function scrapes the data state (correct, present, or absent) for each letter in an entered word.
  
- **`wordGuesser.rb`**  
  This program guesses a word by:  
  - Matching correct and present letters while excluding absent letters.  
  - Ensuring the word doesn't contain present letters in the same positions as previously guessed words.  
  - Avoiding duplicate letters unless at least three letters are correct.  
  If multiple words meet all criteria, the word with the most common letters is chosen.  
  All words the program can guess are stored in `sortedWords.txt`.
  
- **`wordSort.rb`**  
  This program sorts all words from `words.txt` into `sortedWords.txt` based on the frequency of their letters. It also adds words from `addWords.txt` to `words.txt` if they are not already included.  
  - The `wordSort()` function calculates scores for all words and calls the `sort()` function to arrange them by score.  
  - The `checkWords()` function adds new words from `addWords.txt` to `words.txt`.

## Included .txt Files
- **`words.txt`**  
  Contains all words the program can guess, listed in the order they were added.
  
- **`sortedWords.txt`**  
  Contains all words the program can guess, sorted by how common their letters are.
  
- **`addWords.txt`**  
  If you want to add new words, place them in this file. When you run the `wordSort.rb` script, the new words will be added to `words.txt` and sorted into `sortedWords.txt` if they do not already exist in `words.txt`.