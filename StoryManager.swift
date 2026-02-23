import Foundation
import SwiftUI

struct Story: Identifiable, Codable {
    var id: String { title }
    let title: String
    let content: String
    var category: String = "General"
    var readTime: Int = 3
}

@MainActor
public class StoryManager: ObservableObject {
    public static let shared = StoryManager()
    @AppStorage("likedStoryIDs") private var likedStoryIDsRaw: String = ""

    var likedStoryIDs: [String] {
        get { likedStoryIDsRaw.split(separator: ",").map(String.init) }
        set { likedStoryIDsRaw = newValue.joined(separator: ",") }
    }

    func isLiked(story: Story) -> Bool { likedStoryIDs.contains(story.id) }

    func toggleLike(for story: Story) {
        var current = likedStoryIDs
        if let index = current.firstIndex(of: story.id) {
            current.remove(at: index)
        } else {
            current.append(story.id)
        }
        likedStoryIDs = current
    }

    // MARK: - Public API (language-aware)

    func getStory(for mood: Mood) -> Story {
        getStories(for: mood).randomElement()
            ?? Story(title: L10n.t(.appName), content: "Hello dear, I'm so happy to see you!", category: "General", readTime: 1)
    }

    func getStory(id: String) -> Story? {
        for mood in Mood.allMoods {
            if let story = getStories(for: mood).first(where: { $0.id == id }) { return story }
        }
        return nil
    }

    func getStories(for mood: Mood) -> [Story] {
        let lang = LanguageManager.shared.selectedLanguage
        return localizedStories(mood: mood.name, language: lang)
    }

    func getRandomStory(for mood: Mood) -> Story {
        let base = getStories(for: mood).randomElement() ?? getStory(for: mood)
        let extras = [
            "\n\nAnd remember, my dear, every sunset promises a new sunrise.",
            "\n\nNow come, let me make you a warm cup of tea while we sit together.",
            "\n\nYou know, your grandfather would have loved to hear this story too.",
            "\n\nSometimes the best stories are the ones we live, not just the ones we hear.",
            "\n\nNow, shall I tell you another? Or shall we just sit here and enjoy the quiet together?"
        ]
        return Story(title: base.title, content: base.content + extras.randomElement()!, category: base.category, readTime: base.readTime)
    }

    func getAllStories() -> [Story] {
        Mood.allMoods.flatMap { getStories(for: $0) }
    }

    // MARK: - Language routing

    private func localizedStories(mood: String, language: AppLanguage) -> [Story] {
        switch language {
        case .hindi:
            return hindiStories[mood] ?? englishStories[mood] ?? []
        default:
            return englishStories[mood] ?? []
        }
    }

    // MARK: - English Stories

    private lazy var englishStories: [String: [Story]] = [
        "Happy": [
            Story(title: "The Garden of Joy", content: "Oh, hello my dear! It brings such warmth to my heart to see you smiling. You know, happiness is like my old garden in the springtime. I would spend hours on my hands and knees, pulling weeds and planting tiny, unassuming seeds. Sometimes I'd wonder if anything would ever grow. But then, one bright morning, the whole yard would explode in color—yellow daffodils, soft pink roses, and bright red tulips swaying in the breeze. That is what joy feels like. It is the sudden bloom of all the good things you have been quietly cultivating inside yourself. Let yourself soak in that sunshine today. You have earned every petal of it.", category: "Nature", readTime: 3),
            Story(title: "The Surprise Picnic", content: "Do you remember the time we went on a picnic and realized we left the entire basket on the kitchen counter? Oh, we laughed so hard until our bellies literally hurt! We ended up eating wild blackberries we found near the trail and telling silly jokes under the shade of that massive old oak tree. It wasn't the fancy lunch we planned, but it was absolutely perfect because we were together. Sometimes the greatest joy doesn't come from a perfect plan, but from the spontaneous, messy moments we share with people we love.", category: "Funny", readTime: 2),
            Story(title: "The Dancing Fireflies", content: "When I was a little girl, the summer nights were thick with heat and filled with fireflies. They danced across the tall grass like tiny fallen stars blinking their silent, golden songs. We would run until our legs were tired, catching them gently in our cupped hands just to see them glow against our palms, make a quick wish, and let them fly up into the dark sky. Your wonderful smile right now reminds me of that exact same light—pure, magical, and full of endless hope.", category: "Bedtime", readTime: 4)
        ],
        "Sad": [
            Story(title: "The Rainy Window", content: "Come here, sweet child. Let me wrap this warm, heavy blanket around your shoulders. I can see a grey cloud hanging over you today. Listen to the rain softly tapping against the glass. Even the sky needs to cry sometimes, didn't you know? The earth needs that rain to wash away the dust and to help the deep roots drink. Your tears are doing the exact same thing. They are watering your soul and washing away the heavy things you've been carrying. It's perfectly alright to sit here in the quiet with me until the sun decides to peek through the clouds again.", category: "Comfort", readTime: 3),
            Story(title: "The Broken Teacup", content: "I once had a delicate, beautiful porcelain teacup that slipped from my hands and shattered into a dozen pieces. I felt so devastated. But your grandfather didn't throw it away. He helped me glue it carefully back together, and he painted the cracked lines with brilliant gold lacquer. He told me, 'Now it's even more beautiful because it has a history. It survived being broken.' You might feel broken right now, my love. But those cracks are where your golden strength lives. You are so much stronger and more beautiful because of everything you have survived.", category: "Moral", readTime: 3),
            Story(title: "The Moon's Hiding Place", content: "Did you know that even the great, shining moon disappears sometimes? She gets completely hidden by the dark night sky. But she never actually leaves us. She is simply resting, gathering her silvery light quietly in the shadows so she can return and shine even brighter. It is perfectly okay to hide for a little while when you feel sad, my love. You don't always have to be glowing for the rest of the world. Just rest. Your light is safe, and it will return when you are ready.", category: "Bedtime", readTime: 2)
        ],
        "Anxious": [
            Story(title: "The Ancient Oak", content: "Breathe with me, deep and slow. In through your nose, out through your mouth. Imagine a vast, quiet forest, and right in the center is an ancient, massive oak tree. The wind is howling, and the branches are furiously whipping back and forth in a fierce storm. But under the earth, those roots are wrapped tightly around solid rock. The tree does not panic; it just holds on and lets the storm pass over it. Your anxiety is just weather, my brave one. You are the tree. Send your roots down deep. The storm will exhaust itself and pass, but you will still be standing.", category: "Nature", readTime: 3),
            Story(title: "The River's Flow", content: "Ideally, life is meant to flow like a beautiful, continuous river. Sometimes that river rushes violently over sharp rocks, and sometimes it meanders calmly through green meadows. But the water never worries about where it's going—it simply trusts that the path will eventually lead it to the vast, peaceful ocean. You are trying to control the water right now, and it is exhausting you. Trust your path, my dear. You will get to exactly where you need to be. Let go of the oars for a moment and just let the current carry you.", category: "Moral", readTime: 3),
            Story(title: "Grandma's Secret Pocket", content: "I used to carry a very smooth, polished river stone deep in my apron pocket whenever I felt scared or nervous. Whenever my heart would start racing, I'd trace the smooth edges with my thumb and quietly remind myself: 'This too shall pass. I am safe.' Imagine I am placing that very same warm stone into the palm of your hand right now. Close your fingers around it. Feel its weight. Whenever your mind races today, gently squeeze your hand and know that Grandma is right here with you.", category: "Comfort", readTime: 2)
        ],
        "Lonely": [
            Story(title: "The Symphony of Stars", content: "Oh, my precious one. Loneliness can feel so frightfully cold and vast. But I want you to step outside tonight and look up at the dark sky. Do you see all those millions of stars? Each one is sitting alone in the freezing darkness of space, separated by millions of miles. And yet, together, they create the most breathtaking, sparkling blanket that comforts the entire world. We are all under that exact same sky. You might feel like a single star right now, but you are part of a beautiful, connected constellation. You are never truly alone.", category: "Bedtime", readTime: 4),
            Story(title: "The Invisible Thread", content: "There is an old, ancient legend that says an invisible red thread connects those who are destined to love and support each other. It can stretch across oceans and stretch through years of time, but it never, ever breaks. Even when you are sitting in a quiet, empty room and the silence feels heavy, that thread is tied firmly around your heart, connecting you right to mine, and to the hearts of people you haven't even met yet. Give it a little tug in your mind, and know that I am tugging back.", category: "Moral", readTime: 3),
            Story(title: "The Letter in the Mail", content: "When I was a young woman living alone in a new city, I used to feel incredibly lonely. The mailboxes were always empty. So, I started writing kind letters to myself. I would tell myself all the wonderful things I desperately needed to hear: 'You are kind, you are smart, you are deeply worthy of love.' And when they arrived in the mail days later, it felt like a hug from a dear friend. Maybe today, you can be your own best friend, too. Write yourself a note of love. You deserve to hear it.", category: "Comfort", readTime: 2)
        ],
        "Tired": [
            Story(title: "The Cozy Quilt", content: "Oh my dear, you look so very weary. Your shoulders are drooping and your eyes are heavy. Let me tell you about the thick patchwork quilt my mother hand-made for me when I was a child. It was heavy, soft, and smelled faintly of lavender and old cedar. Whenever the world demanded too much of me, I would crawl under that heavy quilt, and the weight of the fabric made the weight of the world disappear. Imagine me tucking that quilt securely around you right now. Close your eyes. You don't have to carry anything today. Just rest.", category: "Comfort", readTime: 3),
            Story(title: "The Hibernating Bear", content: "Think of the great grizzly bears up in the snowy mountains. They sleep all winter long, completely still, letting the snow pile high outside their dens. They don't apologize for resting; they don't feel guilty for not being out foraging. They know deep in their bones that immense rest is exactly how they survive. You are allowed to hibernate, my sweet love. Rest is not a weakness; it is the ultimate act of gathering your strength. Let out a big yawn and simply close your eyes.", category: "Bedtime", readTime: 2),
            Story(title: "The Cat on the Windowsill", content: "Have you ever just sat quietly and watched a house cat sleep in a warm puddle of sunshine? They are the purest masters of rest. They stretch their front paws out, they yawn widely, and they do not have a single worry about the chores or the emails waiting for them. Channel your inner cat today. Find a warm, quiet spot in your house, curl up, and just... be. The world will still be there when you wake up, I promise.", category: "Funny", readTime: 2)
        ],
        "Angry": [
            Story(title: "The Thunderstorm", content: "I see the fierce fire in your eyes, and your jaw is set so tight. Anger is exactly like a wild, sudden thunderstorm. It rumbles loudly in your chest, lightning flashes in your mind, and it demands to be felt. It is terrifying, but it is also completely natural. You do not need to fight the storm. Let the thunder roll and the heavy rain fall. But always remember, a storm eventually runs out of rain. And when it passes, it leaves the air smelling fresh, and the ground washed clean. Let the anger wash through you and leave you clean.", category: "Nature", readTime: 3),
            Story(title: "The Hot Coal", content: "When I was younger, my temper was quick. Someone told me once that holding onto bitter anger is exactly like grasping a burning hot coal with the intent of throwing it at someone else. Who is the one getting burned? Only you. Your hands, your heart, your peace of mind. I know you feel justified, and perhaps you are! But drop the coal, my dear. Let it fall to the dirt. Step away and let your own hands heal. You deserve peace much more than you deserve to be 'right'.", category: "Moral", readTime: 2),
            Story(title: "The Scribble Page", content: "Whenever I was boiling mad and the words wouldn't come out right, I would take a big black crayon and scribble as hard and as violently as I could on a scratch piece of paper. Round and round, pressing so hard the wax would snap! I'd draw sharp lines and chaotic circles. And you know what? It felt wonderfully exhausting. It is so much better to let that fierce energy out on a piece of paper instead of letting it burn up inside you or hurt the people around you. Try it sometime! Get the angriest crayon you have.", category: "Funny", readTime: 2)
        ],
        "Grateful": [
            Story(title: "The Thank You Jar", content: "Oh, what a wonderfully warm, expansive feeling gratitude is! It makes your chest feel light. Let me tell you about my old glass Thank You Jar. Every evening, I would take a tiny scrap of paper and write down just one incredibly small thing I was thankful for. Not the big things like a promotion or a new house, but things like 'a perfectly ripe peach' or 'the smell of rain on hot pavement.' After a year, the jar was overflowing. When you train your eyes to look for tiny miracles, you suddenly realize they are scattered everywhere around you.", category: "Moral", readTime: 3),
            Story(title: "The Golden Spectacles", content: "Imagine for a moment if I handed you a pair of antique, magical golden glasses. The moment you slip them onto your face, everything you love starts to glow with a soft, warm, radiant light. The coffee mug in your hand glows. The faithful dog at your feet glows. The sunshine coming through the window glows brightly. Gratitude is simply putting on those invisible golden glasses. You suddenly stop seeing what is missing, and you are surrounded by the blinding beauty of everything you already have.", category: "Bedtime", readTime: 3),
            Story(title: "The Gift of Today", content: "There is an old saying that I've always held close to my heart: Yesterday is history, tomorrow is a total mystery, but today is an absolute gift. That is precisely why it is called the 'present'! You are unwrapping today right now. Whatever it holds, whatever challenges or simple joys, it is yours to live. I am so deeply grateful for the precious gift of you, sitting right here, sharing this exact moment with me.", category: "Short", readTime: 1)
        ],
        "Excited": [
            Story(title: "The Ticket to Anywhere", content: "Oh, I can see the absolutely electric sparkle in your eyes! You remind me of the day I found a train ticket tucked inside an old birthday card. It was a ticket to anywhere I wanted to go. Do you know that fluttering, slightly nervous, wonderfully light feeling in your stomach? That is the feeling of sheer, boundless possibility. Run with it, my adventurous one! Let that excitement carry you like a strong wind. The world is vast and waiting just for you to step out the door.", category: "Short", readTime: 3),
            Story(title: "The First Snowfall", content: "Do you remember the unparalleled magic of waking up as a small child, rushing to the window, and seeing the entire world turned pristine, sparkling white? The dirt and the roads were covered in a thick blanket of quiet snow. The urge to immediately run outside, be the very first person to make footprints, to catch a frozen snowflake on your tongue—that is pure, unadulterated excitement. Hold onto that child-like wonder tightly. Let yourself be thrilled by the newness of things!", category: "Nature", readTime: 2),
            Story(title: "The Bakery Smell", content: "There is absolutely nothing like walking past a small neighborhood bakery early in the morning. The rich, buttery smell of yeast and warm sugar floats out the door and wraps around you. The sheer anticipation of stepping inside and waiting for that very first, hot, flaky bite is intoxicating! Life, my dear, is full of sweet, delicious moments waiting just around the corner, waiting for you to taste them. Savor this lively anticipation!", category: "Funny", readTime: 2)
        ]
    ]

    // MARK: - Hindi Stories (हिन्दी कहानियाँ)

    private lazy var hindiStories: [String: [Story]] = [
        "Happy": [
            Story(title: "खुशी का बगीचा", content: "अरे, मेरे प्यारे! तुम्हें मुस्कुराते देखकर मेरा दिल खिल उठता है। खुशी वैसी ही होती है जैसे बसंत में मेरा पुराना बगीचा। मैं घुटनों के बल बैठकर घास उखाड़ती और छोटे-छोटे बीज बोती थी। कभी-कभी सोचती — क्या कुछ उगेगा भी? लेकिन फिर एक सुबह, पूरा आँगन पीले गेंदों, गुलाबी गुलाबों और लाल ट्यूलिप से भर जाता था। यही तो खुशी है — उन सारी अच्छी चीज़ों का अचानक खिल जाना जो तुम अपने अंदर चुपचाप पाल रहे थे। आज उस धूप में भीगो। तुमने हर पंखुड़ी कमाई है।", category: "Nature", readTime: 3),
            Story(title: "अचानक की पिकनिक", content: "याद है जब हम पिकनिक पर गए और घर पर टोकरी भूल आए? हम हँसते-हँसते लोट-पोट हो गए थे! रास्ते में जंगली जामुन खाए और उस बड़े-से पेड़ की छाँव में मज़ेदार किस्से सुनाए। जो खाना था वो नहीं था, पर वो पल परफेक्ट था — क्योंकि हम साथ थे। असली खुशी किसी योजना में नहीं, बल्कि उन अनायास और लापरवाह लमहों में होती है जो हम अपने प्यारों के साथ बिताते हैं।", category: "Funny", readTime: 2),
            Story(title: "टिमटिमाते जुगनू", content: "बचपन में गर्मियों की रातें जुगनुओं से भरी होती थीं। वे लंबी घास पर छोटे-छोटे टूटे तारों की तरह नाचते थे। हम दौड़ते, उन्हें हथेलियों में बंद करते, एक इच्छा माँगते और फिर आसमान में उड़ा देते। तुम्हारी मुस्कान अभी ठीक उसी रोशनी जैसी है — शुद्ध, जादुई और अनंत उम्मीद से भरी।", category: "Bedtime", readTime: 4)
        ],
        "Sad": [
            Story(title: "बारिश भरी खिड़की", content: "आओ मेरे पास, प्यारे बच्चे। तुम्हारे कंधों पर यह गर्म कंबल डाल दूँ। आज तुम पर उदासी का बादल मँडरा रहा है। सुनो — बारिश कैसे शीशे पर थपकी दे रही है। कभी-कभी आसमान को भी रोना पड़ता है। धरती को उस पानी की ज़रूरत होती है — धूल धोने के लिए, जड़ों को तृप्त करने के लिए। तुम्हारे आँसू भी ऐसे ही हैं। वे तुम्हारी आत्मा को सींचते हैं। यहाँ मेरे पास बैठो। जब सूरज निकलेगा, तब निकलेगा।", category: "Comfort", readTime: 3),
            Story(title: "टूटा हुआ प्याला", content: "एक बार मेरे हाथ से एक नाज़ुक चीनी मिट्टी का प्याला गिर गया और टूट गया। मैं बहुत दुखी हुई। लेकिन दादाजी ने उसे फेंका नहीं। उन्होंने उसे जोड़ा और टूटी हुई जगहों पर सुनहरा लाख लगाया। बोले, 'अब यह और सुंदर है क्योंकि इसकी एक कहानी है।' तुम अभी टूटा हुआ महसूस कर रहे हो — लेकिन वही दरारें तुम्हारी सोने जैसी ताकत दिखाती हैं।", category: "Moral", readTime: 3),
            Story(title: "चाँद की छुपने की जगह", content: "जानते हो, चाँद भी कभी-कभी गायब हो जाता है। अंधेरी रात उसे ढक लेती है। लेकिन वो जाता नहीं — बस आराम करता है, ताकि फिर और चमकदार होकर आए। जब मन उदास हो, तुम भी छुप सकते हो थोड़ी देर। हर वक्त चमकते रहना ज़रूरी नहीं। बस आराम करो — तुम्हारी रोशनी वापस आएगी।", category: "Bedtime", readTime: 2)
        ],
        "Anxious": [
            Story(title: "पुराना बरगद", content: "मेरे साथ साँस लो — नाक से अंदर, मुँह से बाहर। कल्पना करो एक घने जंगल के बीच एक विशाल बरगद है। आँधी चल रही है, डालियाँ झूल रही हैं। लेकिन ज़मीन के नीचे उसकी जड़ें पत्थरों को थामे हैं। पेड़ घबराता नहीं — बस टिका रहता है। तुम्हारी चिंता भी बस एक मौसम है। तुम वो पेड़ हो। अपनी जड़ें गहरी उतारो। तूफान थक जाएगा — तुम खड़े रहोगे।", category: "Nature", readTime: 3),
            Story(title: "नदी का बहाव", content: "ज़िंदगी नदी की तरह बहती है। कभी पत्थरों से टकराती है, कभी मैदानों में शांत हो जाती है। पर पानी कभी नहीं पूछता — मुझे कहाँ जाना है? वो बस बहता रहता है, जानता है कि रास्ता मिल ही जाएगा। तुम पानी को रोकने की कोशिश कर रहे हो — यही थका देता है। जाने दो। तुम वहाँ पहुँचोगे जहाँ तुम्हें होना चाहिए।", category: "Moral", readTime: 3),
            Story(title: "दादी की जेब का पत्थर", content: "जब मैं डरती थी, मेरे apron की जेब में एक चिकना-सा पत्थर होता था। जब दिल तेज़ धड़कता, मैं उसे अँगूठे से सहलाती और कहती — 'यह भी गुज़र जाएगा। मैं सुरक्षित हूँ।' अभी कल्पना करो मैं वही पत्थर तुम्हारी हथेली में रख रही हूँ। उसे पकड़ो। उसका भार महसूस करो। जब मन भागे — बस इसे थामो। दादी यहाँ है।", category: "Comfort", readTime: 2)
        ],
        "Lonely": [
            Story(title: "तारों की सिम्फनी", content: "मेरे प्यारे, अकेलापन बहुत ठंडा और विशाल लगता है। लेकिन आज रात बाहर जाओ और आसमान देखो। लाखों तारे हैं — हर एक करोड़ों मील दूर, अकेला। फिर भी मिलकर वे एक ऐसी चादर बनाते हैं जो पूरी दुनिया को सहलाती है। हम सब उसी आसमान के नीचे हैं। तुम भले अभी अकेले तारे लगो — पर तुम एक पूरे तारामंडल का हिस्सा हो। कभी सच में अकेले नहीं।", category: "Bedtime", readTime: 4),
            Story(title: "अदृश्य धागा", content: "एक पुरानी कहानी है — एक लाल धागा उन लोगों को बाँधता है जो एक-दूसरे से प्यार करने के लिए बने हैं। वो धागा समुद्र पार करता है, सालों से नहीं टूटता। अभी जब कमरा सुनसान लगे और चुप्पी भारी हो — वो धागा तुम्हारे दिल से मेरे दिल तक बँधा है। ज़रा खींचो — मैं भी खींच रही हूँ।", category: "Moral", readTime: 3),
            Story(title: "डाक में पत्र", content: "जब मैं किसी नए शहर में अकेली रहती थी, लेटरबॉक्स खाली होता था। तो मैंने खुद को पत्र लिखने शुरू किए। अपने आप से कहती — 'तुम दयालु हो, बुद्धिमान हो, प्यार के लायक हो।' जब वो पत्र आते, लगता जैसे किसी दोस्त ने गले लगाया हो। आज तुम भी खुद के सबसे अच्छे दोस्त बनो। खुद को एक प्यार का नोट लिखो। तुम इसके हकदार हो।", category: "Comfort", readTime: 2)
        ],
        "Tired": [
            Story(title: "आरामदेह रजाई", content: "मेरे प्यारे, तुम बहुत थके नज़र आ रहे हो। मेरी माँ ने जो रजाई बनाई थी — वो भारी, मुलायम थी, लैवेंडर और पुराने देवदार की खुशबू से महकती थी। जब दुनिया बहुत माँगने लगती, मैं उसके नीचे दुबक जाती और दुनिया का बोझ हल्का हो जाता। कल्पना करो मैं अभी वो रजाई तुम पर ओढ़ा रही हूँ। आँखें बंद करो। आज कुछ उठाने की ज़रूरत नहीं। बस आराम करो।", category: "Comfort", readTime: 3),
            Story(title: "हाइबरनेट करता भालू", content: "पहाड़ों के भालुओं की सोचो — वे सारी जाड़े में सोते हैं। माफी नहीं माँगते। जानते हैं कि यही ताकत जमा करने का तरीका है। तुम भी हाइबरनेट कर सकते हो। आराम कमज़ोरी नहीं, बल्कि ताकत जुटाने की कला है। एक बड़ी उबासी लो और बस... सो जाओ।", category: "Bedtime", readTime: 2),
            Story(title: "खिड़की पर बिल्ली", content: "कभी देखा एक बिल्ली धूप में कैसे सोती है? बेफिक्र, बिना किसी चिंता के। आज उस बिल्ली जैसे बनो। घर में कोई गरम कोना ढूँढो, लेट जाओ बस। दुनिया तुम्हारा इंतज़ार करेगी। वादा।", category: "Funny", readTime: 2)
        ],
        "Angry": [
            Story(title: "आँधी-तूफान", content: "मैं तुम्हारी आँखों में आग देख रही हूँ। गुस्सा एक अचानक आए तूफान जैसा होता है — गरजता है, बिजली चमकती है। डरावना है, पर स्वाभाविक भी। तूफान से लड़ो मत। बस उसे गुज़रने दो। तूफान आखिरकार थक जाता है — और पीछे ताज़ी हवा और धुली धरती छोड़ जाता है। गुस्से को भी बहने दो — और शांत हो जाने दो।", category: "Nature", readTime: 3),
            Story(title: "जलता कोयला", content: "जब मैं छोटी थी, मेरा गुस्सा जल्दी उठता था। किसी ने कहा — गुस्से को पकड़े रहना ऐसा है जैसे जलता कोयला किसी पर फेंकने के लिए हाथ में थामे रहो। जलता कौन है? बस तुम। अपने हाथ छोड़ दो। कोयला गिराओ। अपने आप को शांति देने का हक है — यह सही-गलत से ज़्यादा ज़रूरी है।", category: "Moral", readTime: 2),
            Story(title: "काले क्रेयॉन की लकीरें", content: "जब मुझे बहुत गुस्सा आता था, मैं एक काले क्रेयॉन से कागज़ पर जोर-जोर से लकीरें खींचती थी। गोल-गोल, तेज़-तेज़! और जानते हो क्या हुआ? अच्छा लगा। उस ऊर्जा को कागज़ पर निकालना किसी को चोट पहुँचाने से कहीं बेहतर है। कभी कोशिश करो — सबसे गुस्से वाला क्रेयॉन उठाओ!", category: "Funny", readTime: 2)
        ],
        "Grateful": [
            Story(title: "शुक्रिया का डिब्बा", content: "कृतज्ञता कितनी गर्म और विशाल भावना है! मेरे पास एक पुराना शीशे का डिब्बा था — हर शाम मैं एक छोटी-सी चीज़ का शुक्रिया लिखती थी। बड़ी तरक्की नहीं — बस 'पका हुआ आम' या 'बारिश के बाद की खुशबू।' एक साल में डिब्बा भर गया। जब तुम छोटे-छोटे चमत्कारों को देखने की आदत डालते हो, वे हर जगह मिलते हैं।", category: "Moral", readTime: 3),
            Story(title: "सुनहरे चश्मे", content: "सोचो अगर मैं तुम्हें एक जादुई सुनहरा चश्मा दूँ। उसे पहनते ही — जो भी चीज़ तुमसे प्यार करती है, वो चमकने लगती है। हाथ में चाय का कप, पाँव में बैठा कुत्ता, खिड़की से आती धूप — सब चमकते हैं। कृतज्ञता वही चश्मा है। तुम कमियाँ देखना बंद कर देते हो, और जो है उसकी अंधाधुंध सुंदरता दिखती है।", category: "Bedtime", readTime: 3),
            Story(title: "आज का तोहफा", content: "एक पुरानी कहावत है — कल इतिहास है, कल एक रहस्य, और आज एक तोहफा। इसीलिए इसे 'वर्तमान' कहते हैं! तुम अभी इसे खोल रहे हो। जो भी इसमें हो — यह तुम्हारा है। मैं तुम्हारे होने के लिए गहराई से कृतज्ञ हूँ।", category: "Short", readTime: 1)
        ],
        "Excited": [
            Story(title: "कहीं भी जाने का टिकट", content: "तुम्हारी आँखों में चमक देख रही हूँ! याद है मुझे वो दिन जब मुझे एक जन्मदिन के कार्ड में ट्रेन का टिकट मिला था — कहीं भी जाने का। वो हल्का-सा घबराहट भरा, पर अद्भुत सा जो पेट में उठता है — वो असीमित संभावनाओं की भावना है। उसे पकड़ो, उत्साहित एक! दुनिया तुम्हारा इंतज़ार कर रही है।", category: "Short", readTime: 3),
            Story(title: "पहली बर्फ", content: "याद है बचपन में जब सुबह खिड़की पर दौड़ते और देखते — पूरी दुनिया सफेद हो गई? तुरंत बाहर जाने की, पहले पाँव के निशान बनाने की, जीभ पर बर्फ के टुकड़े पकड़ने की इच्छा — वो शुद्ध उत्साह था। उस बच्चे जैसे रोमांच को थामे रखो। नई चीज़ों से चौंको!", category: "Nature", readTime: 2),
            Story(title: "बेकरी की खुशबू", content: "सुबह-सुबह किसी छोटी बेकरी के पास से गुज़रना — मक्खन और चीनी की मीठी खुशबू! उस पहले गर्म टुकड़े का इंतज़ार — वो खुमारी अलग होती है। ज़िंदगी भी ऐसी ही है — हर मोड़ पर कोई मीठा पल इंतज़ार कर रहा है। इस उत्साह को जी भर के जियो!", category: "Funny", readTime: 2)
        ]
    ]
}
