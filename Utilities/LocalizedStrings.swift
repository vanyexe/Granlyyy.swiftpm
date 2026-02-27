import Foundation
import SwiftUI

// MARK: - L10n Key Enum
/// Every localizable string key in the app.
enum L10nKey: String {
    // MARK: Common
    case appName
    case cancel, save, ok, done, skip, reset, close, continueAction, getStarted, seeAll, of
    case comingSoon, version

    // MARK: Onboarding
    case onboarding1Title, onboarding1Description
    case onboarding2Title, onboarding2Description
    case onboarding3Title, onboarding3Description
    case onboarding4Title, onboarding4Description

    // MARK: Language Selection
    case chooseLanguage, chooseLanguageSubtitle

    // MARK: Home
    case greetingMorning, greetingAfternoon, greetingEvening
    case myDear
    case featuredForYou, howAreYouFeeling
    case surpriseMe, favorites, dailyWisdom
    case dailyInspiration
    case featuredSeeAll
    case noStoriesFound

    // MARK: Story
    case tellingFrom, readMin, shuffle, story, loading
    case playingFromLibrary, grandmasStories, narratedByGrandma, preparingStory, storyPreview, showFullStory

    // MARK: Quick Toast messages (Grandma tap)
    case toastHehe, toastILoveYou, toastYoureDoing, toastAlwaysHere, toastOhMy

    // MARK: Moods
    case moodHappy, moodSad, moodAnxious, moodLonely, moodTired, moodAngry, moodGrateful, moodExcited

    // MARK: Profile & Settings
    case profile, personal, preferences, support
    case grandmasName, grandmaMakeover
    case language, darkMode, dailyReminders
    case aboutGrantly, viewOnboarding, rateGrantly, shareWithFriends
    case resetAllData, storiesRead
    case renameGrandma

    // MARK: Alerts
    case resetDataQuestion, resetDataMessage, resetDataConfirm
    case rateMessage
    case thankYouForLove

    // MARK: Makeover
    case makeover, hair, glasses, outfit, pattern, accessories, hats, earrings, face, backgrounds, filters
    case wrinkleIntensity, greyIntensity, browThickness, eyelashes

    // MARK: Wisdom
    case wisdom, takeAction, modernExplanation, grandmaAdvice, dailyPractice

    // MARK: Daily Wisdom Page
    case wisdomPageTitle, wisdomPageSubtitle, shareWisdom
    case wisdomCatLife, wisdomCatLove, wisdomCatResilience, wisdomCatSimpleJoys, wisdomCatHappiness, wisdomCatPatience

    // MARK: Wisdom Hub (DigitalGrandmaWisdomView)
    case wisdomHubTitle, wisdomHubSubtitle
    case impactfulStories, impactfulStoriesSubtitle, readOurHistory
    case universalWisdomSubtitle, exploreDailyQuotes
    case memoryBoxSubtitle, openMemoryBox
    case askGrandmaSubtitle, talkToGrandma
    case growthPath, growthPathSubtitle, chooseYourPath

    // MARK: Story List
    case allCategory, shortCategory, moralCategory, bedtimeCategory, funnyCategory, natureCategory, comfortCategory
    case storiesLabel, minRead

    // MARK: Universal Quotes Actions
    case discussThisQuote, updateGrowthPath

    // MARK: Emotional Garden (GrowthPathView)
    case emotionalGarden, statEnergy, statPaths
    case completeReflection, reflectionAckButton, reflectionMessage

    // MARK: Ask Grandma Chat
    case chatWithGrandma, grandmaOnline, grandmaTyping, tellGrandmaMind

    // MARK: Impactful Stories (HistoricalStoryListView)
    case storiesThatShapedUs, storiesThatShapedUsSubtitle

    // MARK: Historical Story Detail
    case whatHappened, lifeLessons, grandmaAsks, growthTakeaway, yourReflection, continueYourJourney, talkGrandmaAboutThis

    // MARK: About Granly
    case aboutGranly, ourMission, missionBody, missionBody2, missionBody3
    case rateAppStore, privacyPolicy, termsOfService, designedWithCare, copyright
    case websiteLabel
    // Legal pages
    case privacyDataWeCollect, privacyDataWeCollectBody
    case privacyHowWeUse, privacyHowWeUseBody
    case privacyChildren, privacyChildrenBody
    case privacyStorage, privacyStorageBody
    case privacyContact, privacyContactBody
    case termsAcceptance, termsAcceptanceBody
    case termsUse, termsUseBody
    case termsIP, termsIPBody
    case termsDisclaimer, termsDisclaimerBody
    case termsChanges, termsChangesBody
    case termsContact, termsContactBody
    case legalLastUpdated

    // MARK: Grandma Makeover
    case saveLabel
    case optionStyle, optionColor, optionFrames, optionNecklace, optionHatStyle
    case optionSkinTone, optionEyeColor, optionExpression, optionLashes, optionTheme, optionCameraFilter

    // MARK: Memory Box
    case memories, addMemory, noMemoriesYet

    // MARK: Ask Grandma
    case askGrandma, typeYourFeeling, sendMessage
    case askGrandmaGreeting

    // MARK: Growth Path Nodes
    case growthNode1Title, growthNode1Desc
    case growthNode2Title, growthNode2Desc
    case growthNode3Title, growthNode3Desc
    case growthNode4Title, growthNode4Desc
    case growthNode5Title, growthNode5Desc

    // MARK: Historical Stories
    case historicalStories, inspiredBy, readStory

    // MARK: Recipes
    // MARK: Recipes
    case recipes, prepTime, ingredients, steps, difficulty, grandmasKitchen, comfortFoodSubtitle, instructions
    
    // MARK: Cozy Activities
    case cozyActivities, cozyActivitiesSubtitle, grandmasHeart, guidedMoment

    // MARK: Universal Quotes
    case universalWisdom, timelessTruthsSubtitle, simpleMeaning, grandmaSaysTitle

    // MARK: Memory Box
    case grandmasMemoryBox, emptyMemoryBox, emptyMemoryBoxHint, savedStories, savedRecipes, savedQuotes

    // MARK: Home View
    case dailyQuoteText, home
}

// MARK: - L10n Lookup Engine
struct L10n {
    /// Reads current language directly from UserDefaults (nonisolated — safe to call from anywhere)
    static func t(_ key: L10nKey) -> String {
        let code = UserDefaults.standard.string(forKey: "selectedLanguage") ?? AppLanguage.english.rawValue
        let lang = AppLanguage(rawValue: code) ?? .english
        return strings[lang]?[key] ?? strings[.english]?[key] ?? key.rawValue
    }

    // MARK: - Translation Dictionaries
    static let strings: [AppLanguage: [L10nKey: String]] = [

        // ─────────────────────────── ENGLISH ────────────────────────────
        .english: [
            .appName: "Granly",
            .cancel: "Cancel", .save: "Save", .ok: "OK", .done: "Done",
            .skip: "Skip", .reset: "Reset", .close: "Close",
            .continueAction: "Continue", .getStarted: "Get Started",
            .seeAll: "See All", .of: "of", .comingSoon: "Coming Soon",
            .version: "Version",

            .onboarding1Title: "Welcome to Granly",
            .onboarding1Description: "Your cozy corner for heartwarming stories and grandma's wisdom.",
            .onboarding2Title: "Stories for Every Mood",
            .onboarding2Description: "Feeling happy, sad, or just need a hug? Granly has a story for you.",
            .onboarding3Title: "Daily Wisdom",
            .onboarding3Description: "Start your day with gentle advice and timeless life lessons.",
            .onboarding4Title: "Always Here For You",
            .onboarding4Description: "A safe space to feel loved, supported, and understood.",

            .chooseLanguage: "Choose Your Language",
            .chooseLanguageSubtitle: "Select a language to begin your journey with Granly",

            .greetingMorning: "Good Morning,",
            .greetingAfternoon: "Good Afternoon,",
            .greetingEvening: "Good Evening,",
            .myDear: "My Dear",

            .featuredForYou: "Featured for You",
            .howAreYouFeeling: "How are you feeling?",
            .surpriseMe: "Surprise Me", .favorites: "Favorites", .dailyWisdom: "Daily Wisdom",
            .dailyInspiration: "Daily Inspiration",
            .featuredSeeAll: "All Stories",
            .noStoriesFound: "No stories found for this filter.",

            .tellingFrom: "TELLING FROM", .readMin: "min read",
            .shuffle: "Shuffle", .story: "Story", .loading: "Loading...",
            .playingFromLibrary: "PLAYING FROM YOUR LIBRARY", .grandmasStories: "Grandma's Stories",
            .narratedByGrandma: "Narrated by Grandma", .preparingStory: "Preparing story…",
            .storyPreview: "STORY PREVIEW", .showFullStory: "Show Full Story",

            .toastHehe: "Hehe!", .toastILoveYou: "I love you, dear!",
            .toastYoureDoing: "You're doing great!", .toastAlwaysHere: "Always here for you",
            .toastOhMy: "Oh my! How sweet",

            .moodHappy: "Happy", .moodSad: "Sad", .moodAnxious: "Anxious",
            .moodLonely: "Lonely", .moodTired: "Tired", .moodAngry: "Angry",
            .moodGrateful: "Grateful", .moodExcited: "Excited",

            .profile: "Profile", .personal: "Personal", .preferences: "Preferences", .support: "Support",
            .grandmasName: "Grandma's Name", .grandmaMakeover: "Grandma Makeover",
            .language: "Language", .darkMode: "Dark Mode", .dailyReminders: "Daily Reminders",
            .aboutGrantly: "About Granly", .viewOnboarding: "View Onboarding",
            .rateGrantly: "Rate Granly", .shareWithFriends: "Share with Friends",
            .resetAllData: "Reset All Data", .storiesRead: "Stories Read",
            .renameGrandma: "Rename Grandma",

            .resetDataQuestion: "Reset Data?",
            .resetDataMessage: "This will clear your read history, favorite stories, and customization settings. This cannot be undone.",
            .resetDataConfirm: "Reset", .rateMessage: "Rate Granly",
            .thankYouForLove: "Thank you for your love!",

            .makeover: "Makeover", .hair: "Hair", .glasses: "Glasses", .outfit: "Outfit",
            .pattern: "Pattern", .accessories: "Accessories", .hats: "Hats",
            .earrings: "Earrings", .face: "Face", .backgrounds: "Backgrounds", .filters: "Filters",
            .wrinkleIntensity: "Wrinkle Intensity", .greyIntensity: "Grey Intensity",
            .browThickness: "Brow Thickness", .eyelashes: "Eyelashes",

            .wisdom: "Wisdom", .takeAction: "Today's Practice",
            .modernExplanation: "Modern Meaning", .grandmaAdvice: "Grandma Says",
            .dailyPractice: "Daily Practice",

            .wisdomPageTitle: "Daily Wisdom", .wisdomPageSubtitle: "Grandma's timeless advice",
            .shareWisdom: "Share Wisdom",
            .wisdomCatLife: "Life Lessons", .wisdomCatLove: "Love & Family",
            .wisdomCatResilience: "Resilience", .wisdomCatSimpleJoys: "Simple Joys",
            .wisdomCatHappiness: "Happiness", .wisdomCatPatience: "Patience",

            .wisdomHubTitle: "Wisdom & Growth", .wisdomHubSubtitle: "A gentle space to reflect and grow.",
            .impactfulStories: "Impactful Stories", .impactfulStoriesSubtitle: "Lessons from history's greatest moments.",
            .readOurHistory: "Read Our Shared History",
            .universalWisdomSubtitle: "Timeless truths from across the world.",
            .exploreDailyQuotes: "Explore Daily Quotes",
            .memoryBoxSubtitle: "Revisit your favorite stories and quotes.",
            .openMemoryBox: "Open Memory Box",
            .askGrandmaSubtitle: "Need advice? I'm here to listen.",
            .talkToGrandma: "Talk to Grandma",
            .growthPath: "Growth Path", .growthPathSubtitle: "Track your emotional journey.",
            .chooseYourPath: "Choose Your Path",

            .allCategory: "All", .shortCategory: "Short", .moralCategory: "Moral",
            .bedtimeCategory: "Bedtime", .funnyCategory: "Funny", .natureCategory: "Nature", .comfortCategory: "Comfort",
            .storiesLabel: "Stories", .minRead: "min read",
            
            .cozyActivities: "Cozy Activities",
            .cozyActivitiesSubtitle: "Comforting moments for your soul.",
            .grandmasHeart: "Grandma's Heart", .guidedMoment: "Guided Moment",

            .discussThisQuote: "Discuss this quote",
            .updateGrowthPath: "Update your Growth Path",

            .emotionalGarden: "Your Emotional Garden",
            .statEnergy: "Energy", .statPaths: "Paths",
            .completeReflection: "Complete Reflection",
            .reflectionAckButton: "I have reflected on this",
            .reflectionMessage: "By marking this as complete, you acknowledge you have spent time focusing on this.",

            .chatWithGrandma: "Chat with Grandma",
            .grandmaOnline: "Online • Ready to listen",
            .grandmaTyping: "Grandma is typing...",
            .tellGrandmaMind: "Tell Grandma what's on your mind...",

            .storiesThatShapedUs: "Stories That Shaped Us",
            .storiesThatShapedUsSubtitle: "Learn from the most impactful events in human history.",

            .whatHappened: "What Happened", .lifeLessons: "Life Lessons",
            .grandmaAsks: "Grandma Asks...", .growthTakeaway: "Growth Takeaway",
            .yourReflection: "Your Reflection", .continueYourJourney: "Continue Your Journey",
            .talkGrandmaAboutThis: "Talk to Grandma about this",

            .aboutGranly: "About Granly", .ourMission: "Our Mission",
            .missionBody: "Granly was born from a heartfelt wish — to keep the warmth of a grandmother's love alive in everyday moments. In a world that moves too fast, we believe everyone deserves a quiet place to pause, breathe, and feel held.",
            .missionBody2: "We craft stories, wisdom, and gentle conversations that feel like a hug from someone who has lived, loved, and learned. Every feature in Granly is built with care, just the way a grandma bakes her favourite recipe — slowly, lovingly, and always for you.",
            .missionBody3: "Our hope is simple: that Granly helps you feel a little less alone, a little more grounded, and a little closer to the wisdom that has carried generations forward.",
            .rateAppStore: "Rate on App Store", .privacyPolicy: "Privacy Policy",
            .termsOfService: "Terms of Service", .designedWithCare: "Designed & Developed with Care",
            .copyright: "© 2026 Granly App", .websiteLabel: "Website",

            // Legal pages – English
            .privacyDataWeCollect: "Data We Don't Collect",
            .privacyDataWeCollectBody: "Granly is built entirely offline. We do not collect, transmit, or store any personal information on external servers. All data you create — memories, customisations, preferences — lives only on your device and is never shared.",
            .privacyHowWeUse: "How Your Data Is Used",
            .privacyHowWeUseBody: "Any information stored by Granly (such as your grandma's name, selected avatar, dark-mode preference, or favourite stories) is used solely to personalise your experience within the app. It is never sold, rented, or shared with any third party.",
            .privacyChildren: "Children's Privacy",
            .privacyChildrenBody: "Granly is designed to be safe for all ages. Because we collect no personal data, there is nothing to misuse. If you have concerns about a child's use of the app, please feel free to contact us anytime.",
            .privacyStorage: "Data Storage & Deletion",
            .privacyStorageBody: "Your data is stored locally on your device using Apple's secure UserDefaults and on-device storage. You can delete all data at any time by using the 'Reset All Data' option in your Profile, or by uninstalling the app entirely.",
            .privacyContact: "Contact Us",
            .privacyContactBody: "If you have any questions, concerns, or requests regarding this Privacy Policy, we would love to hear from you. You can reach us at: granlyapp@gmail.com",

            .termsAcceptance: "Acceptance of Terms",
            .termsAcceptanceBody: "By downloading and using Granly, you agree to these Terms of Service. If you do not agree with any part of these terms, please do not use the app. These terms may be updated from time to time and the latest version will always be available within the app.",
            .termsUse: "Use of the App",
            .termsUseBody: "Granly is intended for personal, non-commercial use. You agree to use the app in a way that is respectful and lawful. You must not attempt to reverse-engineer, copy, or reproduce any part of the app without written permission.",
            .termsIP: "Intellectual Property",
            .termsIPBody: "All stories, artwork, characters (including Granly the grandma), animations, and written content within the app are the intellectual property of Granly App © 2026. All rights are reserved. The stories and wisdom shared in the app are inspired by universal human experience and are created with love.",
            .termsDisclaimer: "Disclaimer",
            .termsDisclaimerBody: "Granly is provided 'as is', without warranty of any kind. While we strive to offer a comforting and reliable experience, we do not guarantee the app will be free of errors or interruptions. Granly is not a substitute for professional mental health support — if you are struggling, please reach out to a qualified professional.",
            .termsChanges: "Changes to These Terms",
            .termsChangesBody: "We may update these Terms of Service occasionally to reflect changes in the app or applicable law. We will notify you of significant changes through an in-app notice. Your continued use of Granly after any change constitutes your acceptance of the new terms.",
            .termsContact: "Contact Us",
            .termsContactBody: "For any questions about these Terms of Service, please contact us at: granlyapp@gmail.com",

            .legalLastUpdated: "Last updated: February 2026",

            .saveLabel: "Save",
            .optionStyle: "Style", .optionColor: "Color", .optionFrames: "Frames",
            .optionNecklace: "Necklace", .optionHatStyle: "Hat Style",
            .optionSkinTone: "Skin Tone", .optionEyeColor: "Eye Color", .optionExpression: "Expression",
            .optionLashes: "Lashes", .optionTheme: "Theme", .optionCameraFilter: "Camera Filter",

            .askGrandmaGreeting: "Hello my dear! What's on your heart today? You can tell me anything.",

            .growthNode1Title: "Seed of Patience", .growthNode1Desc: "Learn to sit with uncertainty.",
            .growthNode2Title: "Sprout of Courage", .growthNode2Desc: "Face a fear, no matter how small.",
            .growthNode3Title: "Branch of Forgiveness", .growthNode3Desc: "Let go of a past grievance.",
            .growthNode4Title: "Bloom of Joy", .growthNode4Desc: "Find happiness in the mundane.",
            .growthNode5Title: "Roots of Wisdom", .growthNode5Desc: "Reflect on a past failure.",

            .memories: "Memories", .addMemory: "Add Memory", .noMemoriesYet: "No memories yet.",
            .askGrandma: "Ask Grandma", .typeYourFeeling: "Type how you're feeling...",
            .sendMessage: "Send",
            .historicalStories: "Historical Stories", .inspiredBy: "Inspired by",
            .readStory: "Read Story",
            .recipes: "Recipes", .prepTime: "Prep Time", .ingredients: "Ingredients",
            .steps: "Steps", .difficulty: "Difficulty", .grandmasKitchen: "Grandma's Kitchen", 
            .comfortFoodSubtitle: "Comfort food for the soul.", .instructions: "Instructions",

            .universalWisdom: "Universal Wisdom", .timelessTruthsSubtitle: "Timeless truths connecting us all.", 
            .simpleMeaning: "Simple Meaning", .grandmaSaysTitle: "Grandma Says...",

            .grandmasMemoryBox: "Grandma's Memory Box", .emptyMemoryBox: "Your Memory Box is empty.", 
            .emptyMemoryBoxHint: "Tap the heart icon on your favorite stories and quotes to keep them safe in here.", 
            .savedStories: "Saved Stories", .savedRecipes: "Saved Recipes", .savedQuotes: "Saved Quotes",

            .dailyQuoteText: "\"Keep your face always toward the sunshine and shadows will fall behind you.\"",
            .home: "Home"
        ],

        // ─────────────────────────── HINDI ──────────────────────────────
        .hindi: [
            .appName: "ग्रैनली",
            .cancel: "रद्द करें", .save: "सहेजें", .ok: "ठीक है", .done: "हो गया",
            .skip: "छोड़ें", .reset: "रीसेट", .close: "बंद करें",
            .continueAction: "जारी रखें", .getStarted: "शुरू करें",
            .seeAll: "सभी देखें", .of: "में से", .comingSoon: "जल्द आ रहा है",
            .version: "संस्करण",

            .onboarding1Title: "ग्रैनली में आपका स्वागत है",
            .onboarding1Description: "दादी की कहानियों और ज्ञान के लिए आपका प्यारा कोना।",
            .onboarding2Title: "हर मूड के लिए कहानियाँ",
            .onboarding2Description: "खुश हो, उदास हो, या बस एक गले लगाना चाहते हो? ग्रैनली के पास आपके लिए कहानी है।",
            .onboarding3Title: "दैनिक ज्ञान",
            .onboarding3Description: "अपना दिन सरल सलाह और जीवन के अमूल्य पाठों से शुरू करें।",
            .onboarding4Title: "हमेशा आपके साथ",
            .onboarding4Description: "एक सुरक्षित जगह जहाँ आप प्यार, सहारा और समझ पा सकते हैं।",

            .chooseLanguage: "अपनी भाषा चुनें",
            .chooseLanguageSubtitle: "ग्रैनली के साथ अपनी यात्रा शुरू करने के लिए एक भाषा चुनें",

            .greetingMorning: "सुप्रभात,",
            .greetingAfternoon: "नमस्ते,",
            .greetingEvening: "शुभ संध्या,",
            .myDear: "मेरे प्रिय",

            .featuredForYou: "आपके लिए चुना गया",
            .howAreYouFeeling: "आप कैसा महसूस कर रहे हैं?",
            .surpriseMe: "चौंकाइए मुझे", .favorites: "पसंदीदा", .dailyWisdom: "दैनिक ज्ञान",
            .dailyInspiration: "दैनिक प्रेरणा",
            .featuredSeeAll: "सभी कहानियाँ",
            .noStoriesFound: "इस फ़िल्टर के लिए कोई कहानी नहीं मिली।",

            .tellingFrom: "यह कहानी है", .readMin: "मिनट पढ़ें",
            .shuffle: "बदलें", .story: "कहानी", .loading: "लोड हो रहा है...",
            .playingFromLibrary: "आपकी लाइब्रेरी से", .grandmasStories: "दादी की कहानियाँ",
            .narratedByGrandma: "दादी द्वारा सुनाई गई", .preparingStory: "कहानी तैयार हो रही है...",
            .storyPreview: "कहानी की झलक", .showFullStory: "पूरी कहानी देखें",

            .toastHehe: "हेहे!", .toastILoveYou: "मैं आपसे प्यार करती हूँ!",
            .toastYoureDoing: "आप बहुत अच्छा कर रहे हैं!", .toastAlwaysHere: "हमेशा आपके साथ हूँ",
            .toastOhMy: "ओह! कितना प्यारा",

            .moodHappy: "खुश", .moodSad: "उदास", .moodAnxious: "चिंतित",
            .moodLonely: "अकेला", .moodTired: "थका हुआ", .moodAngry: "गुस्से में",
            .moodGrateful: "कृतज्ञ", .moodExcited: "उत्साहित",

            .profile: "प्रोफ़ाइल", .personal: "व्यक्तिगत", .preferences: "प्राथमिकताएँ", .support: "सहायता",
            .grandmasName: "दादी का नाम", .grandmaMakeover: "दादी का मेकओवर",
            .language: "भाषा", .darkMode: "डार्क मोड", .dailyReminders: "दैनिक अनुस्मारक",
            .aboutGrantly: "ग्रैनली के बारे में", .viewOnboarding: "परिचय देखें",
            .rateGrantly: "ग्रैनली को रेट करें", .shareWithFriends: "दोस्तों के साथ साझा करें",
            .resetAllData: "सारा डेटा मिटाएँ", .storiesRead: "पढ़ी गई कहानियाँ",
            .renameGrandma: "दादी का नाम बदलें",

            .resetDataQuestion: "डेटा मिटाएँ?",
            .resetDataMessage: "इससे आपका पढ़ने का इतिहास, पसंदीदा कहानियाँ और कस्टमाइज़ेशन सेटिंग्स मिट जाएंगी। यह वापस नहीं होगा।",
            .resetDataConfirm: "मिटाएँ", .rateMessage: "ग्रैनली को रेट करें",
            .thankYouForLove: "आपके प्यार के लिए शुक्रिया!",

            .makeover: "मेकओवर", .hair: "बाल", .glasses: "चश्मा", .outfit: "पहनावा",
            .pattern: "डिज़ाइन", .accessories: "सहायक सामग्री", .hats: "टोपियाँ",
            .earrings: "झुमके", .face: "चेहरा", .backgrounds: "पृष्ठभूमि", .filters: "फ़िल्टर",
            .wrinkleIntensity: "झुर्रियों की तीव्रता", .greyIntensity: "सफेद बालों की तीव्रता",
            .browThickness: "भौं की मोटाई", .eyelashes: "पलकें",

            .wisdom: "ज्ञान", .takeAction: "आज का अभ्यास",
            .modernExplanation: "आधुनिक अर्थ", .grandmaAdvice: "दादी कहती हैं",
            .dailyPractice: "दैनिक अभ्यास",

            .wisdomPageTitle: "दैनिक ज्ञान", .wisdomPageSubtitle: "दादी की अनमोल सीखें",
            .shareWisdom: "ज्ञान साझा करें",
            .wisdomCatLife: "जीवन के पाठ", .wisdomCatLove: "प्यार और परिवार",
            .wisdomCatResilience: "दृढ़ता", .wisdomCatSimpleJoys: "साधारण खुशियाँ",
            .wisdomCatHappiness: "खुशी", .wisdomCatPatience: "धैर्य",

            .wisdomHubTitle: "ज्ञान और विकास", .wisdomHubSubtitle: "सोचने और बढ़ने की एक सौम्य जगह।",
            .impactfulStories: "प्रभावशाली कहानियाँ", .impactfulStoriesSubtitle: "इतिहास के महान पलों से सबक।",
            .readOurHistory: "हमारा साझा इतिहास पढ़ें",
            .universalWisdomSubtitle: "दुनिया भर से कालातीत सच्चाइयाँ।",
            .exploreDailyQuotes: "दैनिक उद्धरण देखें",
            .memoryBoxSubtitle: "अपनी पसंदीदा कहानियों और उद्धरणों पर वापस जाएँ।",
            .openMemoryBox: "मेमोरी बॉक्स खोलें",
            .askGrandmaSubtitle: "सलाह चाहिए? मैं यहाँ सुनने के लिए हूँ।",
            .talkToGrandma: "दादी से बात करें",
            .growthPath: "विकास पथ", .growthPathSubtitle: "अपनी भावनात्मक यात्रा ट्रैक करें।",
            .chooseYourPath: "अपना रास्ता चुनें",

            .allCategory: "सभी", .shortCategory: "छोटी", .moralCategory: "नैतिक",
            .bedtimeCategory: "सोने की", .funnyCategory: "मज़ेदार", .natureCategory: "प्रकृति", .comfortCategory: "सुकून",
            .storiesLabel: "कहानियाँ", .minRead: "मिनट पढ़ें",

            .discussThisQuote: "इस उद्धरण पर चर्चा करें",
            .updateGrowthPath: "अपना विकास पथ अपडेट करें",

            .emotionalGarden: "आपका भावनात्मक उद्यान",
            .statEnergy: "उर्जा", .statPaths: "मार्ग",
            .completeReflection: "चिंतन पूरा करें",
            .reflectionAckButton: "मैंने इस पर चिंतन किया है",
            .reflectionMessage: "इसे पूर्ण के रूप में चिह्नित करने से आप स्वीकार करते हैं कि आपने इस पर ध्यान दिया है।",

            .chatWithGrandma: "दादी से चैट करें",
            .grandmaOnline: "ऑनलाइन • सुनने के लिए तैयार",
            .grandmaTyping: "दादी टाइप कर रही हैं...",
            .tellGrandmaMind: "दादी को बताएं क्या है आपके मन में...",

            .storiesThatShapedUs: "हमारे आकार देने वाली कहानियाँ",
            .storiesThatShapedUsSubtitle: "मानव इतिहास की सबसे प्रभावशाली घटनाओं से सीखें।",

            .whatHappened: "क्या हुआ", .lifeLessons: "जीवन के पाठ",
            .grandmaAsks: "दादी पूछती हैं...", .growthTakeaway: "विकास संदेश",
            .yourReflection: "आपका चिंतन", .continueYourJourney: "अपनी यात्रा जारी रखें",
            .talkGrandmaAboutThis: "दादी से इस बारे में बात करें",

            .aboutGranly: "ग्रॉन्ली के बारे में", .ourMission: "हमारा उद्देश्य",
            .missionBody: "ग्रॉन्ली एक सरल इच्छा के साथ बनाया गया था: आपके दैनिक जीवन में उष्मा, आराम और कालातीत कहानी का जादू लाना।",
            .rateAppStore: "ऐप स्टोर पर रेट करें", .privacyPolicy: "गोपनीयता नीति",
            .termsOfService: "सेवा शर्तें", .designedWithCare: "प्यार से डिज़ाइन और विकसित",
            .copyright: "© 2026 ग्रॉन्ली एप्प", .websiteLabel: "वेबसाइट",

            .saveLabel: "सहेजें",
            .optionStyle: "शैली", .optionColor: "रंग", .optionFrames: "फ्रेम",
            .optionNecklace: "हार", .optionHatStyle: "टोपी शैली",
            .optionSkinTone: "त्वचा का रंग", .optionEyeColor: "आँखों का रंग", .optionExpression: "भाव",
            .optionLashes: "पलकें", .optionTheme: "थीम", .optionCameraFilter: "कैमरा फ़िल्टर",

            .askGrandmaGreeting: "नमस्ते मेरे प्यारे! आज आपके मन में क्या चल रहा है? मुझसे कुछ भी कह सकते हैं।",

            .growthNode1Title: "धैर्य का बीज", .growthNode1Desc: "अनिश्चितता के साथ बैठना सीखें।",
            .growthNode2Title: "साहस की कोपल", .growthNode2Desc: "चाहे कितना छोटा, एक डर का सामना करें।",
            .growthNode3Title: "क्षमा की शाखा", .growthNode3Desc: "पुरानी शिकायत को छोड़ दें।",
            .growthNode4Title: "खुशी का फूल", .growthNode4Desc: "साधारण चीज़ों में खुशी ढूंढें।",
            .growthNode5Title: "ज्ञान की जड़ें", .growthNode5Desc: "पिछली गलति पर विचार करें।",

            .memories: "यादें", .addMemory: "याद जोड़ें", .noMemoriesYet: "अभी तक कोई याद नहीं।",
            .askGrandma: "दादी से पूछें", .typeYourFeeling: "आप क्या महसूस कर रहे हैं...",
            .sendMessage: "भेजें",
            .historicalStories: "ऐतिहासिक कहानियाँ", .inspiredBy: "से प्रेरित",
            .readStory: "कहानी पढ़ें",
            .recipes: "व्यंजन", .prepTime: "तैयारी का समय", .ingredients: "सामग्री",
            .steps: "चरण", .difficulty: "कठिनाई", .grandmasKitchen: "दादी की रसोई",
            .comfortFoodSubtitle: "आत्मा के लिए सुकून का खाना।", .instructions: "निर्देश",

            .cozyActivities: "आरामदायक गतिविधियाँ",
            .cozyActivitiesSubtitle: "आपकी आत्मा के लिए सुखद क्षण।",
            .grandmasHeart: "दादी का हृदय", .guidedMoment: "मार्गदर्शित क्षण",

            .universalWisdom: "सार्वभौमिक ज्ञान", .timelessTruthsSubtitle: "कालातीत सत्य जो हम सभी को जोड़ते हैं।",
            .simpleMeaning: "सरल अर्थ", .grandmaSaysTitle: "दादी कहती हैं...",

            .grandmasMemoryBox: "दादी का मेमोरी बॉक्स", .emptyMemoryBox: "आपका मेमोरी बॉक्स खाली है।",
            .emptyMemoryBoxHint: "अपनी पसंदीदा कहानियों और विचारों को यहां सुरक्षित रखने के लिए उनके दिल के आइकन पर टैप करें।",
            .savedStories: "सहेजी गई कहानियाँ", .savedRecipes: "सहेजे गए व्यंजन", .savedQuotes: "सहेजे गए विचार",

            .dailyQuoteText: "\"अपना चेहरा हमेशा धूप की ओर रखें और परछाइयाँ आपके पीछे पड़ेंगी।\"",
            .home: "मुख्य पृष्ठ"
        ],

        // ─────────────────────────── SPANISH ─────────────────────────────
        .spanish: [
            .appName: "Granly",
            .cancel: "Cancelar", .save: "Guardar", .ok: "Aceptar", .done: "Hecho",
            .skip: "Omitir", .reset: "Restablecer", .close: "Cerrar",
            .continueAction: "Continuar", .getStarted: "Empezar",
            .seeAll: "Ver todo", .of: "de", .comingSoon: "Próximamente",
            .version: "Versión",

            .onboarding1Title: "Bienvenido a Granly",
            .onboarding1Description: "Tu rincón acogedor para historias conmovedoras y la sabiduría de la abuela.",
            .onboarding2Title: "Historias para cada estado de ánimo",
            .onboarding2Description: "¿Feliz, triste o solo necesitas un abrazo? Granly tiene una historia para ti.",
            .onboarding3Title: "Sabiduría diaria",
            .onboarding3Description: "Comienza tu día con dulces consejos y lecciones de vida atemporales.",
            .onboarding4Title: "Siempre aquí para ti",
            .onboarding4Description: "Un espacio seguro para sentirte amado, apoyado y comprendido.",

            .chooseLanguage: "Elige tu idioma",
            .chooseLanguageSubtitle: "Selecciona un idioma para comenzar tu viaje con Granly",

            .greetingMorning: "Buenos días,",
            .greetingAfternoon: "Buenas tardes,",
            .greetingEvening: "Buenas noches,",
            .myDear: "Mi querido",

            .featuredForYou: "Destacado para ti",
            .howAreYouFeeling: "¿Cómo te sientes?",
            .surpriseMe: "Sorpréndeme", .favorites: "Favoritos", .dailyWisdom: "Sabiduría diaria",
            .dailyInspiration: "Inspiración diaria",
            .featuredSeeAll: "Todos los Cuentos",
            .noStoriesFound: "No se encontraron cuentos para este filtro.",

            .tellingFrom: "CONTANDO DESDE", .readMin: "min de lectura",
            .shuffle: "Aleatorio", .story: "Historia", .loading: "Cargando...",
            .playingFromLibrary: "REPRODUCIENDO DE TU BIBLIOTECA", .grandmasStories: "Historias de la Abuela",
            .narratedByGrandma: "Narrado por la Abuela", .preparingStory: "Preparando historia...",
            .storyPreview: "VISTA PREVIA DE LA HISTORIA", .showFullStory: "Mostrar Historia Completa",

            .toastHehe: "¡Jeje!", .toastILoveYou: "¡Te quiero mucho!",
            .toastYoureDoing: "¡Lo estás haciendo genial!", .toastAlwaysHere: "Aquí estaré siempre",
            .toastOhMy: "¡Oh, qué tiernura!",

            .moodHappy: "Feliz", .moodSad: "Triste", .moodAnxious: "Ansioso",
            .moodLonely: "Solo", .moodTired: "Cansado", .moodAngry: "Enojado",
            .moodGrateful: "Agradecido", .moodExcited: "Emocionado",

            .profile: "Perfil", .personal: "Personal", .preferences: "Preferencias", .support: "Soporte",
            .grandmasName: "Nombre de la abuela", .grandmaMakeover: "Cambio de look",
            .language: "Idioma", .darkMode: "Modo oscuro", .dailyReminders: "Recordatorios diarios",
            .aboutGrantly: "Acerca de Granly", .viewOnboarding: "Ver introducción",
            .rateGrantly: "Calificar Granly", .shareWithFriends: "Compartir con amigos",
            .resetAllData: "Borrar todos los datos", .storiesRead: "Historias leídas",
            .renameGrandma: "Renombrar a la abuela",
            .resetDataQuestion: "¿Restablecer datos?",
            .resetDataMessage: "Esto borrará tu historial de lectura, historias favoritas y personalización. No se puede deshacer.",
            .resetDataConfirm: "Restablecer", .rateMessage: "Calificar Granly",
            .thankYouForLove: "¡Gracias por tu cariño!",

            .makeover: "Cambio de look", .hair: "Cabello", .glasses: "Gafas", .outfit: "Atuendo",
            .pattern: "Patrón", .accessories: "Accesorios", .hats: "Sombreros",
            .earrings: "Pendientes", .face: "Rostro", .backgrounds: "Fondos", .filters: "Filtros",
            .wrinkleIntensity: "Intensidad de arrugas", .greyIntensity: "Intensidad de canas",
            .browThickness: "Grosor de cejas", .eyelashes: "Pestañas",

            .wisdom: "Sabiduría", .takeAction: "Práctica de hoy",
            .modernExplanation: "Significado moderno", .grandmaAdvice: "La abuela dice",
            .dailyPractice: "Práctica diaria",

            .wisdomPageTitle: "Sabiduría Diaria", .wisdomPageSubtitle: "Los consejos eternos de la abuela",
            .shareWisdom: "Compartir Sabiduría",
            .wisdomCatLife: "Lecciones de Vida", .wisdomCatLove: "Amor y Familia",
            .wisdomCatResilience: "Resiliencia", .wisdomCatSimpleJoys: "Placeres Simples",
            .wisdomCatHappiness: "Felicidad", .wisdomCatPatience: "Paciencia",

            .wisdomHubTitle: "Sabiduría y Crecimiento", .wisdomHubSubtitle: "Un espacio para reflexionar y crecer.",
            .impactfulStories: "Historias Impactantes", .impactfulStoriesSubtitle: "Lecciones de los grandes momentos de la historia.",
            .readOurHistory: "Leer Nuestra Historia Compartida",
            .universalWisdomSubtitle: "Verdades eternas de todo el mundo.",
            .exploreDailyQuotes: "Explorar Citas Diarias",
            .memoryBoxSubtitle: "Revisa tus historias y citas favoritas.",
            .openMemoryBox: "Abrir Caja de Recuerdos",
            .askGrandmaSubtitle: "¿Necesitas consejo? Estoy aquí para escucharte.",
            .talkToGrandma: "Hablar con la Abuela",
            .growthPath: "Camino de Crecimiento", .growthPathSubtitle: "Sigue tu viaje emocional.",
            .chooseYourPath: "Elige Tu Camino",

            .allCategory: "Todas", .shortCategory: "Corta", .moralCategory: "Moral",
            .bedtimeCategory: "Para Dormir", .funnyCategory: "Graciosa", .natureCategory: "Naturaleza", .comfortCategory: "Consuelo",
            .storiesLabel: "Historias", .minRead: "min de lectura",

            .discussThisQuote: "Discutir esta cita",
            .updateGrowthPath: "Actualizar tu Camino de Crecimiento",

            .emotionalGarden: "Tu Jardín Emocional",
            .statEnergy: "Energía", .statPaths: "Caminos",
            .completeReflection: "Reflexión Completa",
            .reflectionAckButton: "He reflexionado sobre esto",
            .reflectionMessage: "Al marcar esto como completo, reconoces que has dedicado tiempo a enfocarte en esto.",

            .chatWithGrandma: "Charla con la Abuela",
            .grandmaOnline: "En línea • Lista para escuchar",
            .grandmaTyping: "La abuela está escribiendo...",
            .tellGrandmaMind: "Cuéntale a la abuela lo que tienes en mente...",

            .storiesThatShapedUs: "Historias que nos Formaron",
            .storiesThatShapedUsSubtitle: "Aprende de los eventos más impactantes de la historia humana.",

            .whatHappened: "Qué Sucedió", .lifeLessons: "Lecciones de Vida",
            .grandmaAsks: "La Abuela Pregunta...", .growthTakeaway: "Aprendizaje de Crecimiento",
            .yourReflection: "Tu Reflexión", .continueYourJourney: "Continúa tu Viaje",
            .talkGrandmaAboutThis: "Hablar con la abuela sobre esto",

            .aboutGranly: "Acerca de Granly", .ourMission: "Nuestra Misión",
            .missionBody: "Granly fue creado con un simple deseo: traer calidez, confort y la magia de la narración atemporal a tu vida diaria.",
            .rateAppStore: "Valorar en App Store", .privacyPolicy: "Política de Privacidad",
            .termsOfService: "Términos de Servicio", .designedWithCare: "Diseñado y Desarrollado con Cuidado",
            .copyright: "© 2026 Granly App", .websiteLabel: "Sitio Web",

            .saveLabel: "Guardar",
            .optionStyle: "Estilo", .optionColor: "Color", .optionFrames: "Armazón",
            .optionNecklace: "Collar", .optionHatStyle: "Tipo de sombrero",
            .optionSkinTone: "Tono de piel", .optionEyeColor: "Color de ojos", .optionExpression: "Expresión",
            .optionLashes: "Pestañas", .optionTheme: "Tema", .optionCameraFilter: "Filtro de cámara",

            .askGrandmaGreeting: "¡Hola mi querido! ¿Qué tienes en el corazón hoy? Puedes contarme cualquier cosa.",

            .growthNode1Title: "Semilla de Paciencia", .growthNode1Desc: "Aprende a sentarte con la incertidumbre.",
            .growthNode2Title: "Brote de Coraje", .growthNode2Desc: "Enfrenta un miedo, sin importar cuán pequeño.",
            .growthNode3Title: "Rama del Perdón", .growthNode3Desc: "Suelta un rencor del pasado.",
            .growthNode4Title: "Flor de Alegría", .growthNode4Desc: "Encuentra felicidad en lo cotidiano.",
            .growthNode5Title: "Raíces de Sabiduría", .growthNode5Desc: "Reflexiona sobre un fracaso pasado.",

            .memories: "Recuerdos", .addMemory: "Añadir recuerdo", .noMemoriesYet: "Aún no hay recuerdos.",
            .askGrandma: "Pregúntale a la abuela", .typeYourFeeling: "Escribe cómo te sientes...",
            .sendMessage: "Enviar",
            .historicalStories: "Historias históricas", .inspiredBy: "Inspirado en",
            .readStory: "Leer historia",
            .recipes: "Recetas", .prepTime: "Tiempo de prep.", .ingredients: "Ingredientes",
            .steps: "Pasos", .difficulty: "Dificultad", .grandmasKitchen: "La Cocina de la Abuela",
            .comfortFoodSubtitle: "Comida reconfortante para el alma.", .instructions: "Instrucciones",
            
            .cozyActivities: "Actividades Acogedoras",
            .cozyActivitiesSubtitle: "Momentos reconfortantes para tu alma.",
            .grandmasHeart: "Corazón de la Abuela", .guidedMoment: "Momento Guiado",

            .universalWisdom: "Sabiduría Universal", .timelessTruthsSubtitle: "Verdades eternas que nos conectan a todos.",
            .simpleMeaning: "Significado Simple", .grandmaSaysTitle: "La Abuela Dice...",

            .grandmasMemoryBox: "La Caja de Recuerdos de la Abuela", .emptyMemoryBox: "Tu Caja de Recuerdos está vacía.",
            .emptyMemoryBoxHint: "Toca el ícono del corazón en tus historias y citas favoritas para guardarlas aquí.",
            .savedStories: "Historias Guardadas", .savedRecipes: "Recetas Guardadas", .savedQuotes: "Citas Guardadas",

            .dailyQuoteText: "\"Mantén siempre tu rostro hacia la luz del sol y las sombras caerán detrás de ti.\"",
            .home: "Inicio"
        ],

        // ─────────────────────────── FRENCH ─────────────────────────────
        .french: [
            .appName: "Granly",
            .cancel: "Annuler", .save: "Enregistrer", .ok: "OK", .done: "Terminé",
            .skip: "Passer", .reset: "Réinitialiser", .close: "Fermer",
            .continueAction: "Continuer", .getStarted: "Commencer",
            .seeAll: "Voir Tout", .of: "de", .comingSoon: "Bientôt Disponible",
            .version: "Version",

            .onboarding1Title: "Bienvenue sur Granly",
            .onboarding1Description: "Votre coin douillet pour des histoires chaleureuses et la sagesse de Grand-mère.",
            .onboarding2Title: "Des Histoires pour Chaque Humeur",
            .onboarding2Description: "Heureux, triste, ou besoin d'un câlin ? Granly a une histoire pour vous.",
            .onboarding3Title: "Sagesse Quotidienne",
            .onboarding3Description: "Commencez votre journée avec de doux conseils et des leçons de vie intemporelles.",
            .onboarding4Title: "Toujours Là Pour Vous",
            .onboarding4Description: "Un espace sûr pour se sentir aimé, soutenu et compris.",

            .chooseLanguage: "Choisissez Votre Langue",
            .chooseLanguageSubtitle: "Sélectionnez une langue pour commencer votre voyage avec Granly",

            .greetingMorning: "Bonjour,",
            .greetingAfternoon: "Bon après-midi,",
            .greetingEvening: "Bonsoir,",
            .myDear: "Mon Cher",

            .featuredForYou: "Sélectionné Pour Vous",
            .howAreYouFeeling: "Comment vous sentez-vous?",
            .surpriseMe: "Surprenez-Moi", .favorites: "Favoris", .dailyWisdom: "Sagesse Quotidienne",
            .dailyInspiration: "Inspiration Quotidienne",
            .featuredSeeAll: "Toutes les Histoires",
            .noStoriesFound: "Aucune histoire trouvée pour ce filtre.",

            .tellingFrom: "RACONTÉ DEPUIS", .readMin: "min de lecture",
            .shuffle: "Mélanger", .story: "Histoire", .loading: "Chargement...",
            .playingFromLibrary: "LECTURE DEPUIS VOTRE BIBLIOTHÈQUE", .grandmasStories: "Histoires de Grand-mère",
            .narratedByGrandma: "Raconté par Grand-mère", .preparingStory: "Préparation de l'histoire...",
            .storyPreview: "APERÇU DE L'HISTOIRE", .showFullStory: "Afficher l'histoire complète",

            .toastHehe: "Hehe!", .toastILoveYou: "Je vous aime!",
            .toastYoureDoing: "Vous faites du bon travail!", .toastAlwaysHere: "Toujours là pour vous",
            .toastOhMy: "Oh là là! Comme c'est doux",

            .moodHappy: "Heureux", .moodSad: "Triste", .moodAnxious: "Anxieux",
            .moodLonely: "Seul", .moodTired: "Fatigué", .moodAngry: "En colère",
            .moodGrateful: "Reconnaissant", .moodExcited: "Enthousiasmé",

            .profile: "Profil", .personal: "Personnel", .preferences: "Préférences", .support: "Assistance",
            .grandmasName: "Nom de Grand-mère", .grandmaMakeover: "Transformation de Grand-mère",
            .language: "Langue", .darkMode: "Mode Sombre", .dailyReminders: "Rappels Quotidiens",
            .aboutGrantly: "À Propos de Granly", .viewOnboarding: "Voir l'Introduction",
            .rateGrantly: "Évaluer Granly", .shareWithFriends: "Partager avec des Amis",
            .resetAllData: "Réinitialiser Tout", .storiesRead: "Histoires Lues",
            .renameGrandma: "Renommer Grand-mère",
            .resetDataQuestion: "Réinitialiser les Données?",
            .resetDataMessage: "L'historique, les favoris et les paramètres seront effacés. Ceci est irréversible.",
            .resetDataConfirm: "Réinitialiser", .rateMessage: "Évaluer Granly",
            .thankYouForLove: "Merci pour votre amour!",

            .makeover: "Transformation", .hair: "Cheveux", .glasses: "Lunettes", .outfit: "Tenue",
            .pattern: "Motif", .accessories: "Accessoires", .hats: "Chapeaux",
            .earrings: "Boucles d'oreilles", .face: "Visage", .backgrounds: "Arrière-plans", .filters: "Filtres",
            .wrinkleIntensity: "Intensité des Rides", .greyIntensity: "Intensité des Cheveux Gris",
            .browThickness: "Épaisseur des Sourcils", .eyelashes: "Cils",

            .wisdom: "Sagesse", .takeAction: "Pratique du Jour",
            .modernExplanation: "Sens Moderne", .grandmaAdvice: "Grand-mère Dit",
            .dailyPractice: "Pratique Quotidienne",

            .wisdomPageTitle: "Sagesse Quotidienne", .wisdomPageSubtitle: "Les conseils intemporels de Grand-mère",
            .shareWisdom: "Partager la Sagesse",
            .wisdomCatLife: "Leçons de Vie", .wisdomCatLove: "Amour et Famille",
            .wisdomCatResilience: "Résilience", .wisdomCatSimpleJoys: "Joies Simples",
            .wisdomCatHappiness: "Bonheur", .wisdomCatPatience: "Patience",

            .wisdomHubTitle: "Sagesse et Croissance", .wisdomHubSubtitle: "Un espace doux pour réfléchir et grandir.",
            .impactfulStories: "Histoires Marquantes", .impactfulStoriesSubtitle: "Leçons des plus grands moments de l'histoire.",
            .readOurHistory: "Lire Notre Histoire Commune",
            .universalWisdomSubtitle: "Des vérités intemporelles du monde entier.",
            .exploreDailyQuotes: "Explorer les Citations du Jour",
            .memoryBoxSubtitle: "Revisitez vos histoires et citations favorites.",
            .openMemoryBox: "Ouvrir la Boîte à Souvenirs",
            .askGrandmaSubtitle: "Besoin d'un conseil ? Je suis là pour écouter.",
            .talkToGrandma: "Parler à Grand-mère",
            .growthPath: "Chemin de Croissance", .growthPathSubtitle: "Suivez votre voyage émotionnel.",
            .chooseYourPath: "Choisissez Votre Chemin",

            .allCategory: "Tout", .shortCategory: "Court", .moralCategory: "Moral",
            .bedtimeCategory: "Coucher", .funnyCategory: "Drôle", .natureCategory: "Nature", .comfortCategory: "Réconfort",
            .storiesLabel: "Histoires", .minRead: "min de lecture",

            .discussThisQuote: "Discuter de cette citation",
            .updateGrowthPath: "Mettre à jour votre Chemin de Croissance",

            .emotionalGarden: "Votre Jardin Émotionnel",
            .statEnergy: "Énergie", .statPaths: "Chemins",
            .completeReflection: "Réflexion Complète",
            .reflectionAckButton: "J'ai réfléchi à ceci",
            .reflectionMessage: "En marquant ceci comme terminé, vous reconnaissez avoir pris le temps de vous concentrer sur ceci.",

            .chatWithGrandma: "Bavardez avec Grand-mère",
            .grandmaOnline: "En ligne • Prête à écouter",
            .grandmaTyping: "Grand-mère est en train d'écrire...",
            .tellGrandmaMind: "Dites à Grand-mère ce que vous avez en tête...",

            .storiesThatShapedUs: "Histoires qui Nous ont Façonnés",
            .storiesThatShapedUsSubtitle: "Apprenez des événements les plus marquants de l'histoire humaine.",

            .whatHappened: "Ce qui s'est Passé", .lifeLessons: "Leçons de Vie",
            .grandmaAsks: "Grand-mère Demande...", .growthTakeaway: "Leçon de Croissance",
            .yourReflection: "Votre Réflexion", .continueYourJourney: "Continuez votre Voyage",
            .talkGrandmaAboutThis: "Parler à Grand-mère de ceci",

            .aboutGranly: "À propos de Granly", .ourMission: "Notre Mission",
            .missionBody: "Granly a été créé avec un simple souhait : apporter chaleur, réconfort et la magie de la narration intemporelle dans votre vie quotidienne.",
            .rateAppStore: "Noter sur l'App Store", .privacyPolicy: "Politique de Confidentialité",
            .termsOfService: "Conditions d'Utilisation", .designedWithCare: "Conçu et Développé avec Soin",
            .copyright: "© 2026 Granly App", .websiteLabel: "Site Web",

            .saveLabel: "Enregistrer",
            .optionStyle: "Style", .optionColor: "Couleur", .optionFrames: "Montures",
            .optionNecklace: "Collier", .optionHatStyle: "Modèle de chapeau",
            .optionSkinTone: "Teint", .optionEyeColor: "Couleur des yeux", .optionExpression: "Expression",
            .optionLashes: "Cils", .optionTheme: "Thème", .optionCameraFilter: "Filtre caméra",

            .askGrandmaGreeting: "Bonjour mon cher! Qu'est-ce qui pese sur ton cœur aujourd'hui? Tu peux tout me dire.",

            .growthNode1Title: "Graine de Patience", .growthNode1Desc: "Apprends à accepter l'incertitude.",
            .growthNode2Title: "Pousse de Courage", .growthNode2Desc: "Affronte une peur, aussi petite soit-elle.",
            .growthNode3Title: "Branche du Pardon", .growthNode3Desc: "Libère-toi d'un vieux grief.",
            .growthNode4Title: "Fleur de Joie", .growthNode4Desc: "Trouve le bonheur dans l'ordinaire.",
            .growthNode5Title: "Racines de Sagesse", .growthNode5Desc: "Réfléchis à un échec passé.",

            .memories: "Souvenirs", .addMemory: "Ajouter un Souvenir", .noMemoriesYet: "Pas encore de souvenirs.",
            .askGrandma: "Demandez à Grand-mère", .typeYourFeeling: "Comment vous sentez-vous...",
            .sendMessage: "Envoyer",
            .historicalStories: "Histoires Historiques", .inspiredBy: "Inspiré de",
            .readStory: "Lire l'Histoire",
            .recipes: "Recettes", .prepTime: "Temps de Préparation", .ingredients: "Ingrédients",
            .steps: "Étapes", .difficulty: "Difficulté", .grandmasKitchen: "La Cuisine de Grand-mère",
            .comfortFoodSubtitle: "Une cuisine réconfortante pour l'âme.", .instructions: "Instructions",
            
            .cozyActivities: "Activités Cocooning",
            .cozyActivitiesSubtitle: "Des moments de réconfort pour votre âme.",
            .grandmasHeart: "Cœur de Grand-mère", .guidedMoment: "Moment Guidé",

            .universalWisdom: "Sagesse Universelle", .timelessTruthsSubtitle: "Des vérités intemporelles qui nous relient tous.",
            .simpleMeaning: "Signification Simple", .grandmaSaysTitle: "Grand-mère Dit...",

            .grandmasMemoryBox: "La Boîte à Souvenirs de Grand-mère", .emptyMemoryBox: "Votre Boîte à Souvenirs est vide.",
            .emptyMemoryBoxHint: "Appuyez sur l'icône en forme de cœur de vos histoires et citations préférées pour les conserver ici en toute sécurité.",
            .savedStories: "Histoires Enregistrées", .savedRecipes: "Recettes Enregistrées", .savedQuotes: "Citations Enregistrées",

            .dailyQuoteText: "\"Gardez toujours votre visage tourné vers le soleil et les ombres tomberont derrière vous.\"",
            .home: "Accueil"
        ],

        // ─────────────────────────── MANDARIN (zh-CN) ───────────────────────────
        .mandarin: [
            .appName: "Granly",
            .cancel: "取消", .save: "保存", .ok: "确定", .done: "完成",
            .skip: "跳过", .reset: "重置", .close: "关闭",
            .continueAction: "继续", .getStarted: "开始",
            .seeAll: "查看全部", .of: "/", .comingSoon: "敬请期待",
            .version: "版本",

            .onboarding1Title: "欢迎来到 Granly",
            .onboarding1Description: "一个充满温馨故事和奶奶智慧的舒适角落。",
            .onboarding2Title: "适合各种心情的故事",
            .onboarding2Description: "开心、难过、还是只需要一个拥抱？Granly 都有适合你的故事。",
            .onboarding3Title: "每日智慧",
            .onboarding3Description: "用温柔的建议和永恒的人生哲理开始你的一天。",
            .onboarding4Title: "永远在这里陪伴你",
            .onboarding4Description: "一个让你感到被爱、支持和理解的安全空间。",

            .chooseLanguage: "选择您的语言",
            .chooseLanguageSubtitle: "选择一种语言，开始您的 Granly 之旅",

            .greetingMorning: "早上好，",
            .greetingAfternoon: "下午好，",
            .greetingEvening: "晚上好，",
            .myDear: "亲爱的",

            .featuredForYou: "为您推荐",
            .howAreYouFeeling: "您现在感觉如何？",
            .surpriseMe: "给我惊喜", .favorites: "收藏", .dailyWisdom: "每日智慧",
            .dailyInspiration: "每日灵感",
            .featuredSeeAll: "全部故事",
            .noStoriesFound: "没有找到符合此筛选条件的故事。",

            .tellingFrom: "倾听源自", .readMin: "分钟阅读",
            .shuffle: "随机", .story: "故事", .loading: "加载中...",
            .playingFromLibrary: "正在播放你的库", .grandmasStories: "奶奶的故事",
            .narratedByGrandma: "由奶奶讲述", .preparingStory: "正在准备故事...",
            .storyPreview: "故事预览", .showFullStory: "显示完整故事",

            .toastHehe: "呵呵！", .toastILoveYou: "我爱你，亲爱的！",
            .toastYoureDoing: "你做得很棒！", .toastAlwaysHere: "永远在这里陪伴你",
            .toastOhMy: "天啊！真贴心",

            .moodHappy: "开心", .moodSad: "难过", .moodAnxious: "焦虑",
            .moodLonely: "孤独", .moodTired: "疲倦", .moodAngry: "生气",
            .moodGrateful: "感恩", .moodExcited: "兴奋",

            .profile: "个人资料", .personal: "个人", .preferences: "偏好设置", .support: "支持",
            .grandmasName: "奶奶的名字", .grandmaMakeover: "给奶奶打扮",
            .language: "语言", .darkMode: "深色模式", .dailyReminders: "每日提醒",
            .aboutGrantly: "关于 Granly", .viewOnboarding: "查看引导",
            .rateGrantly: "评价 Granly", .shareWithFriends: "分享给朋友",
            .resetAllData: "重置所有数据", .storiesRead: "阅读的故事",
            .renameGrandma: "重命名奶奶",
            .resetDataQuestion: "重置数据?",
            .resetDataMessage: "这将清除您的阅读历史、收藏库和个性化设置。此操作无法撤销。",
            .resetDataConfirm: "重置", .rateMessage: "评价 Granly",
            .thankYouForLove: "感谢您的喜爱！",

            .makeover: "装扮", .hair: "发型", .glasses: "眼镜", .outfit: "服装",
            .pattern: "图案", .accessories: "配饰", .hats: "帽子",
            .earrings: "耳环", .face: "脸型", .backgrounds: "背景", .filters: "滤镜",
            .wrinkleIntensity: "皱纹深浅", .greyIntensity: "白发程度",
            .browThickness: "眉毛浓密度", .eyelashes: "睫毛",

            .wisdom: "智慧", .takeAction: "今日实践",
            .modernExplanation: "现代启示", .grandmaAdvice: "奶奶说",
            .dailyPractice: "日常练习",

            .wisdomPageTitle: "每日智慧", .wisdomPageSubtitle: "奶奶的永恒忠告",
            .shareWisdom: "分享智慧",
            .wisdomCatLife: "人生课题", .wisdomCatLove: "爱与家庭",
            .wisdomCatResilience: "坚韧", .wisdomCatSimpleJoys: "简单快乐",
            .wisdomCatHappiness: "幸福", .wisdomCatPatience: "耐心",

            .wisdomHubTitle: "智慧与成长", .wisdomHubSubtitle: "一个温柔的反思与成长空间。",
            .impactfulStories: "影响深远的故事", .impactfulStoriesSubtitle: "来自历史重大时刻的教训。",
            .readOurHistory: "阅读我们的共同历史",
            .universalWisdomSubtitle: "来自世界各地的永恒真理。",
            .exploreDailyQuotes: "探索每日语录",
            .memoryBoxSubtitle: "重温您最喜爱的故事和语录。",
            .openMemoryBox: "打开记忆宝盒",
            .askGrandmaSubtitle: "需要建议？我在这里倾听。",
            .talkToGrandma: "和奶奶聊聊",
            .growthPath: "成长之路", .growthPathSubtitle: "追踪您的情感旅程。",
            .chooseYourPath: "选择您的道路",

            .allCategory: "全部", .shortCategory: "短篇", .moralCategory: "寓言",
            .bedtimeCategory: "睡前", .funnyCategory: "趣味", .natureCategory: "自然", .comfortCategory: "慰藉",
            .storiesLabel: "故事", .minRead: "分钟阅读",
            
            .cozyActivities: "温馨活动",
            .cozyActivitiesSubtitle: "抚慰心灵的写意时刻。",
            .grandmasHeart: "奶奶的心声", .guidedMoment: "导引时刻",

            .discussThisQuote: "讨论这句话",
            .updateGrowthPath: "更新您的成长之路",

            .emotionalGarden: "您的情感花园",
            .statEnergy: "能量", .statPaths: "路径",
            .completeReflection: "完成反思",
            .reflectionAckButton: "我已经反思了这个",
            .reflectionMessage: "通过将此标记为已完成，您承认已花时间专注于此。",

            .chatWithGrandma: "与奶奶聊天",
            .grandmaOnline: "在线 • 准备倾听",
            .grandmaTyping: "奶奶正在输入...",
            .tellGrandmaMind: "告诉奶奶您心里想的...",

            .storiesThatShapedUs: "塑造我们的故事",
            .storiesThatShapedUsSubtitle: "从人类历史中最具影响力的事件中学习。",

            .whatHappened: "发生了什么", .lifeLessons: "人生课题",
            .grandmaAsks: "奶奶问...", .growthTakeaway: "成长要点",
            .yourReflection: "您的反思", .continueYourJourney: "继续您的旅程",
            .talkGrandmaAboutThis: "就此与奶奶交流",

            .aboutGranly: "关于Granly", .ourMission: "我们的使命",
            .missionBody: "Granly的诞生源于一个简单的愿望：将温暖、安慰和永恒的故事魔力带入您的日常生活。",
            .rateAppStore: "在App Store评分", .privacyPolicy: "隐私政策",
            .termsOfService: "服务条款", .designedWithCare: "用心设计与开发",
            .copyright: "© 2026 Granly应用", .websiteLabel: "网站",

            .saveLabel: "保存",
            .optionStyle: "风格", .optionColor: "颜色", .optionFrames: "镜框",
            .optionNecklace: "项链", .optionHatStyle: "帽子款式",
            .optionSkinTone: "肤色", .optionEyeColor: "眼睛颜色", .optionExpression: "表情",
            .optionLashes: "睫毛", .optionTheme: "主题", .optionCameraFilter: "相机滤镜",

            .askGrandmaGreeting: "亲爱的，你好！今天心里有什么想说的吗？什么都可以告诉我。",

            .growthNode1Title: "耐心的种子", .growthNode1Desc: "学习与不确定性和平共处。",
            .growthNode2Title: "勇气的幼苗", .growthNode2Desc: "面对一个恐惧，无论多小。",
            .growthNode3Title: "宽容的枝条", .growthNode3Desc: "放下过去的怨恨。",
            .growthNode4Title: "快乐的花朵", .growthNode4Desc: "在平凡事物中寻找幸福。",
            .growthNode5Title: "智慧的根", .growthNode5Desc: "反思过去的失败。",

            .memories: "回忆", .addMemory: "添加回忆", .noMemoriesYet: "暂无回忆。",
            .askGrandma: "问问奶奶", .typeYourFeeling: "写下您的感受...",
            .sendMessage: "发送",
            .historicalStories: "历史故事", .inspiredBy: "灵感来源",
            .readStory: "阅读故事",
            .recipes: "食谱", .prepTime: "准备时间", .ingredients: "食材",
            .steps: "步骤", .difficulty: "难度", .grandmasKitchen: "奶奶的厨房",
            .comfortFoodSubtitle: "温暖灵魂的疗愈美食。", .instructions: "制作步骤",

            .universalWisdom: "普世智慧", .timelessTruthsSubtitle: "连接我们所有人的永恒真理。",
            .simpleMeaning: "简单含义", .grandmaSaysTitle: "奶奶说...",

            .grandmasMemoryBox: "奶奶的记忆宝盒", .emptyMemoryBox: "你的记忆宝盒是空的。",
            .emptyMemoryBoxHint: "点击你最喜欢的故事和句子上的小爱心图标，把它们安全地保存在这里。",
            .savedStories: "保存的故事", .savedRecipes: "保存的食谱", .savedQuotes: "保存的句子",

            .dailyQuoteText: "\"将你的脸永远朝向阳光，阴影就会落在你的身后。\"",
            .home: "首页"
        ],
    ]
}
