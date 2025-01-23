# File: wordSort.rb
# Author: Arvid Möller
# Date: 2025-01-23
# Description: This program adds words from addWords.txt (if they aren't already in words.txt) and then sorts all words in words.txt file based on how common their letters are.
# Requried files: words.txt, sortedWords.txt, addWords.txt
# Requried gems: void

# Sorts array of words based on their points using quickSort.
#
# Paramiters:
# - arr: The array that si going to be sorted. Stucture of array: [[word1, points2], [word2, points2], [word3, points3]].
#
# Returns: The array with all words sorted based on points.
def sort(arr)
  if arr.length > 1
    pivot = arr[0]
    arr.delete_at(0)

    sArr1 = Array.new
    sArr2 = Array.new

    arr.each do |e|
      if e[1] < pivot[1]
        sArr1 << e
      else
        sArr2 << e
      end
    end

    return (sort(sArr1) << pivot).concat(sort(sArr2))
  else
    return arr
  end
end

# Adds words from addWords.txt to words.txt if they aren't already in words.txt
#
# Paramiters: void
#
# Returns: void
def checkWords()
  wordArr = File.readlines("words.txt")
  addArr = Array.new
  
  wordArr.each do |word|
    word.chomp
  end

  File.open("addWords.txt", "r") do |file|
    file.each_line do |word|
      word.chomp!.upcase!
      p word
      if !wordArr.include?(word)
        addArr << word
      end
    end
  end

  File.open("words.txt", "w") do |file|
    addArr.each_entry do |e|
      file.write(e, "\n")
    end
  end
end

# Gives all words in words.txt file points based on how common their letters are. sort() funciton is then called to sort the words so they can be enterd in the sortedWords.txt file.
#
# Paramiters: void
#
# Returns: void
def wordSort()
  letterArr = ["E","A","R","I","O","T","N","S","L","C","U","D","P","M","H","G","B","F","Y","W","K","V","X","Z","J","Q"]
  wordPointArr = Array.new
  sortedArr = Array.new

  if File.exist?("words.txt")
    File.open("words.txt", "r") do |file|
      file.each_entry do |word|
        wordArr = [nil, 0]
        wordArr[0] = word.chomp!
        
        wordArr[0].each_char do |currentLetter|
          wordArr[1] += letterArr.find_index(currentLetter)
        end

        wordPointArr << wordArr
        
      end
    end
  else
    puts "words.txt file does not exist in directory"
  end

  sortedArr = sort(wordPointArr)

  if File.exist?("sortedWords.txt")
    File.open("SortedWords.txt", "w") do |file|
      sortedArr.each_entry do |e|
        file.write(e[0], "\n")
      end
    end
  else
    puts "sortedWords.txt file does not exist in directory"
  end
end


checkWords()
wordSort()