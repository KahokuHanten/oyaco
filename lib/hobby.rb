class Hobby
  @@hobbys = %w{ 油絵 編み物 イラスト 歌
  エアブラシ 映画撮影 江戸切子 折り紙
  オープンコーラ 回路作成 紙飛行機 革細工
  機械加工 切り絵 魚拓 クイリング
  グラフィティアート 消しゴムはんこ コンピュータミシン 茶道
  刺繍 写経 写真・カメラ 写真加工
  シャドウボックス 手芸・ハンドクラフト 食品サンプル 書道
  ジオラマ 人物画 水彩画 水墨画
  スクラップブック 砂の城づくり 3Dコンピュータグラフィックス セミナー
  彫刻 DTP デコレーション携帯電話・デコ電 デッサン
  電子工作 電子書籍出版 陶芸 似顔絵
  日曜大工・DIY ニードルポイント 塗り絵 ネイルアート
  粘土 剥製 ハードウェアハッキング バルーンアート
  パステル画 パラパラ漫画 ビーズ細工 不可能ボトル
  プラモデル プリザーブドフラワー ヘナタトゥー ペーパークラフト
  ボトルシップ 盆栽 ポートレート写真 マッチ棒アート
  漫画描き 模型 羊毛フェルト
  合気道 アイススケート ウォーキング F1
  カイト 空手 キャッチボール 弓道
  筋力トレーニング・ボディビルディング 剣道 ゲートボール ゴルフ
  サバイバルゲーム 散歩 サーフィン 射撃
  シュノーケリング ジェットスキー 自転車・サイクリング ジャズダンス
  柔道 重量挙げ 乗馬 水泳
  水上スキー スカイダイビング スカッシュ スキューバーダイビング
  スキー スケートボード スノーモービル スラックライン
  セーリング ソフトボール 太極拳 卓球
  ダーツ ツーリング テニス 登山
  トライアスロン 洞窟探検・ケイビング ドッグスポーツ ネットボール
  ハンドボール バイク バスケットボール バッティングセンター
  バトントワリング バドミントン バブルサッカー バレエ
  バレーボール パラグライダー ビリヤード フェンシング
  フットサル フラフープ フロアボール ボウリング
  ボクシング ボルダリング マラソン モトクロス
  野球・草野球 ヨガ ヨーヨー ラインダンス
  ラクロス ラフティング レスリング レーシングカート
  ロードバイク・ロードレース
  アニメ 囲碁 インターネットラジオ 映画鑑賞
  絵本 お笑い オンラインゲーム 絵画収集
  競馬 けん玉 ゲームセンター 骨董品
  サッカー観戦 将棋 ジグソーパズル ジャグリング
  人狼 水族館 宝くじ タングラム
  チェス 知恵の輪 鉄道 テディベア
  テトリス テレビゲーム ディズニーランド DVD・ブルーレイ鑑賞
  特撮 時計 トランプ トレーディングカードゲーム
  動物園 ドミノ倒し ドライブ ドラマ鑑賞
  ニコニコ動画 2ちゃんねる 花火 花札
  パチンコ 腹話術 プロレス観戦 ペン回し
  ボードゲーム マジック 麻雀 明晰夢
  メダルゲーム ものまね 野球観戦 野球カード
  遊園地 Ustream Youtube UFOキャッチャー
  落語 ラジオ鑑賞 ラジコン ルービックキューブ
  レゴブロック 路上パフォーマンス
  犬飼育 インテリア ウィンドウショッピング 腕時計収集
  占い お灸 オフ会 温泉旅行
  オークション 海外旅行 家族と過ごす 家庭教師
  家庭菜園 カラーコーディネート ガーデニング 着付け
  キャンプ 献血 懸賞 コミュニケーション
  サウナ 手話 小動物 植物採集
  睡眠 スクーター 整理整頓 世界遺産
  速読 タロット占い チャット 手相占い
  天文学 鳥飼育 日記・ブログ 猫飼育
  ネットショッピング 農業 飲み会 葉巻
  ハンドバッグ集め バックパッカー バードウォッチング 一人旅
  日焼け ファッション 風水 フリーマーケット
  古着 ブッククロッシング 文房具 ホエールウォッチング
  ホームオートメーション ボランティア メイク 名刺収集
  ライフキャスティング ラジオ体操 歴史めぐり 朗読 }

  attr_accessor :name

  def self.build(name)
    hobby = self.new
    hobby.name = name
    hobby
  end

  def self.all
    hs = []
    @@hobbys.each do |h|
      hs << self.build(h)
    end
    hs
  end
end
