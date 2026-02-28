import SwiftUI

struct CozyActivity: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let iconName: String
    let description: String
    let grandmaTip: String
    let color: Color
    let category: String
    let duration: String
    let steps: [String]
}

struct CozyActivityData {
    static func activities(for language: AppLanguage) -> [CozyActivity] {
        switch language {
        case .mandarin: return mandarinActivities
        case .hindi:    return hindiActivities
        case .spanish:  return spanishActivities
        case .french:   return frenchActivities
        case .english:  return englishActivities
        }
    }

    private static let englishActivities: [CozyActivity] = [
        CozyActivity(
            title: "Knitting Time",
            iconName: "hands.sparkles.fill",
            description: "Find a comfortable chair, pick up your needles, and let the rhythmic clicking calm your mind as you create something warm.",
            grandmaTip: "Don't worry about dropped stitches, dear. Every mistake is just a reminder that it was made by hand with love.",
            color: Color.themeRose,
            category: "Crafting",
            duration: "30-60 min",
            steps: [
                "Find your favorite soft yarn and a pair of needles.",
                "Settle into your go-to comfy chair with good lighting.",
                "Start with a simple cast-on and feel the texture of the wool.",
                "Listen to the rhythmic click-clack of the needles.",
                "Watch your creation grow, row by row."
            ]
        ),
        CozyActivity(
            title: "Bake Cookies",
            iconName: "oven.fill",
            description: "The sweet scent of vanilla and warm chocolate is enough to make any house feel like a home.",
            grandmaTip: "The secret ingredient has always been a little extra pinch of love—and maybe some real butter.",
            color: Color(red: 0.8, green: 0.5, blue: 0.3),
            category: "Kitchen",
            duration: "45 min",
            steps: [
                "Preheat your oven and gather your bowls.",
                "Cream together the butter and sugar until it's light and fluffy.",
                "Fold in the chocolate chips with a wooden spoon.",
                "Scoop little rounds of joy onto your baking sheet.",
                "Wait for that golden-brown color and that magical smell."
            ]
        ),
        CozyActivity(
            title: "Puzzle Fun",
            iconName: "square.grid.3x3.fill",
            description: "Slow down and piece together a beautiful scene. It's not about finishing—it's about the peaceful search.",
            grandmaTip: "Start with the edges, my dear. It's always easier when you have a solid frame to build upon.",
            color: Color.themeGold,
            category: "Mindfulness",
            duration: "20-90 min",
            steps: [
                "Clear a space on the table where you can leave it for a while.",
                "Sort through the pieces and find the straight edges first.",
                "Look for common colors and interesting patterns.",
                "Take your time; there is no rush to finish.",
                "Enjoy the satisfied snap of a perfectly fitting piece."
            ]
        ),
        CozyActivity(
            title: "Afternoon Tea",
            iconName: "cup.and.saucer.fill",
            description: "A warm cup of tea is a hug in a mug. Steep it just right and enjoy the quiet Steam.",
            grandmaTip: "Warm the pot first, and never forget that a biscuit tastes better when shared with a friend.",
            color: Color(red: 0.6, green: 0.7, blue: 0.4),
            category: "Relaxing",
            duration: "15 min",
            steps: [
                "Boil fresh water and pick your favorite loose-leaf blend.",
                "Steep for exactly three minutes to get the perfect flavor.",
                "Choose your favorite ceramic mug—the one that fits your hands perfectly.",
                "Add a drop of honey or a splash of milk if you like.",
                "Sit by the window and watch the world go by as you sip."
            ]
        ),
        CozyActivity(
            title: "Gardening",
            iconName: "leaf.fill",
            description: "Tend to your plants and feel the connection to the earth. A little patience makes everything bloom.",
            grandmaTip: "Talk to your flowers sometimes. They listen better than you'd think, and it's good for the soul.",
            color: Color.themeGreen,
            category: "Nature",
            duration: "30 min",
            steps: [
                "Put on your gloves and step out into the garden or to your windowsill.",
                "Check the soil moisture and clear away any dry leaves.",
                "Give your plants exactly as much water as they need.",
                "Rearrange your pots so they get the best afternoon sun.",
                "Take a deep breath of the fresh, damp earth scent."
            ]
        ),
        CozyActivity(
            title: "Reading Corner",
            iconName: "book.fill",
            description: "Get lost in a story from another time. A book is a quiet friend you can visit anytime.",
            grandmaTip: "A good book is like a warm blanket for the mind. Tuck yourself in and stay a while.",
            color: Color(red: 0.5, green: 0.4, blue: 0.7),
            category: "Imagination",
            duration: "30-60 min",
            steps: [
                "Choose a story that feels like an old friend.",
                "Find your softest blanket and a few extra pillows.",
                "Turn off your phone and let the world fade away.",
                "Read at your own pace, savoring the beautiful words.",
                "Use a pretty ribbon to mark your place when you're done."
            ]
        ),
        CozyActivity(
            title: "Painting Time",
            iconName: "paintbrush.fill",
            description: "Let the colors flow and express your heart. There are no mistakes in art, only happy accidents.",
            grandmaTip: "Don't try to make it perfect. Just try to make it feel like you.",
            color: Color(red: 0.9, green: 0.4, blue: 0.4),
            category: "Creativity",
            duration: "60 min",
            steps: [
                "Set out your paints, brushes, and a jar of clean water.",
                "Start with a light sketch or just a wash of color.",
                "Mix the shades until you find one that brings you joy.",
                "Let the brush dance across the paper without overthinking.",
                "Admire the unique world you've created on your canvas."
            ]
        ),
        CozyActivity(
            title: "Writing Letters",
            iconName: "envelope.fill",
            description: "Send a piece of your heart through the post. Handwriting is a gift that lasts forever.",
            grandmaTip: "A letter is a piece of yourself that travels across miles to say 'I'm thinking of you.'",
            color: Color.themeRose,
            category: "Connection",
            duration: "20 min",
            steps: [
                "Pick out a nice piece of stationery or a simple card.",
                "Hold your favorite pen and think of someone you love.",
                "Start with a warm greeting and share a small, happy detail of your day.",
                "Sign it with your own hand and seal it with care.",
                "Imagine the smile on their face when they open it."
            ]
        ),
        CozyActivity(
            title: "Memory Box",
            iconName: "archivebox.fill",
            description: "Look through old photos and keepsakes. Every object has a story waiting to be remembered.",
            grandmaTip: "Treasures aren't made of gold, dear. They're made of the moments we've gathered along the way.",
            color: Color(red: 0.7, green: 0.6, blue: 0.5),
            category: "Heritage",
            duration: "40 min",
            steps: [
                "Take down that old box from the top shelf.",
                "Handle each photo and ticket stub with gentle care.",
                "Close your eyes and try to remember the sounds and smells of that day.",
                "Organize them into a sequence that tells a beautiful tale.",
                "Write a tiny note on the back of a photo for the next generation."
            ]
        ),
        CozyActivity(
            title: "Evening Rest",
            iconName: "moon.stars.fill",
            description: "Dim the lights and let the day's worries drift away. Peace is the best way to end the day.",
            grandmaTip: "The stars don't hurry, and neither should you. Let your heart find its quiet rhythm.",
            color: Color(red: 0.2, green: 0.3, blue: 0.5),
            category: "Peace",
            duration: "20 min",
            steps: [
                "Lower the lights and maybe light a small candle.",
                "Do some very gentle stretches to release the day's tension.",
                "Listen to the silence or some very soft ambient sounds.",
                "Take five deep, slow breaths, feeling your body relax.",
                "Be thankful for the day that has passed."
            ]
        )
    ]

    private static let mandarinActivities: [CozyActivity] = [
        CozyActivity(
            title: "编织时光",
            iconName: "hands.sparkles.fill",
            description: "找一把舒服的椅子，拿起针线，让有节奏的咔哒声平复你的思绪，亲手织出一份温暖。",
            grandmaTip: "亲爱的，别担心漏针。每一个小瑕疵都在提醒人们，这是倾注了心血和爱的手工作品。",
            color: Color.themeRose,
            category: "手工艺",
            duration: "30-60 分钟",
            steps: [
                "准备好你最喜欢的柔软毛线和一副编织针。",
                "在光线充足的地方，舒舒服服地坐在你常用的椅子上。",
                "从简单的起针开始，感受羊毛的质感。",
                "倾听针尖碰撞发出的富有节奏的声音。",
                "看着你的作品一行接一行地慢慢成形。"
            ]
        ),
        CozyActivity(
            title: "烘焙饼干",
            iconName: "oven.fill",
            description: "香草和热巧克力的甜香足以让任何房子感觉像一个家。",
            grandmaTip: "秘密配料永远是那一点点额外的爱——也许还有真正的黄油。",
            color: Color(red: 0.8, green: 0.5, blue: 0.3),
            category: "厨房",
            duration: "45 分钟",
            steps: [
                "预热烤箱并准备好所需的碗具。",
                "将黄油和糖搅拌到轻盈蓬松的程度。",
                "用木勺轻轻拌入巧克力豆。",
                "在烤盘上舀出一小团一小团的快乐。",
                "等待那诱人的焦黄色和神奇的香气出现。"
            ]
        ),
        CozyActivity(
            title: "拼图乐趣",
            iconName: "square.grid.3x3.fill",
            description: "慢下来，拼凑出一幅美丽的画面。这不仅仅是为了完成，更是在平静的寻找过程中感受宁静。",
            grandmaTip: "亲爱的，从边缘开始。有了稳固的边框，接下来的拼凑就会容易得多。",
            color: Color.themeGold,
            category: "正念",
            duration: "20-90 分钟",
            steps: [
                "在桌子上清理出一块可以保留一段时间的空间。",
                "整理碎片，先找出直边的部分。",
                "寻找相同的颜色和有趣的图案。",
                "慢慢来，完全不需要急着完成。",
                "享受碎块完美拼合时的那份满足感。"
            ]
        ),
        CozyActivity(
            title: "午后清茶",
            iconName: "cup.and.saucer.fill",
            description: "一杯温热的茶就像一个装在杯子里的拥抱。泡得恰到好处，享受那份静谧的蒸汽。",
            grandmaTip: "先暖一下茶壶，永远不要忘记，和朋友分享时饼干吃起来会更香。",
            color: Color(red: 0.6, green: 0.7, blue: 0.4),
            category: "放松",
            duration: "15 分钟",
            steps: [
                "烧开淡水，选择你最喜欢的散叶茶。",
                "静置三分钟，让茶汤呈现完美的风味。",
                "挑选一个你最喜欢的瓷杯——那种刚好贴合你手掌的杯子。",
                "如果喜欢，可以加一滴蜂蜜或一点牛奶。",
                "坐在窗边，一边品茗一边看世界静静流转。"
            ]
        ),
        CozyActivity(
            title: "园艺时光",
            iconName: "leaf.fill",
            description: "照料你的植物，感受与土地的连接。多一点耐心，万物皆可绽放。",
            grandmaTip: "多跟你的花儿说说话。它们比你想象中更懂得倾听，这对灵魂大有裨益。",
            color: Color.themeGreen,
            category: "自然",
            duration: "30 分钟",
            steps: [
                "戴上手套，来到花园里或窗台边。",
                "检查土壤湿度，清理枯萎的叶子。",
                "给你的植物恰到好处的水分。",
                "调整花盆的位置，让它们晒到午后最好的阳光。",
                "深呼吸，感受泥土湿润而清新的芬芳。"
            ]
        ),
        CozyActivity(
            title: "阅读角落",
            iconName: "book.fill",
            description: "沉浸在另一个时代的故事里。书是不管什么时候都可以造访的安静好友。",
            grandmaTip: "一本好书就像给心灵盖上的一条暖毯。把自己裹进去，享受一段宁静时光吧。",
            color: Color(red: 0.5, green: 0.4, blue: 0.7),
            category: "想象力",
            duration: "30-60 分钟",
            steps: [
                "挑选一个让你感到亲切的故事。",
                "找来你最柔软的毯子和几个额外的枕头。",
                "关掉手机，让喧嚣的世界渐渐远去。",
                "按你自己的节奏阅读，细细品味美妙的文字。",
                "读完后，用一条漂亮的丝带标记出你的进度。"
            ]
        ),
        CozyActivity(
            title: "绘画时光",
            iconName: "paintbrush.fill",
            description: "让色彩流淌，表达你的心声。艺术里没有错误，只有美丽的意外。",
            grandmaTip: "别总想着要做得完美。只要试着画出你自己的感觉就好。",
            color: Color(red: 0.9, green: 0.4, blue: 0.4),
            category: "创意",
            duration: "60 分钟",
            steps: [
                "摆好你的颜料、画笔和一瓶清水。",
                "从简单的草图或一层底色开始。",
                "调配色彩，直到找到让你感到愉悦的色调。",
                "让画笔在纸上随心舞动。不要想太多。",
                "欣赏你在画布上亲手创造的独特世界。"
            ]
        ),
        CozyActivity(
            title: "书写信件",
            iconName: "envelope.fill",
            description: "通过邮寄传递你的一份心意。手写的文字是能够永恒留存的礼物。",
            grandmaTip: "一封信就是你的一部分，跨越千山万水去告诉对方：‘我在想你。’",
            color: Color.themeRose,
            category: "连接",
            duration: "20 分钟",
            steps: [
                "挑选一张漂亮的信纸或一张简单的卡片。",
                "握住你最喜欢的笔，想起一个你爱的人。",
                "从温馨的问候开始，分享你生活中一个小小的快乐细节。",
                "亲手签上你的名字，细心封好信封。",
                "想象他们打开信件时脸上的那抹微笑。"
            ]
        ),
        CozyActivity(
            title: "记忆宝盒",
            iconName: "archivebox.fill",
            description: "翻看老照片和纪念品。每一件物品背后都藏着一段等待被记起的往事。",
            grandmaTip: "财富不一定是由金钱组成的，亲爱的。它是我们在旅途中汇聚的点滴时光。",
            color: Color(red: 0.7, green: 0.6, blue: 0.5),
            category: "传承",
            duration: "40 分钟",
            steps: [
                "从书架顶层取下那个老旧的盒子。",
                "温柔地拿取每一张照片和每一张票根。",
                "闭上眼睛，试着回想起那天的声音和气味。",
                "按照顺序整理它们，编织成一个美丽的故事。",
                "在照片背面写下简短的注释，留给下一代看。"
            ]
        ),
        CozyActivity(
            title: "晚间小憩",
            iconName: "moon.stars.fill",
            description: "调暗灯光，让一天的烦恼随风而去。宁静是结束一天的最好方式。",
            grandmaTip: "星星从不匆忙，你也不必如此。让你的心找到它静谧的节奏。",
            color: Color(red: 0.2, green: 0.3, blue: 0.5),
            category: "宁静",
            duration: "20 分钟",
            steps: [
                "调暗灯光，或许可以点上一盏小蜡烛。",
                "做一些非常轻柔的拉伸，释放一天的紧张感。",
                "倾听寂静或一些非常轻柔的环境音。",
                "进行五次深沉而缓慢的呼吸，感受身体的放松。",
                "感谢这一天平安度过。"
            ]
        )
    ]
    private static let hindiActivities: [CozyActivity] = [
        CozyActivity(
            title: "बुनाई का समय",
            iconName: "hands.sparkles.fill",
            description: "एक आरामदायक कुर्सी खोजें, अपनी सुई उठाएं, और जैसे-जैसे आप कुछ गर्म बनाते हैं, लयबद्ध टिक-टिक को अपने मन को शांत करने दें।",
            grandmaTip: "छूटे हुए टांकों की चिंता मत करो, बेटा। हर गलती बस एक याद दिलाती है कि इसे प्यार से हाथों से बनाया गया था।",
            color: Color.themeRose,
            category: "शिल्प",
            duration: "30-60 मिनट",
            steps: [
                "अपना पसंदीदा नरम ऊन और बुनाई की सुइयों की एक जोड़ी खोजें।",
                "अच्छी रोशनी वाली अपनी आरामदायक कुर्सी पर बैठ जाएं।",
                "एक साधारण शुरुआत करें और ऊन की बनावट को महसूस करें।",
                "सुइयों की लयबद्ध टिक-टिक को सुनें।",
                "अपनी रचना को धीरे-धीरे बढ़ते हुए देखें।"
            ]
        ),
        CozyActivity(
            title: "बिस्कुट बनाना",
            iconName: "oven.fill",
            description: "वैनिला और गरम चॉकलेट की मीठी सुगंध किसी भी घर को घर जैसा महसूस कराने के लिए काफी है।",
            grandmaTip: "सीक्रेट सामग्री हमेशा थोड़ा अतिरिक्त प्यार—और शायद असली मक्खन रही है।",
            color: Color(red: 0.8, green: 0.5, blue: 0.3),
            category: "रसोई",
            duration: "45 मिनट",
            steps: [
                "अपने ओवन को प्रीहीट करें और अपने कटोरे इकट्ठा करें।",
                "मक्खन और चीनी को हल्का और फूला होने तक फेंटें।",
                "लकड़ी के चम्मच से चॉकलेट चिप्स मिलाएँ।",
                "अपनी बेकिंग शीट पर खुशी के छोटे-छोटे गोले रखें।",
                "उस सुनहरे-भूरे रंग और उस जादुई सुगंध का इंतज़ार करें।"
            ]
        ),
        CozyActivity(
            title: "पहेली का आनंद",
            iconName: "square.grid.3x3.fill",
            description: "धीमे हो जाएं और एक खूबसूरत दृश्य के टुकड़ों को जोड़ें। यह खत्म करने के बारे में नहीं है—यह शांतिपूर्ण खोज के बारे में है।",
            grandmaTip: "किनारों से शुरू करो, बेटा। जब आपके पास निर्माण करने के लिए एक ठोस ढांचा होता है तो यह हमेशा आसान होता है।",
            color: Color.themeGold,
            category: "मनन",
            duration: "20-90 मिनट",
            steps: [
                "मेज पर एक जगह साफ करें जहां आप इसे कुछ समय के लिए छोड़ सकें।",
                "टुकड़ों को छाँटें और पहले सीधे किनारों को खोजें।",
                "सामान्य रंगों और दिलचस्प पैटर्न की तलाश करें।",
                "अपना समय लें; खत्म करने की कोई जल्दी नहीं है।",
                "पूरी तरह से फिट होने वाले टुकड़े की संतुष्टि महसूस करें।"
            ]
        ),
        CozyActivity(
            title: "दोपहर की चाय",
            iconName: "cup.and.saucer.fill",
            description: "एक गर्म चाय का प्याला एक मग में गले मिलने जैसा है। इसे बिल्कुल सही तरीके से भिगोएँ और शांत भाप का आनंद लें।",
            grandmaTip: "पहले केतली को गरम करें, और कभी न भूलें कि बिस्कुट का स्वाद तब बेहतर होता है जब उसे किसी दोस्त के साथ साझा किया जाए।",
            color: Color(red: 0.6, green: 0.7, blue: 0.4),
            category: "आराम",
            duration: "15 मिनट",
            steps: [
                "ताजा पानी उबालें और अपना पसंदीदा चाय पत्ती चुनें।",
                "सही स्वाद पाने के लिए ठीक तीन मिनट तक भिगोएँ।",
                "अपना पसंदीदा सिरेमिक मग चुनें—वह जो आपके हाथों में पूरी तरह फिट बैठता हो।",
                "अगर आप चाहें तो शहद की एक बूंद या थोड़ा दूध मिलाएं।",
                "खिड़की के पास बैठें और चाय पीते हुए दुनिया को गुजरते हुए देखें।"
            ]
        ),
        CozyActivity(
            title: "बागवानी",
            iconName: "leaf.fill",
            description: "अपने पौधों की देखभाल करें और धरती से जुड़ाव महसूस करें। थोड़ा धैर्य सब कुछ खिला देता है।",
            grandmaTip: "कभी-कभी अपने फूलों से बात करो। वे तुम्हारी सोच से बेहतर सुनते हैं, और यह आत्मा के लिए अच्छा है।",
            color: Color.themeGreen,
            category: "प्रकृति",
            duration: "30 मिनट",
            steps: [
                "अपने दस्ताने पहनें और बगीचे या अपनी खिड़की की ओर कदम बढ़ाएं।",
                "मिट्टी की नमी की जांच करें और सूखी पत्तियों को साफ करें।",
                "अपने पौधों को उतना ही पानी दें जितना उन्हें जरूरत है।",
                "अपने गमलों को इस तरह व्यवस्थित करें कि उन्हें दोपहर की सबसे अच्छी धूप मिले।",
                "ताजी, गीली मिट्टी की सोंधी खुशबू की एक गहरी सांस लें।"
            ]
        ),
        CozyActivity(
            title: "पढ़ने का कोना",
            iconName: "book.fill",
            description: "किसी दूसरे समय की कहानी में खो जाएं। एक किताब एक शांत दोस्त है जिससे आप कभी भी मिल सकते हैं।",
            grandmaTip: "एक अच्छी किताब मन के लिए एक गर्म कंबल की तरह होती है। खुद को इसमें समेट लें और कुछ देर ठहरें।",
            color: Color(red: 0.5, green: 0.4, blue: 0.7),
            category: "कल्पना",
            duration: "30-60 मिनट",
            steps: [
                "ऐसी कहानी चुनें जो एक पुराने दोस्त की तरह लगे।",
                "अपना सबसे मुलायम कंबल और कुछ अतिरिक्त तकिए खोजें।",
                "अपना फोन बंद कर दें और दुनिया को ओझल होने दें।",
                "अपनी गति से पढ़ें, खूबसूरत शब्दों का आनंद लें।",
                "खत्म करने पर अपनी जगह को चिह्नित करने के लिए एक सुंदर रिबन का उपयोग करें।"
            ]
        ),
        CozyActivity(
            title: "पेंटिंग का समय",
            iconName: "paintbrush.fill",
            description: "रंगों को बहने दें और अपने दिल की बात व्यक्त करें। कला में कोई गलती नहीं होती, बस सुखद घटनाएं होती हैं।",
            grandmaTip: "इसे परफेक्ट बनाने की कोशिश मत करो। बस इसे वैसा बनाने की कोशिश करो जैसा तुम महसूस करते हो।",
            color: Color(red: 0.9, green: 0.4, blue: 0.4),
            category: "रचनात्मकता",
            duration: "60 मिनट",
            steps: [
                "अपने रंग, ब्रश और साफ पानी का जार रखें।",
                "एक हल्के स्केच या बस रंगों की एक लेयर से शुरू करें।",
                "शेड्स मिलाएं जब तक कि आपको वह न मिल जाए जो आपको खुशी दे।",
                "ब्रश को बिना ज्यादा सोचे कागज पर नाचने दें।",
                "अपने कैनवास पर बनाई गई अपनी अनूठी दुनिया की प्रशंसा करें।"
            ]
        ),
        CozyActivity(
            title: "पत्र लिखना",
            iconName: "envelope.fill",
            description: "डाक के जरिए अपने दिल का एक टुकड़ा भेजें। लिखावट एक ऐसा उपहार है जो हमेशा बना रहता बहा है।",
            grandmaTip: "एक पत्र स्वयं का एक टुकड़ा है जो यह कहने के लिए मीलों सफर तय करता है कि 'मैं तुम्हारे बारे में सोच रहा हूँ।'",
            color: Color.themeRose,
            category: "जुड़ाव",
            duration: "20 मिनट",
            steps: [
                "एक अच्छा सा स्टेशनरी या एक साधारण कार्ड चुनें।",
                "अपना पसंदीदा पेन पकड़ें और किसी ऐसे व्यक्ति के बारे में सोचें जिसे आप प्यार करते हैं।",
                "एक गर्मजोशी भरी बधाई के साथ शुरू करें और अपने दिन की एक छोटी, सुखद बात साझा करें।",
                "अपने हाथ से हस्ताक्षर करें और इसे सावधानी से सील करें।",
                "जब वे इसे खोलेंगे तो उनके चेहरे पर मुस्कान की कल्पना करें।"
            ]
        ),
        CozyActivity(
            title: "स्मृति बॉक्स",
            iconName: "archivebox.fill",
            description: "पुरानी तस्वीरों और यादगार चीजों को देखें। हर वस्तु की एक कहानी होती है जो याद किए जाने का इंतज़ार करती है।",
            grandmaTip: "खजाने सोने के नहीं बने होते, बेटा। वे उन पलों से बने होते हैं जिन्हें हमने रास्ते में इकट्ठा किया है।",
            color: Color(red: 0.7, green: 0.6, blue: 0.5),
            category: "विरासत",
            duration: "40 मिनट",
            steps: [
                "ऊपरी शेल्फ से वह पुराना डिब्बा नीचे उतारें।",
                "हर फोटो और टिकट के टुकड़े को कोमलता से संभालें।",
                "अपनी आँखें बंद करें और उस दिन की आवाज़ों और महक को याद करने की कोशिश करें।",
                "उन्हें एक क्रम में व्यवस्थित करें जो एक सुंदर कहानी सुनाए।",
                "अगली पीढ़ी के लिए फोटो के पीछे एक छोटी सी नोट लिखें।"
            ]
        ),
        CozyActivity(
            title: "शाम का विश्राम",
            iconName: "moon.stars.fill",
            description: "रोशनी कम करें और दिन की चिंताओं को दूर होने दें। शांति दिन को खत्म करने का सबसे अच्छा तरीका है।",
            grandmaTip: "तारे जल्दी में नहीं होते, और आपको भी नहीं होना चाहिए। अपने दिल को अपनी शांत लय खोजने दें।",
            color: Color(red: 0.2, green: 0.3, blue: 0.5),
            category: "शांति",
            duration: "20 मिनट",
            steps: [
                "रोशनी कम करें और शायद एक छोटी मोमबत्ती जलाएं।",
                "दिन के तनाव को दूर करने के लिए कुछ बहुत ही कोमल स्ट्रेचिंग करें।",
                "खामोशी या कुछ बहुत ही शांत परिवेश की आवाज़ें सुनें।",
                "अपने शरीर को रिलैक्स महसूस करते हुए पाँच गहरी, धीमी साँसें लें।",
                "बीते हुए दिन के लिए आभारी रहें।"
            ]
        )
    ]
    private static let spanishActivities: [CozyActivity] = [
        CozyActivity(
            title: "Tiempo de Tejer",
            iconName: "hands.sparkles.fill",
            description: "Busca una silla cómoda, toma tus agujas y deja que el clic rítmico calme tu mente mientras creas algo cálido.",
            grandmaTip: "No te preocupes si se te escapa un punto, cielo. Cada error es solo un recordatorio de que fue hecho a mano con amor.",
            color: Color.themeRose,
            category: "Manualidad",
            duration: "30-60 min",
            steps: [
                "Busca tu lana suave favorita y un par de agujas.",
                "Ponte cómodo en tu silla preferida con buena iluminación.",
                "Comienza con un montaje sencillo y siente la textura de la lana.",
                "Escucha el clic-clac rítmico de las agujas.",
                "Mira cómo crece tu creación, fila tras fila."
            ]
        ),
        CozyActivity(
            title: "Hornear Galletas",
            iconName: "oven.fill",
            description: "El dulce aroma de la vainilla y el chocolate caliente es suficiente para que cualquier casa se sienta como un hogar.",
            grandmaTip: "El ingrediente secreto siempre ha sido un poco de amor extra—y tal vez un poco de mantequilla de verdad.",
            color: Color(red: 0.8, green: 0.5, blue: 0.3),
            category: "Cocina",
            duration: "45 min",
            steps: [
                "Precalienta el horno y reúne tus recipientes.",
                "Bate la mantequilla y el azúcar hasta que esté ligera y esponjosa.",
                "Añade las pepitas de chocolate con una cuchara de madera.",
                "Coloca pequeñas porciones de alegría en tu bandeja de horno.",
                "Espera a que tengan ese color dorado y ese olor mágico."
            ]
        ),
        CozyActivity(
            title: "Diversión con Puzzles",
            iconName: "square.grid.3x3.fill",
            description: "Ve despacio y une las piezas de una escena hermosa. No se trata de terminar, sino de la búsqueda tranquila.",
            grandmaTip: "Empieza por los bordes, cariño. Siempre es más fácil cuando tienes un marco sólido sobre el que construir.",
            color: Color.themeGold,
            category: "Mindfulness",
            duration: "20-90 min",
            steps: [
                "Despeja un espacio en la mesa donde puedas dejarlo un tiempo.",
                "Clasifica las piezas y encuentra primero los bordes rectos.",
                "Busca colores comunes y patrones interesantes.",
                "Tómate tu tiempo; no hay prisa por terminar.",
                "Disfruta del chasquido satisfactorio de una pieza que encaja perfectamente."
            ]
        ),
        CozyActivity(
            title: "Té de la Tarde",
            iconName: "cup.and.saucer.fill",
            description: "Una taza de té caliente es un abrazo en una taza. Déjalo reposar justo el tiempo necesario y disfruta del vapor tranquilo.",
            grandmaTip: "Calienta la tetera primero, y nunca olvides que una galleta sabe mejor cuando se comparte con un amigo.",
            color: Color(red: 0.6, green: 0.7, blue: 0.4),
            category: "Relajación",
            duration: "15 min",
            steps: [
                "Hierve agua fresca y elige tu mezcla de hojas sueltas favorita.",
                "Deja reposar exactamente tres minutos para obtener el sabor perfecto.",
                "Elige tu taza de cerámica favorita, la que se adapta perfectamente a tus manos.",
                "Añade una gota de miel o un poco de leche si quieres.",
                "Siéntate junto a la ventana y mira el mundo pasar mientras bebes."
            ]
        ),
        CozyActivity(
            title: "Jardinería",
            iconName: "leaf.fill",
            description: "Cuida tus plantas y siente la conexión con la tierra. Un poco de paciencia hace que todo florezca.",
            grandmaTip: "Habla con tus flores a veces. Escuchan mejor de lo que crees, y es bueno para el alma.",
            color: Color.themeGreen,
            category: "Naturaleza",
            duration: "30 min",
            steps: [
                "Ponte los guantes y sal al jardín o a tu ventana.",
                "Comprueba la humedad de la tierra y quita las hojas secas.",
                "Dale a tus plantas exactamente el agua que necesitan.",
                "Reorganiza tus macetas para que reciban el mejor sol de la tarde.",
                "Respira hondo el aroma de la tierra fresca y húmeda."
            ]
        ),
        CozyActivity(
            title: "Rincón de Lectura",
            iconName: "book.fill",
            description: "Piérdete en una historia de otro tiempo. Un libro es un amigo silencioso que puedes visitar cuando quieras.",
            grandmaTip: "Un buen libro es como una manta caliente para la mente. Arrópate y quédate un rato.",
            color: Color(red: 0.5, green: 0.4, blue: 0.7),
            category: "Imaginación",
            duration: "30-60 min",
            steps: [
                "Elige una historia que se sienta como un viejo amigo.",
                "Busca tu manta más suave y algunos cojines extra.",
                "Apaga el móvil y deja que el mundo desaparezca.",
                "Lee a tu propio ritmo, saboreando las hermosas palabras.",
                "Usa una cinta bonita para marcar tu lugar cuando termines."
            ]
        ),
        CozyActivity(
            title: "Tiempo de Pintar",
            iconName: "paintbrush.fill",
            description: "Deja que fluyan los colores y expresa lo que dicta tu corazón. En el arte no hay errores, solo accidentes felices.",
            grandmaTip: "No intentes que sea perfecto. Solo intenta que se sienta como tú.",
            color: Color(red: 0.9, green: 0.4, blue: 0.4),
            category: "Creatividad",
            duration: "60 min",
            steps: [
                "Prepara tus pinturas, pinceles y un frasco de agua limpia.",
                "Comienza con un boceto ligero o simplemente con una mancha de color.",
                "Mezcla los tonos hasta que encuentres uno que te de alegría.",
                "Deja que el pincel baile sobre el papel sin pensarlo demasiado.",
                "Admira el mundo único que has creado en tu lienzo."
            ]
        ),
        CozyActivity(
            title: "Escribir Cartas",
            iconName: "envelope.fill",
            description: "Envía un pedazo de tu corazón por correo. La escritura a mano es un regalo que dura para siempre.",
            grandmaTip: "Una carta es un trozo de ti mismo que viaja kilómetros para decir 'estoy pensando en ti'.",
            color: Color.themeRose,
            category: "Conexión",
            duration: "20 min",
            steps: [
                "Elige un papel bonito o una tarjeta sencilla.",
                "Sujeta tu bolígrafo favorito y piensa en alguien a quien quieras.",
                "Comienza con un saludo cálido y comparte un pequeño detalle alegre de tu día.",
                "Fírmala de tu puño y letra y séllala con cuidado.",
                "Imagina la sonrisa en su cara cuando la abran."
            ]
        ),
        CozyActivity(
            title: "Caja de Recuerdos",
            iconName: "archivebox.fill",
            description: "Mira fotos antiguas y objetos guardados. Cada objeto tiene una historia esperando ser recordada.",
            grandmaTip: "Los tesoros no están hechos de oro, cielo. Están hechos de los momentos que hemos reunido en el camino.",
            color: Color(red: 0.7, green: 0.6, blue: 0.5),
            category: "Herencia",
            duration: "40 min",
            steps: [
                "Baja esa vieja caja del estante superior.",
                "Toma cada foto y entrada con cuidado y suavidad.",
                "Cierra los ojos e intenta recordar los sonidos y olores de aquel día.",
                "Organízalos en una secuencia que cuente una historia hermosa.",
                "Escribe una pequeña nota al dorso de una foto para la siguiente generación."
            ]
        ),
        CozyActivity(
            title: "Descanso Nocturno",
            iconName: "moon.stars.fill",
            description: "Atenúa las luces y deja que las preocupaciones del día se desvanezcan. La paz es la mejor forma de terminar el día.",
            grandmaTip: "Las estrellas no tienen prisa, y tú tampoco deberías tenerla. Deja que tu corazón encuentre su ritmo tranquilo.",
            color: Color(red: 0.2, green: 0.3, blue: 0.5),
            category: "Paz",
            duration: "20 min",
            steps: [
                "Baja las luces y tal vez enciende una pequeña vela.",
                "Haz algunos estiramientos muy suaves para liberar la tensión del día.",
                "Escucha el silencio o algunos sonidos ambientales muy suaves.",
                "Haz cinco respiraciones profundas y lentas, sintiendo tu cuerpo relajarse.",
                "Agradece el día que ha pasado."
            ]
        )
    ]
    private static let frenchActivities: [CozyActivity] = [
        CozyActivity(
            title: "Temps de Tricot",
            iconName: "hands.sparkles.fill",
            description: "Trouvez une chaise confortable, prenez vos aiguilles et laissez le cliquetis rythmé calmer votre esprit pendant que vous créez quelque chose de chaud.",
            grandmaTip: "Ne t'inquiète pas pour les mailles perdues, ma chérie. Chaque erreur est juste un rappel que c'est fait à la main avec amour.",
            color: Color.themeRose,
            category: "Artisanat",
            duration: "30-60 min",
            steps: [
                "Trouvez votre laine douce préférée et une paire d'aiguilles.",
                "Installez-vous confortablement dans votre chaise préférée avec un bon éclairage.",
                "Commencez par un montage simple et ressentez la texture de la laine.",
                "Écoutez le clic-clac rythmé des aiguilles.",
                "Regardez votre création grandir, rang après rang."
            ]
        ),
        CozyActivity(
            title: "Cuire des Biscuits",
            iconName: "oven.fill",
            description: "La douce odeur de vanille et de chocolat chaud suffit à faire de n'importe quelle maison un foyer.",
            grandmaTip: "L'ingrédient secret a toujours été un petit supplément d'amour—et peut-être du vrai beurre.",
            color: Color(red: 0.8, green: 0.5, blue: 0.3),
            category: "Cuisine",
            duration: "45 min",
            steps: [
                "Préchauffez votre four et rassemblez vos bols.",
                "Battez le beurre et le sucre jusqu'à ce que le mélange soit léger et mousseux.",
                "Incorporez les pépites de chocolat avec une cuillère en bois.",
                "Déposez de petites boules de joie sur votre plaque de cuisson.",
                "Attendez cette couleur brun-doré et cette odeur magique."
            ]
        ),
        CozyActivity(
            title: "Plaisir du Puzzle",
            iconName: "square.grid.3x3.fill",
            description: "Ralentissez et assemblez les pièces d'une belle scène. Il ne s'agit pas de finir, mais de la recherche paisible.",
            grandmaTip: "Commence par les bords, ma chérie. C'est toujours plus facile quand on a un cadre solide sur lequel s'appuyer.",
            color: Color.themeGold,
            category: "Pleine Conscience",
            duration: "20-90 min",
            steps: [
                "Dégagez un espace sur la table où vous pourrez le laisser un moment.",
                "Triez les pièces et trouvez d'abord les bords droits.",
                "Cherchez des couleurs communes et des motifs intéressants.",
                "Prenez votre temps ; il n'y a pas d'urgence à finir.",
                "Appréciez le petit clic satisfaisant d'une pièce parfaitement emboîtée."
            ]
        ),
        CozyActivity(
            title: "Thé de l'Après-midi",
            iconName: "cup.and.saucer.fill",
            description: "Une tasse de thé chaud est un câlin dans un mug. Faites-le infuser juste comme il faut et profitez de la vapeur tranquille.",
            grandmaTip: "Chauffe d'abord la théière, et n'oublie jamais qu'un biscuit a meilleur goût lorsqu'il est partagé avec un ami.",
            color: Color(red: 0.6, green: 0.7, blue: 0.4),
            category: "Relaxation",
            duration: "15 min",
            steps: [
                "Faites bouillir de l'eau fraîche et choisissez votre mélange de feuilles préféré.",
                "Laissez infuser exactement trois minutes pour obtenir la saveur parfaite.",
                "Choisissez votre mug en céramique préféré—celui qui tient parfaitement dans vos mains.",
                "Ajoutez une goutte de miel ou un nuage de lait si vous le souhaitez.",
                "Asseyez-vous près de la fenêtre et regardez le monde passer en sirotant."
            ]
        ),
        CozyActivity(
            title: "Jardinage",
            iconName: "leaf.fill",
            description: "Prenez soin de vos plantes et ressentez le lien avec la terre. Un peu de patience fait tout fleurir.",
            grandmaTip: "Parle à tes fleurs de temps en temps. Elles écoutent mieux que tu ne le penses, et c'est bon pour l'âme.",
            color: Color.themeGreen,
            category: "Nature",
            duration: "30 min",
            steps: [
                "Mettez vos gants et sortez au jardin ou sur votre rebord de fenêtre.",
                "Vérifiez l'humidité du sol et enlevez les feuilles sèches.",
                "Donnez à vos plantes exactement l'eau dont elles ont besoin.",
                "Réorganisez vos pots pour qu'ils profitent au mieux du soleil de l'après-midi.",
                "Prenez une grande inspiration de l'odeur de la terre fraîche et humide."
            ]
        ),
        CozyActivity(
            title: "Coin Lecture",
            iconName: "book.fill",
            description: "Perdez-vous dans une histoire d'un autre temps. Un livre est un ami tranquille que l'on peut visiter n'importe quand.",
            grandmaTip: "Un bon livre est comme une couverture chaude pour l'esprit. Blottis-toi et reste un moment.",
            color: Color(red: 0.5, green: 0.4, blue: 0.7),
            category: "Imagination",
            duration: "30-60 min",
            steps: [
                "Choisissez une histoire qui vous semble être une vieille amie.",
                "Trouvez votre couverture la plus douce et quelques oreillers supplémentaires.",
                "Éteignez votre téléphone et laissez le monde s'effacer.",
                "Lisez à votre propre rythme, en savourant les beaux mots.",
                "Utilisez un joli ruban pour marquer votre page quand vous avez fini."
            ]
        ),
        CozyActivity(
            title: "Temps de Peinture",
            iconName: "paintbrush.fill",
            description: "Laissez couler les couleurs et exprimez votre cœur. Il n'y a pas d'erreurs en art, seulement des accidents heureux.",
            grandmaTip: "N'essaie pas de faire quelque chose de parfait. Essaie juste de faire quelque chose qui te ressemble.",
            color: Color(red: 0.9, green: 0.4, blue: 0.4),
            category: "Créativité",
            duration: "60 min",
            steps: [
                "Installez vos peintures, vos pinceaux et un bocal d'eau propre.",
                "Commencez par une esquisse légère ou juste un lavis de couleur.",
                "Mélangez les nuances jusqu'à ce que vous trouviez celle qui vous apporte de la joie.",
                "Laissez le pinceau danser sur le papier sans trop réfléchir.",
                "Admirez le monde unique que vous avez créé sur votre toile."
            ]
        ),
        CozyActivity(
            title: "Écrire des Lettres",
            iconName: "envelope.fill",
            description: "Envoyez un morceau de votre cœur par la poste. L'écriture manuscrite est un cadeau qui dure pour toujours.",
            grandmaTip: "Une lettre est un morceau de toi-même qui voyage sur des kilomètres pour dire 'je pense à toi'.",
            color: Color.themeRose,
            category: "Connexion",
            duration: "20 min",
            steps: [
                "Choisissez un joli papier à lettres ou une simple carte.",
                "Tenez votre stylo préféré et pensez à quelqu'un que vous aimez.",
                "Commencez par un accueil chaleureux et partagez un petit détail joyeux de votre journée.",
                "Signez de votre main et scellez-la avec soin.",
                "Imaginez le sourire sur leur visage quand ils l'ouvriront."
            ]
        ),
        CozyActivity(
            title: "Boîte à Souvenirs",
            iconName: "archivebox.fill",
            description: "Regardez les vieilles photos et les souvenirs. Chaque objet a une histoire qui attend d'être rappelée.",
            grandmaTip: "Les trésors ne sont pas faits d'or, ma chérie. Ils sont faits des moments que nous avons rassemblés tout au long du chemin.",
            color: Color(red: 0.7, green: 0.6, blue: 0.5),
            category: "Héritage",
            duration: "40 min",
            steps: [
                "Descendez cette vieille boîte de l'étagère du haut.",
                "Manipulez chaque photo et chaque talon de billet avec précaution.",
                "Fermez les yeux et essayez de vous rappeler les sons et les odeurs de cette journée.",
                "Organisez-les dans un ordre qui raconte une belle histoire.",
                "Écrivez une petite note au dos d'une photo pour la génération suivante."
            ]
        ),
        CozyActivity(
            title: "Repos du Soir",
            iconName: "moon.stars.fill",
            description: "Tamisez les lumières et laissez s'envoler les soucis de la journée. La paix est le meilleur moyen de terminer la journée.",
            grandmaTip: "Les étoiles ne se pressent pas, et toi non plus tu ne devrais pas. Laisse ton cœur trouver son rythme tranquille.",
            color: Color(red: 0.2, green: 0.3, blue: 0.5),
            category: "Paix",
            duration: "20 min",
            steps: [
                "Baissez les lumières et allumez peut-être une petite bougie.",
                "Faites quelques étirements très doux pour relâcher la tension de la journée.",
                "Écoutez le silence ou des sons d'ambiance très doux.",
                "Prenez cinq respirations profondes et lentes, en sentant votre corps se détendre.",
                "Soyez reconnaissant pour la journée qui s'est écoulée."
            ]
        )
    ]
}