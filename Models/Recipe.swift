import Foundation
import SwiftUI

struct Recipe: Identifiable {
    let id = UUID()
    let title: String
    let backstory: String
    let ingredients: [String]
    let instructions: [String]
    let prepTime: String
    let cookTime: String
    let iconName: String
    let color: Color
}

struct RecipeData {
    static func comfortRecipes(for language: AppLanguage) -> [Recipe] {
        switch language {
        case .mandarin: return mandarinRecipes
        case .hindi: return hindiRecipes
        case .spanish: return spanishRecipes
        case .french: return frenchRecipes
        case .english: return englishRecipes
        }
    }

    private static let englishRecipes: [Recipe] = [
        Recipe(
            title: "Rainy Day Tomato Soup",
            backstory: "Whenever the sky turned grey and the rain started tapping on the kitchen window, I would pull out the big iron pot. This soup isn't just about tomatoes; it's about warming your hands on the bowl and feeling safe inside.",
            ingredients: [
                "2 cans (28oz) whole San Marzano tomatoes",
                "1 large yellow onion, diced",
                "4 cloves garlic, smashed",
                "1/2 cup heavy cream",
                "1/4 cup fresh basil leaves",
                "2 tbsp olive oil",
                "1 tbsp butter",
                "Salt and black pepper to taste"
            ],
            instructions: [
                "In a large pot, melt the butter with the olive oil over medium heat.",
                "Add the diced onion and smashed garlic. Cook until soft and fragrant, about 5-7 minutes.",
                "Pour in the tomatoes (juices and all). Crush them gently with a wooden spoon.",
                "Bring to a simmer, cover, and let it cook on low heat for 30 minutes.",
                "Remove from heat. Add the fresh basil and carefully blend the soup until smooth using an immersion blender.",
                "Stir in the heavy cream and season with salt and pepper.",
                "Serve piping hot with a gooey grilled cheese sandwich."
            ],
            prepTime: "10 mins",
            cookTime: "40 mins",
            iconName: "cup.and.saucer.fill",
            color: .themeRose
        ),
        Recipe(
            title: "Warm Cinnamon Cookies",
            backstory: "The secret to these cookies isn't the cinnamon, my dear—it's letting the dough rest. Sometimes the best things in life require a little bit of patience. The smell alone will make your heart feel ten times lighter.",
            ingredients: [
                "2 3/4 cups all-purpose flour",
                "1 cup unsalted butter, softened",
                "1 1/2 cups white sugar",
                "2 large eggs",
                "2 tsp cream of tartar",
                "1 tsp baking soda",
                "1/2 tsp salt",
                "For rolling: 3 tbsp sugar + 1 tbsp cinnamon"
            ],
            instructions: [
                "Preheat your oven to 350°F (175°C) and line a baking sheet with parchment paper.",
                "In a large bowl, cream together the softened butter and 1 1/2 cups of sugar until light and fluffy.",
                "Beat in the eggs, one at a time.",
                "In a separate bowl, whisk together the flour, cream of tartar, baking soda, and salt.",
                "Gradually blend the dry ingredients into the butter mixture until quite smooth.",
                "In a small bowl, mix the 3 tablespoons of sugar and 1 tablespoon of cinnamon together.",
                "Roll the dough into small, 1-inch balls, then roll them entirely in the cinnamon-sugar mixture.",
                "Place them two inches apart on the baking sheet.",
                "Bake for 8-10 minutes. They should be very soft in the center when you take them out. Let them rest."
            ],
            prepTime: "15 mins",
            cookTime: "10 mins",
            iconName: "star.fill",
            color: .themeWarm
        ),
        Recipe(
            title: "Sunday Roast Chicken",
            backstory: "Every Sunday afternoon, the entire house would smell of rosemary and roasting chicken. It was our signal that it was time to put away our work, sit around the table, and just be a family.",
            ingredients: [
                "1 whole chicken (4-5 lbs)",
                "1/4 cup olive oil or melted butter",
                "1 lemon, halved",
                "1 whole head of garlic, cut in half horizontally",
                "A large bunch of fresh rosemary and thyme",
                "Generous salt and black pepper",
                "4 carrots and 4 potatoes, roughly chopped"
            ],
            instructions: [
                "Preheat your oven to 425°F (220°C).",
                "Pat the chicken completely dry inside and out with paper towels. (This makes the skin crispy!)",
                "Generously salt and pepper the inside of the chicken cavity. Stuff the cavity with the lemon halves, garlic head, and fresh herbs.",
                "Tie the legs together with kitchen twine and tuck the wing tips under the body.",
                "Rub the outside of the chicken all over with olive oil, salt, and pepper.",
                "Place the chopped carrots and potatoes at the bottom of a roasting pan. Toss with a little oil and salt.",
                "Place the chicken on top of the vegetables.",
                "Roast for about 1 hour and 15 minutes, or until the juices run clear.",
                "Let it rest for 15 minutes before carving. This step is crucial!"
            ],
            prepTime: "20 mins",
            cookTime: "1 hr 15 mins",
            iconName: "flame.fill",
            color: .themeGold
        ),
        Recipe(
            title: "Healing Ginger Tea",
            backstory: "Whenever you feel a sniffle coming on, or your stomach is a bit unsettled, this was my go-to remedy. It's sharp, sweet, and feels like a warm hug from the inside out.",
            ingredients: [
                "2-inch piece of fresh ginger root, peeled and thinly sliced",
                "4 cups of water",
                "1/2 lemon, juiced",
                "2-3 tablespoons of raw honey",
                "1 cinnamon stick (optional)"
            ],
            instructions: [
                "Bring the 4 cups of water to a rolling boil in a small saucepan.",
                "Add the sliced ginger and the cinnamon stick if using.",
                "Lower the heat and let it gently simmer for 15-20 minutes, depending on how strong you like it.",
                "Remove from heat and carefully strain the tea into a large mug.",
                "Stir in the fresh lemon juice and honey while it's still hot.",
                "Sip it slowly while wrapped in a favorite blanket."
            ],
            prepTime: "5 mins",
            cookTime: "20 mins",
            iconName: "leaf.fill",
            color: .themeGreen
        )
    ]

    private static let mandarinRecipes: [Recipe] = [
        Recipe(
            title: "雨天番茄汤",
            backstory: "每当天空变成灰色，雨水开始敲打厨房的窗户时，我就会拿出那口大铁锅。这道汤不仅是番茄的味道；更是为了在捧着碗时温暖你的双手，让你在室内感到安全。",
            ingredients: [
                "2罐（28盎司）完整的圣马扎诺番茄",
                "1个大黄洋葱，切丁",
                "4瓣大蒜，拍碎",
                "1/2杯浓奶油",
                "1/4杯新鲜罗勒叶",
                "2汤匙橄榄油",
                "1汤匙黄油",
                "盐和黑胡椒调味"
            ],
            instructions: [
                "在一个大锅里，用中火将黄油和橄榄油融化。",
                "加入切好的洋葱和拍碎的大蒜。炒至变软散发香味，大约5-7分钟。",
                "倒入番茄（含汁水）。用木勺轻轻压碎。",
                "煮沸后，盖上锅盖，用小火煮30分钟。",
                "离火。加入新鲜罗勒，用手持式搅拌机小心地将汤搅拌至顺滑。",
                "拌入浓奶油，用盐和黑胡椒调味。",
                "趁热上桌，搭配一份拉丝的烤奶酪三明治。"
            ],
            prepTime: "10分钟",
            cookTime: "40分钟",
            iconName: "cup.and.saucer.fill",
            color: .themeRose
        ),
        Recipe(
            title: "温暖的肉桂饼干",
            backstory: "这些饼干的秘诀不在于肉桂，亲爱的——而在于让面团静置。有时生活中最美好的事物需要一点耐心。单单是这种香味就能让你的心感到轻盈十倍。",
            ingredients: [
                "2又3/4杯中筋面粉",
                "1杯无盐黄油，软化",
                "1又1/2杯白糖",
                "2个大鸡蛋",
                "2茶匙塔塔粉",
                "1茶匙小苏打",
                "1/2茶匙盐",
                "用于滚面团：3汤匙糖 + 1汤匙肉桂粉"
            ],
            instructions: [
                "将烤箱预热至350°F（175°C），在烤盘上铺上羊皮纸。",
                "在一个大碗中，将软化的黄油和1又1/2杯糖搅打至轻盈蓬松。",
                "加入鸡蛋，一次一个地打匀。",
                "在另一个碗中，将面粉、塔塔粉、小苏打和盐混合均匀。",
                "逐渐将干性材料拌入黄油混合物中，直到非常均匀。",
                "在一个小碗里，将3汤匙糖和1汤匙肉桂粉混合在一起。",
                "讲面团揉成1英寸的小球，然后让它们完全裹上肉桂糖粉。",
                "将它们间隔两英寸放在烤盘上。",
                "烤8-10分钟。取出时中心应该非常柔软。让它们静置一会。"
            ],
            prepTime: "15分钟",
            cookTime: "10分钟",
            iconName: "star.fill",
            color: .themeWarm
        ),
        Recipe(
            title: "周日烤鸡",
            backstory: "每个星期天下午，整个房子里都会飘荡着迷迭香和烤鸡的香味。这是我们放下工作、围坐在桌旁，仅仅作为一家人待在一起的信号。",
            ingredients: [
                "1整只鸡（4-5磅）",
                "1/4杯橄榄油或融化的黄油",
                "1个柠檬，对半切开",
                "1整头大蒜，横向切半",
                "一大把新鲜迷迭香和百里香",
                "足量的盐和黑胡椒",
                "4个胡萝卜和4个土豆，粗略切块"
            ],
            instructions: [
                "将烤箱预热至425°F（220°C）。",
                "用纸巾将鸡的里外完全擦干。（这样能让鸡皮酥脆！）",
                "在鸡腔内部撒上充足的盐和胡椒。将柠檬半、大蒜头和新鲜香草塞入鸡腔。",
                "用厨房绳将鸡腿绑在一起，将翅尖塞在身体下方。",
                "在鸡的外部涂满橄榄油、盐和胡椒。",
                "将切好的胡萝卜和土豆放在烤盘底部。拌入少许油和盐。",
                "将鸡放在蔬菜上。",
                "烤大约1小时15分钟，或直到流出的汁液变清澈。",
                "切块前让它静置15分钟。这一步至关重要！"
            ],
            prepTime: "20分钟",
            cookTime: "1小时15分钟",
            iconName: "flame.fill",
            color: .themeGold
        ),
        Recipe(
            title: "治愈姜茶",
            backstory: "每当你感觉要流鼻涕，或者胃有点不舒服时，这就是我的首选疗法。它辛辣、甜美，感觉就像从里到外给了你一个温暖的拥抱。",
            ingredients: [
                "2英寸长的新鲜生姜块，去皮切薄片",
                "4杯水",
                "半个柠檬的汁",
                "2-3汤匙生蜂蜜",
                "1根肉桂棒（可选）"
            ],
            instructions: [
                "在一个小火锅里将4杯水烧开。",
                "加入生姜片，如果使用肉桂棒也一并加入。",
                "调低火候，让它轻轻炖15-20分钟，取决于你喜欢的浓淡。",
                "离火，小心地将茶过滤到一个大杯子里。",
                "趁热拌入新鲜柠檬汁和蜂蜜。",
                "裹着最喜欢的毯子，慢慢地喝。"
            ],
            prepTime: "5分钟",
            cookTime: "20分钟",
            iconName: "leaf.fill",
            color: .themeGreen
        )
    ]

    private static let hindiRecipes: [Recipe] = [
        Recipe(
            title: "बरसात के दिन का टमाटर सूप",
            backstory: "जब भी आसमान भूरा हो जाता और बारिश की बूंदें रसोई की खिड़की पर थपथपाने लगतीं, मैं बड़ा सा लोहे का बर्तन निकालती। यह सूप सिर्फ टमाटर के बारे में नहीं है; यह आपके हाथों को कटोरी में गर्म करने और अंदर सुरक्षित महसूस करने के लिए है।",
            ingredients: [
                "2 डिब्बे (28 ऑउंस) पूरे सैन मार्ज़ानो टमाटर",
                "1 बड़ा पीला प्याज, कटा हुआ",
                "4 लहसुन की कलियाँ, कुचली हुई",
                "1/2 कप भारी मलाई (हैवी क्रीम)",
                "1/4 कप ताजी तुलसी के पत्ते",
                "2 बड़े चम्मच जैतून का तेल",
                "1 बड़ा चम्मच मक्खन",
                "स्वादानुसार नमक और काली मिर्च"
            ],
            instructions: [
                "एक बड़े बर्तन में, मध्यम आँच पर जैतून के तेल के साथ मक्खन पिघलाएँ।",
                "कटा हुआ प्याज और कुचला हुआ लहसुन डालें। नरम और खुशबूदार होने तक पकाएं, लगभग 5-7 मिनट।",
                "टमाटर (उनके रस के साथ) डालें। लकड़ी के चम्मच से उन्हें धीरे से कुचलें。",
                "उबाल आने दें, फिर ढक दें और धीमी आँच पर 30 मिनट तक पकने दें।",
                "आंच से उतार लें। ताजी तुलसी डालें और सूप को 'इमर्शन ब्लेंडर' से धीरे-धीरे चिकना होने तक ब्लेंड करें।",
                "विपड क्रीम मिलाएँ और नमक व काली मिर्च से मसाला सेट करें।",
                "पिघले हुए ग्रिल्ड चीज़ सैंडविच के साथ गर्मागर्म परोसें।"
            ],
            prepTime: "10 मिनट",
            cookTime: "40 मिनट",
            iconName: "cup.and.saucer.fill",
            color: .themeRose
        ),
        Recipe(
            title: "गरम दालचीनी कुकीज़",
            backstory: "इन कुकीज़ का राज दालचीनी नहीं है, मेरी जान- राज ये है कि आटे को थोड़ा आराम करने दिया जाए। ज़िंदगी की सबसे अच्छी चीज़ों के लिए थोड़े धैर्य की ज़रूरत होती है। इसकी खुशबू ही आपके दिल को दस गुना हल्का कर देगी।",
            ingredients: [
                "2 3/4 कप मैदा",
                "1 कप अनसाल्टेड मक्खन, नर्म किया हुआ",
                "1 1/2 कप सफेद चीनी",
                "2 बड़े अंडे",
                "2 चम्मच क्रीम ऑफ टार्टर",
                "1 चम्मच बेकिंग सोडा",
                "1/2 चम्मच नमक",
                "गोल करने के लिए: 3 बड़े चम्मच चीनी + 1 बड़ा चम्मच दालचीनी"
            ],
            instructions: [
                "अपने ओवन को 350°F (175°C) पर प्रीहीट करें और बेकिंग शीट पर पार्चमेंट पेपर लगाएं।",
                "एक बड़े कटोरे में, नरम मक्खन और 1 1/2 कप चीनी को हल्का और फूला हुआ होने तक फेंटें।",
                "अंडे डालें, एक-एक करके।",
                "एक अलग कटोरे में, मैदा, क्रीम ऑफ टार्टर, बेकिंग सोडा और नमक को एक साथ मिला लें।",
                "सूखी सामग्री को धीरे-धीरे मक्खन के मिश्रण में तब तक मिलाएँ जब तक कि वह पूरी तरह चिकना न हो जाए।",
                "एक छोटी कटोरी में, 3 बड़े चम्मच चीनी और 1 बड़ा चम्मच दालचीनी एक साथ मिलाएं।",
                "आटे के 1 इंच के छोटे-छोटे गोले बना लें, फिर उन्हें दालचीनी-चीनी के मिश्रण में पूरी तरह लपेट लें।",
                "उनको बेकिंग शीट पर दो इंच की दूरी पर रखें।",
                "8-10 मिनट तक बेक करें। जब आप इन्हें बाहर निकालें तो ये बीच से बहुत मुलायम होने चाहिए। इन्हें थोड़ा आराम करने दें।"
            ],
            prepTime: "15 मिनट",
            cookTime: "10 मिनट",
            iconName: "star.fill",
            color: .themeWarm
        ),
        Recipe(
            title: "संडे रोस्ट चिकन",
            backstory: "हर रविवार दोपहर, पूरे घर में रोज़मेरी और भुनते हुए चिकन की खुशबू आती थी। यह इस बात का इशारा था कि अब सारे काम किनारे रख दें, मेज़ के चारों ओर बैठें, और बस एक परिवार की तरह साथ रहें।",
            ingredients: [
                "1 पूरा चिकन (4-5 पाउंड)",
                "1/4 कप जैतून का तेल या पिघला हुआ मक्खन",
                "1 नींबू, आधा कटा हुआ",
                "1 पूरा लहसुन का सिर, क्षैतिज रूप से कटा हुआ",
                "ताज़ा रोज़मेरी और थाइम की एक बड़ी गुच्छा",
                "पर्याप्त नमक और काली मिर्च",
                "4 गाजर और 4 आलू, मोटे तौर पर कटे हुए"
            ],
            instructions: [
                "अपने ओवन को 425°F (220°C) पर प्रीहीट करें।",
                "चिकन को अंदर और बाहर पूरी तरह से कागज़ के तौलिये (पेपर टॉवल) से सुखा लें। (इससे त्वचा कुरकुरी बनती है!)",
                "चिकन के भीतरी हिस्से में नमक और काली मिर्च अच्छे से लगायें। अंदर नींबू के टुकड़े, लहसुन और ताज़ी जड़ी-बूटियाँ भर दें।",
                "पैरों को रसोई के धागे से एक साथ बाँध दें और पंखों के सिरों को शरीर के नीचे दबा दें。小句: ",
                "चिकन के बाहर हर तरफ जैतून का तेल, नमक और काली मिर्च रगड़ें।",
                "कटी हुई गाजर और आलू को रोस्टिंग पैन के तले में रखें। थोड़ा तेल और नमक मिलाएं।",
                "सब्जियों के ऊपर चिकन रखें।",
                "लगभग 1 घंटे 15 मिनट तक भूनें, या तब तक जब तक कि रस साफ़ न निकलने लगे।",
                "काटने से पहले 15 मिनट तक आराम करने दें। यह कदम बेहद महत्वपूर्ण है!"
            ],
            prepTime: "20 मिनट",
            cookTime: "1 घंटा 15 मिनट",
            iconName: "flame.fill",
            color: .themeGold
        ),
        Recipe(
            title: "राहत देने वाली अदरक की चाय",
            backstory: "जब भी तुम्हें लगे कि सर्दी हो रही है, या तुम्हारा पेट थोड़ा खराब हो, तो यह मेरा सबसे भरोसेमंद नुस्खा था। यह तीखा, मीठा और ऐसा लगता है जैसे अंदर से एक गर्म गले लगाने का एहसास हो।",
            ingredients: [
                "2 इंच ताज़ा अदरक का टुकड़ा, छिलका उतरा और पतला कटा हुआ",
                "4 कप पानी",
                "आधा नींबू, रस निकाला हुआ",
                "2-3 बड़े चम्मच कच्चा शहद",
                "1 दालचीनी की छड़ी (वैकल्पिक)"
            ],
            instructions: [
                "एक छोटे सॉस पैन में 4 कप पानी डालकर तेज़ उबाल लाएँ।",
                "कटा हुआ अदरक डालें और अगर इस्तेमाल कर रहे हैं तो दालचीनी का टुकड़ा भी डालें।",
                "आँच कम करें और अपनी पसंद के अनुसार 15-20 मिनट तक धीरे-धीरे उबलने दें।",
                "आँच से हटाएँ और चाय को सावधानी से एक बड़े मग में छान लें।",
                "गरम रहते हुए ही ताज़ा नींबू का रस और शहद मिलाएँ।",
                "अपने पसंदीदा कंबल में लिपटकर इसे धीरे-धीरे घूंट लें।"
            ],
            prepTime: "5 मिनट",
            cookTime: "20 मिनट",
            iconName: "leaf.fill",
            color: .themeGreen
        )
    ]
    private static let spanishRecipes: [Recipe] = [
        Recipe(
            title: "Sopa de Tomate para Días Lluviosos",
            backstory: "Cada vez que el cielo se volvía gris y la lluvia empezaba a golpear la ventana de la cocina, yo sacaba la olla grande de hierro. Esta sopa no se trata solo de tomates; se trata de calentar las manos en el tazón y sentirse a salvo adentro.",
            ingredients: [
                "2 latas (28 oz) de tomates San Marzano enteros",
                "1 cebolla amarilla grande, picada fina",
                "4 dientes de ajo, machacados",
                "1/2 taza de crema espesa",
                "1/4 taza de hojas de albahaca fresca",
                "2 cucharadas de aceite de oliva",
                "1 cucharada de mantequilla",
                "Sal y pimienta negra al gusto"
            ],
            instructions: [
                "En una olla grande, derrite la mantequilla con el aceite de oliva a fuego medio.",
                "Agrega la cebolla picada y el ajo machacado. Cocina hasta que estén suaves y fragantes, unos 5-7 minutos.",
                "Vierte los tomates (con todo y sus jugos). Aplástalos suavemente con una cuchara de madera.",
                "Lleva a ebullición, tapa y deja cocinar a fuego lento durante 30 minutos.",
                "Retira del fuego. Agrega la albahaca fresca y licúa suavemente la sopa hasta que quede tersa usando una batidora de inmersión.",
                "Incorpora la crema espesa y sazona con sal y pimienta.",
                "Sirve bien caliente con un sándwich de queso derretido a la plancha."
            ],
            prepTime: "10 mins",
            cookTime: "40 mins",
            iconName: "cup.and.saucer.fill",
            color: .themeRose
        ),
        Recipe(
            title: "Galletas Calientes de Canela",
            backstory: "El secreto de estas galletas no es la canela, mi vida, es dejar reposar la masa. A veces las mejores cosas de la vida requieren un poco de paciencia. Solo el olor hará que tu corazón se sienta diez veces más ligero.",
            ingredients: [
                "2 3/4 tazas de harina para todo uso",
                "1 taza de mantequilla sin sal, ablandada",
                "1 1/2 tazas de azúcar blanca",
                "2 huevos grandes",
                "2 cucharaditas de crémor tártaro",
                "1 cucharadita de bicarbonato de sodio",
                "1/2 cucharadita de sal",
                "Para rebozar: 3 cucharadas de azúcar + 1 cucharada de canela"
            ],
            instructions: [
                "Precalienta tu horno a 350°F (175°C) y forra una bandeja para hornear con papel pergamino.",
                "En un tazón grande, bate la mantequilla ablandada y 1 1/2 tazas de azúcar hasta que la mezcla esté suave y esponjosa.",
                "Añade los huevos, batiendo uno a la vez.",
                "En otro tazón, mezcla la harina, el crémor tártaro, el bicarbonato de sodio y la sal.",
                "Poco a poco, incorpora los ingredientes secos a la mezcla de mantequilla hasta que quede muy suave.",
                "En un tazón pequeño, mezcla las 3 cucharadas de azúcar y 1 cucharada de canela.",
                "Forma bolitas de masa de 1 pulgada (2.5 cm), luego rebózalas por completo en la mezcla de canela y azúcar.",
                "Colócalas separadas por dos pulgadas en la bandeja para hornear.",
                "Hornea durante 8-10 minutos. Deberían estar muy suaves en el centro cuando las saques. Déjalas reposar."
            ],
            prepTime: "15 mins",
            cookTime: "10 mins",
            iconName: "star.fill",
            color: .themeWarm
        ),
        Recipe(
            title: "Pollo Asado de Domingo",
            backstory: "Cada domingo por la tarde, toda la casa olía a romero y pollo asado. Era nuestra señal de que era momento de dejar nuestro trabajo, sentarnos a la mesa y simplemente ser una familia.",
            ingredients: [
                "1 pollo entero (4-5 lbs)",
                "1/4 de taza de aceite de oliva o mantequilla derretida",
                "1 limón, partido a la mitad",
                "1 cabeza de ajo entera, cortada a la mitad horizontalmente",
                "Un manojo grande de romero y tomillo frescos",
                "Sal y pimienta negra generosas",
                "4 zanahorias y 4 papas, cortadas en trozos grandes"
            ],
            instructions: [
                "Precalienta tu horno a 425°F (220°C).",
                "Seca completamente el pollo por dentro y por fuera con toallas de papel. (¡Esto hace que la piel quede crujiente!)",
                "Aplica sal y pimienta generosamente en la cavidad interior del pollo. Rellena la cavidad con las mitades de limón, la cabeza de ajo y las hierbas frescas.",
                "Ata las patas con hilo de cocina y mete las puntas de las alas debajo del cuerpo.",
                "Unta el exterior del pollo con el aceite de oliva, sal y pimienta.",
                "Coloca las zanahorias y papas picadas en el fondo de una asadera. Mezcla con un poco de aceite y sal.",
                "Coloca el pollo encima de las verduras.",
                "Hornea por aproximadamente 1 hora y 15 minutos, o hasta que los jugos salgan transparentes.",
                "Déjalo reposar por 15 minutos antes de trincharlo. ¡Este paso es crucial!"
            ],
            prepTime: "20 mins",
            cookTime: "1 hr 15 mins",
            iconName: "flame.fill",
            color: .themeGold
        ),
        Recipe(
            title: "Té Curativo de Jengibre",
            backstory: "Siempre que sentías que te ibas a resfriar, o tenías el estómago un poco revuelto, este era mi remedio de cabecera. Es fuerte, dulce y se siente como un abrazo cálido de adentro hacia afuera.",
            ingredients: [
                "Un trozo de raíz de jengibre fresco de 2 pulgadas, pelado y cortado en rodajas finas",
                "4 tazas de agua",
                "El jugo de medio limón",
                "2-3 cucharadas de miel cruda",
                "1 rama de canela (opcional)"
            ],
            instructions: [
                "Lleva a hervor las 4 tazas de agua en una cacerola pequeña.",
                "Agrega el jengibre en rodajas y la rama de canela, si la utilizas.",
                "Baja el fuego y deja cocinar a fuego lento suavemente durante 15-20 minutos, según qué tan fuerte te guste.",
                "Retira del fuego y cuela el té con cuidado en una taza grande.",
                "Agrega el jugo de limón fresco y la miel mientras todavía esté caliente.",
                "Bébelo poco a poco envuelto en tu manta favorita."
            ],
            prepTime: "5 mins",
            cookTime: "20 mins",
            iconName: "leaf.fill",
            color: .themeGreen
        )
    ]

    private static let frenchRecipes: [Recipe] = [
        Recipe(
            title: "Soupe aux Tomates des Jours de Pluie",
            backstory: "À chaque fois que le ciel devenait gris et que la pluie commençait à taper sur la fenêtre de la cuisine, je sortais la grande marmite en fer. Cette soupe, ce n'est pas seulement une affaire de tomates ; c'est pour se réchauffer les mains sur le bol et se sentir en sécurité à l'intérieur.",
            ingredients: [
                "2 boîtes (28 oz) de tomates San Marzano entières",
                "1 gros oignon jaune, coupé en dés",
                "4 gousses d'ail, écrasées",
                "1/2 tasse de crème épaisse",
                "1/4 de tasse de feuilles de basilic frais",
                "2 cuillères à soupe d'huile d'olive",
                "1 cuillère à soupe de beurre",
                "Sel et poivre noir au goût"
            ],
            instructions: [
                "Dans une grande marmite, faites fondre le beurre avec l'huile d'olive à feu moyen.",
                "Ajoutez l'oignon coupé en dés et l'ail écrasé. Faites cuire jusqu'à ce qu'ils soient tendres et parfumés, environ 5 à 7 minutes.",
                "Versez les tomates (avec leur jus). Écrasez-les doucement avec une cuillère en bois.",
                "Portez à ébullition, couvrez et laissez mijoter à feu doux pendant 30 minutes.",
                "Retirez du feu. Ajoutez le basilic frais et mixez soigneusement la soupe à l'aide d'un mixeur plongeant jusqu'à ce qu'elle soit lisse.",
                "Incorporez la crème épaisse et assaisonnez avec du sel et du poivre.",
                "Servez très chaud avec un sandwich au fromage grillé bien coulant."
            ],
            prepTime: "10 mins",
            cookTime: "40 mins",
            iconName: "cup.and.saucer.fill",
            color: .themeRose
        ),
        Recipe(
            title: "Biscuits Chauds à la Cannelle",
            backstory: "Le secret de ces biscuits n'est pas la cannelle, ma chérie, c'est de laisser reposer la pâte. Parfois, les meilleures choses de la vie nécessitent un peu de patience. L'odeur à elle seule rendra ton cœur dix fois plus léger.",
            ingredients: [
                "2 tasses 3/4 de farine tout usage",
                "1 tasse de beurre doux, ramolli",
                "1 tasse 1/2 de sucre blanc",
                "2 gros œufs",
                "2 cuillères à café de crème de tartre",
                "1 cuillère à café de bicarbonate de soude",
                "1/2 cuillère à café de sel",
                "Pour l'enrobage : 3 cuillères à soupe de sucre + 1 cuillère à soupe de cannelle"
            ],
            instructions: [
                "Préchauffez votre four à 350°F (175°C) et tapissez une plaque à pâtisserie de papier sulfurisé.",
                "Dans un grand bol, battez le beurre ramolli et 1 tasse 1/2 de sucre jusqu'à ce que le mélange soit léger et mousseux.",
                "Incorporez les œufs, un par un.",
                "Dans un autre bol, fouettez ensemble la farine, la crème de tartre, le bicarbonate de soude et le sel.",
                "Incorporez progressivement les ingrédients secs au mélange de beurre jusqu'à ce que la pâte soit bien lisse.",
                "Dans un petit bol, mélangez les 3 cuillères à soupe de sucre et 1 cuillère à soupe de cannelle.",
                "Roulez la pâte en petites boules de 1 pouce (2,5 cm), puis roulez-les entièrement dans le mélange cannelle-sucre.",
                "Placez-les à deux pouces d'intervalle sur la plaque à pâtisserie.",
                "Faites cuire au four pendant 8 à 10 minutes. Ils doivent être très tendres au centre lorsque vous les sortez. Laissez-les reposer."
            ],
            prepTime: "15 mins",
            cookTime: "10 mins",
            iconName: "star.fill",
            color: .themeWarm
        ),
        Recipe(
            title: "Poulet Rôti du Dimanche",
            backstory: "Chaque dimanche après-midi, toute la maison sentait le romarin et le poulet rôti. C'était le signal qu'il était temps de ranger notre travail, de s'asseoir autour de la table et d'être simplement en famille.",
            ingredients: [
                "1 poulet entier (4-5 lbs)",
                "1/4 de tasse d'huile d'olive ou de beurre fondu",
                "1 citron, coupé en deux",
                "1 tête d'ail entière, coupée en deux horizontalement",
                "Un gros bouquet de romarin et de thym frais",
                "Sel et poivre noir généreux",
                "4 carottes et 4 pommes de terre, grossièrement hachées"
            ],
            instructions: [
                "Préchauffez votre four à 425°F (220°C).",
                "Séchez complètement le poulet à l'intérieur et à l'extérieur avec du papier absorbant. (C'est ce qui rend la peau croustillante !)",
                "Salez et poivrez généreusement l'intérieur de la cavité du poulet. Farcissez la cavité avec les moitiés de citron, la tête d'ail et les herbes fraîches.",
                "Attachez les cuisses ensemble avec de la ficelle de cuisine et rentrez le bout des ailes sous le corps.",
                "Frottez l'extérieur du poulet avec l'huile d'olive, le sel et le poivre.",
                "Placez les carottes et les pommes de terre hachées au fond d'un plat à rôtir. Mélangez avec un peu d'huile et de sel.",
                "Placez le poulet sur les légumes.",
                "Faites rôtir pendant environ 1 heure et 15 minutes, ou jusqu'à ce que le jus soit clair.",
                "Laissez reposer pendant 15 minutes avant de découper. Cette étape est cruciale !"
            ],
            prepTime: "20 mins",
            cookTime: "1 h 15 mins",
            iconName: "flame.fill",
            color: .themeGold
        ),
        Recipe(
            title: "Thé Réconfortant au Gingembre",
            backstory: "À chaque fois que tu sentais que tu allais t'enrhumer, ou que ton estomac était un peu barbouillé, c'était mon remède de prédilection. Il est piquant, sucré et on a l'impression de recevoir un câlin chaleureux de l'intérieur.",
            ingredients: [
                "Un morceau de racine de gingembre frais de 2 pouces (5 cm), pelé et coupé en fines tranches",
                "4 tasses d'eau",
                "Le jus d'un demi-citron",
                "2-3 cuillères à soupe de miel brut",
                "1 bâton de cannelle (facultatif)"
            ],
            instructions: [
                "Portez les 4 tasses d'eau à forte ébullition dans une petite casserole.",
                "Ajoutez le gingembre en tranches et le bâton de cannelle si vous l'utilisez.",
                "Baissez le feu et laissez mijoter doucement pendant 15 à 20 minutes, selon la force que vous désirez.",
                "Retirez du feu et filtrez soigneusement le thé dans une grande tasse.",
                "Incorporez le jus de citron frais et le miel pendant que c'est encore chaud.",
                "Buvez-le doucement enroulé dans votre couverture préférée."
            ],
            prepTime: "5 mins",
            cookTime: "20 mins",
            iconName: "leaf.fill",
            color: .themeGreen
        )
    ]
}