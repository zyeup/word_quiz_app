#アルファベット版
EASY_WORDS = ["desk", "pin", "ox", "age", "fish", "sun", "moon", "day", "hand", "head"]
NORMAL_WORDS = ["apple", "banana", "account", "table", "chair", "stick", "morning", "evening", "ground", "school"]
HARD_WORDS = ["yesterday", "application", "solution", "validation", "judgement", "illusion", "destination", "provision", "movement", "education"]

#日本語ひらがな版
EASY_HIRAGANA_WORDS = ["ごはん", "りんご", "たまご", "たいよう", "ばなな", "てれび", "ほん", "おわん", "わりばし", "とけい"]
NORMAL_HIRAGANA_WORDS = ["ほどうきょう", "りょうきん", "りょくちゃ", "おうだんほどう", "しんごうき", "すいはんき", "せんたくき", "れいぞうこ", "ぎじゅつしょ", "しおこしょう"]
HARD_HIRAGANA_WORDS = ["けんちょうしょざいち", "こんびにえんすすとあ", "すーぱーまーけっと", "もばいるばってりー", "こうとうきょういく", "かいせきりょうり", "かんきょうおせん", "きしょうえいせい", "ぜんこくたいかい", "うんどうしんけい"]

def str_valid(input, hiragana_flg)
  if hiragana_flg && input.match?(/[ぁ-ん]/) && input.size == 1
    true
  elsif !hiragana_flg && input.match?(/[a-zA-Z]/) && input.size == 1
    true
  else
    puts "他の文字種、または複数の文字が入力されたました。再度入力してください"
    false
  end
end

def str_input(hiragana_flg)
  valid_flg = false
  while valid_flg == false
    puts "入力してください"
    input = gets.chomp.downcase
    valid_flg = str_valid(input, hiragana_flg)
  end
  input
end

def version_select(version)
  if version == "y"
    puts ""
    puts "アルファベット版が選択されました"
    puts ""
    false
  else
    puts ""
    puts "日本語ひらがな版が選択されました"
    puts ""
    true
  end
end

def mode_select(mode, mode_flg, hiragana_flg)
  case mode
  when "easy"
    words = hiragana_flg ? EASY_HIRAGANA_WORDS : EASY_WORDS
    try_count = 10
    mode_flg = true
  when "normal"
    words = hiragana_flg ? NORMAL_HIRAGANA_WORDS : NORMAL_WORDS
    try_count = 8
    mode_flg = true
  when "hard"
    words = hiragana_flg ? HARD_HIRAGANA_WORDS : HARD_WORDS
    try_count = 5
    mode_flg = true
  else
    puts "もう一度入力してください。"
    puts ""
    mode_flg = false
  end
  return mode_flg, words, try_count
end

def run_game(try_count, ans_array, hiragana_flg)
  result_index = []
  result_array = Array.new(ans_array.size, "_")
  input_array = []
  run_flg = true

  puts ""
  puts "問題：#{result_array.join}"
  puts "残り失敗可能回数：#{try_count}"
  puts input_array.join(" ")
  puts ""

  while run_flg
    input_array << str_input(hiragana_flg)
    match_flg = false

    ans_array.each_with_index do |char, i|
      if char == input_array[-1] && result_array[i] == "_"
        result_index << i
        match_flg = true
      end
    end

    if match_flg == false
      try_count -= 1
    end

    result_index.each do |num|
      result_array[num] = ans_array[num]
    end

    puts ""
    puts "結果：#{result_array.join}"
    puts "残り失敗可能回数：#{try_count}"
    puts "これまで入力した単語：#{input_array.join(" ")}"
    puts ""

    unless result_array.join.include?("_")
      puts "成功です。ゲームを終了します"
      puts ""
      run_flg = false
    end

    if try_count == 0
      puts "残り失敗可能回数が0になったので、ゲームを終了します"
      puts "正解は、「#{ans_array.join("")}」でした。"
      puts ""
      run_flg = false
    end
  end
end

# 実行部分
if __FILE__ == $0
  loop_flg = true
  ans = ""
  prev_ans = ""

  while loop_flg
    hiragana_flg = false
    mode_flg = false

    #バージョン選択
    puts ""
    puts "ゲームを始めます。"
    puts "アルファベット版で遊びたい場合は「y」を、日本語ひらがな版で遊びたい場合はそれ以外のキーを押してください。"
    version = gets.chomp
    hiragana_flg = version_select(version)

    #モード選択
    while mode_flg == false
      puts "モードを入力してください。「easy」 「normal」 「hard」"
      mode = gets.chomp
      mode_flg, words, try_count = mode_select(mode, mode_flg, hiragana_flg)
    end

    #答えは2回連続同じにならない
    while ans == prev_ans
      ans_index = rand(0...words.size)
      ans = words[ans_index]
    end
    ans_array = ans.split("")

    #ゲームの実行
    run_game(try_count, ans_array, hiragana_flg)

    puts "もう一度遊びたい場合は「y」を、終了する場合はそれ以外のキーを押してください。"
    input = gets.chomp
    if input == "y"
      prev_ans = ans
    else
      loop_flg = false
      puts "ゲームを終了します。"
    end
  end
end
