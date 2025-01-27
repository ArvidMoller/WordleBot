# File: wordleBot.rb
# Author: Arvid Möller
# Date: 2025-01-17
# Description: This program opens Wordle in Chrome using Selenium and solves todays Wordle.
# Requried files: wordGuesser.rb, sortedWords.txt
# Requried gems: Selenium WebDriver

# Require Selenium (gem) and wordGuesser.rb (word guessing algorithm)
require "selenium-webdriver"
require_relative 'D:\Programmering\Tillämp\WordleBot\wordleBot\wordGuesser.rb'


# Declare global variables
$correct = Array.new(5)
$present = Array.new
$absent = Array.new
$enterdWords = Array.new
$currentRow = 0

# Initiate Selenium with correct options
options = Selenium::WebDriver::Options.chrome
options.detach = true
$driver = Selenium::WebDriver.for :chrome, options: options


# Enters a word to the current row
#
# Paramiters:
# - str: the string that is going to be entered
#
# Returns: void
def enterWord(str)
  arr = [["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"], ["A", "S", "D", "F", "G", "H", "J", "K", "L"], [nil, "Z", "X", "C", "V", "B", "N", "M"]]
  xpathArr = Array.new

  $enterdWords << str
  $currentRow += 1

  # Calculate xPaths for chars in word
  str.each_char do |char|
    i = 0
    while i < arr.length
      if arr[i].include?(char)
        xpathArr << "/html/body/div[3]/div/div[4]/main/div[2]/div[#{i + 1}]/button[#{arr[i].find_index(char) + 1}]"
      end
      i += 1
    end
  end

  # Enter word
  xpathArr.each_entry do |xpath|
    $driver.find_element(:xpath, xpath).click
  end

  # Click enter
  $driver.find_element(:xpath, "/html/body/div[3]/div/div[4]/main/div[2]/div[3]/button[1]").click
end


# Gets the data-state (absent, present or correct) for all letters in current row
#
# Paramiters: void
#
# Returns: void
def getWordData()
  while $driver.find_element(:xpath, "/html/body/div[3]/div/div[4]/main/div[1]/div/div[#{$currentRow}]/div[5]/div").attribute("data-state") == "tbd"
  end

  # Add char to data-state array
  i = 0
  while i < 5
    letterData = $driver.find_element(:xpath, "/html/body/div[3]/div/div[4]/main/div[1]/div/div[#{$currentRow}]/div[#{i+1}]/div").attribute("data-state")
    if letterData == "correct"
      $correct[i] = $enterdWords[$currentRow-1][i]
      if $present.include?($enterdWords[$currentRow-1][i])
        $present.delete($enterdWords[$currentRow-1][i])
      end
    elsif letterData == "present" && !$present.include?($enterdWords[$currentRow-1][i])
      $present << $enterdWords[$currentRow-1][i]
    elsif letterData == "absent" && !$absent.include?($enterdWords[$currentRow-1][i]) && !$correct.include?($enterdWords[$currentRow-1][i]) && !$present.include?($enterdWords[$currentRow-1][i])
      $absent << $enterdWords[$currentRow-1][i]
    end

    i += 1
  end

  sleep 1
end

# Open Wordle
$driver.navigate.to "https://www.nytimes.com/games/wordle"

# Navigate to the game (and avoid cookies)
wait = Selenium::WebDriver::Wait.new(:timeout => 10)
search_button = wait.until{$driver.find_element(:xpath, "/html/body/div[1]/div/div[2]/div/div/div/div[3]/div[1]/button[1]")}
$driver.manage.timeouts.implicit_wait = 1

$driver.find_element(:xpath, "/html/body/div[1]/div/div[2]/div/div/div/div[3]/div[1]/button[1]").click
$driver.find_element(:xpath, "/html/body/div[4]/div/div/button").click
$driver.find_element(:xpath, "/html/body/div[3]/div/div/div/div/div[2]/button[3]").click

$driver.manage.timeouts.implicit_wait = 1
$driver.find_element(:xpath, "/html/body/div[3]/div/dialog/div/div/button").click

footer = $driver.find_element(:xpath, "/html/body/div[3]/div/footer")
$driver.action.scroll_to(footer).perform

# Play the game
i = 0
while i < 6 && $correct.include?(nil)
  enterWord(wordGuesser($correct, $present, $absent, $enterdWords))
  getWordData()

  i += 1
end