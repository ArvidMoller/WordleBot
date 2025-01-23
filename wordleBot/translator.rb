def translate(str)
  arr = [["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"], ["A", "S", "D", "F", "G", "H", "J", "K", "L"], [nil, "Z", "X", "C", "V", "B", "N", "M"]]
  xpathArr = Array.new

  str.each_char do |char|
    i = 0
    while i < arr.length
      if arr[i].include?(char)
        xpathArr << "/html/body/div[3]/div/div[4]/main/div[1]/div/div[#{i + 1}]/div[#{arr[i].find_index(char) + 1}]/div"
      end
      i += 1
    end
  end

  return xpathArr
end

p translate("SOARE")