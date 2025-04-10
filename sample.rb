WORDS = ["apple", "banana", "desk", "pin", "yesterday", "application", "ox", "account", "solution", "validation"]
ANS_INDEX = rand(0...WORDS.size)
ANS_ARRAY = WORDS[ANS_INDEX].split("")

def str_valid(input)
  if input.size == 1 && input.match?(/[a-zA-Z]/)
    true
  else
    false
  end
end

def str_input
  valid_flg = false
  while valid_flg == false
    input = gets.chomp.downcase
    valid_flg = str_valid(input)
  end
  input
end

def run_game
  try_count = 5
  result_index = []
  result_array = Array.new(ANS_ARRAY.size, "_")

  puts result_array.join
  puts try_count

  while
    input = str_input
    match_flg = false

    ANS_ARRAY.each_with_index do |char, i|
      if char == input && result_array[i] != ANS_ARRAY[i]
        result_index << i
        match_flg = true
      end
    end

    if match_flg == false
      try_count -= 1
    end


    result_index.each do |num|
      result_array[num] = ANS_ARRAY[num]
    end

    puts result_array.join
    puts try_count

    unless result_array.join.include?("_")
      puts "成功です。ゲームを終了します"
      exit
    end

    if try_count == 0
      puts "残り失敗可能回数が0になったので、ゲームを終了します"
      exit
    end
  end
end

if __FILE__ == $0
  run_game
end
