import Foundation

struct HistoricalStoriesData {
    static func top10Stories(for language: AppLanguage) -> [HistoricalStory] {
        switch language {
        case .mandarin: return mandarinStories
        case .hindi: return hindiStories
        case .spanish: return spanishStories
        case .french: return frenchStories
        case .english: return englishStories
        }
    }

    private static let englishStories: [HistoricalStory] = [
        HistoricalStory(
            title: "Mahatma Gandhi & The Salt March",
            era: "1930 - India",
            summary: "In 1930, to peacefully protest an unjust tax on salt imposed by British rulers, Mahatma Gandhi led a 240-mile march to the Arabian Sea to make his own salt. Thousands joined him along the way. Without raising a single weapon, Gandhi showed the world that peaceful resistance—Satyagraha—could shake an empire. It was a turning point in India's struggle for independence.",
            lessons: [
                "True power comes from inner strength, not violence.",
                "Patience and persistence can overturn the greatest injustices.",
                "Leading by absolute example inspires others to follow."
            ],
            reflectionQuestions: [
                "What would you have done in a situation where the rules felt deeply unfair?",
                "What does this teach us about patience and holding onto our principles?",
                "How can you handle a conflict in your life today with peaceful firmness instead of anger?"
            ],
            personalGrowthTakeaway: "Courage doesn't always roar. Sometimes courage is the quiet, steady choice to do what is right, no matter how long the walk is.",
            iconName: "figure.walk"
        ),
        
        HistoricalStory(
            title: "Nelson Mandela's Forgiveness",
            era: "1990 - South Africa",
            summary: "After spending 27 years in prison for opposing the racist system of apartheid, Nelson Mandela was finally released. Instead of seeking revenge against those who had locked him away, he chose forgiveness. He worked alongside his former captors to build a new, democratic South Africa, eventually becoming its first Black president. His choice prevented a civil war and healed a fractured nation.",
            lessons: [
                "Forgiveness liberates the soul and removes fear.",
                "Resentment is like drinking poison and hoping it will kill your enemies.",
                "True leadership means putting the greater good above personal grievance."
            ],
            reflectionQuestions: [
                "Could you forgive someone who took away 27 years of your life?",
                "What does Mandela's choice teach you about the danger of letting ego and anger control you?",
                "Who in your life might you need to forgive to free yourself?"
            ],
            personalGrowthTakeaway: "Your ability to forgive is your greatest strength. It frees you from the past and allows you to build a beautiful future.",
            iconName: "hands.sparkles"
        ),
        
        HistoricalStory(
            title: "Martin Luther King Jr. & The Dream",
            era: "1963 - United States",
            summary: "During the March on Washington in 1963, Dr. Martin Luther King Jr. delivered his famous 'I Have a Dream' speech to over 250,000 civil rights supporters. He painted a vivid picture of a future where people would not be judged by the color of their skin but by the content of their character. His words ignited a moral awakening and paved the way for landmark civil rights laws.",
            lessons: [
                "A clear, loving vision can unite and move masses of people.",
                "Words have the power to change the course of history.",
                "We must meet physical force with soul force."
            ],
            reflectionQuestions: [
                "What is your dream for the world you will leave behind?",
                "How do you judge others, and how do you wish to be judged?",
                "What does this teach you about the power of your own voice?"
            ],
            personalGrowthTakeaway: "Never underestimate the power of your words and your vision. Speak your truth with love, and you will spark light in others.",
            iconName: "mic.fill"
        ),
        
        HistoricalStory(
            title: "The Christmas Truce of WWI",
            era: "1914 - Europe",
            summary: "During the first Christmas of World War I, something miraculous happened. Without any official orders, soldiers from opposing sides (British and German) climbed out of their muddy trenches to meet in 'No Man's Land.' They exchanged gifts, sang carols, and even played football together. For a few brief hours, humanity triumphed over hostility.",
            lessons: [
                "At our core, we share a common humanity that borders cannot erase.",
                "Compassion can bloom even in the darkest, most terrifying places.",
                "Peace is always a choice, even if only for a moment."
            ],
            reflectionQuestions: [
                "What does it say about humanity that sworn enemies could put down their weapons to sing together?",
                "Are there 'enemies' in your life who might just be people you haven't understood yet?",
                "How can you bring a moment of peace to a stressful situation?"
            ],
            personalGrowthTakeaway: "Look for the humanity in everyone you meet. We are all just people, hoping for warmth, peace, and connection.",
            iconName: "snowflake"
        ),
        
        HistoricalStory(
            title: "The Fall of the Berlin Wall",
            era: "1989 - Germany",
            summary: "For 28 years, the Berlin Wall physically and ideologically divided a city and a nation. Families were torn apart. But on November 9, 1989, following weeks of peaceful protests and a mistaken official announcement, thousands of East Berliners gathered at the wall. The guards were overwhelmed, and the gates were opened. People from both sides climbed the wall, chipping it away with hammers, reuniting with tears of joy.",
            lessons: [
                "No wall is strong enough to forever divide the human spirit.",
                "Ordinary people, united, can dismantle the greatest barriers.",
                "Change can happen in an instant after years of silent pressure."
            ],
            reflectionQuestions: [
                "What 'walls' have you built around your own heart?",
                "What does this teach us about the perseverance of love over fear?",
                "How can you break down barriers between yourself and others?"
            ],
            personalGrowthTakeaway: "Tear down the walls that keep you isolated. Connection, freedom, and love are always worth the effort of breaking through.",
            iconName: "squareshape.split.2x2"
        ),
        
        HistoricalStory(
            title: "The Formation of the United Nations",
            era: "1945 - Global",
            summary: "After the devastating destruction of World War II, 51 countries came together to sign a charter, creating the United Nations. They recognized that the only way to prevent another global catastrophe was through dialogue, cooperation, and a shared commitment to human rights. It was a promise to the future that we would try to solve our problems with words before weapons.",
            lessons: [
                "From great tragedy can come great collaboration.",
                "Dialogue is always superior to destruction.",
                "We are stronger when we work together toward a shared goal."
            ],
            reflectionQuestions: [
                "When you have a conflict, do you seek dialogue or try to 'win' at all costs?",
                "What does the UN teach us about the importance of compromise?",
                "How can you create a 'united' approach in your own family or community?"
            ],
            personalGrowthTakeaway: "Seek understanding before victory. The most lasting peace comes when everyone has a seat at the table.",
            iconName: "globe.americas.fill"
        ),
        
        HistoricalStory(
            title: "Helen Keller's Breakthrough",
            era: "1887 - United States",
            summary: "Left deaf and blind by an illness at 19 months old, Helen Keller lived in a dark, silent, and frustrating world. That changed when her teacher, Anne Sullivan, relentlessly spelled words into her hand. The breakthrough came at a water pump; as water flowed over one hand, Anne spelled 'W-A-T-E-R' in the other. Helen understood. She went on to become a world-renowned author, activist, and speaker.",
            lessons: [
                "The human spirit can overcome seemingly impossible physical barriers.",
                "A dedicated teacher or mentor can change the trajectory of a life.",
                "Knowledge and communication are the keys to unlocking our potential."
            ],
            reflectionQuestions: [
                "How would you handle being locked in a world without sight or sound?",
                "Who are the 'Anne Sullivans' in your life who patiently taught you?",
                "What perceived limitation is currently holding you back, and how can you think differently about it?"
            ],
            personalGrowthTakeaway: "No limitation is absolute. With determination, patience, and the right help, you can find a way to express your unique light.",
            iconName: "hand.point.up.braille.fill"
        ),
        
        HistoricalStory(
            title: "The Eradication of Smallpox",
            era: "1980 - Global",
            summary: "For centuries, smallpox was one of the deadliest diseases on Earth, taking millions of lives. But in a historic global effort led by the World Health Organization, countries put aside their political differences (even during the Cold War) to execute a massive, worldwide vaccination campaign. In 1980, smallpox became the first human disease to be completely eradicated from the planet.",
            lessons: [
                "Science, combined with global unity, can solve impossible problems.",
                "We must look beyond borders when facing mutual threats.",
                "A shared enemy can unite divided peoples."
            ],
            reflectionQuestions: [
                "What can we learn when sworn political enemies work together to save lives?",
                "Are there 'impossible' tasks in your life that just require a coordinated effort?",
                "How does this story change your perspective on human capability?"
            ],
            personalGrowthTakeaway: "When we focus on what binds us rather than what divides us, we can cure the world's deepest ailments.",
            iconName: "cross.case.fill"
        ),
        
        HistoricalStory(
            title: "The Apollo 11 Moon Landing",
            era: "1969 - Space",
            summary: "On July 20, 1969, a human being stepped off a spacecraft and onto the surface of the moon for the first time. 'That's one small step for man, one giant leap for mankind.' The Apollo 11 mission was the result of the tireless work of hundreds of thousands of scientists, engineers, and dreamers. It proved that human ingenuity, when focused on a grand vision, knows no bounds.",
            lessons: [
                "No dream is too big if you are willing to do the work.",
                "Great achievements require teamwork and thousands of unsung heroes.",
                "Exploring the unknown expands our understanding of who we are."
            ],
            reflectionQuestions: [
                "What is your 'moonshot'—the big, scary dream you want to achieve?",
                "How does looking at the stars change your perspective on everyday worries?",
                "Who is part of the 'team' that supports you in your daily life?"
            ],
            personalGrowthTakeaway: "Aim for the stars. Even if you miss, you will expand your universe. Don't be afraid of the unknown.",
            iconName: "moon.stars.fill"
        ),
        
        HistoricalStory(
            title: "The Global Response to COVID-19",
            era: "2020 - Global",
            summary: "When a novel coronavirus swept the globe, humanity faced a terrifying unknown. Lockdowns forced us apart physically, but communities found ways to connect—singing from balconies, checking on elderly neighbors, and clapping for healthcare workers. Scientists worldwide collaborated at unprecedented speeds to develop vaccines. It was a stark reminder of our fragility and our profound interconnectedness.",
            lessons: [
                "We are all deeply connected; what happens to one affects all.",
                "In times of crisis, everyday people become extraordinary heroes.",
                "Resilience isn't about avoiding the storm, but learning to weather it together."
            ],
            reflectionQuestions: [
                "What did isolation teach you about the value of connection?",
                "Who were the quiet heroes in your life during difficult times?",
                "How can you maintain a sense of global unity even when the crisis has passed?"
            ],
            personalGrowthTakeaway: "Cherish your connections. Hard times reveal what is truly essential—health, love, and community.",
            iconName: "heart.text.square.fill"
        )
    ]

    private static let mandarinStories: [HistoricalStory] = [
        HistoricalStory(
            title: "圣雄甘地与食盐长征",
            era: "1930 - 印度",
            summary: "1930年，为了和平抗议英国统治者对食盐征收的不公正税收，圣雄甘地领导了一场240英里的长征，徒步走到阿拉伯海自己制盐。成千上万的人沿途加入了他的行列。甘地没有举起任何武器，却向世界展示了和平抵抗——非暴力不合作（Satyagraha）——可以动摇一个帝国。这是印度争取独立斗争的转折点。",
            lessons: [
                "真正的力量来自内心的坚韧，而不是暴力。",
                "耐心和毅力可以推翻最大的不公正。",
                "以身作则的领导方式会激励他人追随。"
            ],
            reflectionQuestions: [
                "在感到规则极度不公平的情况下，你会怎么做？",
                "这教会了我们关于耐心和坚持原则的什么道理？",
                "今天你如何在生活中用和平的坚定而非愤怒来处理冲突？"
            ],
            personalGrowthTakeaway: "勇气并不总是轰轰烈烈的。有时，勇气是平静而坚定地选择做正确的事，无论这段路程有多长。",
            iconName: "figure.walk"
        ),
        
        HistoricalStory(
            title: "纳尔逊·曼德拉的宽恕",
            era: "1990 - 南非",
            summary: "在因反对种族隔离的种族主义制度而入狱27年后，纳尔逊·曼德拉终于获释。他没有寻求对那些将他关押起来的人进行报复，而是选择了宽恕。他与昔日的抓捕者一起努力建设一个新的民主南非，并最终成为该国第一位黑人总统。他的选择阻止了内战，并治愈了一个分裂的国家。",
            lessons: [
                "宽恕能解放灵魂并消除恐惧。",
                "怨恨就像是自己喝下毒药，却希望敌人去死。",
                "真正的领导力意味着将更伟大的利益置于个人恩怨之上。"
            ],
            reflectionQuestions: [
                "你能原谅剥夺你27年生命的人吗？",
                "曼德拉的选择教会了你什么关于让自负和愤怒控制你的危险？",
                "在你生活中，你可能需要原谅谁来释放自己？"
            ],
            personalGrowthTakeaway: "你宽恕的能力是你最大的力量。它将你从过去中解放出来，让你建立一个美好的未来。",
            iconName: "hands.sparkles"
        ),
        
        HistoricalStory(
            title: "马丁·路德·金与梦想",
            era: "1963 - 美国",
            summary: "在1963年向华盛顿进军期间，马丁·路德·金博士向超过25万名民权支持者发表了他著名的讲演《我有一个梦想》。他生动描绘了一个美好的未来：在那里，人们不会因肤色受到评判，而是基于他们的品格。他的语言点燃了道德觉醒，并为具有里程碑意义的民权法案铺平了道路。",
            lessons: [
                "一个清晰、充满爱的愿景可以团结和打动大众。",
                "语言拥有改变历史进程的力量。",
                "我们必须用灵魂的力量去应对物理上的武力。"
            ],
            reflectionQuestions: [
                "你希望为后人留下一个怎样的世界？你的梦想是什么？",
                "你如何评判他人，你希望别人如何评判你？",
                "这教会了你关于自己发声力量的什么？"
            ],
            personalGrowthTakeaway: "永远不要低估你语言和愿景的力量。带着爱说出你的真理，你就会在他人身上点亮光芒。",
            iconName: "mic.fill"
        ),
        
        HistoricalStory(
            title: "第一次世界大战的圣诞休战",
            era: "1914 - 欧洲",
            summary: "在第一次世界大战的第一个圣诞节期间，发生了一件奇迹。在没有任何官方命令的情况下，敌对双方（英国和德国）的士兵爬出泥泞的战壕，在‘无人区’相遇。他们交换礼物，唱颂歌，甚至一起踢足球。在短短几个小时里，人性战胜了敌意。",
            lessons: [
                "在我们的核心深处，我们共享着国界无法抹去的共同人性。",
                "即使在最黑暗、最可怕的地方，同情心也能绽放。",
                "和平始终是一种选择，哪怕只有短短的一瞬。"
            ],
            reflectionQuestions: [
                "死敌能放下武器一起唱歌，这说明了人性的什么？",
                "你生活中有没有那些可能只是因为你还不了解就被视为‘敌人’的人？",
                "你如何给紧张的情况带去片刻的和平？"
            ],
            personalGrowthTakeaway: "在你遇到的每个人身上寻找人性。我们都是一样的人，渴望温暖、和平与联系。",
            iconName: "snowflake"
        ),
        
        HistoricalStory(
            title: "柏林墙的倒塌",
            era: "1989 - 德国",
            summary: "28年来，柏林墙在地理上和意识形态上分裂了一个城市和一个国家。无数家庭被拆散。但是在1989年11月9日，经过数周的和平抗议以及一次错误发布的官方公告之后，数千名东柏林人聚集在墙边。边防警卫被这浩大的声势压倒，大门终于被打开。两边的人们爬上柏林墙，用锤子将其敲碎，带着喜悦的泪水重新团聚。",
            lessons: [
                "没有任何一堵墙能足够坚固到可以永远分隔人类的精神。",
                "团结起来的普通人可以拆除最巨大的障碍。",
                "经过数年的默默施压，改变可以在一瞬间发生。"
            ],
            reflectionQuestions: [
                "你在自己的心中筑起了什么‘墙’？",
                "关于爱战胜恐惧，这教会了我们什么？",
                "你如何打破自己与他人之间的隔阂？"
            ],
            personalGrowthTakeaway: "推倒那些让你孤立的墙。联系、自由与爱永远值得你去努力突破阻碍。",
            iconName: "squareshape.split.2x2"
        ),
        
        HistoricalStory(
            title: "联合国的成立",
            era: "1945 - 全球",
            summary: "在第二次世界大战带来毁灭性的破坏之后，51个国家齐聚一堂签署了宪章，建立了联合国。他们认识到防止另一场全球性灾难的唯一途径是对话、合作和对人权的共同承诺。这是对未来的庄严承诺：我们将尝试用语言而非武器来解决问题。",
            lessons: [
                "伟大的合作可以从巨大的悲剧中诞生。",
                "对话始终优于毁灭。",
                "当我们为一个共同目标而合作时，我们会变得更加强大。"
            ],
            reflectionQuestions: [
                "当你遇到冲突时，你是寻求对话，还是试图不惜代价‘赢’？",
                "关于妥协的重要性，联合国教会了我们什么？",
                "你如何在自己的家庭或社区中创造一种‘团结一致’的方式？"
            ],
            personalGrowthTakeaway: "在寻求胜利之前先寻求理解。只有当所有人都能坐在谈判桌前时，最持久的和平才会到来。",
            iconName: "globe.americas.fill"
        ),
        
        HistoricalStory(
            title: "海伦·凯勒的突破",
            era: "1887 - 美国",
            summary: "海伦·凯勒在19个月大时因患病而失聪且失明，她生活在一个黑暗、寂静又令人沮丧的世界里。但当她的老师安妮·沙利文不屈不挠地在她的手上拼写单词时，这一切都改变了。突破发生在一个水泵旁；当水流过她的一只手时，安妮在另一只手上拼写了‘W-A-T-E-R’（水）。海伦瞬间明白了。她后来成为了一位世界著名的作家、活动家和演讲家。",
            lessons: [
                "人类的精神可以克服看似不可能的身体障碍。",
                "一位尽职的老师或导师可以改变人一生的轨迹。",
                "知识和沟通是开启我们潜能的关键。"
            ],
            reflectionQuestions: [
                "如果你被锁在一个没有色彩和声音的世界里，你会如何应对？",
                "耐心教导你的生命中的‘安妮·沙利文’是谁？",
                "目前有什么看似限制的东西在阻碍你？你如何换个角度看待它？"
            ],
            personalGrowthTakeaway: "没有任何限制是绝对的。只要有决心、耐心和正确的帮助，你就能找到表达自己独特光芒的方法。",
            iconName: "hand.point.up.braille.fill"
        ),
        
        HistoricalStory(
            title: "天花的根除",
            era: "1980 - 全球",
            summary: "几个世纪以来，天花一直是地球上最致命的疾病之一，夺走了数百万人的生命。但在世界卫生组织主导的历史性全球努力下，各国搁置政治分歧（即使在冷战期间），开展了大规模的全球疫苗接种行动。1980年，天花成为人类第一个真正从地球上根除的疾病。",
            lessons: [
                "科学与全球团结相结合，能够解决不可能的问题。",
                "面对共同的威胁时，我们必须超越国界。",
                "一个共同的敌人可以使分裂的人们团结起来。"
            ],
            reflectionQuestions: [
                "当政治上的宿敌为了拯救生命而合作时，我们能学到什么？",
                "在你的生活中，是否有那些只需要协调合作就能完成的‘不可能的’任务？",
                "这个故事如何改变了你对人类能力的看法？"
            ],
            personalGrowthTakeaway: "当我们关注将我们联系在一起的东西，而不是将我们分开的东西时，我们就能治愈世界上最深的疮痍。",
            iconName: "cross.case.fill"
        ),
        
        HistoricalStory(
            title: "阿波罗11号登月",
            era: "1969 - 太空",
            summary: "1969年7月20日，一个人从宇宙飞船上走下来，首次踏上了月球表面。‘这是个人的一小步，却是人类的一大步。’阿波罗11号任务是数十万名科学家、工程师和梦想家不知疲倦工作的成果。它证明了人类的聪明才智如果集中在一个宏伟的愿景上，它是没有边界的。",
            lessons: [
                "只要你愿意去付出努力，没有哪个梦想是遥不可及的。",
                "伟大的成就需要团队合作和成千上万名无名英雄。",
                "探索未知领域会扩展我们对‘我们是谁’的理解。"
            ],
            reflectionQuestions: [
                "你的‘登月计划’——你想实现的那个宏大又令人畏惧的梦想是什么？",
                "仰望星空如何改变了你对日常烦恼的看法？",
                "在你的日常生活中，谁是支持你的‘团队成员’？"
            ],
            personalGrowthTakeaway: "把目标定在群星。即使你射偏了，你也会广阔你的宇宙。不要害怕未知。",
            iconName: "moon.stars.fill"
        ),
        
        HistoricalStory(
            title: "全球应对新冠疫情",
            era: "2020 - 全球",
            summary: "当新型冠状病毒席卷全球时，人类面临着可怕的未知。封锁在物理上将我们分开，但社区们找到了保持联系的方法——在阳台上唱歌、看望年迈的邻居、为医护人员鼓掌。全球的科学家们以前所未有的速度合作研发疫苗。这清楚地提醒了我们人类的脆弱以及我们深刻的相互联系。",
            lessons: [
                "我们紧密相连；发生在一个人的事，会影响到所有人。",
                "在危机时刻，普通人会成为不平凡的英雄。",
                "韧性不是为了避开风暴，而是学习一起抵御风暴。"
            ],
            reflectionQuestions: [
                "隔离让你学到了哪些关于联系的价值？",
                "在困难时期，你生命中安静的英雄是谁？",
                "即使危机过后，你如何依然保持全球团结的意识？"
            ],
            personalGrowthTakeaway: "珍惜你建立的联系。困难时期揭示了真正本质的东西——健康、爱与社区。",
            iconName: "heart.text.square.fill"
        )
    ]

    private static let hindiStories: [HistoricalStory] = [
        HistoricalStory(
            title: "महात्मा गांधी और नमक सत्याग्रह",
            era: "1930 - भारत",
            summary: "1930 में, ब्रिटिश शासकों द्वारा नमक पर लगाए गए अनुचित कर का शांतिपूर्ण विरोध करने के लिए, महात्मा गांधी ने खुद का नमक बनाने के लिए अरब सागर तक 240 मील की यात्रा का नेतृत्व किया। रास्ते में हजारों लोग उनके साथ जुड़ गए। बिना कोई हथियार उठाए, गांधी ने दुनिया को दिखाया कि शांतिपूर्ण प्रतिरोध—सत्याग्रह—एक साम्राज्य को हिला सकता है। यह भारत के स्वतंत्रता संग्राम में एक महत्वपूर्ण मोड़ था।",
            lessons: [
                "सच्ची शक्ति आंतरिक दृढ़ता से आती है, हिंसा से नहीं।",
                "धैर्य और दृढ़ता सबसे बड़े अन्यायों को भी उलट सकती है।",
                "पूर्ण उदाहरण देकर नेतृत्व करना दूसरों को अनुसरण करने के लिए प्रेरित करता है।"
            ],
            reflectionQuestions: [
                "आप ऐसी स्थिति में क्या करते जहां नियम पूरी तरह से अनुचित लगते?",
                "यह हमें धैर्य और अपने सिद्धांतों पर डटे रहने के बारे में क्या सिखाता है?",
                "आप आज अपने जीवन में किसी संघर्ष को क्रोध के बजाय शांतिपूर्ण दृढ़ता से कैसे संभाल सकते हैं?"
            ],
            personalGrowthTakeaway: "साहस हमेशा दहाड़ता नहीं है। कभी-कभी साहस वह शांत, स्थिर विकल्प होता है जो सही काम करने का होता है, भले ही इसके लिए कितनी भी लंबी दूरी क्यों न तय करनी पड़े।",
            iconName: "figure.walk"
        ),
        
        HistoricalStory(
            title: "नेल्सन मंडेला की क्षमा",
            era: "1990 - दक्षिण अफ्रीका",
            summary: "रंगभेद की नस्लवादी व्यवस्था का विरोध करने के कारण 27 साल जेल में बिताने के बाद, नेल्सन मंडेला को आख़िरकार रिहा कर दिया गया। उन लोगों से बदला लेने के बजाय जिन्होंने उन्हें कैद में रखा था, उन्होंने माफ करना चुना। उन्होंने एक नए, लोकतांत्रिक दक्षिण अफ्रीका का निर्माण करने के लिए अपने पूर्व कैदियों के साथ काम किया और अंततः वे इसके पहले अश्वेत राष्ट्रपति बने। उनके इस विकल्प ने एक गृहयुद्ध को रोक दिया और एक टूटे हुए राष्ट्र को ठीक कर दिया।",
            lessons: [
                "माफी आत्मा को मुक्त करती है और भय को दूर करती है।",
                "नाराजगी जहर पीने जैसा है, इस उम्मीद में कि यह आपके दुश्मनों को मार देगा।",
                "सच्चे नेतृत्व का अर्थ है व्यक्तिगत शिकायत से ऊपर বৃহত্তর भलाई को प्राथमिकता देना।"
            ],
            reflectionQuestions: [
                "क्या आप किसी ऐसे व्यक्ति को माफ कर सकते हैं जिसने आपके जीवन के 27 साल छीन लिए हों?",
                "अहंकार और गुस्से को खुद पर नियंत्रण करने देने के खतरे के बारे में मंडेला का चुनाव आपको क्या सिखाता है?",
                "अपने जीवन में मुक्त होने के लिए आपको किसे माफ करने की आवश्यकता हो सकती है?"
            ],
            personalGrowthTakeaway: "क्षमा करने की आपकी क्षमता आपकी सबसे बड़ी ताकत है। यह आपको अतीत से मुक्त करती है और एक खूबसूरत भविष्य बनाने की अनुमति देती है।",
            iconName: "hands.sparkles"
        ),
        
        HistoricalStory(
            title: "मार्टिन लूथर किंग जूनियर और वो सपना",
            era: "1963 - संयुक्त राज्य अमेरिका",
            summary: "1963 में वाशिंगटन मार्च के दौरान, डॉ. मार्टिन लूथर किंग जूनियर ने नागरिक अधिकारों के 2.5 लाख से अधिक समर्थकों को अपना प्रसिद्ध 'मेरा एक सपना है' भाषण दिया। उन्होंने उस भविष्य की एक स्पष्ट तस्वीर पेश की जहां लोगों को उनकी त्वचा के रंग से नहीं बल्कि उनके चरित्र के आधार पर आंका जाएगा। उनके शब्दों ने एक नैतिक जागृति को प्रज्वलित किया और मील के पत्थर के समान नागरिक अधिकार कानूनों का मार्ग प्रशस्त किया।",
            lessons: [
                "एक स्पष्ट, प्रेमपूर्ण दृष्टिकोण लोगों के जनसमूह को एकजुट कर सकता है और उन्हें आगे बढ़ा सकता है।",
                "शब्दों में इतिहास का मार्ग बदलने की शक्ति होती है।",
                "हमें भौतिक शक्ति का सामना आत्मा की शक्ति से करना चाहिए।"
            ],
            reflectionQuestions: [
                "आप अपने पीछे कैसी दुनिया छोड़ना चाहेंगे, आपका सपना क्या है?",
                "आप दूसरों का न्याय कैसे करते हैं, और आप कैसे चाहते हैं कि आपका न्याय किया जाए?",
                "यह आपको अपनी खुद की आवाज़ की शक्ति के बारे में क्या सिखाता है?"
            ],
            personalGrowthTakeaway: "कभी भी अपने शब्दों और अपनी दृष्टि की शक्ति को कम मत समझो। प्रेम के साथ अपना सच बोलो, और तुम दूसरों में भी उम्मीद जगा दोगे।",
            iconName: "mic.fill"
        ),
        
        HistoricalStory(
            title: "प्रथम विश्व युद्ध का क्रिसमस युद्धविराम",
            era: "1914 - यूरोप",
            summary: "प्रथम विश्व युद्ध की पहली क्रिसमस के दौरान, कुछ चमत्कारी हुआ। बिना किसी आधिकारिक आदेश के, विरोधी पक्षों (ब्रिटिश और जर्मन) के सैनिक 'नो मैन्स लैंड' में मिलने के लिए अपनी कीचड़ भरी खाइयों से बाहर निकल आए। उन्होंने उपहारों का आदान-प्रदान किया, कैरोल गाए, और यहां तक कि एक साथ फुटबॉल भी खेला। कुछ ही घंटों के लिए, मानवता ने शत्रुता पर विजय प्राप्त की।",
            lessons: [
                "हमारे मूल में, हम एक साझा मानवता साझा करते हैं जिसे कोई भी सीमा नहीं मिटा सकती।",
                "सबसे अंधेरे, सबसे भयानक स्थानों में भी करुणा पनप सकती है।",
                "शांति हमेशा एक विकल्प है, भले ही वह केवल कुछ पल के लिए हो।"
            ],
            reflectionQuestions: [
                "यह मानवता के बारे में क्या कहता है कि कट्टर दुश्मन एक साथ गाने के लिए हथियार छोड़ सकते हैं?",
                "क्या आपके जीवन में ऐसे 'दुश्मन' हैं जो शायद वे लोग हैं जिन्हें आप अभी तक समझ नहीं पाए हैं?",
                "आप किसी तनावपूर्ण स्थिति में शांति का क्षण कैसे ला सकते हैं?"
            ],
            personalGrowthTakeaway: "आप जिस किसी से भी मिलें, उसमें मानवता की तलाश करें। हम सभी बस इंसान हैं, जो गर्मी, शांति और आपसी जुड़ाव की उम्मीद कर रहे हैं।",
            iconName: "snowflake"
        ),
        
        HistoricalStory(
            title: "बर्लिन की दीवार का गिरना",
            era: "1989 - जर्मनी",
            summary: "28 वर्षों तक, बर्लिन की दीवार ने भौतिक और वैचारिक रूप से एक शहर और एक राष्ट्र को विभाजित रखा। परिवार बिखर गए थे। लेकिन 9 नवंबर, 1989 को, हफ्तों के शांतिपूर्ण विरोध प्रदर्शनों और एक गलत आधिकारिक घोषणा के बाद, हजारों पूर्वी बर्लिनवासी दीवार पर इकट्ठा हुए। गार्ड अभिभूत हो गए, और फाटक खोल दिए गए। दोनों तरफ के लोग दीवार पर चढ़ गए, उसे हथौड़ों से तोड़ा, और खुशी के आंसुओं के साथ फिर से मिले।",
            lessons: [
                "मानव आत्मा को हमेशा के लिए विभाजित करने के लिए कोई दीवार पर्याप्त मजबूत नहीं है।",
                "असाधारण रूप से एकजुट आम लोग सबसे बड़ी बाधाओं को तोड़ सकते हैं।",
                "सालों के मौन दबाव के बाद बदलाव पल भर में हो सकता है।"
            ],
            reflectionQuestions: [
                "आपने अपने दिल के चारों ओर कौन सी 'दीवारें' बनाई हैं?",
                "यह हमें डर से ऊपर प्यार की दृढ़ता के बारे में क्या सिखाता है?",
                "आप अपने और दूसरों के बीच की बाधाओं को कैसे तोड़ सकते हैं?"
            ],
            personalGrowthTakeaway: "उन दीवारों को गिरा दें जो आपको अलग-थलग रखती हैं। जुड़ाव, स्वतंत्रता और प्यार हमेशा प्रयास करने लायक है।",
            iconName: "squareshape.split.2x2"
        ),
        
        HistoricalStory(
            title: "अंतर्राष्ट्रीय संयुक्त राष्ट्र का गठन",
            era: "1945 - वैश्विक",
            summary: "द्वितीय विश्व युद्ध के विनाशकारी प्रभाव के बाद, 51 देश एक चार्टर पर हस्ताक्षर करने के लिए एक साथ आए, जिससे संयुक्त राष्ट्र का निर्माण हुआ। उन्होंने माना कि एक और वैश्विक आपदा को रोकने का एकमात्र तरीका बातचीत, सहयोग और मानवाधिकारों के प्रति साझा प्रतिबद्धता है। यह भविष्य के लिए एक वादा था कि हम हथियारों से पहले शब्दों से अपनी समस्याओं को हल करने का प्रयास करेंगे।",
            lessons: [
                "महान सहयोग बहुत बड़ी त्रासदी से आ सकता है।",
                "विनाश से हमेशा संवाद श्रेष्ठ होता है।",
                "हम और अधिक मजबूत होते हैं जब हम एक साझा लक्ष्य की दिशा में मिलकर काम करते हैं।"
            ],
            reflectionQuestions: [
                "जब आपका कोई संघर्ष होता है, तो क्या आप बातचीत की तलाश करते हैं या हर कीमत पर जीतने की कोशिश करते हैं?",
                "संयुक्त राष्ट्र हमें समझौते के महत्व के बारे में क्या सिखाता है?",
                "आप अपने ही परिवार या समुदाय में 'एकजुट' दृष्टिकोण कैसे बना सकते हैं?"
            ],
            personalGrowthTakeaway: "जीतने से पहले समझौता और समझ खोजें। सबसे स्थायी शांति तभी आती है जब सभी को समान अधिकार मिलते हैं।",
            iconName: "globe.americas.fill"
        ),
        
        HistoricalStory(
            title: "हेलेन केलर की सफलता",
            era: "1887 - संयुक्त राज्य अमेरिका",
            summary: "19 महीने की उम्र में एक बीमारी के कारण बहरी और अंधी होने वाली हेलेन केलर अंधेरे, खामोश और निराशाजनक दुनिया में रहती थी। लेकिन जब उनकी शिक्षिका एनी सुलिवन ने लगातार उनके हाथों पर अक्षरों को उकेरा, तो सब बदल गया। सफलता एक पानी के पंप पर मिली; जब पानी एक हाथ पर बहा, तो एनी ने दूसरे पर 'W-A-T-E-R' लिखा। हेलेन समझ गई। वह एक विश्व प्रसिद्ध लेखक, कार्यकर्ता और वक्ता बनी।",
            lessons: [
                "मानवीय भावना अकल्पनीय शारीरिक बाधाओं को दूर कर सकती है।",
                "एक समर्पित शिक्षक या गुरु जीवन की दिशा बदल सकता है।",
                "ज्ञान और संचार हमारी क्षमताओं को प्रकट करने की कुंजियाँ हैं।"
            ],
            reflectionQuestions: [
                "आप बिना देखने और सुने वाली दुनिया में कैसे रहेंगे?",
                "आपके जीवन में आपकी एनी सुलिवन कौन हैं जिन्होंने आपको धैर्यपूर्वक सिखाया?",
                "आपको अभी क्या बाधा रोक रही है और आप इसे कैसे दूर कर सकते हैं?"
            ],
            personalGrowthTakeaway: "कोई भी सीमा हमेशा नहीं रहती। निश्चय, धैर्य और सही सहायता से, आप अपनी रोशनी बिखेरने का मार्ग ढूंढ सकते हैं।",
            iconName: "hand.point.up.braille.fill"
        ),
        
        HistoricalStory(
            title: "चेचक का पूर्ण उन्मूलन",
            era: "1980 - वैश्विक",
            summary: "सदियों के लिए चेचक दुनिया में सबसे घातक बीमारियों में से एक था, जिसने लाखों लोगों की जान ली। लेकिन विश्व स्वास्थ्य संगठन (WHO) के नेतृत्व में एक ऐतिहासिक वैश्विक प्रयास में देशों ने अपने राजनीतिक मतभेदों को एक तरफ रखते हुए (शीत युद्ध के दौरान भी) बड़े पैमाने पर वैश्विक टीकाकरण अभियान चलाया। 1980 में चेचक पृथ्वी से पूरी तरह से समाप्त होने वाली पहली मानव बीमारी बन गया।",
            lessons: [
                "विज्ञान और वैश्विक एकता एक असंभव समस्या का समाधान कर सकते हैं।",
                "हमें पारस्परिक खतरों का सामना करते समय सीमाओं से परे देखना होगा।",
                "एक साझा दुश्मन बंटे हुए लोगों को एकजुट कर सकता है।"
            ],
            reflectionQuestions: [
                "हम क्या सीख सकते हैं जब धुर राजनीतिक दुश्मन जीवन बचाने के लिए एक साथ काम करते हैं?",
                "क्या आपके जीवन में ऐसे 'असंभव' कार्य हैं जिनके लिए केवल समन्वित प्रयास की आवश्यकता है?",
                "यह कहानी मानवीय क्षमताओं पर आपका नज़रिया कैसे बदलती है?"
            ],
            personalGrowthTakeaway: "जब हम इस बात पर ध्यान केंद्रित करते हैं कि क्या हमें एक साथ बांधता है, न कि क्या हमें अलग करता है, तो हम दुनिया के सबसे गहरे रोगों को ठीक कर सकते हैं।",
            iconName: "cross.case.fill"
        ),
        
        HistoricalStory(
            title: "अपोलो 11 का चंद्र अभियान",
            era: "1969 - अंतरिक्ष",
            summary: "20 जुलाई 1969 को, एक अंतरिक्षयान से मनुष्य ने पहली बार चाँद की सतह पर कदम रखा: 'यह आदमी के लिए एक छोटा कदम है, मानवता के लिए एक बड़ी छलांग।' अपोलो 11 अभियान हजारों विद्वानों, इंजीनियरों और सपने देखने वालों के अथक परिश्रम का नतीजा था। इसने साबित कर दिया कि जब मानव बुद्धि एक महान दृष्टिकोण पर केंद्रित होती है तो इसकी कोई सीमा नहीं होती।",
            lessons: [
                "कोई भी सपना बहुत बड़ा नहीं होता अगर आप प्रयास करने को तैयार हैं।",
                "महान उपलब्धियों में टीमवर्क और हजारों अनसुने नायकों की आवश्यकता होती है।",
                "अज्ञात की खोज यह हमारी समझ को बढ़ाती है कि हम कौन हैं।"
            ],
            reflectionQuestions: [
                "आपका 'चाँद पर कदम रखना' क्या है — वह बड़ा सपना जो आप पूरा करना चाहते हैं?",
                "तारों की ओर देखना आपके दैनिक चिंताओं को कैसे छोटा कर देता है?",
                "आपके जीवन की उस 'टीम' का हिस्सा कौन है जो आपको सहारा देती है?"
            ],
            personalGrowthTakeaway: "तारों का लक्ष्य रखो। भले ही आप चूक जाएं, लेकिन आप अपने क्षितिज का विस्तार करेंगे। अज्ञात से मत डरो।",
            iconName: "moon.stars.fill"
        ),
        
        HistoricalStory(
            title: "COVID-19 पर वैश्विक प्रतिक्रिया",
            era: "2020 - वैश्विक",
            summary: "जब एक नये कोरोनावायरस ने दुनिया को अपने लपेटे में लिया, तब मानवता का सामना भयानक अज्ञात से हुआ। लॉकडाउन ने हमें शारीरिक रूप से अलग कर दिया, लेकिन लोगों ने जुड़ने के नए तरीके ढूंढ लिए — बालकनी से गाना, बुजुर्ग पड़ोसियों की जाँच करना, और स्वास्थ्य कर्मचारियों के लिए ताली बजाना। दुनिया भर के वैज्ञानिकों ने अप्रत्याशित गति से टीके विकसित करने के लिए काम किया। यह हमारी भेद्यता और हमारे गहरे जुड़ाव का एक स्पष्ट अनुस्मारक था।",
            lessons: [
                "हम सभी गहराई से जुड़े हुए हैं; जो एक के साथ होता है, उसका सभी पर प्रभाव पड़ता है।",
                "संकट के समय में, आम लोग असाधारण नायक बन जाते हैं।",
                "लचीलापन (रिज़िल्यन्स) तूफान से बचने के लिए नहीं, बल्कि इसके साथ टिके रहना सीखने के बारे में है।"
            ],
            reflectionQuestions: [
                "अकेलेपन ने आपको आपसी रिश्ते और जुड़ावों के बारे में क्या सिखाया?",
                "मुश्किल समय के दौरान आपके जीवन में अज्ञात नायक कौन थे?",
                "संकट समाप्त हो जाने के बाद भी आप वैश्विक एकता की भावना कैसे बनाए रख सकते हैं?"
            ],
            personalGrowthTakeaway: "अपने रिश्तों को संजोएं। कठिनाइयाँ प्रकट करती हैं कि वास्तव में क्या आवश्यक है — स्वास्थ्य, प्यार और समाज।",
            iconName: "heart.text.square.fill"
        )
    ]
    private static let spanishStories: [HistoricalStory] = [
        HistoricalStory(
            title: "Mahatma Gandhi y la Marcha de la Sal",
            era: "1930 - India",
            summary: "En 1930, para protestar pacíficamente contra un impuesto injusto sobre la sal impuesto por los gobernantes británicos, Mahatma Gandhi lideró una marcha de 240 millas hasta el Mar Arábigo para fabricar su propia sal. Miles de personas se le unieron en el camino. Sin levantar una sola arma, Gandhi demostró al mundo que la resistencia pacífica (Satyagraha) podía hacer temblar a un imperio. Fue un punto de inflexión en la lucha de la India por su independencia.",
            lessons: [
                "El verdadero poder proviene de la fuerza interior, no de la violencia.",
                "La paciencia y la perseverancia pueden anular las mayores injusticias.",
                "Liderar con el ejemplo absoluto inspira a otros a seguirte."
            ],
            reflectionQuestions: [
                "¿Qué habrías hecho en una situación en la que las reglas se sintieran profundamente injustas?",
                "¿Qué nos enseña esto sobre la paciencia y el aferrarnos a nuestros principios?",
                "¿Cómo puedes manejar un conflicto en tu vida actual con firmeza pacífica en lugar de enojo?"
            ],
            personalGrowthTakeaway: "El valor no siempre ruge. A veces el coraje es la elección silenciosa y constante de hacer lo que es correcto, sin importar cuán largo sea el camino.",
            iconName: "figure.walk"
        ),
        
        HistoricalStory(
            title: "El Perdón de Nelson Mandela",
            era: "1990 - Sudáfrica",
            summary: "Después de pasar 27 años en prisión por oponerse al sistema racista del apartheid, Nelson Mandela fue finalmente liberado. En lugar de buscar venganza contra quienes lo habían encerrado, eligió el perdón. Trabajó junto a sus antiguos captores para construir una nueva Sudáfrica democrática, convirtiéndose eventualmente en su primer presidente negro. Su elección evitó una guerra civil y sanó a una nación fracturada.",
            lessons: [
                "El perdón libera el alma y elimina el miedo.",
                "El resentimiento es como beber veneno y esperar que mate a tus enemigos.",
                "El verdadero liderazgo significa poner el bien mayor por encima del agravio personal."
            ],
            reflectionQuestions: [
                "¿Podrías perdonar a alguien que te quitó 27 años de vida?",
                "¿Qué te enseña la elección de Mandela sobre el peligro de dejar que el ego y la ira te controlen?",
                "¿A quién en tu vida podrías necesitar perdonar para liberarte?"
            ],
            personalGrowthTakeaway: "Tu capacidad de perdonar es tu mayor fortaleza. Te libera del pasado y te permite construir un hermoso futuro.",
            iconName: "hands.sparkles"
        ),
        
        HistoricalStory(
            title: "Martin Luther King Jr. y El Sueño",
            era: "1963 - Estados Unidos",
            summary: "Durante la Marcha en Washington en 1963, el Dr. Martin Luther King Jr. pronunció su famoso discurso 'Tengo un sueño' ante más de 250,000 partidarios de los derechos civiles. Pintó una imagen vívida de un futuro donde las personas no serían juzgadas por el color de su piel sino por el contenido de su carácter. Sus palabras encendieron un despertar moral y allanaron el camino para leyes históricas de derechos civiles.",
            lessons: [
                "Una visión clara y amorosa puede unir y mover a las masas.",
                "Las palabras tienen el poder de cambiar el curso de la historia.",
                "Debemos enfrentar la fuerza física con la fuerza del alma."
            ],
            reflectionQuestions: [
                "¿Cuál es tu sueño para el mundo que dejarás atrás?",
                "¿Cómo juzgas a los demás y cómo deseas ser juzgado?",
                "¿Qué te enseña esto sobre el poder de tu propia voz?"
            ],
            personalGrowthTakeaway: "Nunca subestimes el poder de tus palabras y tu visión. Habla tu verdad con amor, y encenderás la luz en otros.",
            iconName: "mic.fill"
        ),
        
        HistoricalStory(
            title: "La Tregua de Navidad de la Primera Guerra Mundial",
            era: "1914 - Europa",
            summary: "Durante la primera Navidad de la Primera Guerra Mundial, ocurrió algo milagroso. Sin ninguna orden oficial, soldados de bandos opuestos (británicos y alemanes) salieron de sus trincheras fangosas para encontrarse en la 'Tierra de Nadie'. Intercambiaron regalos, cantaron villancicos e incluso jugaron al fútbol juntos. Por unas breves horas, la humanidad triunfó sobre la hostilidad.",
            lessons: [
                "En nuestro núcleo, compartimos una humanidad común que las fronteras no pueden borrar.",
                "La compasión puede florecer incluso en los lugares más oscuros y aterradores.",
                "La paz siempre es una elección, incluso si es solo por un momento."
            ],
            reflectionQuestions: [
                "¿Qué dice sobre la humanidad el hecho de que enemigos jurados pudieran bajar sus armas para cantar juntos?",
                "¿Hay 'enemigos' en tu vida que podrían ser simplemente personas a las que aún no has entendido?",
                "¿Cómo puedes aportar un momento de paz a una situación estresante?"
            ],
            personalGrowthTakeaway: "Busca la humanidad en cada persona que conozcas. Todos somos simplemente personas, esperando calor, paz y conexión.",
            iconName: "snowflake"
        ),
        
        HistoricalStory(
            title: "La Caída del Muro de Berlín",
            era: "1989 - Alemania",
            summary: "Durante 28 años, el Muro de Berlín dividió física e ideológicamente una ciudad y una nación. Las familias fueron separadas. Pero el 9 de noviembre de 1989, tras semanas de protestas pacíficas y un anuncio oficial erróneo, miles de berlineses orientales se reunieron en el muro. Los guardias se vieron abrumados y las puertas se abrieron. Personas de ambos lados treparon el muro, rompiéndolo con martillos y reuniéndose con lágrimas de alegría.",
            lessons: [
                "Ningún muro es lo suficientemente fuerte como para dividir para siempre el espíritu humano.",
                "La gente común y corriente, unida, puede desmantelar las barreras más grandes.",
                "El cambio puede ocurrir en un instante después de años de presión silenciosa."
            ],
            reflectionQuestions: [
                "¿Qué 'muros' has construido alrededor de tu propio corazón?",
                "¿Qué nos enseña esto sobre la perseverancia del amor por sobre el miedo?",
                "¿Cómo puedes derribar las barreras entre tú y los demás?"
            ],
            personalGrowthTakeaway: "Derriba los muros que te mantienen aislado. La conexión, la libertad y el amor siempre valen el esfuerzo de romper lo que nos separa.",
            iconName: "squareshape.split.2x2"
        ),
        
        HistoricalStory(
            title: "La Formación de las Naciones Unidas",
            era: "1945 - Global",
            summary: "Después de la devastadora destrucción de la Segunda Guerra Mundial, 51 países se unieron para firmar una carta, creando las Naciones Unidas. Reconocieron que la única forma de evitar otra catástrofe global era a través del diálogo, la cooperación y un compromiso compartido con los derechos humanos. Fue una promesa hacia el futuro de que intentaríamos resolver nuestros problemas con palabras antes que con armas.",
            lessons: [
                "De una gran tragedia puede surgir una gran colaboración.",
                "El diálogo siempre es superior a la destrucción.",
                "Somos más fuertes cuando trabajamos juntos hacia un objetivo compartido."
            ],
            reflectionQuestions: [
                "Cuando tienes un conflicto, ¿buscas el diálogo o tratas de 'ganar' a toda costa?",
                "¿Qué nos enseñan las Naciones Unidas sobre la importancia de llegar a compromisos?",
                "¿Cómo puedes crear un enfoque 'unido' en tu propia familia o comunidad?"
            ],
            personalGrowthTakeaway: "Busca entender antes que vencer. La paz más duradera se logra cuando todos tienen un asiento en la mesa.",
            iconName: "globe.americas.fill"
        ),
        
        HistoricalStory(
            title: "El Gran Avance de Helen Keller",
            era: "1887 - Estados Unidos",
            summary: "Tras quedar sorda y ciega a causa de una enfermedad a los 19 meses, Helen Keller vivía en un mundo oscuro, silencioso y frustrante. Eso cambió cuando su maestra, Anne Sullivan, deletreaba palabras sin descanso en su mano. El gran avance ocurrió junto a una bomba de agua; mientras el agua fluía sobre una mano, Anne deletreaba 'W-A-T-E-R' (agua) en la otra. Helen comprendió. Tras ese momento, se convirtió en una autora, activista y oradora de renombre mundial.",
            lessons: [
                "El espíritu humano puede superar barreras físicas aparentemente imposibles.",
                "Un maestro o mentor dedicado puede cambiar la trayectoria de una vida.",
                "El conocimiento y la comunicación son las llaves para desbloquear nuestro potencial."
            ],
            reflectionQuestions: [
                "¿Cómo manejarías estar encerrado en un mundo sin vista ni sonido?",
                "¿Quiénes son los tutores 'Anne Sullivans' en tu vida que te enseñaron con paciencia?",
                "¿Qué limitación aparente te está frenando actualmente y cómo puedes pensar diferente al respecto?"
            ],
            personalGrowthTakeaway: "Ninguna limitación es absoluta. Con determinación, paciencia y la ayuda adecuada, puedes encontrar una manera de expresar tu propia e irrepetible luz.",
            iconName: "hand.point.up.braille.fill"
        ),
        
        HistoricalStory(
            title: "La Erradicación de la Viruela",
            era: "1980 - Global",
            summary: "Durante siglos, la viruela fue una de las enfermedades más mortales de la Tierra y cobró millones de vidas. Pero en un esfuerzo histórico mundial liderado por la Organización Mundial de la Salud, los países dejaron de lado sus diferencias políticas (incluso durante la Guerra Fría) para ejecutar una campaña de vacunación mundial masiva. En 1980, la viruela se convirtió en la primera enfermedad humana en ser completamente erradicada del planeta.",
            lessons: [
                "La ciencia, combinada con la unidad global, puede resolver problemas imposibles.",
                "Debemos mirar más allá de nuestras fronteras al enfrentarnos a amenazas mutuas.",
                "Un enemigo compartido puede unir a pueblos divididos."
            ],
            reflectionQuestions: [
                "¿Qué podemos aprender cuando enemigos políticos jurados trabajan juntos para salvar vidas?",
                "¿Hay tareas 'imposibles' en tu vida que simplemente requieran un esfuerzo coordinado?",
                "¿Cómo cambia esta historia tu perspectiva sobre la capacidad humana?"
            ],
            personalGrowthTakeaway: "Cuando nos enfocamos en lo que nos une en lugar de lo que nos divide, podemos curar las enfermedades más profundas del mundo.",
            iconName: "cross.case.fill"
        ),
        
        HistoricalStory(
            title: "El Aterrizaje en la Luna del Apolo 11",
            era: "1969 - Espacio",
            summary: "El 20 de julio de 1969, un ser humano bajó de una nave espacial para pisar la superficie de la luna por primera vez. 'Es un pequeño paso para un hombre, un gran salto para la humanidad.' La misión Apolo 11 fue el resultado del inalcanzable trabajo de cientos de miles de científicos, ingenieros y soñadores. Demostró que el ingenio humano, cuando se centra en una gran visión, no tiene límites.",
            lessons: [
                "Ningún sueño es demasiado grande si estás dispuesto a hacer el trabajo.",
                "Los grandes logros requieren trabajo en equipo y miles de héroes anónimos.",
                "Explorar lo desconocido amplía nuestra comprensión de quiénes somos."
            ],
            reflectionQuestions: [
                "¿Cuál es tu 'viaje a la luna'—ese gran y aterrador sueño que quieres lograr?",
                "¿Cómo el mirar a las estrellas cambia tu perspectiva sobre las preocupaciones diarias?",
                "¿Quién forma parte del 'equipo' que te apoya en tu vida diaria?"
            ],
            personalGrowthTakeaway: "Apunta a las estrellas. Incluso si fallas, ampliarás tu horizonte. No le tengas miedo a lo desconocido.",
            iconName: "moon.stars.fill"
        ),
        
        HistoricalStory(
            title: "La Respuesta Global al COVID-19",
            era: "2020 - Global",
            summary: "Cuando un nuevo coronavirus barrió el mundo entero, la humanidad se enfrentó a un panorama aterrador. Los encierros nos separaron físicamente, pero las comunidades encontraron formas de unirse: cantando desde los balcones, asegurándose de que los vecinos ancianos estuvieran bien y aplaudiendo a los trabajadores de la salud. Los científicos de todo el mundo colaboraron a velocidades sin precedentes para desarrollar vacunas. Fue un duro recordatorio de nuestra fragilidad y de lo profundamente conectados que estamos.",
            lessons: [
                "Todos estamos profundamente conectados; lo que le ocurre a uno, afecta a todos.",
                "En tiempos de crisis, la gente común se convierte en héroes extraordinarios.",
                "La resiliencia no se trata de evitar la tormenta, sino de aprender a superarla juntos."
            ],
            reflectionQuestions: [
                "¿Qué te enseñó el aislamiento sobre el valor de la conexión interpersonal?",
                "¿Quiénes fueron los héroes silenciosos en tu vida durante los tiempos difíciles?",
                "¿Cómo construyes y mantienes un sentido de unidad global incluso superada la crisis?"
            ],
            personalGrowthTakeaway: "Valora tus conexiones con los demás. Los tiempos difíciles revelan qué factores son verdaderamente esenciales: la salud, el amor y la comunidad.",
            iconName: "heart.text.square.fill"
        )
    ]

    private static let frenchStories: [HistoricalStory] = [
        HistoricalStory(
            title: "Mahatma Gandhi et la Marche du Sel",
            era: "1930 - Inde",
            summary: "En 1930, pour protester pacifiquement contre les impôts injustement placés sur le sel par les dirigeants britanniques, le Mahatma Gandhi a dirigé une marche de 240 miles jusqu'à la mer d'Oman pour fabriquer son propre sel. Des milliers l'ont rejoint en chemin. Sans lever la moindre arme, Gandhi a montré au monde entier que la résistance pacifique—la satyagraha—pouvait ébranler un empire. Ce moment fut un grand tournant dans la lutte de l'Inde pour l'indépendance et son autonomie.",
            lessons: [
                "Le véritable pouvoir vient de la force et paix intérieure, pas de la violence.",
                "La patience et la persévérance peuvent renverser d'immenses injustices.",
                "Diriger par l'exemple encourage infailliblement les autres à suivre le mouvement."
            ],
            reflectionQuestions: [
                "Qu'auriez-vous fait dans une situation où les règles et lois vous sembleraient profondément injustes ?",
                "En quoi cette histoire peut-elle influencer notre conception de la persévérance pour nos principes ?",
                "De quelle manière allez-vous dorénavant pacifier les conflits dans votre vie au lieu de chercher la colère ?"
            ],
            personalGrowthTakeaway: "Le courage ne rugit pas toujours de manière impressionnante. Parfois, le courage est fait d'un choix serein à l'épreuve des obstacles vers un chemin meilleur pour autrui.",
            iconName: "figure.walk"
        ),

        HistoricalStory(
            title: "Le Pardon de Nelson Mandela",
            era: "1990 - Afrique du Sud",
            summary: "Après avoir passé 27 ans prison pour son opposition contre le système d'Apartheid raciste, Nelson Mandela fut enfin libéré de son geôle. Au lieu de choisir le chemin menant à la vengeance pour cet emprisonnement, ce grand homme décida finalement le cheminement du pardon absolu. Ce choix permit à une reconstruction nationale d'éviter un sanglant affrontement civil pour le grand bien des individus.",
            lessons: [
                "Le pardon parvient non seulement à adoucir l'âme de l'individu, mais anéantit sa peur la plus secrète.",
                "Dépérir avec du ressentiment serait tel un empoisonnement quotidien nourri d'une espérance fatiguée.",
                "Prendre un rôle de leader, c'est concevoir le succès global plus que par son intérêt individuel propre ou orgueilleux."
            ],
            reflectionQuestions: [
                "Vous serait-il venu à l'esprit possible pardon quant d'autres auraient arraché plus d'une double décennie de votre enfance et accomplissements prévus ?",
                "Cette vision prônée par de vieux dirigeants montre la pure futilité quant au renforcement malsain des passions rudes destructrices.",
                "Vers quelle relation de votre quotidien un humble et discret pardon vous délivrerait des impasses sociales éreintantes actuelles ?"
            ],
            personalGrowthTakeaway: "En l'occurrence, concéder sans arrière pensées un franc pardon montre très assurément toute fière grandeur à soi pour des jours optimisés et radieux à venir.",
            iconName: "hands.sparkles"
        ),

        HistoricalStory(
            title: "Martin Luther King Jr. et le Rêve",
            era: "1963 - États-Unis",
            summary: "Lors de la très forte marche sur Washington l'année de 1963, Martin Luther King Jr prononça son chef-d'œuvre titré « I have a dream » vers des foules approchant les deux cent cinquante mille alliés unis de droits de civisme nationaux et globaux. Cette peinture poétique exposant tout un avenir en phase et exempté du fléau coloriste permit d'inspirer, pour les lendemains approchants, tous fondements justes quant aux jugements purement des belles richesses spirituelles sur la discrimination insalubre de corps.",
            lessons: [
                "Afin de rassembler fermement divers groupements ou individus, on doit exposer toute pensée pure, inclusive et solidaire.",
                "Pour redéfinir sans pitié des courants néfastes et les transformer historiquement, notre élocution devient bien sûr indispensable à sa progression et ascension !",
                "Chaque évasion conflictuelle de mains corporelles trouve d'indéniables adoucissements à même notre forte présence."
            ],
            reflectionQuestions: [
                "Pour les prochains âges planétaires ou locaux qui arriveront à de plus jeunes descendants futurs, quelle serait ta formulation et vision radieuse qui émergera ?",
                "Avec l'évolution, sur quoi désirez vous qu’un individu inconnu porte de manière éthique tout respect envers l’homme à évaluer son portrait intime ? ",
                "S'inspirer sur ces paroles majestueuses montre que toi également tu maîtrises le puissant potentiel pour le jour devant l'iniquité et rudes événements à ta portée !"
            ],
            personalGrowthTakeaway: "Même une maigre ou faible articulation aura sûrement les pleines envergures et facultés pour déclencher l'énorme potentiel aux changements chez tes spectateurs ou compagnons.",
            iconName: "mic.fill"
        ),

        HistoricalStory(
            title: "La Trêve de Noël",
            era: "1914 - L'Europe",
            summary: "En la date précise du tout premier avènement de fêter la Noël au temps difficile d'une première triste guerre globale un vrai miracle divin se dessina par pure bénédiction solennelle dans des lignes sanglantes. Nul besoin ou de consigne pour ce phénomène où ennemis des tranchées ou contrées sortirent du bourbier. Ils décidèrent avec des airs partagés de festivités se transmettre tous joyeux respects sous le partage amicales chants et parties inespérées sur d'anciens champs maculés d'épreuves mortifères effacés avec ferveur temporaire !",
            lessons: [
                "Un rassemblement de traits universels traverse amèrement par toutes absurdités bellicistes de géostratèges par dessus toute notre véritable humanité de confrérie planétaire .",
                "Bien qu'esseulé et face à des circonstances dégradées denses de cruelles folies des jours sombres, cette indulgence pure subsistera infaillible et resplendissante de lumière chaleureuse éternelle !",
                "Cette accalmie amène inconditionnellement vers des actes conscients posés tout délibérément pour instaurer tendrement ses effets sans même aucune restriction."
            ],
            reflectionQuestions: [
                "Si tes fervents anciens dures assaillants d'époques s'arrêtent vers des élans artistiques ou d'ententes unies d'amusement : qu’en penses tu concrètement du résultat final positif d’union ?",
                "Peux-tu deviner certains rivaux, amis brouillés, concurrents très distincts s'avérant très vraisemblablement pas trop étrangers aux même aspirations de paix à espérer tous conjointement de nos proches actuels .",
                "N'hésite pas à instaurer promptement cette sagesse devant n’importe quels futurs embûches émotives à contrecarrer la tempête stressante environnante des proches par moment .."
            ],
            personalGrowthTakeaway: "Tâche de transposer ton acuité aux sensibilités similaires de ton alter ego face à autrui rencontré peu importe tes doutes. Il n’a d'ordinaire qu’humbles joies, affections en besoin ou espoir sincère .",
            iconName: "snowflake"
        ),

        HistoricalStory(
            title: "La Chute du Grand Mur",
            era: "1989 - Allemagne",
            summary: "Presqu'environ trois dizaines ou trentaines de longues suites annuelles, on dut s'obliger en ce territoire allemand distinct ce découpage déchirant une citoyenneté capitale pour tout le pays ! Familles amputés des contacts chers . Malgré ça survint la journée du miracle ; la foule inondât pacifiquement un poste frontière après quelque maladresse télévisuelle ! Ces postes dépassés ouvrent toutes barricades clôturées. L'inattendue destruction effondrée réunifiant enfin tous larmes avec martèlements victorieux du partage libre !.",
            lessons: [
                "La constitution éphémère ne retiendrait de justesse des unions viscérales d’attachement moral en aucune période ! ",
                "Devant toutes infranchissables architectures c'est à coup unanime d’une plèbe associée quant à briser son fardeau lourd oppressant de ses restrictions rigides..",
                "Ne désespère en la stagnation car bien ces bouleversements intenses éclosent spontanément quand ses forces passives agissantes culminent par pure certitude des efforts accumulés !"
            ],
            reflectionQuestions: [
                "Identifier ces lourds remparts qui te protègent souvent trop intensément à éviter ton monde aimant d'amour libre t'est-il évident ? ",
                "S'abandonner vers la peur restreindrait très indéniablement ta poursuite envers d’autres affections d’être en plein potentiel sans aucun barrage artificiel protecteur vain..",
                "Dans un effort journalier comment espérerais-tu anéantir tous ses murs te dissimilant du monde au près d'amitiés pures vraies autour de toi ?? "
            ],
            personalGrowthTakeaway: "Extirpes des murailles illusoires qui t’éloignent de la connexion sociale ou autres amours véritables qui vaudraient fermement tant tes actions résolues à percer du lourd mur .!",
            iconName: "squareshape.split.2x2"
        ),

        HistoricalStory(
            title: "L'Arrivée de cette Coalition Nations-Unis",
            era: "1945 - Événement Mondial ",
            summary: "Avec toutes désolations infligées en une terrifiante Seconde dure Époque belligérante mondiale de destructions.. un accord de cinquante et divers nations décident par l'unanime une conception nouvelle des ententes internationales sur un document des droits sacrés universels fondamentaux pour prévenir tous dégâts. Par un consensus diplomatique : prioriser ce parler dialogué commun avant faire usage aux armements lourds aveugles désastreux pour le salut public de l'humanité",
            lessons: [
                "La pure synergie d’échanges mutuels fleurira incroyablement depuis les gouffres inconditionnels de la catastrophe et ruines historiques de grand peine subies",
                "De la communication intelligible résolverait considérablement avec assurance : d'insensées violences destructrices en série vers nos semblables planétaires",
                "D'immense gains s'acquiert lors qu'il agit d’entremêlés multiples objectifs convergents d’ententes de projets harmonieux unifiés .!"
            ],
            reflectionQuestions: [
                "Concentre-tu vraiment au calme d’une parole modérée lorsqu'apparaît vos oppositions individuelles , et sinon penses tu gagner pour des raisons douteuses ?",
                "Comprendre ces conventions démontre l'absolu fondement inévitables à formuler vers d'authentiques compromis réciproque !",
                "Il te suffit dès ce prochain événement à instituer un comportement plus tolérant conciliant parmi ta chère fratrie famille avec sagesse commune ?."
            ],
            personalGrowthTakeaway: "Incontournable : privilégie toute pleine lucidité sans préjugé pour amener ta prochaine victoire méritée avec sérénité ! Ces triomphes réels partagés l’emportent aux égoïsmes. ",
            iconName: "globe.americas.fill"
        ),

        HistoricalStory(
            title: "La Brillante Percée De Helen",
            era: "1887 - Amériques du nord",
            summary: "Victimes cruelles à cause d'une très forte épreuve de fragilités sensorielles causée en ses courtes très jeunes années la fillette, ce priva brutalement et injustement vision mais en son ouïe limitante ; baigna inlassablement du sentiment oppressif . Mais une figure tutrice décida le cours de ces événements: mademoiselle Anne à forger inlassable et répétée le traçage des écritures langagières tactiles vers ces fragiles paumes manuelles ! Et la compréhension jaillit vers de l'Eau qui fuyait . D'instinct ! S’ouvrit ce lien magique des expressions menant sa grande célébrité écrivaine ou de conférencière à l’avant.",
            lessons: [
                "L'aptitude du vouloir des consciences accomplirait bien des dépassements de l'inimaginable sur-passant  nos corps organiques contraignants !.",
                "Ce rôle guide d'altruiste par ce formateur d'expertises transformerai majestueusement les horizons incertains au potentiel florissant de l’apprentie réceptive!.",
                "Puisque nul destin conteste ses connaissances transmissives pour un total accomplissements des épanouissements intérieurs profonds personnels !"
            ],
            reflectionQuestions: [
                "Devancé de sens vitaux par nature de percevoir ou interagir en commun ; de quel artifice auriez vous pensé utiliser du mieux des créations novatrices pour comprendre ceci ?",
                "Découvrez les vrais noms identifiants à cette “mademoiselle Anne” que représentes vos sages figures influentes encadrant ces savoirs pour de bonnes directions et bienfaits ?.",
                "Quelle se dessine selon ton propre angle et regards ton véritable mur barriéré empêchant ce présent ; à franchir intelligemment à rebrousse poils pour avancer ??."
            ],
            personalGrowthTakeaway: "Un tel défi personnel trouveras infailliblement une finalité transcendée sans limite stricte impossible car persistera toujours d'infimes mais de précieuses lumières expressives intimes étincelantes .",
            iconName: "hand.point.up.braille.fill"
        ),

        HistoricalStory(
            title: "Une Extinction contre ce Fléau.",
            era: "1980 - Effort International Global",
            summary: "Traversant d'imémorables et terrifiants anciens siècles la fameuse Variole faisait d'épouvantables redoutables dégâts éteignant tristement très nombreuses des dizaine et des longues victimes mondiales mortuaires de multitudes. Contre quoi cette instance directive (oms mondiale santés globales); déclara avec forte alliance, même au court une très forte d’opposition d’hostilité des climats d’affrontements internationaux .. à l'éradication : Ces masses campagnes de soins vaccinantes stoppèrent enfin définitivement vers ces années les affres dramatiques et rayera très précisément ce fléaux destructeurs.!",
            lessons: [
                "Même le pire scénarios trouve fin s'unissant aux efforts d'intelligences médico-scientifiques fusionnant au solidaire rassemblement civiques commun.",
                "On supprime très judicieusement tout barrages identitaires , des appartenances bornées au besoin exclusif ou pressent des graves maux qui frapperaient notre globalité de communauté humaine mondiale !",
                "Avec cette adversité partagée , nous créons incroyablement  vers un rapprochement des rassemblements entre des clivages farouchement de pensés lointaines très  soutenue au départ opposés."
            ],
            reflectionQuestions: [
                "Peut t'on décerner cette prouesses exceptionnelles où d'adversité politique ont réussi miraculeusement verser par concorde solidaire pour le stricte objectif aux sauvetages des humaines de populations !",
                "Se pourrait-il à vos défis personnels et inatteignables d'être que concrètes applications liées de part d'une unifiante bonne volonté aux ententes organisés convergents .?",
                "Une de ses actions très constructives modifièrent un tel paramètre aux doutes récurrent de ces grandioses et belles possibilités humaines altruistes ? "
            ],
            personalGrowthTakeaway: "Ces victoires se fondent aux piliers aux alliances où s'attachent fortement le grand respect inconditionnels ; ne s'attardant sur ce simple clivage très destructices , cela soigneras indubitablement toutes plaies communes mortelles..!",
            iconName: "cross.case.fill"
        ),

        HistoricalStory(
            title: "Ce Posé  Lunaire , d'Apollo Onzième .",
            era: "1969 - À l'Espace Spatial Astre :",
            summary: "Quand cet atterrissage s'achève ce mois de ce très beau millésime .. Le représentant pionnier délaissa  son appareil orbital au franchissement versés sur de la poudre fine cendrée des ces nouvelles de ces surfaces rocailleuses . !'Le Pas est petitement pour cet homme  , par conséquent ; de pas de géants envers  à  sa race d’humanité commune.' Cet accomplissement démesurément majestueux provient du fantastiques acharnements par de milles milliers de génies : des savants et  ingénierie utopiste par  grandes visionnaires folles ! Un tel couronnement prodigieux aux rêves démontrèrent l'éclat infini de l'intelligence humaine !  .",
            lessons: [
                "Ce souhait fantasmagorique fou serai indéniablement et complètement conquis du parfait labeur laborieux régulier et du désiré vouloir .",
                "Chaque de fantastiques progrès reposera à juste titre au travers et multiples anonymes d’ouvrier sans aucunes de prestiges célébrités éclatées !",
                "Ceci t’encourage vivement  sans bornes ! À l' exploration au d’incessantes horizons lointain nous épanouissant incroyablement . !"
            ],
            reflectionQuestions: [
                " Quel t’imposes tu comme une fulgurants , lointaines ou un grandiose vertigineuse utopie  à l' accomplissements propre des ces rêves fou souhaités , très hardis ! . ?",
                "En admirant sereinement les étoiles scintillantes loin là-haut réduient considérablement la petitesse minuscule d'un insignifiants problèmes passagers quotidien terrestres !! ??",
                "Ces artisans inconnues , invisibles composant vos petites équipées vous chérissant ; qui furent ce très discrets rouages soutient aux belles quotidiens très vitale ?"
            ],
            personalGrowthTakeaway: "Pointe fermement le doigts d'au delà un firmament d’étoiles : ce ne causera que la beauté d'agrandissement d’espérance et repousser des méconnaissance par l'audace et non de l'intimide peur aux nouveaux jours .",
            iconName: "moon.stars.fill"
        ),

        HistoricalStory(
            title: "Cette Nouvelle  Face aux Maladies Mondiale 19",
            era: "Année 2020  - Mondialisée Terrestre .",
            summary: "Au pire assaut de ces souches virales s’abattirent vertigineuses aux coins terrestres . Le de terrifiants doutes paralyse ce devenir humain ; Les restrictions d’enclavements et enfermements imposée ont cloisonnés nos chers relations et notre chaleureuse corporéités ! Ce n’ont point abattus à toutes initiatives sociales; Des voisins prirent d'innovante mesures liante: Les vocalises partagées de grandes fenêtres! L’assistance de ravitaillement aux fragiles ; le de bruyant hourras applaudis pour cet exceptionnel corps professionnels d'aide médicinales courageuses . Rapidement l'inégalités ont brisé à de records inéluctables pour repousser par  un remède très novateur universel contre l'anéantissement commun .",
            lessons: [
                "Tous individus terrestres tisse cet énorme réseaux étroit reliés de sort où une chute déstabilise entièrement tout ses autres de composantes humaines globalisées ! . ",
                "S'il advient très dramatique évènements anxiogènes des braves inconnues banales surgissent tel une providentielles forces d'aides angéliques de ces heros et d'héroïnes du moment !",
                "Ceci affirme que ; La persistance tenace ce n'est nul refus par couardise envers des tumultes mais on fait ces rudes  traversés au solidarités main contre des pires oragières météores ."
            ],
            reflectionQuestions: [
                "Pour les de difficiles confinement imposée; Quelles enseignements bénéfiques tireriez vraiment  aux importances primordiales inter-humaine chaleureuses manquantes ?!",
                "Nommés ces précieuse pépites bienfaisantes par leurs aides désintéressées en périodes d'une extrêmes accalmies pour des fardeaux  ?!",
                "A force de d'épreuves achevées! . Poursuit tu vraiment la fermetés par de bonnes pensées unies mondialement envers et  plus clémentes en fraternelles ententes  ?"
            ],
            personalGrowthTakeaway: "Protèges et aime fermement l’intensité aimante . C’était seulement ces affres de la privation difficile! . Au cœur du problème seul notre bien , de santés, amours du prochain, et communautaire importait vraiment à tout bien suprême !",
            iconName: "heart.text.square.fill"
        )
    ]
}
