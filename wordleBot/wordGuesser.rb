# File: wordGuesser.rb
# Author: Arvid Möller
# Date: 2025-01-23
# Description: This program guesses a word to enter in Wordle.
# Required files: void
# Required gems: void


# Guesses a word based on data-state of previous letters and what row it is (words with duplicate letters aren't allowed in first row). All words are read from sortedWords.txt file.
#
# Paramiters:
# - correct: Array of correct letters.
# - present: Array of present letters.
# - absent: Array of absent letters.
# - enterdWords: Array of all entered words (I know I spelled it wrong).
# - currentRow: Integer showing which row is currently played.
#
# Returns: A word which meets all criteria to be guessed.
def wordGuesser(correct, present, absent, enterdWords)
  if File.exist?("sortedWords.txt")
    File.open("sortedWords.txt", "r") do |file|   #Open sortedWords.txt file
      potWordExist = false
      file.each_line do |word|    # Loop through all lines in sortedWords.txt
        word.chomp!
        wrong = false

        i = 0
        if !enterdWords.include?(word)  # Don't guess words that is already guessed
          while i < word.length   # All correct letters need to be in the right place
            if correct[i] != nil
              if word[i] != correct[i]
                wrong = true
              end
            end

            if absent.include?(word[i])   # Word can't include any absent letter
              wrong = true
            end
          
            i += 1
          end

          present.each_entry do |presentChar|
            if !word.include?(presentChar)    # Word needs to include all present chars
              wrong = true
            else
              enterdWords.each do |enterdWord|
                if enterdWord.include?(presentChar)
                  if word.index(presentChar) == enterdWord.index(presentChar)   # The present char can't be in the same place as in a previously guessed word.
                    wrong = true
                  end
                end
              end
            end
          end  

          correctLetters = 0
          correct.each_entry do |e|   # Find numer of correct letters
            if e != nil
              correctLetters += 1
            end
          end
          if correctLetters < 3
            if word.chars.uniq != word.chars  # The word can't include duplicate letters if there are less than three correct letters
              if potWordExist == false && wrong == false  # Save word that matches all criteria exept duplicate letters for use if no other word is found
                $potWord = word
                potWordExist = true
              end
              
              wrong = true
            end
          end

          if wrong == false
            return word   # Return only words that have passed all criteria.
          end
        end
      end
      return $potWord  # If no word is found return a word that has duplicate letters
    end
  end
end