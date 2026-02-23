import Foundation
import SwiftUI

struct UniversalQuote: Identifiable {
    let id = UUID()
    let originalQuote: String
    let source: String
    let modernMeaning: String
    let corePrinciple: String
    let grandmaInterpretation: String
    let dailyPractice: String
    let iconColor: Color
}

struct UniversalQuotesData {
    static func quotes(for language: AppLanguage) -> [UniversalQuote] {
        switch language {
        case .mandarin: return mandarinQuotes
        case .hindi: return hindiQuotes
        case .spanish: return spanishQuotes
        case .french: return frenchQuotes
        case .english: return englishQuotes
        }
    }

    private static let englishQuotes: [UniversalQuote] = [
        UniversalQuote(
            originalQuote: "You are what your deep, driving desire is. As your desire is, so is your will. As your will is, so is your deed. As your deed is, so is your destiny.",
            source: "Brihadaranyaka Upanishad (Vedic / Hindu)",
            modernMeaning: "Your most deep-rooted intentions shape your actions, and those actions continuously create your future. You define your path.",
            corePrinciple: "Intention & Action",
            grandmaInterpretation: "My dear, the seeds you plant in your heart today are exactly what will grow in your garden tomorrow. What are you watering with your thoughts?",
            dailyPractice: "Write down one thing you strongly desire today. Notice if your actions this afternoon move you closer to it or further away.",
            iconColor: .orange
        ),
        
        UniversalQuote(
            originalQuote: "Love your neighbor as yourself.",
            source: "Leviticus 19:18 & Mark 12:31 (Torah / Bible)",
            modernMeaning: "Treat the people around you with the exact same kindness, grace, and patience you would hope someone shows to you when you make a mistake.",
            corePrinciple: "Compassion",
            grandmaInterpretation: "It is easy to love someone perfect, sweetheart, but there are no perfect people. We all need love the most when we deserve it the least. Give what you hope to receive.",
            dailyPractice: "When someone annoys you today, pause and ask: 'If I was in their shoes, how would I want to be treated right now?'",
            iconColor: Color.themeRose
        ),
        
        UniversalQuote(
            originalQuote: "Hatred does not cease by hatred, but only by love; this is the eternal rule.",
            source: "The Dhammapada (Buddhist)",
            modernMeaning: "You cannot solve anger with more anger. Fire cannot put out fire; only water can.",
            corePrinciple: "Forgiveness",
            grandmaInterpretation: "Holding onto anger is like drinking poison and expecting the other person to get sick. Whenever you feel angry, take a deep breath and let it go. It's for your own peace.",
            dailyPractice: "Think of a small grudge you are holding. Visualize opening your hand and letting it fly away like a bird. You don't need to carry it anymore.",
            iconColor: .purple
        ),
        
        UniversalQuote(
            originalQuote: "Whoever saves one life, it is as if he had saved mankind entirely.",
            source: "Quran 5:32 (Islamic)",
            modernMeaning: "Every single human life holds infinite value. One small act of kindness to one person changes the entire world because they are someone's whole world.",
            corePrinciple: "Value of Life",
            grandmaInterpretation: "Never think your small acts of kindness don't matter, my love. A smile, holding the door, a kind word—you might just be saving someone's day without even knowing it.",
            dailyPractice: "Do one totally unseen, anonymous act of kindness today. Pick up a piece of trash, leave a nice note, let someone merge in traffic.",
            iconColor: .green
        ),
        
        UniversalQuote(
            originalQuote: "Recognize the human race as one.",
            source: "Guru Gobind Singh (Sikh)",
            modernMeaning: "Beyond all our different clothing, jobs, appearances, and beliefs, we all share the exact same fundamental human spirit and worth.",
            corePrinciple: "Unity",
            grandmaInterpretation: "We are all different flowers in the same big garden. The differences make the garden beautiful. We need the roses and the sunflowers alike.",
            dailyPractice: "When you interact with a stranger today (like a cashier), look them in the eyes and remember: they have a family, hopes, and worries, just like you.",
            iconColor: .blue
        ),
        
        UniversalQuote(
            originalQuote: "You have the right to work, but never to the fruit of work.",
            source: "Bhagavad Gita (Hindu)",
            modernMeaning: "Focus entirely on doing a good job with what is in front of you, but do not get obsessed with the reward, the applause, or the outcome. You can only control your effort.",
            corePrinciple: "Detachment",
            grandmaInterpretation: "Do your absolute best, wash your hands, and let it be. If you bake a cake just for the compliments, it never tastes as sweet as a cake baked with pure love.",
            dailyPractice: "Do a chore today (dishes, sweeping) not just to 'get it done,' but to do it beautifully. Appreciate the act of doing.",
            iconColor: .yellow
        ),
        
        UniversalQuote(
            originalQuote: "Nature does not hurry, yet everything is accomplished.",
            source: "Lao Tzu (Tao Te Ching)",
            modernMeaning: "Growth takes the time it takes. You cannot force a flower to bloom by pulling its petals.",
            corePrinciple: "Patience",
            grandmaInterpretation: "Oh honey, you're always running so fast! Sit. Breathe. The seasons always change right on time. Trust your own timing. You are not behind.",
            dailyPractice: "For just five minutes today, sit completely still with no screens, no music, no talking. Just watch the world happen around you.",
            iconColor: Color.themeGreen
        ),
        
        UniversalQuote(
            originalQuote: "The earth is but one country, and mankind its citizens.",
            source: "Bahá'u'lláh (Bahá'í Faith)",
            modernMeaning: "National borders and cultural differences are artificial constructs; we all live on the same small planet and share a common destiny.",
            corePrinciple: "Global Citizenship",
            grandmaInterpretation: "If we zoom far enough out, sweetheart, there are no lines drawn on the Earth. We share the same air, the same water, the same sun. Treat everyone like a neighbor.",
            dailyPractice: "Read one positive news story today from a country you have never visited and know very little about.",
            iconColor: Color.themeRose
        ),
        
        UniversalQuote(
            originalQuote: "Good thoughts, good words, good deeds.",
            source: "Zoroaster (Zoroastrianism)",
            modernMeaning: "A righteous life brings harmony to the world through a simple, three-part alignment: what you think, what you say, and what you do.",
            corePrinciple: "Integrity",
            grandmaInterpretation: "It's not enough to just think about being kind, dear. Your thoughts must match your words, and your words must match your actions. That's how you build trust.",
            dailyPractice: "Catch yourself before you speak a complaint today. Change the thought, speak a kinder word, or take a tiny action to fix the problem instead.",
            iconColor: Color.themeWarm
        ),
        
        UniversalQuote(
            originalQuote: "Do not do to others what you do not want done to yourself.",
            source: "Confucius (Confucianism)",
            modernMeaning: "The golden rule of empathy: do not inflict the pain or frustration onto others that you would hate to experience yourself.",
            corePrinciple: "Empathy",
            grandmaInterpretation: "Always look in the mirror before you judge the window, my love. If you don't like being talked down to, make sure your own voice is gentle.",
            dailyPractice: "The next time you are frustrated with someone (like a slow driver), ask yourself how you'd want someone to react to you if you were the one making a mistake.",
            iconColor: .purple
        ),
        
        UniversalQuote(
            originalQuote: "We do not inherit the earth from our ancestors, we borrow it from our children.",
            source: "Indigenous Proverb (Native American)",
            modernMeaning: "We are caretakers of the present, with a profound responsibility to leave the world in a beautiful, habitable state for the generations that follow us.",
            corePrinciple: "Stewardship",
            grandmaInterpretation: "You're borrowing this beautiful world from your grandchildren, sweetie! Would you return a borrowed dress with stains on it? Treat the earth with the same respect.",
            dailyPractice: "Make one conscious choice to reduce waste today—use a reusable cup, turn off the lights, or pick up a piece of litter on your walk.",
            iconColor: .green
        ),
        
        UniversalQuote(
            originalQuote: "Do not injure, abuse, oppress, enslave, insult, torment, torture, or kill any creature or living being.",
            source: "Mahavira (Jainism)",
            modernMeaning: "Live a life of absolute non-violence (Ahimsa), honoring the life force and right to exist of every living entity, no matter how small.",
            corePrinciple: "Non-Violence",
            grandmaInterpretation: "Every tiny bug, every stray cat, every person has a right to be here. Tread lightly on the earth, my brave one, and leave peace wherever you step.",
            dailyPractice: "If you see an insect inside your house today, try to gently catch it and release it outside rather than squishing it.",
            iconColor: .orange
        )
    ]

    private static let mandarinQuotes: [UniversalQuote] = [
        UniversalQuote(
            originalQuote: "你的深层渴望造就了你。你的渴望即为你的意志。你的意志即为你的行动。你的行动即为你的宿命。",
            source: "《广林奥义书》（吠陀/印度教）",
            modernMeaning: "你最深层的意图塑造了你的行动，而这些行动不断地创造着你的未来。你定义自己的道路。",
            corePrinciple: "意愿与行动",
            grandmaInterpretation: "亲爱的，你今天在心里播下的种子，就是明天花园里长出的花朵。你正在用什么样的想法灌溉它们呢？",
            dailyPractice: "今天写下一件你强烈渴望的事情。注意你今天下午的行动是让你离它更近还是更远。",
            iconColor: .orange
        ),
        
        UniversalQuote(
            originalQuote: "爱人如己。",
            source: "《利未记》19:18 & 《马可福音》12:31（妥拉/圣经）",
            modernMeaning: "以你希望别人在你犯错时表现出的善良、宽容和耐心，来对待你周围的人。",
            corePrinciple: "同情与怜悯",
            grandmaInterpretation: "爱一个完美的人很容易，亲爱的，但这世上没有完美的人。我们最需要爱的时候，往往是我们最不配得到爱的时候。给予你希望得到的吧。",
            dailyPractice: "当你今天对某人感到烦躁时，停下来问问：‘如果我处于他们的位置，我现在希望别人如何对待我？’",
            iconColor: Color.themeRose
        ),
        
        UniversalQuote(
            originalQuote: "仇恨不能平息仇恨，唯有爱能平息仇恨；这是永恒的法则。",
            source: "《法句经》（佛教）",
            modernMeaning: "你不能用更多的愤怒来解决愤怒。火不能灭火；只有水才能。",
            corePrinciple: "和平与宽恕",
            grandmaInterpretation: "抓住愤怒不放就像喝毒药却指望别人死掉。原谅他们并不是说他们是对的，而是说你值得拥有平和的心态。",
            dailyPractice: "想想一个让你轻微恼火的人。不要想着自己有多生气，试着向他们发送一个无声的好愿望。",
            iconColor: .pink
        ),
        
        UniversalQuote(
            originalQuote: "你拥有控制自己思想的力量，而非外部事件。认识到这一点，你就会找到力量。",
            source: "马可·奥勒留《沉思录》（斯多葛学派）",
            modernMeaning: "你无法控制发生在你身上的事，但你可以100%控制你的反应。这才是你真正的力量所在。",
            corePrinciple: "韧性",
            grandmaInterpretation: "外面的风多大并不重要，重要的是你建造房子的基础。当世界混乱时，就把你的思绪拉回到你能控制的事情上。",
            dailyPractice: "当今天发生不顺心的事情时，深吸一口气，这样说：‘我无法控制这件事，但我能控制我接下来的做法。’",
            iconColor: Color.themeGold
        ),
        
        UniversalQuote(
            originalQuote: "伤口是光进入你内心的地方。",
            source: "鲁米（苏菲神秘主义）",
            modernMeaning: "我们最痛苦的经历，虽然可怕，却往往是对我们成长为更深刻、更富有同情心的人影响最大的经历。",
            corePrinciple: "从痛苦中成长",
            grandmaInterpretation: "破碎的心是一颗敞开的心，亲爱的。如果没有我们所经历的裂缝，同理心和智慧的光芒就无法照进我们灵魂的深处。",
            dailyPractice: "回想一个曾经让你痛苦，但使你变得更坚强的过去挑战。对那份力量说声谢谢。",
            iconColor: .yellow
        ),
        
        UniversalQuote(
            originalQuote: "大自然从不匆忙，但万物皆成。",
            source: "老子《道德经》（道教）",
            modernMeaning: "不断地奔忙和急躁并不会带来更好的结果。可持续的成长需要时间、耐心和稳定的节奏。",
            corePrinciple: "耐心与节奏",
            grandmaInterpretation: "你不能通过拉扯树叶来让树长高。在你的人生旅途中深吸一口气，相信如果你每天踏实地走，总会到达目的地。",
            dailyPractice: "选择一项你今天会做的日常杂务（如洗碗或散步），并专注于以平时一半的速度仔细完成它。",
            iconColor: Color.themeGreen
        ),
        
        UniversalQuote(
            originalQuote: "你要专心仰赖耶和华，不可倚靠自己的聪明。",
            source: "《箴言》3:5-6（犹太-基督教）",
            modernMeaning: "有时生活并不合理。与其试图控制或过度分析每一个变数，不如相信这个过程和你自己。",
            corePrinciple: "信仰与顺服",
            grandmaInterpretation: "我们无法看到整幅挂毯，亲爱的，只能看到背后的乱线。当事情让你困惑时，做你最好的那一面，顺其自然。结局会顺理成章。",
            dailyPractice: "指认一个你正在压力下试图去‘弄清楚’的情况。今天练习放弃对那件事的控制力。",
            iconColor: .purple
        ),
        
        UniversalQuote(
            originalQuote: "因为我们存在，所以我存在。",
            source: "乌班图哲学（南部非洲）",
            modernMeaning: "人类的身份和成长深深地纠缠在社区中。你在孤立和绝对自立中是无法茁壮成长的。",
            corePrinciple: "社区与联系",
            grandmaInterpretation: "一根木棍很容易折断，但一捆木棍就很坚固。你的成功和你的心都与你周围的人紧密相连。我们是来互相帮助的。",
            dailyPractice: "今天主动联系某个人，不要问他们最近怎么样，而要告诉他们一个你感激他们生活在你生命中的具体原因。",
            iconColor: .brown
        ),
        
        UniversalQuote(
            originalQuote: "我们在想象中受的苦，往往多于现实中的苦。",
            source: "塞内卡（斯多葛学派）",
            modernMeaning: "我们因为过度思考和为根本没有发生的最坏情况做准备而给自己造成了巨大的焦虑。现实通常更容易应对。",
            corePrinciple: "克服焦虑",
            grandmaInterpretation: "亲爱的，不要在桥还没建好之前就去过河。你的脑海里充满了根本没有发生的怪物。留在今天吧。",
            dailyPractice: "每当你今天感到自己往最坏的方面想时，停下来，列出三个此时此刻绝对存在的真实事物。",
            iconColor: Color.themeText
        ),
        
        UniversalQuote(
            originalQuote: "真理是最高的德行，但更高的是真实的生活。",
            source: "《阿迪格兰特》（锡克教）",
            modernMeaning: "知道什么是对的并在理论上谈论它是一回事；但在你的日常行动、工作和与他人的交往中始终如一地践行它是另一回事。",
            corePrinciple: "正直",
            grandmaInterpretation: "说漂亮话是没有用的，除非你有漂亮的行动来支持它。通过别人不在场时你如何对待他们，来向我展示你的信念吧。",
            dailyPractice: "寻找一个你的文字可能与你的行为不完全匹配的小生活区域。今天只采取一小步来纠正它。",
            iconColor: .orange
        )
    ]
    
    private static let hindiQuotes: [UniversalQuote] = [
        UniversalQuote(
            originalQuote: "आप वही हैं जो आपकी गहरी, प्रबल इच्छा है। जैसी आपकी इच्छा है, वैसी ही आपकी संकल्प शक्ति है। जैसा आपका संकल्प है, वैसा ही आपका कर्म है। और जैसा आपका कर्म है, वैसा ही आपका भाग्य है।",
            source: "बृहदारण्यक उपनिषद (वैदिक / हिंदू)",
            modernMeaning: "आपके सबसे गहरे इरादे आपके कर्मों को आकार देते हैं, और वे कर्म आपके भविष्य का निर्माण करते हैं। आप अपना रास्ता खुद तय करते हैं।",
            corePrinciple: "इरादा और कर्म",
            grandmaInterpretation: "मेरे बच्चे, जो बीज तुम आज अपने दिल में बोते हो, कल तुम्हारे बगीचे में वही फूल खिलेंगे। तुम अपने विचारों से उन्हें क्या सींच रहे हो?",
            dailyPractice: "आज किसी एक ऐसी चीज़ को लिखें जिसकी आप बहुत इच्छा रखते हैं। ध्यान दें कि क्या आपके आज के काम आपको उसके करीब ले जा रहे हैं या दूर।",
            iconColor: .orange
        ),
        
        UniversalQuote(
            originalQuote: "अपने पड़ोसी से अपने समान प्रेम रखो।",
            source: "लैव्यव्यवस्था 19:18 और मरकुस 12:31 (तोराह / बाइबिल)",
            modernMeaning: "अपने आस-पास के लोगों के साथ वैसी ही दया, क्षमा और धैर्य के साथ पेश आएं, जिसकी आप तब उम्मीद करते हैं जब आपसे कोई गलती हो जाए।",
            corePrinciple: "करुणा",
            grandmaInterpretation: "किसी पूर्ण इंसान से प्यार करना आसान है, बेटा, लेकिन कोई भी पूर्ण नहीं है। जब हम प्यार के सबसे कम हक़दार होते हैं, तभी हमें इसकी सबसे ज्यादा जरूरत होती है। वही दें जो आप पाना चाहते हैं।",
            dailyPractice: "जब आज कोई आपको गुस्सा दिलाए, तो रुकें और पूछें: 'यदि मैं उनकी जगह होता, तो मैं क्या चाहता कि वो मुझसे कैसे पेश आएं?'",
            iconColor: Color.themeRose
        ),
        
        UniversalQuote(
            originalQuote: "नफ़रत से नफ़रत कभी खत्म नहीं होती, यह केवल प्यार से खत्म होती है; यह शाश्वत नियम है।",
            source: "धम्मपद (बौद्ध)",
            modernMeaning: "आप गुस्से का जवाब और गुस्से से नहीं दे सकते। आग से आग नहीं बुझती; केवल पानी ही आग बुझा सकता है।",
            corePrinciple: "शांति और क्षमा",
            grandmaInterpretation: "गुस्से को पकड़ कर रखना ज़हर पीने जैसा है और यह उम्मीद करना कि दूसरा इंसान मर जाएगा। उन्हें माफ़ करने का मतलब ये नहीं कि वे सही हैं, इसका मतलब है कि आप शांति के हक़दार हैं।",
            dailyPractice: "उस व्यक्ति के बारे में सोचें जिसने आपको थोड़ा गुस्सा दिलाया हो। अपने गुस्से पर ध्यान देने के बजाय, मन ही मन उनके भले की कामना करें।",
            iconColor: .pink
        ),
        
        UniversalQuote(
            originalQuote: "आपके मन पर आपका नियंत्रण है - बाहरी घटनाओं पर नहीं। इसे समझें, और आप ताकत पाएंगे।",
            source: "मार्कस ऑरेलियस, मेडिटेशंस (स्टोइकवाद)",
            modernMeaning: "आप यह नियंत्रित नहीं कर सकते कि आपके साथ क्या होता है, लेकिन आप 100% इस बात को नियंत्रित कर सकते हैं कि आप उस पर कैसी प्रतिक्रिया देते हैं। आपकी असली ताकत वहीं है।",
            corePrinciple: "लचीलापन",
            grandmaInterpretation: "बाहर कितनी भी तेज़ हवा क्यों न चले, मायने यह रखता है कि आपने अपने घर की नींव कितनी मज़बूत बनाई है। जब बाहर सब कुछ अफ़रा-तफ़री भरा हो, तो अपने ध्यान को उस पर वापस लाएँ जिसे आप नियंत्रित कर सकते हैं।",
            dailyPractice: "आज जब कुछ आपकी उम्मीद के मुताबिक न हो, तो गहरी साँस लें और कहें: 'मैं इसे नहीं बदल सकता, लेकिन मैं यह तय कर सकता हूँ कि मैं आगे क्या करूँगा।'",
            iconColor: Color.themeGold
        ),
        
        UniversalQuote(
            originalQuote: "घाव वो जगह है जहाँ से रोशनी आपके अंदर प्रवेश करती है।",
            source: "रूमी (सूफी रहस्यवाद)",
            modernMeaning: "हमारे सबसे दर्दनाक अनुभव, हालांकि डरावने होते हैं, अक्सर हमें गहरे और दयालु इंसान बनने में सबसे ज्यादा मदद करते हैं।",
            corePrinciple: "दर्द से सीखना",
            grandmaInterpretation: "टूटा हुआ दिल एक खुला हुआ दिल है, बेटा। अगर हमारे ऊपर पड़ी दरारें न हों, तो सहानुभूति और ज्ञान की रोशनी हमारी आत्मा की गहराइयों तक नहीं पहुँच पाएगी।",
            dailyPractice: "किसी पुरानी चुनौती को याद करें जिससे दर्द हुआ लेकिन आपको मजबूत बनाया। उस ताकत के लिए मन में धन्यवाद कहें।",
            iconColor: .yellow
        ),
        
        UniversalQuote(
            originalQuote: "प्रकृति कभी जल्दबाजी नहीं करती, फिर भी सब कुछ पूरा हो जाता है।",
            source: "लाओ त्सू, ताओ ते चिंग (ताओवाद)",
            modernMeaning: "हर समय भागदौड़ करने और बेचैन रहने से बेहतर नतीजे नहीं मिलते। टिकाऊ विकास के लिए समय, धैर्य और एक स्थिर गति की जरूरत होती है।",
            corePrinciple: "धैर्य",
            grandmaInterpretation: "पत्तियों को खींचकर तुम पेड़ को लंबा नहीं कर सकते। अपनी जिंदगी की यात्रा में गहरी साँस लें और भरोसा रखें कि अगर आप हर दिन कदम बढ़ाते हैं, तो आप मंज़िल तक पहुँच ही जाएँगे।",
            dailyPractice: "आज कोई ऐसा छोटा काम चुनें (जैसे बर्तन धोना या टहलना), और उसे अपनी सामान्य गति से आधी गति में ध्यान से करने की कोशिश करें।",
            iconColor: Color.themeGreen
        ),
        
        UniversalQuote(
            originalQuote: "संपूर्ण हृदय से ईश्वर पर भरोसा रखें और अपनी समझ पर निर्भर न रहें।",
            source: "नीतिवचन 3:5-6 (यहूदी-ईसाई)",
            modernMeaning: "कभी-कभी ज़िंदगी के पन्ने समझ नहीं आते। हर चीज़ को नियंत्रित करने या बहुत ज्यादा सोचने के बजाय, प्रक्रिया और खुद पर विश्वास करें।",
            corePrinciple: "विश्वास और समर्पण",
            grandmaInterpretation: "हम पूरी तस्वीर नहीं देख सकते, मेरे बच्चे, बस पीछे धागों का उलझा हुआ गुच्छा देख सकते हैं। जब कुछ समझ न आए, तो अपना सर्वश्रेष्ठ दें और बाकी छोड़ दें। अंततः सब ठीक हो जाएगा।",
            dailyPractice: "किसी ऐसी स्थिति के बारे में सोचें जिसे आप तनाव में आकर 'सुलझाने' की कोशिश कर रहे हैं। आज उस बात पर से अपना नियंत्रण छोड़ने का अभ्यास करें।",
            iconColor: .purple
        ),
        
        UniversalQuote(
            originalQuote: "मैं हूँ क्योंकि हम हैं।",
            source: "उबंटू दर्शन (दक्षिणी अफ्रीकी)",
            modernMeaning: "इंसान की पहचान और विकास समुदाय के साथ गहराई से जुड़े हुए हैं। आप पूरी तरह से अकेले और सिर्फ अपने आप पर निर्भर रहकर उन्नति नहीं कर सकते।",
            corePrinciple: "समुदाय और जुड़ाव",
            grandmaInterpretation: "एक लकड़ी आसानी से टूट जाती है, लेकिन लकड़ियों का गट्ठर मजबूत होता है। आपकी सफलता और आपका दिल आपके आस-पास के लोगों से जुड़ा हुआ है। हम सब एक-दूसरे की मदद करने के लिए यहाँ हैं।",
            dailyPractice: "आज किसी से बात करें, सिर्फ यह पूछने के लिए नहीं कि वे कैसे हैं, बल्कि उन्हें यह बताने के लिए कि आप अपनी ज़िंदगी में उनके होने के लिए आभारी क्यों हैं।",
            iconColor: .brown
        ),
        
        UniversalQuote(
            originalQuote: "हम वास्तविकता से कहीं ज़्यादा अपनी कल्पनाओं में पीड़ित होते हैं।",
            source: "सेनेका (स्टोइकवाद)",
            modernMeaning: "हम बहुत ज्यादा सोचने और उन सबसे बुरी स्थितियों की तैयारी करने के लिए खुद को चिंतित कर लेते हैं, जो कभी नहीं होतीं। वास्तविकता अक्सर अधिक सहने योग्य होती है।",
            corePrinciple: "चिंता पर विजय",
            grandmaInterpretation: "मेरे बच्चे, नदी के पास पहुँचने से पहले ही उसे पार करने की कोशिश मत करो। आपका मन उन राक्षसों से भरा है जो कभी घटित ही नहीं हुए। आज में जिएँ।",
            dailyPractice: "जब भी आप आज महसूस करें कि आप 'क्या होगा अगर' वाली सोच में पड़ गए हैं, तो रुकें और उस पल की 3 'वास्तविक' चीज़ें अपने आस-पास देखें।",
            iconColor: Color.themeText
        ),
        
        UniversalQuote(
            originalQuote: "सच्चाई सबसे बड़ा गुण है, लेकिन सच्चा जीवन जीना उससे भी बड़ा है।",
            source: "गुरु ग्रंथ साहिब (सिख धर्म)",
            modernMeaning: "सिर्फ यह जानना और बात करना कि सही क्या है, काफी नहीं है; इसे अपने रोज़मर्रा के कामों और दूसरों के साथ व्यवहार में उतारना भी उतना ही ज़रूरी है।",
            corePrinciple: "ईमानदारी",
            grandmaInterpretation: "सुंदर शब्दों का तब तक कोई अर्थ नहीं है जब तक आपके कार्य सुंदर न हों। मुझे दिखाओ कि जब कोई नहीं देख रहा होता है, तब तुम दूसरों के साथ कैसा व्यवहार करते हो।",
            dailyPractice: "अपनी ज़िंदगी के किसी ऐसे हिस्से को खोजें जहाँ आपके शब्द आपके कार्यों से 100% मेल नहीं खाते। आज उसे सुधारने के लिए एक छोटा सा कदम उठाएं।",
            iconColor: .orange
        )
    ]
    private static let spanishQuotes: [UniversalQuote] = [
        UniversalQuote(
            originalQuote: "Eres lo que es tu profundo y vehemente deseo. Tal como es tu deseo, así es tu voluntad. Tal como es tu voluntad, así son tus actos. Tal como son tus actos, así es tu destino.",
            source: "Brihadaranyaka Upanishad (Védico / Hindú)",
            modernMeaning: "Tus intenciones más arraigadas moldean tus acciones, y esas acciones guían tu futuro continuamente. Tú defines tu propio camino.",
            corePrinciple: "Intención y Acción",
            grandmaInterpretation: "Mi cielo, las semillas que plantas hoy en tu corazón son exactamente lo que crecerá mañana en tu jardín. ¿Con qué tipo de pensamientos las estás regando?",
            dailyPractice: "Anota hoy una cosa que deseas con fuerza. Observa si tus acciones de esta tarde te acercan o te alejan de ella.",
            iconColor: .orange
        ),
        
        UniversalQuote(
            originalQuote: "Ama a tu prójimo como a ti mismo.",
            source: "Levítico 19:18 y Marcos 12:31 (Torá / Biblia)",
            modernMeaning: "Trata a las personas que te rodean con la misma amabilidad, gracia y paciencia que esperarías que alguien te mostrara cuando cometes un error.",
            corePrinciple: "Compasión",
            grandmaInterpretation: "Es fácil amar a alguien perfecto, cariño, pero no hay personas perfectas. Todos necesitamos más amor cuando menos lo merecemos. Da lo que esperas recibir.",
            dailyPractice: "Cuando alguien te moleste hoy, haz una pausa y pregúntate: 'Si yo estuviera en su lugar, ¿cómo me gustaría ser tratado en este momento?'",
            iconColor: Color.themeRose
        ),
        
        UniversalQuote(
            originalQuote: "El odio no cesa con el odio, sino sólo con el amor; esta es la regla eterna.",
            source: "El Dhammapada (Budismo)",
            modernMeaning: "No puedes resolver la ira con más ira. El fuego no puede apagar el fuego; solo el agua puede.",
            corePrinciple: "Paz y Perdón",
            grandmaInterpretation: "Aferrarse al enojo es como beber veneno y esperar que la otra persona muera. Perdonarlos no significa que tengan razón, significa que mereces tener paz mental.",
            dailyPractice: "Piensa en alguien que te haya molestado un poco. En lugar de detenerte en lo frustrado que estás, intenta enviarle un buen deseo en silencio.",
            iconColor: .pink
        ),
        
        UniversalQuote(
            originalQuote: "Tienes poder sobre tu mente, no sobre los acontecimientos externos. Date cuenta de esto, y encontrarás fuerza.",
            source: "Marco Aurelio, Meditaciones (Estoicismo)",
            modernMeaning: "No puedes controlar lo que te sucede, pero puedes controlar al 100% cómo respondes. Ahí es donde reside tu verdadero poder.",
            corePrinciple: "Resiliencia",
            grandmaInterpretation: "No importa cuán fuerte sople el viento afuera, lo que importa es la fuerza de los cimientos de tu casa. Cuando el mundo sea un caos, vuelve tu mente a lo que puedes controlar.",
            dailyPractice: "Cuando algo salga mal hoy, respira hondo y di: 'No puedo controlar esto, pero decido lo que haré a continuación'.",
            iconColor: Color.themeGold
        ),
        
        UniversalQuote(
            originalQuote: "La herida es el lugar por donde la Luz entra en ti.",
            source: "Rumi (Misticismo Sufí)",
            modernMeaning: "Nuestras experiencias más dolorosas, aunque terribles, suelen ser las que más nos ayudan a crecer para convertirnos en personas más profundas y compasivas.",
            corePrinciple: "Crecimiento de las Heridas",
            grandmaInterpretation: "Un corazón roto es un corazón abierto, cielo. Si no fuera por las grietas que experimentamos, la luz de la empatía y la sabiduría no podría entrar a las profundidades de nuestra alma.",
            dailyPractice: "Recuerda un desafío pasado que te dolió pero te hizo más fuerte. Da las gracias en silencio por esa fuerza.",
            iconColor: .yellow
        ),
        
        UniversalQuote(
            originalQuote: "La naturaleza no se apresura, y sin embargo todo se logra.",
            source: "Lao Tse, Tao Te Ching (Taoísmo)",
            modernMeaning: "Las prisas constantes y la inquietud no producen mejores resultados. El crecimiento sostenible requiere tiempo, paciencia y un ritmo constante.",
            corePrinciple: "Paciencia y Ritmo",
            grandmaInterpretation: "No puedes hacer que un árbol crezca más alto tirando de sus hojas. Respira hondo en tu viaje y confía en que si caminas un buen paso constante cada día, llegarás.",
            dailyPractice: "Elige una pequeña tarea física que harás hoy (como lavar los platos o dar un paseo) y concéntrate en hacerla a la mitad de tu velocidad normal, con toda la atención.",
            iconColor: Color.themeGreen
        ),
        
        UniversalQuote(
            originalQuote: "Confía en el Señor de todo corazón, y no te apoyes en tu propio entendimiento.",
            source: "Proverbios 3:5-6 (Judeocristiano)",
            modernMeaning: "A veces la vida simplemente no tiene sentido lógico. En lugar de tratar de controlar o analizar en exceso cada variable, confía en el proceso y en ti mismo.",
            corePrinciple: "Fe y Rendición",
            grandmaInterpretation: "No podemos ver el tapiz completo, hija mía, sólo el montón de hilos por la parte de atrás. Cuando las cosas no tengan sentido, hazlo lo mejor que puedas y déjalo ir. Todo saldrá bien al final.",
            dailyPractice: "Identifica una situación que estés tratando de 'resolver' bajo estrés. Practica soltar conscientemente tu control parcial de eso por hoy.",
            iconColor: .purple
        ),
        
        UniversalQuote(
            originalQuote: "Yo soy porque nosotros somos.",
            source: "Filosofía Ubuntu (Sudáfrica)",
            modernMeaning: "La identidad y el crecimiento humanos están profundamente enredados en la comunidad. No puedes prosperar en el aislamiento y la autosuficiencia absoluta.",
            corePrinciple: "Comunidad y Conexión",
            grandmaInterpretation: "Un solo palo se rompe fácilmente, pero un manojo de palos es fuerte. Tu éxito, y tu corazón, están ligados a las personas que te rodean. Todos estamos aquí para ayudarnos unos a otros.",
            dailyPractice: "Comunícate hoy con alguien, no para preguntarle cómo está, sino para decirle una razón específica por la que estás agradecido de que esté en tu vida.",
            iconColor: .brown
        ),
        
        UniversalQuote(
            originalQuote: "Sufrimos más a menudo en la imaginación que en la realidad.",
            source: "Séneca (Estoicismo)",
            modernMeaning: "Nos causamos una ansiedad masiva por pensar demasiado y prepararnos para los peores escenarios que simplemente nunca suceden. La realidad suele ser mucho más fácil de manejar.",
            corePrinciple: "Superando la Ansiedad",
            grandmaInterpretation: "Mi querido niño, no cruce el puente antes de que se haya construido. Tu mente está llena de monstruos que nunca sucedieron. Quédate en el día de hoy.",
            dailyPractice: "Siempre que sientas que entras en la espiral de los 'y si…' el día de hoy, detente y nombra 3 cosas físicas reales que son absolutamente seguras justo frente a ti.",
            iconColor: Color.themeText
        ),
        
        UniversalQuote(
            originalQuote: "La verdad es la virtud más elevada, pero aún más elevada es la vida verdadera.",
            source: "Guru Granth Sahib (Sikhismo)",
            modernMeaning: "Una cosa es saber qué es lo correcto y hablar de ello en teoría; otra muy distinta es practicarlo constantemente en tus acciones diarias, en tu trabajo y en tu trato con los demás.",
            corePrinciple: "Integridad",
            grandmaInterpretation: "Pronunciar palabras bonitas de nada sirve a menos que tengas acciones bonitas que las respalden. Muéstrame en qué crees por cómo tratas a las personas cuando nadie más está mirando.",
            dailyPractice: "Busca un área pequeña de tu vida en la que tus palabras tal vez no coincidan al 100% con tus acciones. Da un solo paso para alinearlas de nuevo hoy.",
            iconColor: .orange
        )
    ]
    
    private static let frenchQuotes: [UniversalQuote] = [
        UniversalQuote(
            originalQuote: "Vous êtes ce qu'est votre profond désir. Tel est votre désir, telle est votre volonté. Telle est votre volonté, tels sont vos actes. Tels sont vos actes, tel est votre destin.",
            source: "Brihadaranyaka Upanishad (Védique / Hindouisme)",
            modernMeaning: "Vos intentions les plus profondes façonnent vos actions, et ces actions créent continuellement votre avenir. Vous définissez votre propre chemin.",
            corePrinciple: "Intention et Action",
            grandmaInterpretation: "Ma chérie, les graines que tu plantes dans ton cœur aujourd'hui sont exactement ce qui poussera dans ton jardin demain. Avec quelles pensées les arroses-tu ?",
            dailyPractice: "Écrivez une chose que vous désirez fortement aujourd'hui. Remarquez si vos actions de cet après-midi vous en rapprochent ou vous en éloignent.",
            iconColor: .orange
        ),
        
        UniversalQuote(
            originalQuote: "Tu aimeras ton prochain comme toi-même.",
            source: "Lévitique 19:18 & Marc 12:31 (Torah / Bible)",
            modernMeaning: "Traitez les personnes de votre entourage avec la même gentillesse, la même grâce et la même patience que vous aimeriez que l'on vous témoigne lorsque vous faites une erreur.",
            corePrinciple: "Compassion",
            grandmaInterpretation: "Il est facile d'aimer quelqu'un de parfait, mon cœur, mais il n'y a personne de parfait. C'est quand nous le méritons le moins que nous avons le plus besoin d'amour. Donne ce que tu espères recevoir.",
            dailyPractice: "Quand quelqu'un vous agace aujourd'hui, arrêtez-vous et demandez-vous : 'Si j'étais à sa place, comment voudrais-je être traité en ce moment ?'",
            iconColor: Color.themeRose
        ),
        
        UniversalQuote(
            originalQuote: "La haine ne cesse jamais par la haine, elle ne cesse que par l'amour ; c'est là une loi éternelle.",
            source: "Le Dhammapada (Bouddhisme)",
            modernMeaning: "Vous ne pouvez pas résoudre la colère par plus de colère. Le feu ne peut pas éteindre le feu ; seule l'eau le peut.",
            corePrinciple: "Paix et Pardon",
            grandmaInterpretation: "S'accrocher à la colère, c'est comme boire du poison et s'attendre à ce que l'autre personne meure. Leur pardonner ne signifie pas qu'ils ont raison, cela signifie que tu mérites la paix de l'esprit.",
            dailyPractice: "Pensez à une personne qui vous a légèrement agacé. Au lieu de vous attarder sur votre frustration, essayez de lui envoyer silencieusement de bonnes pensées.",
            iconColor: .pink
        ),
        
        UniversalQuote(
            originalQuote: "Vous avez le pouvoir sur votre esprit - pas sur les événements extérieurs. Réalisez ceci, et vous trouverez la force.",
            source: "Marc Aurèle, Pensées pour moi-même (Stoïcisme)",
            modernMeaning: "Vous ne pouvez pas contrôler ce qui vous arrive, mais vous pouvez contrôler à 100 % votre réaction. C'est là que réside votre véritable pouvoir.",
            corePrinciple: "Résilience",
            grandmaInterpretation: "Peu importe la force du vent à l'extérieur, ce qui compte, ce sont les fondations de ta maison. Quand le monde est chaotique, ramène ton esprit à ce que tu peux contrôler.",
            dailyPractice: "Quand quelque chose de travers arrive aujourd'hui, prenez une grande respiration et dites : 'Je ne peux pas contrôler cela, mais je choisis ce que je ferai ensuite'.",
            iconColor: Color.themeGold
        ),
        
        UniversalQuote(
            originalQuote: "La blessure est l'endroit par lequel la Lumière entre en vous.",
            source: "Rûmî (Mysticisme Soufi)",
            modernMeaning: "Nos expériences les plus douloureuses, bien que terribles, sont souvent celles qui nous aident le plus à devenir des personnes plus profondes et plus compatissantes.",
            corePrinciple: "Croissance par la Douleur",
            grandmaInterpretation: "Un cœur brisé est un cœur ouvert, chéri. S'il n'y avait pas les fissures que nous subissons, la lumière de l'empathie et de la sagesse ne pourrait pas atteindre les profondeurs de notre âme.",
            dailyPractice: "Rappelez-vous un défi passé qui a fait mal mais qui vous a rendu plus fort. Remerciez silencieusement pour cette force.",
            iconColor: .yellow
        ),
        
        UniversalQuote(
            originalQuote: "La nature ne se presse pas, et pourtant tout est accompli.",
            source: "Lao Tseu, Tao Tö King (Taoïsme)",
            modernMeaning: "Se précipiter constamment et s'agiter ne donnent pas de meilleurs résultats. Une croissance durable nécessite du temps, de la patience et un rythme régulier.",
            corePrinciple: "Patience et Rythme",
            grandmaInterpretation: "Tu ne peux pas faire grandir un arbre en tirant sur ses feuilles. Prends une grande respiration dans le voyage de ta vie, et aies confiance que si tu as un rythme régulier chaque jour, tu arriveras à destination.",
            dailyPractice: "Choisissez une petite tâche physique que vous ferez aujourd'hui (comme faire la vaisselle ou vous promener) et concentrez-vous pour le faire à moitié de votre vitesse normale, en pleine conscience.",
            iconColor: Color.themeGreen
        ),
        
        UniversalQuote(
            originalQuote: "Confie-toi en l'Éternel de tout ton cœur, et ne t'appuie pas sur ta sagesse.",
            source: "Proverbes 3:5-6 (Judéo-chrétien)",
            modernMeaning: "Parfois, la vie n'a tout simplement pas de sens logique. Au lieu d'essayer de contrôler ou de suranalyser chaque variable, faites confiance au processus et faites-vous confiance.",
            corePrinciple: "Foi et Abandon",
            grandmaInterpretation: "Nous ne pouvons pas voir toute la tapisserie, mon enfant, juste le fouillis de fils à l'arrière. Quand les choses n'ont pas de sens, fais de ton mieux et lâche prise. Tout va s'arranger à la fin.",
            dailyPractice: "Identifiez une situation que vous essayez de 'résoudre' sous l'effet du stress. Entraînez-vous à lâcher prise de ce contrôle partiel juste pour aujourd'hui.",
            iconColor: .purple
        ),
        
        UniversalQuote(
            originalQuote: "Je suis parce que nous sommes.",
            source: "Philosophie Ubuntu (Sud-Africaine)",
            modernMeaning: "L'identité et la croissance humaines sont profondément liées à la communauté. Vous ne pouvez pas vous épanouir dans l'isolement et la confiance absolue en vous-même.",
            corePrinciple: "Communauté et Connexion",
            grandmaInterpretation: "Un seul bâton se casse facilement, mais un fagot de bâtons est solide. Ta réussite, et ton cœur, sont liés aux personnes qui t'entourent. Nous sommes tous là pour nous entraider.",
            dailyPractice: "Contactez quelqu'un aujourd'hui, non pas pour lui demander comment il va, mais pour lui donner une raison spécifique pour laquelle vous êtes reconnaissant qu'il fasse partie de votre vie.",
            iconColor: .brown
        ),
        
        UniversalQuote(
            originalQuote: "Nous souffrons plus souvent dans l'imagination que dans la réalité.",
            source: "Sénèque (Stoïcisme)",
            modernMeaning: "Nous nous causons une immense anxiété en réfléchissant trop et en nous préparant aux pires scénarios qui n'arrivent tout simplement jamais. La réalité est généralement beaucoup plus facile à gérer.",
            corePrinciple: "Surmonter l'Anxiété",
            grandmaInterpretation: "Mon cher enfant, ne traverse pas le pont avant même qu'il ne soit construit. Ton esprit est plein de monstres qui n'ont même jamais existé. Reste dans le moment présent.",
            dailyPractice: "Chaque fois que vous vous sentez partir dans la spirale des pensées du type 'et si' aujourd'hui, arrêtez-vous et nommez 3 choses physiques réelles qui sont absolument vraies sous vos yeux.",
            iconColor: Color.themeText
        ),
        
        UniversalQuote(
            originalQuote: "La vérité est la plus haute vertu, mais plus haute encore est la vie véritable.",
            source: "Guru Granth Sahib (Sikhisme)",
            modernMeaning: "C'est une chose de savoir ce qui est juste et d'en parler en théorie ; c'en est une autre de le pratiquer régulièrement dans vos actions quotidiennes, votre travail et vos relations avec les autres.",
            corePrinciple: "Intégrité",
            grandmaInterpretation: "Dire de belles paroles ne sert à rien à moins d'avoir de belles actions pour les soutenir. Montre-moi ce en quoi tu crois par la façon dont tu traites les gens quand personne d'autre ne regarde.",
            dailyPractice: "Trouvez un petit domaine de votre vie où vos paroles peuvent ne pas correspondre à 100 % à vos actions. Faites un seul petit pas pour y remédier aujourd'hui.",
            iconColor: .orange
        )
    ]
}
