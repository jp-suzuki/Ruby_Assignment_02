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
  #--- 学習メモ ---
  # C言語の3項演算子と同様の処理が行われる
  # 使い方次第では便利だが、可読性が悪くなりやすい点から禁止されることが多い？
  #---------------
  puts "1:グー 2:チョキ 3:パー 0:戦わない"
  print "> "
  player_hand = Integer(gets, exception:false)
  if (0...JANKEN_HAND.length)&.include?(player_hand)
    #--- 学習メモ ---
    # include?は範囲オブジェクトの中に含まれるかを判定できる
    # その他には配列や文字列なども参照し、判定できる
    # 正式には「Enumerableモジュールを実装しているオブジェクト」が対象になる、らしい
    #---------------
    # &.は「セーフ・ナビゲーション演算子」と呼び、左辺がnilでないときだけ右のメソッドを実行する
    # 左辺がnilだった場合は、そのまま何もしないため、nilが返ってくる
    # 変数.&オブジェクト != nil は 変数 != nilで十分だし、
    # if 変数.&オブジェクト == a, elsif 変数.&オブジェクト…の形はcaseを使うのであまり木にする必要はない？
    #---------------
    if player_hand == 0 # 0(出さない)を選択した時にだけ、ループを抜ける
      puts "> #{JANKEN_HAND[player_hand]}"
      break
    else
      cpu_hand = rand(1..3)
      #--- 学習メモ ---
      # Rubyでは、乱数の種を設定しなかった場合、現在時刻等を参考に自動で種が生成される。
      # rand(3)は、0,1,2の'3つ'の整数から選ばれる
      # rand(1..3)と記述すると、1,2,3の中から選ばれる
      #---------------
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
      #--- 学習メモ ---
      # between?は範囲オブジェクトのみを判定する
      # このとき、引数の(0, 5)は(0..5)として扱っている
      # そのため、between?(1..5)や、range=1..5 between?(range)のような記述も可能
      #---------------
      # sampleメソッドは対象からランダムに要素を抜き出す
      # sample(3)のように引数を指定すると、ランダムに3回抜き出し、配列に格納する
      # 応用として、.uniq.sample(3)のように記述すると、重複を回避できる（くじ引きのイメージ）
      # また、include?同様にEnumerableモジュールが関係している
      #---------------
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
        #--- 学習メモ ---
        # !をつけるとbooleanの値を反転することが出来る
        # そのほか、nil, 0, ""に適用したときはtrueを返す
        #---------------
      end
      break
    else
      separator_line(15)
      range_error_message(1, DIRECTION.length)
    end
  end
  break if game_set
  #--- 学習メモ ---
  # if janken_result
  #   break
  # end
  # 上記コードの省略形、1行で記述する関係上elseが使えない
  #---------------
end