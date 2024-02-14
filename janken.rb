JANKEN_HAND = ["終了します", "グー", "チョキ", "パー"] # キーボード上0だけ離れているので0を終了に配置
DIRECTION = ["左", "上", "下", "右"] # 向きの順番はGoogle日本語入力の zh zj zk zl による
janken_result = nil
game_set = false

def separator_line(length)
  puts "-" * length
end
def range_error_message(minNum, maxNum)
  puts "#{minNum}〜#{maxNum}の数字で入力してください"
end

loop do
  puts (janken_result != 0 ? "じゃんけん…" : "あいこで…")
  puts "1:グー 2:チョキ 3:パー 0:戦わない"
  print "> "
  player_hand = Integer(gets, exception:false)
  if (0...JANKEN_HAND.length)&.include?(player_hand)
    if player_hand == 0 # 0(出さない)を選択した時にだけ、ループを抜ける
      puts "> #{JANKEN_HAND[player_hand]}"
      break
    else
      cpu_hand = rand(1..3)
      puts (janken_result != 0 ? "ぽん！" : "しょ！")
      puts "YOU:#{JANKEN_HAND[player_hand]}"
      puts "CPU:#{JANKEN_HAND[cpu_hand]}"
      separator_line(15)
    end
  else
    range_error_message(0, JANKEN_HAND.length - 1)
    separator_line(15)
    next 
  end
  janken_result = player_hand - cpu_hand
  if janken_result == 0 # あいこのときだけじゃんけん続行
    next
  end
  loop do
    puts "あっち向いて…"
    puts "1:左 2:上 3:下 4:右"
    print "> "
    player_direction = Integer(gets, exception:false)
    if player_direction&.between?(1, DIRECTION.length)
      cpu_direction = DIRECTION.sample
      puts "ほい！"
      puts "YOU:#{DIRECTION[player_direction - 1]}"
      puts "CPU:#{cpu_direction}"
      separator_line(15)
      if DIRECTION[player_direction - 1] == cpu_direction
        if janken_result == (-1 || 2) # じゃんけん入力番号を利用して勝敗判定
          puts "あなたの勝ちです！"
        else
          puts "あなたの負けです…"
        end
        separator_line(15)
        game_set = !game_set
      end
      break
    else
      range_error_message(1, DIRECTION.length)
      separator_line(15)
    end
  end
  break if game_set
end