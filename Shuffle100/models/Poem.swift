//
//  poem.swift
//  Shuffle100
//
//  Created by 里 佳史 on 2017/04/16, with code generator "swift_poem_creator.rb".
//  Copyright © 2017年 里 佳史. All rights reserved.
//

import Foundation

struct Liner2Parts {
	var kami: String
	var shimo: String
}

struct Poem {
    let number: Int
    let poet: String
    let living_years: String
    let liner: [String]
    let in_hiragana: Liner2Parts
    let in_modern_kana: [String]
    let kimari_ji: String
}

class Poem100 {
    static let poems = [

        Poem(number: 1,
            poet: "天智天皇",
            living_years: "(626〜671)",
            liner: ["秋の田の", "かりほの庵の", "とまをあらみ", "我が衣手は", "露にぬれつつ"], 
            in_hiragana: Liner2Parts(
                kami: "あきのたのかりほのいほのとまをあらみ",
                shimo: "わかころもてはつゆにぬれつつ"
            ),
            in_modern_kana: ["あきのたの", "かりほのいおの", "とまをあらみ", "わがころもでは", "つゆにぬれつつ"],
            kimari_ji: "あきの"
        ),
        Poem(number: 2,
            poet: "持統天皇",
            living_years: "(645〜702)",
            liner: ["春過ぎて", "夏来にけらし", "白妙の", "衣干すてふ", "天の香具山"], 
            in_hiragana: Liner2Parts(
                kami: "はるすきてなつきにけらししろたへの",
                shimo: "ころもほすてふあまのかくやま"
            ),
            in_modern_kana: ["はるすぎて", "なつきにけらし", "しろたえの", "ころもほすちょう", "あまのかぐやま"],
            kimari_ji: "はるす"
        ),
        Poem(number: 3,
            poet: "柿本人丸",
            living_years: "(?〜710?)",
            liner: ["あしびきの", "山鳥の尾の", "しだり尾の", "ながながし夜を", "ひとりかもねむ"], 
            in_hiragana: Liner2Parts(
                kami: "あしひきのやまとりのをのしたりをの",
                shimo: "なかなかしよをひとりかもねむ"
            ),
            in_modern_kana: ["あしびきの", "やまどりのおの", "しだりおの", "ながながしよを", "ひとりかもねん"],
            kimari_ji: "あし"
        ),
        Poem(number: 4,
            poet: "山辺赤人",
            living_years: "(?〜737?)",
            liner: ["田子の浦に", "うち出てみれば", "白妙の", "富士のたかねに", "雪は降りつつ"], 
            in_hiragana: Liner2Parts(
                kami: "たこのうらにうちいててみれはしろたへの",
                shimo: "ふしのたかねにゆきはふりつつ"
            ),
            in_modern_kana: ["たごのうらに", "うちいでてみれば", "しろたえの", "ふじのたかねに", "ゆきはふりつつ"],
            kimari_ji: "たご"
        ),
        Poem(number: 5,
            poet: "猿丸大夫",
            living_years: "(?〜?)",
            liner: ["奥山に", "紅葉踏み分け", "鳴く鹿の", "声聞くときぞ", "秋はかなしき"], 
            in_hiragana: Liner2Parts(
                kami: "おくやまにもみちふみわけなくしかの",
                shimo: "こゑきくときそあきはかなしき"
            ),
            in_modern_kana: ["おくやまに", "もみじふみわけ", "なくしかの", "こえきくときぞ", "あきはかなしき"],
            kimari_ji: "おく"
        ),
        Poem(number: 6,
            poet: "中納言家持",
            living_years: "(718〜785)",
            liner: ["かささぎの", "渡せる橋に", "おく霜の", "白きを見れば", "夜ぞ更けにける"], 
            in_hiragana: Liner2Parts(
                kami: "かささきのわたせるはしにおくしもの",
                shimo: "しろきをみれはよそふけにける"
            ),
            in_modern_kana: ["かささぎの", "わたせるはしに", "おくしもの", "しろきをみれば", "よぞふけにける"],
            kimari_ji: "かさ"
        ),
        Poem(number: 7,
            poet: "阿倍仲麻呂",
            living_years: "(698〜770)",
            liner: ["天の原", "ふりさけみれば", "春日なる", "三笠の山に", "いでし月かも"], 
            in_hiragana: Liner2Parts(
                kami: "あまのはらふりさけみれはかすかなる",
                shimo: "みかさのやまにいてしつきかも"
            ),
            in_modern_kana: ["あまのはら", "ふりさけみれば", "かすがなる", "みかさのやまに", "いでしつきかも"],
            kimari_ji: "あまの"
        ),
        Poem(number: 8,
            poet: "喜撰法師",
            living_years: "(?〜?)",
            liner: ["我が庵は", "都のたつみ", "しかぞ住む", "世をうぢ山と", "人はいふなり"], 
            in_hiragana: Liner2Parts(
                kami: "わかいほはみやこのたつみしかそすむ",
                shimo: "よをうちやまとひとはいふなり"
            ),
            in_modern_kana: ["わがいおは", "みやこのたつみ", "しかぞすむ", "よをうじやまと", "ひとはいうなり"],
            kimari_ji: "わがい"
        ),
        Poem(number: 9,
            poet: "小野小町",
            living_years: "(?〜?)",
            liner: ["花の色は", "移りにけりな", "いたづらに", "我が身世にふる", "ながめせしまに"], 
            in_hiragana: Liner2Parts(
                kami: "はなのいろはうつりにけりないたつらに",
                shimo: "わかみよにふるなかめせしまに"
            ),
            in_modern_kana: ["はなのいろは", "うつりにけりな", "いたずらに", "わがみよにふる", "ながめせしまに"],
            kimari_ji: "はなの"
        ),
        Poem(number: 10,
            poet: "蝉丸",
            living_years: "(?〜?)",
            liner: ["これやこの", "行くも帰るも", "別れつつ", "知るも知らぬも", "逢坂の関"], 
            in_hiragana: Liner2Parts(
                kami: "これやこのゆくもかへるもわかれては",
                shimo: "しるもしらぬもあふさかのせき"
            ),
            in_modern_kana: ["これやこの", "ゆくもかえるも", "わかれては", "しるもしらぬも", "おうさかのせき"],
            kimari_ji: "これ"
        ),
        Poem(number: 11,
            poet: "参議篁",
            living_years: "(802〜852)",
            liner: ["和田の原", "八十島かけて", "漕ぎ出ぬと", "人にはつげよ", "あまのつりぶね"], 
            in_hiragana: Liner2Parts(
                kami: "わたのはらやそしまかけてこきいてぬと",
                shimo: "ひとにはつけよあまのつりふね"
            ),
            in_modern_kana: ["わたのはら", "やそしまかけて", "こぎいでぬと", "ひとにはつげよ", "あまのつりぶね"],
            kimari_ji: "わたのはら　や"
        ),
        Poem(number: 12,
            poet: "僧正遍昭",
            living_years: "(816〜890)",
            liner: ["あまつ風", "雲の通ひ路", "吹きとぢよ", "乙女の姿", "しばしとどめむ"], 
            in_hiragana: Liner2Parts(
                kami: "あまつかせくものかよひちふきとちよ",
                shimo: "をとめのすかたしはしととめむ"
            ),
            in_modern_kana: ["あまつかぜ", "くものかよいじ", "ふきとじよ", "おとめのすがた", "しばしとどめん"],
            kimari_ji: "あまつ"
        ),
        Poem(number: 13,
            poet: "陽成院",
            living_years: "(868〜949)",
            liner: ["つくばねの", "峰より落つる", "みなの川", "恋ぞつもりて", "淵となりける"], 
            in_hiragana: Liner2Parts(
                kami: "つくはねのみねよりおつるみなのかわ",
                shimo: "こひそつもりてふちとなりぬる"
            ),
            in_modern_kana: ["つくばねの", "みねよりおつる", "みなのがわ", "こいぞつもりて", "ふちとなりぬる"],
            kimari_ji: "つく"
        ),
        Poem(number: 14,
            poet: "河原左大臣",
            living_years: "(822〜895)",
            liner: ["陸奥の", "しのぶもぢずり", "誰ゆゑに", "乱れそめにし", "我ならなくに"], 
            in_hiragana: Liner2Parts(
                kami: "みちのくのしのふもちすりたれゆゑに",
                shimo: "みたれそめにしわれならなくに"
            ),
            in_modern_kana: ["みちのくの", "しのぶもじずり", "たれゆえに", "みだれそめにし", "われならなくに"],
            kimari_ji: "みち"
        ),
        Poem(number: 15,
            poet: "光孝天皇",
            living_years: "(830〜887)",
            liner: ["君がため", "春の野に出て", "若菜つむ", "我が衣手に", "雪はふりつつ"], 
            in_hiragana: Liner2Parts(
                kami: "きみかためはるののにいててわかなつむ",
                shimo: "わかころもてにゆきはふりつつ"
            ),
            in_modern_kana: ["きみがため", "はるののにいでて", "わかなつむ", "わがころもでに", "ゆきはふりつつ"],
            kimari_ji: "きみがため　は"
        ),
        Poem(number: 16,
            poet: "中納言行平",
            living_years: "(818〜893)",
            liner: ["立ち別れ", "いなばの山の", "峰におふる", "まつとしきかば", "今帰りこむ"], 
            in_hiragana: Liner2Parts(
                kami: "たちわかれいなはのやまのみねにおふる",
                shimo: "まつとしきかはいまかへりこむ"
            ),
            in_modern_kana: ["たちわかれ", "いなばのやまの", "みねにおうる", "まつとしきかば", "いまかえりこん"],
            kimari_ji: "たち"
        ),
        Poem(number: 17,
            poet: "在原業平朝臣",
            living_years: "(825〜880)",
            liner: ["ちはやぶる", "神代もきかず", "龍田川", "からくれなゐに", "水くぐるとは"], 
            in_hiragana: Liner2Parts(
                kami: "ちはやふるかみよもきかすたつたかは",
                shimo: "からくれなゐにみつくくるとは"
            ),
            in_modern_kana: ["ちはやぶる", "かみよもきかず", "たつたがわ", "からくれないに", "みずくくるとは"],
            kimari_ji: "ちは"
        ),
        Poem(number: 18,
            poet: "藤原敏行朝臣",
            living_years: "(?〜901?)",
            liner: ["住の江の", "岸による波", "よるさへや", "夢の通ひ路", "人めよくらむ"], 
            in_hiragana: Liner2Parts(
                kami: "すみのえのきしによるなみよるさへや",
                shimo: "ゆめのかよひちひとめよくらむ"
            ),
            in_modern_kana: ["すみのえの", "きしによるなみ", "よるさえや", "ゆめのかよいじ", "ひとめよくらん"],
            kimari_ji: "す"
        ),
        Poem(number: 19,
            poet: "伊勢",
            living_years: "(874〜938?)",
            liner: ["難波がた", "短き葦の", "ふしの間も", "逢はでこの世を", "過してよとや"], 
            in_hiragana: Liner2Parts(
                kami: "なにはかたみしかきあしのふしのまも",
                shimo: "あはてこのよをすくしてよとや"
            ),
            in_modern_kana: ["なにわがた", "みじかきあしの", "ふしのまも", "あわでこのよを", "すぐしてよとや"],
            kimari_ji: "なにわが"
        ),
        Poem(number: 20,
            poet: "元良親王",
            living_years: "(890〜943)",
            liner: ["わびぬれば", "今はた同じ", "難波なる", "身をつくしても", "逢はむとぞ思ふ"], 
            in_hiragana: Liner2Parts(
                kami: "わひぬれはいまはたおなしなにはなる",
                shimo: "みをつくしてもあはむとそおもふ"
            ),
            in_modern_kana: ["わびぬれば", "いまはたおなじ", "なにわなる", "みをつくしても", "あわんとぞおもう"],
            kimari_ji: "わび"
        ),
        Poem(number: 21,
            poet: "素性法師",
            living_years: "(844〜909?)",
            liner: ["今こむと", "いひしばかりに", "長月の", "有明の月を", "待ちいでつるかな"], 
            in_hiragana: Liner2Parts(
                kami: "いまこむといひしはかりになかつきの",
                shimo: "ありあけのつきをまちいてつるかな"
            ),
            in_modern_kana: ["いまこんと", "いいしばかりに", "ながつきの", "ありあけのつきを", "まちいでつるかな"],
            kimari_ji: "いまこ"
        ),
        Poem(number: 22,
            poet: "文屋康秀",
            living_years: "(?〜879?)",
            liner: ["吹くからに", "秋の草木の", "しほるれば", "むべ山風を", "嵐といふらむ"], 
            in_hiragana: Liner2Parts(
                kami: "ふくからにあきのくさきのしをるれは",
                shimo: "むへやまかせをあらしといふらむ"
            ),
            in_modern_kana: ["ふくからに", "あきのくさきの", "しおるれば", "むべやまかぜを", "あらしというらん"],
            kimari_ji: "ふ"
        ),
        Poem(number: 23,
            poet: "大江千里",
            living_years: "(?〜903?)",
            liner: ["月みれば", "千々に物こそ", "悲しけれ", "我が身ひとつの", "秋にはあらねど"], 
            in_hiragana: Liner2Parts(
                kami: "つきみれはちちにものこそかなしけれ",
                shimo: "わかみひとつのあきにはあらねと"
            ),
            in_modern_kana: ["つきみれば", "ちぢにものこそ", "かなしけれ", "わがみひとつの", "あきにはあらねど"],
            kimari_ji: "つき"
        ),
        Poem(number: 24,
            poet: "菅家",
            living_years: "(845〜903)",
            liner: ["このたびは", "幣もとりあへず", "手向山", "紅葉の錦", "神のまにまに"], 
            in_hiragana: Liner2Parts(
                kami: "このたひはぬさもとりあへすたむけやま",
                shimo: "もみちのにしきかみのまにまに"
            ),
            in_modern_kana: ["このたびは", "ぬさもとりあえず", "たむけやま", "もみじのにしき", "かみのまにまに"],
            kimari_ji: "この"
        ),
        Poem(number: 25,
            poet: "三条右大臣",
            living_years: "(873〜932)",
            liner: ["名にしおはば", "逢坂山の", "さねかづら", "人に知られで", "くるよしもがな"], 
            in_hiragana: Liner2Parts(
                kami: "なにしおははあふさかやまのさねかつら",
                shimo: "ひとにしられてくるよしもかな"
            ),
            in_modern_kana: ["なにしおわば", "おうさかやまの", "さねかずら", "ひとにしられで", "くるよしもがな"],
            kimari_ji: "なにし"
        ),
        Poem(number: 26,
            poet: "貞信公",
            living_years: "(880〜949)",
            liner: ["小倉山", "峰の紅葉ば", "心あらば", "今ひとたびの", "みゆきまたなむ"], 
            in_hiragana: Liner2Parts(
                kami: "をくらやまみねのもみちはこころあらは",
                shimo: "いまひとたひのみゆきまたなむ"
            ),
            in_modern_kana: ["おぐらやま", "みねのもみじば", "こころあらば", "いまひとたびの", "みゆきまたなん"],
            kimari_ji: "おぐ"
        ),
        Poem(number: 27,
            poet: "中納言兼輔",
            living_years: "(877〜933)",
            liner: ["みかの原", "わきて流るる", "泉河", "いつ見きとてか", "恋しかるらむ"], 
            in_hiragana: Liner2Parts(
                kami: "みかのはらわきてなかるるいつみかは",
                shimo: "いつみきとてかこひしかるらむ"
            ),
            in_modern_kana: ["みかのはら", "わきてながるる", "いずみがわ", "いつみきとてか", "こいしかるらん"],
            kimari_ji: "みかの"
        ),
        Poem(number: 28,
            poet: "源宗干朝臣",
            living_years: "(?〜939)",
            liner: ["山里は", "冬ぞ寂しさ", "まさりける", "人めも草も", "かれぬと思へば"], 
            in_hiragana: Liner2Parts(
                kami: "やまさとはふゆそさびしさまさりける",
                shimo: "ひとめもくさもかれぬとおもへは"
            ),
            in_modern_kana: ["やまざとは", "ふゆぞさびしさ", "まさりける", "ひとめもくさも", "かれぬとおもえば"],
            kimari_ji: "やまざ"
        ),
        Poem(number: 29,
            poet: "凡河内躬恒",
            living_years: "(?〜925?)",
            liner: ["心あてに", "折らばや折らむ", "初霜の", "おきまどはせる", "白菊の花"], 
            in_hiragana: Liner2Parts(
                kami: "こころあてにおらはやおらむはつしもの",
                shimo: "おきまとはせるしらきくのはな"
            ),
            in_modern_kana: ["こころあてに", "おらばやおらん", "はつしもの", "おきまどわせる", "しらぎくのはな"],
            kimari_ji: "こころあ"
        ),
        Poem(number: 30,
            poet: "壬生忠岑",
            living_years: "(?〜907?)",
            liner: ["有明の", "つれなく見えし", "別れより", "暁ばかり", "うきものはなし"], 
            in_hiragana: Liner2Parts(
                kami: "ありあけのつれなくみえしわかれより",
                shimo: "あかつきはかりうきものはなし"
            ),
            in_modern_kana: ["ありあけの", "つれなくみえし", "わかれより", "あかつきばかり", "うきものはなし"],
            kimari_ji: "ありあ"
        ),
        Poem(number: 31,
            poet: "坂上是則",
            living_years: "(?〜924?)",
            liner: ["朝ぼらけ", "有明の月と", "見るまでに", "吉野の里に", "降れる白雪"], 
            in_hiragana: Liner2Parts(
                kami: "あさほらけありあけのつきとみるまてに",
                shimo: "よしののさとにふれるしらゆき"
            ),
            in_modern_kana: ["あさぼらけ", "ありあけのつきと", "みるまでに", "よしののさとに", "ふれるしらゆき"],
            kimari_ji: "あさぼらけ　あ"
        ),
        Poem(number: 32,
            poet: "春道列樹",
            living_years: "(?〜920)",
            liner: ["山川に", "風のかけたる", "しがらみは", "流れもあへぬ", "紅葉なりけり"], 
            in_hiragana: Liner2Parts(
                kami: "やまかはにかせのかけたるしからみは",
                shimo: "なかれもあへぬもみちなりけり"
            ),
            in_modern_kana: ["やまがわに", "かぜのかけたる", "しがらみは", "ながれもあえぬ", "もみじなりけり"],
            kimari_ji: "やまが"
        ),
        Poem(number: 33,
            poet: "紀友則",
            living_years: "(?〜905?)",
            liner: ["ひさかたの", "光のどけき", "春の日に", "しづ心なく", "花の散るらむ"], 
            in_hiragana: Liner2Parts(
                kami: "ひさかたのひかりのとけきはるのひに",
                shimo: "しつこころなくはなのちるらむ"
            ),
            in_modern_kana: ["ひさかたの", "ひかりのどけき", "はるのひに", "しずこころなく", "はなのちるらん"],
            kimari_ji: "ひさ"
        ),
        Poem(number: 34,
            poet: "藤原興風",
            living_years: "(?〜913?)",
            liner: ["誰をかも", "知る人にせむ", "高砂の", "松も昔の", "友ならなくに"], 
            in_hiragana: Liner2Parts(
                kami: "たれをかもしるひとにせむたかさこの",
                shimo: "まつもむかしのともならなくに"
            ),
            in_modern_kana: ["たれをかも", "しるひとにせん", "たかさごの", "まつもむかしの", "ともならなくに"],
            kimari_ji: "たれ"
        ),
        Poem(number: 35,
            poet: "紀貫之",
            living_years: "(872〜945?)",
            liner: ["人はいさ", "心も知らず", "故郷は", "花ぞ昔の", "かに匂ひける"], 
            in_hiragana: Liner2Parts(
                kami: "ひとはいさこころもしらすふるさとは",
                shimo: "はなそむかしのかににほひける"
            ),
            in_modern_kana: ["ひとはいさ", "こころもしらず", "ふるさとは", "はなぞむかしの", "かににおいける"],
            kimari_ji: "ひとは"
        ),
        Poem(number: 36,
            poet: "清原深養父",
            living_years: "(?〜930?)",
            liner: ["夏の夜は", "まだ宵ながら", "明けぬるを", "雲のいづくに", "月宿るらむ"], 
            in_hiragana: Liner2Parts(
                kami: "なつのよはまたよひなからあけぬるを",
                shimo: "くものいつこにつきやとるらむ"
            ),
            in_modern_kana: ["なつのよは", "まだよいながら", "あけぬるを", "くものいずこに", "つきやどるらん"],
            kimari_ji: "なつ"
        ),
        Poem(number: 37,
            poet: "文屋朝康",
            living_years: "(?〜902?)",
            liner: ["白露に", "風の吹きしく", "秋の野は", "つらぬきとめぬ", "玉ぞ散りける"], 
            in_hiragana: Liner2Parts(
                kami: "しらつゆにかせのふきしくあきののは",
                shimo: "つらぬきとめぬたまそちりける"
            ),
            in_modern_kana: ["しらつゆに", "かぜのふきしく", "あきののは", "つらぬきとめぬ", "たまぞちりける"],
            kimari_ji: "しら"
        ),
        Poem(number: 38,
            poet: "右近",
            living_years: "(?〜966?)",
            liner: ["忘らるる", "身をば思はず", "誓ひてし", "人の命の", "惜しくもあるかな"], 
            in_hiragana: Liner2Parts(
                kami: "わすらるるみをはおもはすちかひてし",
                shimo: "ひとのいのちのをしくもあるかな"
            ),
            in_modern_kana: ["わすらるる", "みをばおもわず", "ちかいてし", "ひとのいのちの", "おしくもあるかな"],
            kimari_ji: "わすら"
        ),
        Poem(number: 39,
            poet: "参議等",
            living_years: "(880〜951)",
            liner: ["浅茅生の", "小野の篠原", "忍ぶれど", "あまりてなどか", "人の恋しき"], 
            in_hiragana: Liner2Parts(
                kami: "あさちふのをののしのはらしのふれと",
                shimo: "あまりてなとかひとのこひしき"
            ),
            in_modern_kana: ["あさぢうの", "おののしのはら", "しのぶれど", "あまりてなどか", "ひとのこいしき"],
            kimari_ji: "あさじ"
        ),
        Poem(number: 40,
            poet: "平兼盛",
            living_years: "(?〜990)",
            liner: ["忍ぶれど", "色に出にけり", "わが恋は", "物や思ふと", "人の問ふまで"], 
            in_hiragana: Liner2Parts(
                kami: "しのふれといろにいてにけりわかこひは",
                shimo: "ものやおもふとひとのとふまて"
            ),
            in_modern_kana: ["しのぶれど", "いろにいでにけり", "わがこいは", "ものやおもうと", "ひとのとうまで"],
            kimari_ji: "しの"
        ),
        Poem(number: 41,
            poet: "壬生忠見",
            living_years: "(?〜960?)",
            liner: ["恋すてふ", "我が名はまだき", "立ちにけり", "人知れずこそ", "思ひ初めしか"], 
            in_hiragana: Liner2Parts(
                kami: "こひすてふわかなはまたきたちにけり",
                shimo: "ひとしれすこそおもひそめしか"
            ),
            in_modern_kana: ["こいすちょう", "わがなはまだき", "たちにけり", "ひとしれずこそ", "おもいそめしか"],
            kimari_ji: "こい"
        ),
        Poem(number: 42,
            poet: "清原元輔",
            living_years: "(908〜990)",
            liner: ["契りきな", "かたみに袖を", "しぼりつつ", "末の松山", "波こさじとは"], 
            in_hiragana: Liner2Parts(
                kami: "ちきりきなかたみにそてをしほりつつ",
                shimo: "すゑのまつやまなみこさしとは"
            ),
            in_modern_kana: ["ちぎりきな", "かたみにそでを", "しぼりつつ", "すえのまつやま", "なみこさじとは"],
            kimari_ji: "ちぎりき"
        ),
        Poem(number: 43,
            poet: "権中納言敦忠",
            living_years: "(906〜943)",
            liner: ["あひ見ての", "後の心に", "くらぶれば", "昔は物を", "思はざりけり"], 
            in_hiragana: Liner2Parts(
                kami: "あひみてののちのこころにくらふれは",
                shimo: "むかしはものをおもはさりけり"
            ),
            in_modern_kana: ["あいみての", "のちのこころに", "くらぶれば", "むかしはものを", "おもわざりけり"],
            kimari_ji: "あい"
        ),
        Poem(number: 44,
            poet: "中納言朝忠",
            living_years: "(910〜966)",
            liner: ["逢ふ事の", "絶えてしなくは", "中々に", "人をも身をも", "恨みざらまし"], 
            in_hiragana: Liner2Parts(
                kami: "あふことのたえてしなくはなかなかに",
                shimo: "ひとをもみをもうらみさらまし"
            ),
            in_modern_kana: ["あうことの", "たえてしなくば", "なかなかに", "ひとをもみをも", "うらみざらまし"],
            kimari_ji: "おうこ"
        ),
        Poem(number: 45,
            poet: "謙徳公",
            living_years: "(924〜972)",
            liner: ["あはれとも", "いふべき人は", "思ほえで", "身のいたづらに", "なりぬべきかな"], 
            in_hiragana: Liner2Parts(
                kami: "あはれともいふへきひとはおもほえて",
                shimo: "みのいたつらになりぬへきかな"
            ),
            in_modern_kana: ["あわれとも", "いうべきひとは", "おもおえで", "みのいたずらに", "なりぬべきかな"],
            kimari_ji: "あわれ"
        ),
        Poem(number: 46,
            poet: "曾禰好忠",
            living_years: "(?〜1003?)",
            liner: ["由良の戸を", "渡る舟人", "かぢを絶え", "行くへも知らぬ", "恋の道かな"], 
            in_hiragana: Liner2Parts(
                kami: "ゆらのとをわたるふなひとかちをたえ",
                shimo: "ゆくへもしらぬこひのみちかな"
            ),
            in_modern_kana: ["ゆらのとを", "わたるふなびと", "かじをたえ", "ゆくえもしらぬ", "こいのみちかな"],
            kimari_ji: "ゆら　"
        ),
        Poem(number: 47,
            poet: "恵慶法師",
            living_years: "(?〜986?)",
            liner: ["八重葎", "しげれる宿の", "寂しきに", "人こそ見えね", "秋は来にけり"], 
            in_hiragana: Liner2Parts(
                kami: "やへむくらしけれるやとのさひしきに",
                shimo: "ひとこそみえねあきはきにけり"
            ),
            in_modern_kana: ["やえむぐら", "しげれるやどの", "さびしきに", "ひとこそみえね", "あきはきにけり"],
            kimari_ji: "やえ"
        ),
        Poem(number: 48,
            poet: "源重之",
            living_years: "(?〜1000?)",
            liner: ["風をいたみ", "岩うつ波の", "をのれのみ", "くだけて物を", "思ふころかな"], 
            in_hiragana: Liner2Parts(
                kami: "かせをいたみいはうつなみのおのれのみ",
                shimo: "くたけてものをおもふころかな"
            ),
            in_modern_kana: ["かぜをいたみ", "いわうつなみの", "おのれのみ", "くだけてものを", "おもうころかな"],
            kimari_ji: "かぜを"
        ),
        Poem(number: 49,
            poet: "大中臣能宣",
            living_years: "(921〜991)",
            liner: ["みかきもり", "衛士のたく火の", "夜は燃え", "昼は消えつつ", "物をこそ思へ"], 
            in_hiragana: Liner2Parts(
                kami: "みかきもりゑしのたくひのよるはもえ",
                shimo: "ひるはきえつつものをこそおもへ"
            ),
            in_modern_kana: ["みかきもり", "えじのたくひの", "よるはもえ", "ひるはきえつつ", "ものをこそおもえ"],
            kimari_ji: "みかき"
        ),
        Poem(number: 50,
            poet: "藤原義孝",
            living_years: "(954〜974)",
            liner: ["君がため", "惜しからざりし", "命さへ", "長くもがなと", "思ひぬるかな"], 
            in_hiragana: Liner2Parts(
                kami: "きみかためおしからさりしいのちさへ",
                shimo: "なかくもかなとおもひけるかな"
            ),
            in_modern_kana: ["きみがため", "おしからざりし", "いのちさえ", "ながくもがなと", "おもいけるかな"],
            kimari_ji: "きみがため　お"
        ),
        Poem(number: 51,
            poet: "藤原実方朝臣",
            living_years: "(?〜998)",
            liner: ["かくとだに", "えやはいぶきの", "さしも草", "さしも知らじな", "燃ゆる思ひを"], 
            in_hiragana: Liner2Parts(
                kami: "かくとたにえやはいふきのさしもくさ",
                shimo: "さしもしらしなもゆるおもひを"
            ),
            in_modern_kana: ["かくとだに", "えやはいぶきの", "さしもぐさ", "さしもしらじな", "もゆるおもいを"],
            kimari_ji: "かく"
        ),
        Poem(number: 52,
            poet: "藤原道信朝臣",
            living_years: "(972〜994)",
            liner: ["明けぬれば", "くるるものとは", "知りながら", "なほうらめしき", "朝ぼらけかな"], 
            in_hiragana: Liner2Parts(
                kami: "あけぬれはくるるものとはしりなから",
                shimo: "なほうらめしきあさほらけかな"
            ),
            in_modern_kana: ["あけぬれば", "くるるものとは", "しりながら", "なおうらめしき", "あさぼらけかな"],
            kimari_ji: "あけ"
        ),
        Poem(number: 53,
            poet: "右大将道綱母",
            living_years: "(?〜995)",
            liner: ["嘆きつつ", "ひとりぬる夜の", "明くるま", "いかに久しき", "ものとかはしる"], 
            in_hiragana: Liner2Parts(
                kami: "なけきつつひとりぬるよのあくるまは",
                shimo: "いかにひさしきものとかはしる"
            ),
            in_modern_kana: ["なげきつつ", "ひとりぬるよの", "あくるまは", "いかにひさしき", "ものとかはしる"],
            kimari_ji: "なげき"
        ),
        Poem(number: 54,
            poet: "儀同三司母",
            living_years: "(?〜996)",
            liner: ["わすれじの", "行末までは", "かたければ", "けふをかぎりの", "命ともがな"], 
            in_hiragana: Liner2Parts(
                kami: "わすれしのゆくすゑまてはかたけれは",
                shimo: "けふをかきりのいのちともかな"
            ),
            in_modern_kana: ["わすれじの", "ゆくすえまでは", "かたければ", "きょうをかぎりの", "いのちともがな"],
            kimari_ji: "わすれ"
        ),
        Poem(number: 55,
            poet: "大納言公任",
            living_years: "(966〜1041)",
            liner: ["滝の音は", "絶えて久しく", "なりぬれど", "名こそ流れて", "なほ聞こえけれ"], 
            in_hiragana: Liner2Parts(
                kami: "たきのおとはたえてひさしくなりぬれと",
                shimo: "なこそなかれてなほきこえけれ"
            ),
            in_modern_kana: ["たきのおとは", "たえてひさしく", "なりぬれど", "なこそながれて", "なおきこえけれ"],
            kimari_ji: "たき"
        ),
        Poem(number: 56,
            poet: "和泉式部",
            living_years: "(?〜1035?)",
            liner: ["あらざらむ", "この世のほかの", "思ひ出に", "今ひとたびの", "逢ふ事もがな"], 
            in_hiragana: Liner2Parts(
                kami: "あらさらむこのよのほかのおもひてに",
                shimo: "いまひとたひのあふこともかな"
            ),
            in_modern_kana: ["あらざらん", "このよのほかの", "おもいでに", "いまひとたびの", "あうこともがな"],
            kimari_ji: "あらざ"
        ),
        Poem(number: 57,
            poet: "紫式部",
            living_years: "(?〜1031?)",
            liner: ["めぐり逢ひて", "見しやそれとも", "わかぬまに", "雲がくれにし", "夜半の月影"], 
            in_hiragana: Liner2Parts(
                kami: "めくりあひてみしやそれともわかぬまに",
                shimo: "くもかくれにしよはのつきかけ"
            ),
            in_modern_kana: ["めぐりあいて", "みしやそれとも", "わかぬまに", "くもがくれにし", "よはのつきかな"],
            kimari_ji: "め"
        ),
        Poem(number: 58,
            poet: "大弐三位",
            living_years: "(?〜1078?)",
            liner: ["有馬山", "いなのささ原", "風吹けば", "いでそよ人を", "忘れやはする"], 
            in_hiragana: Liner2Parts(
                kami: "ありまやまゐなのささはらかせふけは",
                shimo: "いてそよひとをわすれやはする"
            ),
            in_modern_kana: ["ありまやま", "いなのささはら", "かぜふけば", "いでそよひとを", "わすれやはする"],
            kimari_ji: "ありま"
        ),
        Poem(number: 59,
            poet: "赤染衛門",
            living_years: "(?〜1041?)",
            liner: ["やすらはで", "ねなまし物を", "さよ更けて", "かたぶくまでの", "月を見しかな"], 
            in_hiragana: Liner2Parts(
                kami: "やすらはてねなましものをさよふけて",
                shimo: "かたふくまてのつきをみしかな"
            ),
            in_modern_kana: ["やすらわで", "ねなましものを", "さよふけて", "かたぶくまでの", "つきをみしかな"],
            kimari_ji: "やす"
        ),
        Poem(number: 60,
            poet: "小式部内侍",
            living_years: "(?〜1025)",
            liner: ["大江山", "いくのの道の", "遠ければ", "まだふみもみず", "天の橋立"], 
            in_hiragana: Liner2Parts(
                kami: "おほえやまいくののみちのとほけれは",
                shimo: "またふみもみすあまのはしたて"
            ),
            in_modern_kana: ["おおえやま", "いくののみちの", "とおければ", "まだふみもみず", "あまのはしだて"],
            kimari_ji: "おおえ"
        ),
        Poem(number: 61,
            poet: "伊勢大輔",
            living_years: "(?〜1060?)",
            liner: ["いにしへの", "奈良の都の", "八重桜", "けふ九重に", "匂ひぬるかな"], 
            in_hiragana: Liner2Parts(
                kami: "いにしへのならのみやこのやへさくら",
                shimo: "けふここのへににほひぬるかな"
            ),
            in_modern_kana: ["いにしえの", "ならのみやこの", "やえざくら", "きょうここのえに", "においぬるかな"],
            kimari_ji: "いに"
        ),
        Poem(number: 62,
            poet: "清少納言",
            living_years: "(?〜1027?)",
            liner: ["夜をこめて", "鳥の空音は", "はかるとも", "よに逢坂の", "関はゆるさじ"], 
            in_hiragana: Liner2Parts(
                kami: "よをこめてとりのそらねははかるとも",
                shimo: "よにあふさかのせきはゆるさし"
            ),
            in_modern_kana: ["よをこめて", "とりのそらねは", "はかるとも", "よにおうさかの", "せきはゆるさじ"],
            kimari_ji: "よを"
        ),
        Poem(number: 63,
            poet: "左京大夫道雅",
            living_years: "(992〜1054)",
            liner: ["今はただ", "思ひ絶えなむ", "とばかりを", "人づてならで", "いふよしもがな"], 
            in_hiragana: Liner2Parts(
                kami: "いまはたたおもひたえなむとはかりを",
                shimo: "ひとつてならていふよしもかな"
            ),
            in_modern_kana: ["いまはただ", "おもいたえなん", "とばかりを", "ひとずてならで", "いうよしもがな"],
            kimari_ji: "いまは"
        ),
        Poem(number: 64,
            poet: "権中納言定頼",
            living_years: "(995〜1045)",
            liner: ["朝ぼらけ", "宇治の川ぎり", "絶えだえに", "あらはれわたる", "瀬々の網代木"], 
            in_hiragana: Liner2Parts(
                kami: "あさほらけうちのかはきりたえたえに",
                shimo: "あらはれわたるせせのあしろき"
            ),
            in_modern_kana: ["あさぼらけ", "うじのかわぎり", "たえだえに", "あらわれわたる", "せぜのあじろぎ"],
            kimari_ji: "あさぼらけ　う"
        ),
        Poem(number: 65,
            poet: "相模",
            living_years: "(?〜1061?)",
            liner: ["恨みわび", "ほさぬ袖だに", "ある物を", "恋にくちなん", "名こそ惜しけれ"], 
            in_hiragana: Liner2Parts(
                kami: "うらみわひほさぬそてたにあるものを",
                shimo: "こひにくちなむなこそをしけれ"
            ),
            in_modern_kana: ["うらみわび", "ほさぬそでだに", "あるものを", "こいにくちなん", "なこそおしけれ"],
            kimari_ji: "うら"
        ),
        Poem(number: 66,
            poet: "大僧正行尊",
            living_years: "(1055〜1135)",
            liner: ["もろともに", "あはれと思へ", "山桜", "花よりほかに", "知る人もなし"], 
            in_hiragana: Liner2Parts(
                kami: "もろともにあはれとおもへやまさくら",
                shimo: "はなよりほかにしるひともなし"
            ),
            in_modern_kana: ["もろともに", "あわれとおもえ", "やまざくら", "はなよりほかに", "しるひともなし"],
            kimari_ji: "もろ"
        ),
        Poem(number: 67,
            poet: "周防内侍",
            living_years: "(?〜1109?)",
            liner: ["春の夜の", "夢ばかりなる", "手枕に", "かひなくたたむ", "名こそ惜しけれ"], 
            in_hiragana: Liner2Parts(
                kami: "はるのよのゆめはかりなるたまくらに",
                shimo: "かひなくたたむなこそをしけれ"
            ),
            in_modern_kana: ["はるのよの", "ゆめばかりなる", "たまくらに", "かいなくたたん", "なこそおしけれ"],
            kimari_ji: "はるの"
        ),
        Poem(number: 68,
            poet: "三条院",
            living_years: "(976〜1017)",
            liner: ["心にも", "あらでうき世にに", "ながらへば", "恋しかるべき", "夜半の月かな"], 
            in_hiragana: Liner2Parts(
                kami: "こころにもあらてうきよになからへは",
                shimo: "こひしかるへきよはのつきかな"
            ),
            in_modern_kana: ["こころにも", "あらでうきよに", "ながらえば", "こいしかるべき", "よわのつきかな"],
            kimari_ji: "こころに"
        ),
        Poem(number: 69,
            poet: "能因法師",
            living_years: "(988〜1051?)",
            liner: ["嵐吹く", "三室の山の", "紅葉ばは", "龍田の川の", "錦なりけり"], 
            in_hiragana: Liner2Parts(
                kami: "あらしふくみむろのやまのもみちはは",
                shimo: "たつたのかはのにしきなりけり"
            ),
            in_modern_kana: ["あらしふく", "みむろのやまの", "もみじばは", "たつたのかわの", "にしきなりけり"],
            kimari_ji: "あらし"
        ),
        Poem(number: 70,
            poet: "良暹法師",
            living_years: "(?〜1065?)",
            liner: ["寂しさに", "宿を立ち出て", "ながむれば", "いづくも同じ", "秋の夕暮れ"], 
            in_hiragana: Liner2Parts(
                kami: "さひしさにやとをたちいててなかむれは",
                shimo: "いつくもおなしあきのゆふくれ"
            ),
            in_modern_kana: ["さびしさに", "やどをたちいでて", "ながむれば", "いずこもおなじ", "あきのゆうぐれ"],
            kimari_ji: "さ"
        ),
        Poem(number: 71,
            poet: "大納言経信",
            living_years: "(1016〜1097)",
            liner: ["夕されば", "門田の稲葉", "おとづれて", "あしのまろやに", "秋風ぞ吹く"], 
            in_hiragana: Liner2Parts(
                kami: "ゆうされはかとたのいなはおとつれて",
                shimo: "あしのまろやにあきかせそふく"
            ),
            in_modern_kana: ["ゆうされば", "かどたのいなば", "おとずれて", "あしのまろやに", "あきかぜぞふく"],
            kimari_ji: "ゆう"
        ),
        Poem(number: 72,
            poet: "祐子内親王家紀伊",
            living_years: "(?〜1113?)",
            liner: ["音に聞く", "たかしの浜の", "あだ波は", "かけじや袖の", "ぬれもこそすれ"], 
            in_hiragana: Liner2Parts(
                kami: "おとにきくたかしのはまのあたなみは",
                shimo: "かけしやそてのぬれもこそすれ"
            ),
            in_modern_kana: ["おとにきく", "たかしのはまの", "あだなみは", "かけじやそでの", "ぬれもこそすれ"],
            kimari_ji: "おと"
        ),
        Poem(number: 73,
            poet: "前中納言匡房",
            living_years: "(1041〜1111)",
            liner: ["高砂の", "尾上の桜", "咲きにけり", "とやまの霞", "たたずもあらなむ"], 
            in_hiragana: Liner2Parts(
                kami: "たかさこのをのへのさくらさきにけり",
                shimo: "とやまのかすみたたすもあらなむ"
            ),
            in_modern_kana: ["たかさごの", "おのえのさくら", "さきにけり", "とやまのかすみ", "たたずもあらなん"],
            kimari_ji: "たか"
        ),
        Poem(number: 74,
            poet: "源俊頼朝臣",
            living_years: "(1055〜1129)",
            liner: ["うかりける", "人をはつせの", "山おろしよ", "はげしかれとは", "祈らぬ物を"], 
            in_hiragana: Liner2Parts(
                kami: "うかりけるひとをはつせのやまおろしよ",
                shimo: "はけしかれとはいのらぬものを"
            ),
            in_modern_kana: ["うかりける", "ひとをはつせの", "やまおろしよ", "はげしかれとは", "いのらぬものを"],
            kimari_ji: "うか"
        ),
        Poem(number: 75,
            poet: "藤原基俊",
            living_years: "(1060〜1142)",
            liner: ["契りおきし", "させもが露を", "命にて", "あはれことしの", "秋もいぬめり"], 
            in_hiragana: Liner2Parts(
                kami: "ちきりおきしさせもかつゆをいのちにて",
                shimo: "あはれことしのあきもいぬめり"
            ),
            in_modern_kana: ["ちぎりおきし", "させもがつゆを", "いのちにて", "あわれことしの", "あきもいぬめり"],
            kimari_ji: "ちぎりお"
        ),
        Poem(number: 76,
            poet: "法性寺入道前関白太政大臣",
            living_years: "(1117〜1164)",
            liner: ["和田の原", "漕ぎ出てみれば", "ひさかたの", "雲ゐにまがふ", "沖つ白波"], 
            in_hiragana: Liner2Parts(
                kami: "わたのはらこきいててみれはひさかたの",
                shimo: "くもゐにまかふおきつしらなみ"
            ),
            in_modern_kana: ["わたのはら", "こぎいでてみれば", "ひさかたの", "くもいにまごう", "おきつしらなみ"],
            kimari_ji: "わたのはら　こ"
        ),
        Poem(number: 77,
            poet: "崇徳院",
            living_years: "(1119〜1164)",
            liner: ["瀬をはやみ", "岩にせかるる", "滝川の", "われてもすゑに", "逢はむとぞ思ふ"], 
            in_hiragana: Liner2Parts(
                kami: "せをはやみいわにせかるるたきかはの",
                shimo: "われてもすゑにあはむとそおもふ"
            ),
            in_modern_kana: ["せをはやみ", "いわにせかるる", "たきがわの", "われてもすえに", "あわんとぞおもう"],
            kimari_ji: "せ"
        ),
        Poem(number: 78,
            poet: "源兼昌",
            living_years: "(?〜1128?)",
            liner: ["淡路島", "かよふ千鳥の", "鳴く声に", "いく夜ねざめぬ", "須磨の関守"], 
            in_hiragana: Liner2Parts(
                kami: "あはちしまかよふちとりのなくこゑに",
                shimo: "いくよねさめぬすまのせきもり"
            ),
            in_modern_kana: ["あわじしま", "かようちどりの", "なくこえに", "いくよねざめぬ", "すまのせきもり"],
            kimari_ji: "あわじ"
        ),
        Poem(number: 79,
            poet: "左京大夫顕輔",
            living_years: "(1090〜1155)",
            liner: ["秋風に", "たなびく雲の", "絶え間より", "もれいづる月の", "かげのさやけさ"], 
            in_hiragana: Liner2Parts(
                kami: "あきかせにたなひくくものたえまより",
                shimo: "もれいつるつきのかけのさやけさ"
            ),
            in_modern_kana: ["あきかぜに", "たなびくくもの", "たえまより", "もれいずるつきの", "かげのさやけさ"],
            kimari_ji: "あきか"
        ),
        Poem(number: 80,
            poet: "待賢門院堀河",
            living_years: "(?〜1146?)",
            liner: ["長からむ", "心も知らず", "黒髪の", "乱れてけさは", "物をこそ思へ"], 
            in_hiragana: Liner2Parts(
                kami: "なかからむこころもしらすくろかみの",
                shimo: "みたれてけさはものをこそおもへ"
            ),
            in_modern_kana: ["ながからん", "こころもしらず", "くろかみの", "みだれてけさは", "ものをこそおもえ"],
            kimari_ji: "ながか"
        ),
        Poem(number: 81,
            poet: "後徳大寺左大臣",
            living_years: "(1139〜1191)",
            liner: ["ほととぎす", "鳴きつるかたを", "ながむれば", "ただ有明の", "月ぞ残れる"], 
            in_hiragana: Liner2Parts(
                kami: "ほとときすなきつるかたをなかむれは",
                shimo: "たたありあけのつきそのこれる"
            ),
            in_modern_kana: ["ほととぎす", "なきつるかたを", "ながむれば", "ただありあけの", "つきぞのこれる"],
            kimari_ji: "ほ"
        ),
        Poem(number: 82,
            poet: "道因法師",
            living_years: "(1090〜1179?)",
            liner: ["思ひわび", "さても命は", "ある物を", "うきにたへぬは", "涙なりけり"], 
            in_hiragana: Liner2Parts(
                kami: "おもひわひさてもいのちはあるものを",
                shimo: "うきにたへぬはなみたなりけり"
            ),
            in_modern_kana: ["おもいわび", "さてもいのちは", "あるものを", "うきにたえぬは", "なみだなりけり"],
            kimari_ji: "おも"
        ),
        Poem(number: 83,
            poet: "皇太后宮大夫俊成",
            living_years: "(1114〜1204)",
            liner: ["世の中よ", "道こそなけれ", "思ひ入る", "山の奥にも", "鹿ぞ鳴くなる"], 
            in_hiragana: Liner2Parts(
                kami: "よのなかよみちこそなけれおもひいる",
                shimo: "やまのおくにもしかそなくなる"
            ),
            in_modern_kana: ["よのなかよ", "みちこそなけれ", "おもいいる", "やまのおくにも", "しかぞなくなる"],
            kimari_ji: "よのなかよ"
        ),
        Poem(number: 84,
            poet: "藤原清輔朝臣",
            living_years: "(1104〜1177)",
            liner: ["ながらへば", "またこのごろや", "しのばれむ", "うしと見し世ぞ", "いまは恋しき"], 
            in_hiragana: Liner2Parts(
                kami: "なからへはまたこのころやしのはれむ",
                shimo: "うしとみしよそいまはこひしき"
            ),
            in_modern_kana: ["ながらえば", "またこのごろや", "しのばれん", "うしとみしよぞ", "いまはこいしき"],
            kimari_ji: "ながら"
        ),
        Poem(number: 85,
            poet: "俊恵法師",
            living_years: "(1113〜1191?)",
            liner: ["よもすがら", "物思ふころは", "明けやらぬ", "閨のひまさへ", "つれなかりけり"], 
            in_hiragana: Liner2Parts(
                kami: "よもすからものおもふころはあけやらぬ",
                shimo: "ねやのひまさへつれなかりけり"
            ),
            in_modern_kana: ["よもすがら", "ものおもうころは", "あけやらで", "ねやのひまさえ", "つれなかりけり"],
            kimari_ji: "よも"
        ),
        Poem(number: 86,
            poet: "西行法師",
            living_years: "(1118〜1190)",
            liner: ["嘆けとて", "月やは物を", "思はする", "かこちがほなる", "我が涙かな"], 
            in_hiragana: Liner2Parts(
                kami: "なけけとてつきやはものをおもはする",
                shimo: "かこちかほなるわかなみたかな"
            ),
            in_modern_kana: ["なげけとて", "つきやはものを", "おもわする", "かこちがおなる", "わがなみだかな"],
            kimari_ji: "なげけ"
        ),
        Poem(number: 87,
            poet: "寂蓮法師",
            living_years: "(1139〜1202)",
            liner: ["村雨の", "露もまだひぬ", "まきの葉に", "霧立ちのぼる", "秋の夕暮れ"], 
            in_hiragana: Liner2Parts(
                kami: "むらさめのつゆもまたひぬまきのはに",
                shimo: "きりたちのほるあきのゆふくれ"
            ),
            in_modern_kana: ["むらさめの", "つゆもまだひぬ", "まきのはに", "きりたちのぼる", "あきのゆうぐれ"],
            kimari_ji: "む"
        ),
        Poem(number: 88,
            poet: "皇嘉門院別当",
            living_years: "(?〜1181?)",
            liner: ["難波江の", "葦のかりねの", "ひとよゆゑ", "身をつくしてや", "恋わたるべき"], 
            in_hiragana: Liner2Parts(
                kami: "なにはえのあしのかりねのひとよゆゑ",
                shimo: "みをつくしてやこひわたるへき"
            ),
            in_modern_kana: ["なにわえの", "あしのかりねの", "ひとよゆえ", "みをつくしてや", "こいわたるべき"],
            kimari_ji: "なにわえ"
        ),
        Poem(number: 89,
            poet: "式子内親王",
            living_years: "(1149〜1201)",
            liner: ["玉の緒よ", "絶えなば絶えね", "ながらへば", "忍ぶることの", "よわりもぞする"], 
            in_hiragana: Liner2Parts(
                kami: "たまのをよたえなはたえねなからへは",
                shimo: "しのふることのよはりもそする"
            ),
            in_modern_kana: ["たまのおよ", "たえなばたえね", "ながらえば", "しのぶることの", "よわりもぞする"],
            kimari_ji: "たま"
        ),
        Poem(number: 90,
            poet: "殷富門院大輔",
            living_years: "(?〜1200?)",
            liner: ["見せばやな", "雄島のあまの", "袖だにも", "ぬれにぞぬれし", "色はかはらず"], 
            in_hiragana: Liner2Parts(
                kami: "みせはやなをしまのあまのそてたにも",
                shimo: "ぬれにそぬれしいろはかはらす"
            ),
            in_modern_kana: ["みせばやな", "おじまのあまの", "そでだにも", "ぬれにぞぬれし", "いろはかわらず"],
            kimari_ji: "みせ"
        ),
        Poem(number: 91,
            poet: "後京極摂政太政大臣",
            living_years: "(1169〜1206)",
            liner: ["きりぎりす", "鳴くや霜夜の", "さむしろに", "衣かたしき", "ひとりかもねむ"], 
            in_hiragana: Liner2Parts(
                kami: "きりきりすなくやしもよのさむしろに",
                shimo: "ころもかたしきひとりかもねむ"
            ),
            in_modern_kana: ["きりぎりす", "なくやしもよの", "さむしろに", "ころもかたしき", "ひとりかもねん"],
            kimari_ji: "きり"
        ),
        Poem(number: 92,
            poet: "二条院讃岐",
            living_years: "(?〜1216?)",
            liner: ["我が袖は", "しほひに見えぬ", "沖の石の", "人こそしらね", "かわくまもなし"], 
            in_hiragana: Liner2Parts(
                kami: "わかそてはしほひにみえぬおきのいしの",
                shimo: "ひとこそしらねかわくまもなし"
            ),
            in_modern_kana: ["わがそでは", "しおひにみえぬ", "おきのいしの", "ひとこそしらね", "かわくまもなし"],
            kimari_ji: "わがそ"
        ),
        Poem(number: 93,
            poet: "鎌倉右大臣",
            living_years: "(1192〜1219)",
            liner: ["世の中は", "常にもがもな", "なぎさ漕ぐ", "あまのをぶねの", "綱手かなしも"], 
            in_hiragana: Liner2Parts(
                kami: "よのなかはつねにもかもななきさこく",
                shimo: "あまのおふねのつなてかなしも"
            ),
            in_modern_kana: ["よのなかは", "つねにもがもな", "なぎさこぐ", "あまのおぶねの", "つなでかなしも"],
            kimari_ji: "よのなかは"
        ),
        Poem(number: 94,
            poet: "参議雅経",
            living_years: "(1170〜1221)",
            liner: ["み吉野の", "山の秋風", "さよ更けて", "故郷寒く", "衣うつなり"], 
            in_hiragana: Liner2Parts(
                kami: "みよしののやまのあきかせさよふけて",
                shimo: "ふるさとさむくころもうつなり"
            ),
            in_modern_kana: ["みよしのの", "やまのあきかぜ", "さよふけて", "ふるさとさむく", "ころもうつなり"],
            kimari_ji: "みよ"
        ),
        Poem(number: 95,
            poet: "前大僧正慈円",
            living_years: "(1155〜1225)",
            liner: ["おほけなく", "うき世の民に", "おほふかな", "我が立つ杣に", "墨染めの袖"], 
            in_hiragana: Liner2Parts(
                kami: "おほけなくうきよのたみにおほふかな",
                shimo: "わかたつそまにすみそめのそて"
            ),
            in_modern_kana: ["おおけなく", "うきよのたみに", "おおうかな", "わがたつそまに", "すみぞめのそで"],
            kimari_ji: "おおけ"
        ),
        Poem(number: 96,
            poet: "入道前大政大臣",
            living_years: "(1171〜1244)",
            liner: ["花さそふ", "嵐の庭の", "雪ならで", "ふり行くものは", "我が身なりけり"], 
            in_hiragana: Liner2Parts(
                kami: "はなさそふあらしのにはのゆきならて",
                shimo: "ふりゆくものはわかみなりけり"
            ),
            in_modern_kana: ["はなさそう", "あらしのにわの", "ゆきならで", "ふりゆくものは", "わがみなりけり"],
            kimari_ji: "はなさ"
        ),
        Poem(number: 97,
            poet: "権中納言定家",
            living_years: "(1162〜1241)",
            liner: ["こぬ人を", "まつほの浦の", "夕なぎに", "焼くやもしほの", "身もこがれつつ"], 
            in_hiragana: Liner2Parts(
                kami: "こぬひとをまつほのうらのゆふなきに",
                shimo: "やくやもしほのみもこかれつつ"
            ),
            in_modern_kana: ["こぬひとを", "まつほのうらの", "ゆうなぎに", "やくやもしおの", "みもこがれつつ"],
            kimari_ji: "こぬ"
        ),
        Poem(number: 98,
            poet: "従二位家隆",
            living_years: "(1158〜1237)",
            liner: ["風そよぐ", "ならの小川の", "夕暮れは", "みそぎぞ夏の", "しるしなりける"], 
            in_hiragana: Liner2Parts(
                kami: "かせそよくならのをかはのゆふくれは",
                shimo: "みそきそなつのしるしなりける"
            ),
            in_modern_kana: ["かぜそよぐ", "ならのおがわの", "ゆうぐれは", "みそぎぞなつの", "しるしなりける"],
            kimari_ji: "かぜそ"
        ),
        Poem(number: 99,
            poet: "後鳥羽院",
            living_years: "(1180〜1239)",
            liner: ["人もをし", "人も恨めし", "あぢきなく", "世を思ふゆゑに", "物思ふ身は"], 
            in_hiragana: Liner2Parts(
                kami: "ひともをしひともうらめしあちきなく",
                shimo: "よをおもふゆゑにものおもふみは"
            ),
            in_modern_kana: ["ひともおし", "ひともうらめし", "あじきなく", "よをおもうゆえに", "ものおもうみは"],
            kimari_ji: "ひとも"
        ),
        Poem(number: 100,
            poet: "順徳院",
            living_years: "(1197〜1242)",
            liner: ["百敷や", "古き軒端の", "しのぶにも", "なほあまりある", "昔なりけり"], 
            in_hiragana: Liner2Parts(
                kami: "ももしきやふるきのきはのしのふにも",
                shimo: "なほあまりあるむかしなりけり"
            ),
            in_modern_kana: ["ももしきや", "ふるきのきばの", "しのぶにも", "なおあまりある", "むかしなりけり"],
            kimari_ji: "もも"
        ),

    ]
}
