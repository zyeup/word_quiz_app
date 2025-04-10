try_count = 5
array = ["apple", "banana", "desk", "pin", "yesterday", "application", "ox", "account", "solution", "validation"]
ans_index = rand(0...array.size)
ans = array[ans_index].split("")
result_array = Array.new(ans.size, "_")
result_index = []


def str_input
  valid_flg = false
  while valid_flg == false
    input = gets.chomp.downcase
    if input.size == 1 && input.match?(/[a-zA-Z]/)
      valid_flg = true
    else
      valid_flg = false
    end
  end
  input
end

puts result_array.join
puts try_count

while
  input = str_input
  match_flg = false

  ans.each_with_index do |char, i|
    if char == input && result_array[i] != ans[i]
      result_index << i
      match_flg = true
    end
  end

  if match_flg == false
    try_count -= 1
  end


  result_index.each do |num|
    result_array[num] = ans[num]
  end


  #終わりの処理
  puts result_array.join
  puts try_count

  #成功パターン
  unless result_array.join.include?("_")
    puts "成功です。ゲームを終了します"
    exit
  end

  #失敗パターン
  if try_count == 0
    puts "残り失敗可能回数が0になったので、ゲームを終了します"
    exit
  end
end
