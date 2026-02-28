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
    case aboutGrantly, viewOnboarding, rateGrantly, shareWithFriends, shareMessage
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

    // MARK: Avatar & Player UI
    case currentPreview, themedIcons, resetToDefault, changeProfilePicture, chooseFromGallery
    case sleepTimer, playing, paused

    // MARK: Missing translations (Timers, Buttons, MemBox, Activities)
    case savedMemoriesTitle, storiesSavedCount, noMemoriesBody
    case termsIntroBody, privacyIntroBody
    case stopPlaybackAfter, timer5Min, timer15Min, timer30Min, turnOffTimer, shareStory, stopPlayback
    case stepNoOfTotal, step, currentStep, back, nextStep, completeLabel, activityCompleteTitle, activityCompleteBody, tryAgain, activityComplete, activityFinishedBody, wonderful

    // MARK: Notifications
    case notificationsSection, notifications, reminderTime
    case storyReminder, notifStorySubtitle
    case activityReminder, notifActivitySubtitle
    case progressUpdates, notifProgressSubtitle
    case notifEmptyTitle, notifEmptyBody
    case notifPermissionTitle, notifPermissionBody, notifPermissionButton
    // Notification body copy (shown in the actual OS notification)
    case notifStoryTitle, notifStoryBody, notifStoryBody2
    case notifActivityTitle, notifActivityBody, notifActivityBody2
    case notifStreakTitle, notifStreakBody
    case notifDisabledTitle, notifDisabledBody, notifSettingsButton
}

// MARK: - L10n Lookup Engine
struct L10n {
    /// Reads current language directly from UserDefaults (nonisolated — safe to call from anywhere)
    static func t(_ key: L10nKey) -> String {
        let code = UserDefaults.standard.string(forKey: "selectedLanguage") ?? AppLanguage.english.rawValue
        let lang = AppLanguage(rawValue: code) ?? .english
        return strings[lang]?[key] ?? strings[.english]?[key] ?? key.rawValue
    }

    /// Interpolates formatted text (e.g. "Step %d of %d") using the current language
    static func tf(_ key: L10nKey, _ args: CVarArg...) -> String {
        let template = t(key)
        return String(format: template, arguments: args)
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
            .renameGrandma: "Rename Grandma", .shareMessage: "Check out Granly! It's the sweetest storytelling app ever.",

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
            .privacyContactBody: "If you have any questions, concerns, or requests regarding this Privacy Policy, we would love to hear from you. You can reach us at:",

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
            .termsContactBody: "For any questions about these Terms of Service, please contact us at:",

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
            .home: "Home",

            // NEW STRUCTURAL TEXT KEYS
            .savedMemoriesTitle: "Saved Memories", .storiesSavedCount: "%d stories saved", .noMemoriesBody: "When grandma tells you a story you love,\ntap the heart to save it here forever.",
            .termsIntroBody: "These terms govern your use of Granly. Please take a moment to read them — they're written with the same warmth and care as everything else in this app.",
            .privacyIntroBody: "At Granly, your privacy is as sacred as grandma's secret recipe. Here's exactly what we do — and don't do — with your information.",
            .stopPlaybackAfter: "Stop audio playback after...", .timer5Min: "5 Minutes", .timer15Min: "15 Minutes", .timer30Min: "30 Minutes", .turnOffTimer: "Turn Off Timer", .shareStory: "Share Story", .stopPlayback: "Stop Playback",
            .stepNoOfTotal: "Step %d of %d", .step: "%d steps", .currentStep: "Current Step", .back: "Back", .nextStep: "Next Step", .completeLabel: "Complete", .activityCompleteTitle: "Activity Complete!", .activityCompleteBody: "You've completed all %d steps of %@. Well done.", .tryAgain: "Try Again", .activityComplete: "Activity Complete", .activityFinishedBody: "%@ finished.\nWell done — Grandma is proud of you.", .wonderful: "Wonderful",

            // NOTIFICATIONS
            .notificationsSection: "Notifications", .notifications: "Notifications", .reminderTime: "Reminder Time",
            .storyReminder: "Story Reminder", .notifStorySubtitle: "Evening nudge for bedtime stories",
            .activityReminder: "Activity Reminder", .notifActivitySubtitle: "Morning prompt for cozy activities",
            .progressUpdates: "Progress Updates", .notifProgressSubtitle: "Streaks and milestone celebrations",
            .notifEmptyTitle: "Your cozy moments will appear here",
            .notifEmptyBody: "Start a story or activity to receive updates.",
            .notifPermissionTitle: "Allow Notifications",
            .notifPermissionBody: "Let Granly remind you of story time and cozy activities.",
            .notifPermissionButton: "Enable Notifications",
            .notifStoryTitle: "Story Time",
            .notifStoryBody: "It's story time! Let's continue where you left off.",
            .notifStoryBody2: "A cozy bedtime story is waiting for you tonight.",
            .notifActivityTitle: "Good Morning",
            .notifActivityBody: "Try a 5-minute gratitude activity today.",
            .notifActivityBody2: "Let's build emotional strength with today's activity.",
            .notifStreakTitle: "You're on a roll!",
            .notifStreakBody: "3 days of story bonding in a row — Grandma is so proud!",
            .notifDisabledTitle: "Notifications disabled",
            .notifDisabledBody: "Enable them in iOS Settings → Granly.",
            .notifSettingsButton: "Settings",

            // Avatar & Player
            .currentPreview: "Current Preview",
            .themedIcons: "Themed Icons",
            .resetToDefault: "Reset to Default Grandma",
            .changeProfilePicture: "Change Profile Picture",
            .chooseFromGallery: "Choose from Gallery",
            .sleepTimer: "Sleep Timer",
            .playing: "Playing",
            .paused: "Paused"
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
            .renameGrandma: "दादी का नाम बदलें", .shareMessage: "ग्रॉन्ली आज़माएं! यह अब तक का सबसे प्यारा कहानी सुनाने वाला ऐप है।",

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
            .missionBody2: "हम ऐसी कहानियाँ, ज्ञान और सौम्य बातचीत बनाते हैं जो किसी ऐसे व्यक्ति के गले मिलने जैसी लगती हैं जिसने जीवन जिया, प्यार किया और सीखा। ग्रॉन्ली की हर सुविधा उसी देखभाल से बनाई गई है जैसे दादी अपना पसंदीदा नुस्खा बनाती हैं — धीरे-धीरे, प्यार से और हमेशा आपके लिए।",
            .missionBody3: "हमारी उम्मीद सरल है: कि ग्रॉन्ली आपको थोड़ा कम अकेला, थोड़ा अधिक स्थिर और उस ज्ञान के थोड़ा करीब महसूस कराए जो पीढ़ियों को आगे ले जाता रहा है।",
            .rateAppStore: "ऐप स्टोर पर रेट करें", .privacyPolicy: "गोपनीयता नीति",
            .termsOfService: "सेवा शर्तें", .designedWithCare: "प्यार से डिज़ाइन और विकसित",
            .copyright: "© 2026 ग्रॉन्ली एप्प", .websiteLabel: "वेबसाइट",

            // Legal pages – Hindi
            .privacyDataWeCollect: "हम कोई डेटा एकत्र नहीं करते",
            .privacyDataWeCollectBody: "ग्रॉन्ली पूरी तरह ऑफलाइन बना है। हम किसी बाहरी सर्वर पर कोई व्यक्तिगत जानकारी एकत्र, प्रसारित या संग्रहीत नहीं करते। आपका सारा डेटा — यादें, कस्टमाइज़ेशन, प्राथमिकताएँ — केवल आपके डिवाइस पर रहती हैं और कभी साझा नहीं की जाती।",
            .privacyHowWeUse: "आपका डेटा कैसे उपयोग होता है",
            .privacyHowWeUseBody: "ग्रॉन्ली द्वारा संग्रहीत कोई भी जानकारी (जैसे दादी का नाम, चुना गया अवतार, डार्क मोड प्राथमिकता, या पसंदीदा कहानियाँ) केवल ऐप के भीतर आपके अनुभव को व्यक्तिगत बनाने के लिए उपयोग की जाती है। इसे कभी किसी तीसरे पक्ष को बेचा, किराए पर दिया या साझा नहीं किया जाता।",
            .privacyChildren: "बच्चों की गोपनीयता",
            .privacyChildrenBody: "ग्रॉन्ली सभी उम्र के लिए सुरक्षित है। चूँकि हम कोई व्यक्तिगत डेटा एकत्र नहीं करते, इसलिए कोई दुरुपयोग की संभावना नहीं है। यदि आपको किसी बच्चे के ऐप उपयोग के बारे में कोई चिंता है, तो कृपया हमसे किसी भी समय संपर्क करें।",
            .privacyStorage: "डेटा संग्रहण और हटाना",
            .privacyStorageBody: "आपका डेटा एप्प्ल के सुरक्षित उपयोगकर्ता डिफ़ॉल्ट और डिवाइस पर संग्रहण का उपयोग करके स्थानीय रूप से संग्रहीत है। आप अपनी प्रोफ़ाइल में 'सारा डेटा मिटाएँ' विकल्प का उपयोग करके या ऐप को पूरी तरह अनइंस्टॉल करके किसी भी समय सारा डेटा हटा सकते हैं।",
            .privacyContact: "संपर्क करें",
            .privacyContactBody: "यदि इस गोपनीयता नीति के बारे में आपके कोई प्रश्न, चिंताएँ या अनुरोध हैं, तो हम आपसे सुनना चाहेंगे। आप हमसे यहाँ संपर्क कर सकते हैं:",

            .termsAcceptance: "नियमों की स्वीकृति",
            .termsAcceptanceBody: "ग्रॉन्ली डाउनलोड करने और उपयोग करने से आप इन सेवा की शर्तों से सहमत होते हैं। यदि आप इन शर्तों के किसी भी भाग से असहमत हैं, तो कृपया ऐप का उपयोग न करें। ये शर्तें समय-समय पर अपडेट की जा सकती हैं और नवीनतम संस्करण हमेशा ऐप के भीतर उपलब्ध होगा।",
            .termsUse: "ऐप का उपयोग",
            .termsUseBody: "ग्रॉन्ली व्यक्तिगत, गैर-व्यावसायिक उपयोग के लिए है। आप सहमत हैं कि आप ऐप का उपयोग सम्मानजनक और कानूनी तरीके से करेंगे। आप लिखित अनुमति के बिना ऐप के किसी भी हिस्से को रिवर्स-इंजीनियर, कॉपी या पुनः उत्पन्न करने का प्रयास नहीं करेंगे।",
            .termsIP: "बौद्धिक संपदा",
            .termsIPBody: "ऐप के भीतर सभी कहानियाँ, कलाकृति, पात्र (ग्रॉन्ली दादी सहित), एनिमेशन और लिखित सामग्री ग्रॉन्ली एप्प © 2026 की बौद्धिक संपदा हैं। सभी अधिकार सुरक्षित हैं।",
            .termsDisclaimer: "अस्वीकरण",
            .termsDisclaimerBody: "ग्रॉन्ली 'जैसा है' बिना किसी वारंटी के प्रदान किया जाता है। हम एक आरामदायक और विश्वसनीय अनुभव प्रदान करने का प्रयास करते हैं, लेकिन हम गारंटी नहीं देते कि ऐप त्रुटियों या रुकावटों से मुक्त होगा। ग्रॉन्ली पेशेवर मानसिक स्वास्थ्य सहायता का विकल्प नहीं है।",
            .termsChanges: "शर्तों में बदलाव",
            .termsChangesBody: "हम ऐप या लागू कानून में बदलावों को दर्शाने के लिए इन सेवा की शर्तों को कभी-कभी अपडेट कर सकते हैं। हम ऐप में सूचना के माध्यम से महत्वपूर्ण बदलावों की जानकारी देंगे। किसी भी बदलाव के बाद ग्रॉन्ली का उपयोग जारी रखना नई शर्तों की स्वीकृति है।",
            .termsContact: "संपर्क करें",
            .termsContactBody: "इन सेवा की शर्तों के बारे में किसी भी प्रश्न के लिए, कृपया हमसे संपर्क करें:",

            .legalLastUpdated: "अंतिम अपडेट: फरवरी 2026",

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
            .home: "मुख्य पृष्ठ",

            .savedMemoriesTitle: "सहेजी गई यादें", .storiesSavedCount: "%d कहानियाँ सहेजी गईं", .noMemoriesBody: "जब दादी आपको कोई ऐसी कहानी सुनाएं जो आपको पसंद हो,\nतो उसे हमेशा के लिए यहाँ सहेजने के लिए दिल पर टैप करें।",
            .termsIntroBody: "ये शर्तें आपके ग्रैनली के उपयोग को नियंत्रित करती हैं। कृपया इन्हें पढ़ने के लिए कुछ समय लें—इन्हें उसी गर्मजोशी और प्यार से लिखा गया है जैसे कि इस ऐप की अन्य चीज़ें।",
            .privacyIntroBody: "ग्रैनली में आपकी गोपनीयता दादी की गुप्त रेसिपी की तरह ही पवित्र है। यहाँ बताया गया है कि हम आपकी जानकारी के साथ क्या करते हैं—और क्या नहीं करते।",
            .stopPlaybackAfter: "इसके बाद ऑडियो प्लेबैक बंद करें...", .timer5Min: "5 मिनट", .timer15Min: "15 मिनट", .timer30Min: "30 मिनट", .turnOffTimer: "टाइमर बंद करें", .shareStory: "कहानी साझा करें", .stopPlayback: "प्लेबैक रोकें",
            .stepNoOfTotal: "चरण %d / %d", .step: "%d चरण", .currentStep: "वर्तमान चरण", .back: "पीछे", .nextStep: "अगला चरण", .completeLabel: "पूरा", .activityCompleteTitle: "गतिविधि पूरी हुई!", .activityCompleteBody: "आपने %@ के सभी %d चरण पूरे कर लिए हैं। बहुत बढ़िया।", .tryAgain: "फिर से प्रयास करें", .activityComplete: "गतिविधि पूरी", .activityFinishedBody: "%@ समाप्त हुई।\nबहुत बढ़िया — दादी को आप पर गर्व है।", .wonderful: "अद्भुत",

            // NOTIFICATIONS (Hindi)
            .notificationsSection: "सूचनाएँ", .notifications: "सूचनाएँ", .reminderTime: "अनुस्मारक समय",
            .storyReminder: "कहानी अनुस्मारक", .notifStorySubtitle: "सोने की कहानियों के लिए शाम की याद",
            .activityReminder: "गतिविधि अनुस्मारक", .notifActivitySubtitle: "आरामदायक गतिविधियों के लिए सुबह की याद",
            .progressUpdates: "प्रगति अपडेट", .notifProgressSubtitle: "स्ट्रीक और मील के पत्थर",
            .notifEmptyTitle: "आपके आरामदायक पल यहाँ दिखाई देंगे",
            .notifEmptyBody: "अपडेट पाने के लिए एक कहानी या गतिविधि शुरू करें।",
            .notifPermissionTitle: "सूचनाएँ चालू करें",
            .notifPermissionBody: "ग्रैनली को कहानी के समय और गतिविधियों की याद दिलाने दें।",
            .notifPermissionButton: "सूचनाएँ सक्षम करें",
            .notifStoryTitle: "कहानी का समय",
            .notifStoryBody: "आज की कहानी तैयार है",
            .notifStoryBody2: "अपने बच्चे के साथ 5 मिनट का समय बिताएं।",
            .notifActivityTitle: "शुभ प्रभात",
            .notifActivityBody: "आज एक 5 मिनट की कृतज्ञता गतिविधि करें।",
            .notifActivityBody2: "आज की गतिविधि के साथ भावनात्मक शक्ति बनाएं।",
            .notifStreakTitle: "बहुत अच्छे!",
            .notifStreakBody: "3 दिन कहानी पढ़ी — दादी को आप पर गर्व है!",
            .notifDisabledTitle: "सूचनाएँ अक्षम हैं",
            .notifDisabledBody: "इन्हें iOS सेटिंग्स → ग्रैनली में सक्षम करें।",
            .notifSettingsButton: "सेटिंग्स",

            // Avatar & Player
            .currentPreview: "वर्तमान पूर्वावलोकन",
            .themedIcons: "थीम वाले आइकन",
            .resetToDefault: "डिफ़ॉल्ट दादी पर रीसेट करें",
            .changeProfilePicture: "प्रोफ़ाइल चित्र बदलें",
            .chooseFromGallery: "गैलरी से चुनें",
            .sleepTimer: "नींद टाइमर",
            .playing: "चल रहा है",
            .paused: "रुका हुआ"
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
            .renameGrandma: "Renombrar a la abuela", .shareMessage: "¡Echa un vistazo a Granly! Es la aplicación de cuentos más dulce del mundo.",

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
            .reflectionAckButton: "He reflejado sobre esto",
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
            .missionBody2: "Creamos historias, sabiduría y conversaciones gentiles que se sienten como un abrazo de alguien que ha vivido, amado y aprendido. Cada función de Granly está hecha con cuidado, igual que una abuela hornea su receta favorita — lentamente, con amor y siempre para ti.",
            .missionBody3: "Nuestra esperanza es simple: que Granly te ayude a sentirte un poco menos solo, un poco más centrado y un poco más cerca de la sabiduría que ha llevado a las generaciones hacia adelante.",
            .rateAppStore: "Valorar en App Store", .privacyPolicy: "Política de Privacidad",
            .termsOfService: "Términos de Servicio", .designedWithCare: "Diseñado y Desarrollado con Cuidado",
            .copyright: "© 2026 Granly App", .websiteLabel: "Sitio Web",

            // Legal pages – Spanish
            .privacyDataWeCollect: "Datos que No Recopilamos",
            .privacyDataWeCollectBody: "Granly está creado completamente sin conexión. No recopilamos, transmitimos ni almacenamos ninguna información personal en servidores externos. Todos los datos que creas — recuerdos, personalizaciones, preferencias — viven solo en tu dispositivo y nunca se comparten.",
            .privacyHowWeUse: "Cómo se Usan tus Datos",
            .privacyHowWeUseBody: "Cualquier información almacenada por Granly (como el nombre de la abuela, el avatar elegido, la preferencia del modo oscuro o las historias favoritas) se utiliza únicamente para personalizar tu experiencia dentro de la aplicación. Nunca se vende, alquila ni comparte con terceros.",
            .privacyChildren: "Privacidad de los Niños",
            .privacyChildrenBody: "Granly está diseñado para ser seguro para todas las edades. Como no recopilamos ningún dato personal, no hay nada que pueda ser mal utilizado. Si tienes inquietudes sobre el uso de la aplicación por un niño, no dudes en contactarnos.",
            .privacyStorage: "Almacenamiento y Eliminación de Datos",
            .privacyStorageBody: "Tus datos se almacenan localmente en tu dispositivo mediante el almacenamiento seguro de Apple. Puedes eliminar todos los datos en cualquier momento usando 'Borrar todos los datos' en tu Perfil, o desinstalando la aplicación por completo.",
            .privacyContact: "Contáctanos",
            .privacyContactBody: "Si tienes alguna pregunta, inquietud o solicitud sobre esta Política de Privacidad, nos encantaría escucharte. Puedes contactarnos en:",

            .termsAcceptance: "Aceptación de los Términos",
            .termsAcceptanceBody: "Al descargar y usar Granly, aceptas estos Términos de Servicio. Si no estás de acuerdo con alguna parte de estos términos, por favor no uses la aplicación. Estos términos pueden actualizarse ocasionalmente y la versión más reciente siempre estará disponible dentro de la aplicación.",
            .termsUse: "Uso de la Aplicación",
            .termsUseBody: "Granly está destinado para uso personal y no comercial. Aceptas usar la aplicación de manera respetuosa y legal. No debes intentar aplicar ingeniería inversa, copiar o reproducir ninguna parte de la aplicación sin permiso escrito.",
            .termsIP: "Propiedad Intelectual",
            .termsIPBody: "Todas las historias, ilustraciones, personajes (incluida la abuela Granly), animaciones y contenido escrito dentro de la aplicación son propiedad intelectual de Granly App © 2026. Todos los derechos están reservados.",
            .termsDisclaimer: "Descargo de Responsabilidad",
            .termsDisclaimerBody: "Granly se proporciona 'tal como está', sin garantía de ningún tipo. Nos esforzamos por ofrecer una experiencia reconfortante y confiable, pero no garantizamos que la aplicación esté libre de errores. Granly no es un sustituto del apoyo profesional de salud mental.",
            .termsChanges: "Cambios en estos Términos",
            .termsChangesBody: "Podemos actualizar estos Términos de Servicio ocasionalmente para reflejar cambios en la aplicación o la ley aplicable. Te notificaremos de cambios significativos a través de un aviso en la aplicación. El uso continuado de Granly tras cualquier cambio constituye tu aceptación.",
            .termsContact: "Contáctanos",
            .termsContactBody: "Para cualquier pregunta sobre estos Términos de Servicio, contáctanos en:",

            .legalLastUpdated: "Última actualización: Febrero 2026",

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
            .home: "Inicio",

            .savedMemoriesTitle: "Recuerdos Guardados", .storiesSavedCount: "%d historias guardadas", .noMemoriesBody: "Cuando la abuela te cuente una historia que ames,\ntoca el corazón para guardarla aquí siempre.",
            .termsIntroBody: "Estos términos rigen el uso de Granly. Tómese un momento para leerlos; están escritos con el mismo cuidado y calidez que todo en la aplicación.",
            .privacyIntroBody: "En Granly, su privacidad es tan sagrada como la receta secreta de la abuela. Esto es exactamente lo que hacemos —y lo que no— con su información.",
            .stopPlaybackAfter: "Detener reproducción de audio después...", .timer5Min: "5 minutos", .timer15Min: "15 minutos", .timer30Min: "30 minutos", .turnOffTimer: "Apagar el temporizador", .shareStory: "Compartir historia", .stopPlayback: "Detener reproducción",
            .stepNoOfTotal: "Paso %d de %d", .step: "%d pasos", .currentStep: "Paso actual", .back: "Atrás", .nextStep: "Siguiente paso", .completeLabel: "Completar", .activityCompleteTitle: "¡Actividad completada!", .activityCompleteBody: "Ha completado todos los %d pasos de %@. Bien hecho.", .tryAgain: "Intentar otra vez", .activityComplete: "Actividad Completada", .activityFinishedBody: "%@ terminada.\nBien hecho — La abuela está orgullosa.", .wonderful: "Maravilloso",

            // NOTIFICATIONS (Spanish)
            .notificationsSection: "Notificaciones", .notifications: "Notificaciones", .reminderTime: "Hora del recordatorio",
            .storyReminder: "Recordatorio de historia", .notifStorySubtitle: "Recordatorio vespertino para cuentos",
            .activityReminder: "Recordatorio de actividad", .notifActivitySubtitle: "Recordatorio matutino para actividades",
            .progressUpdates: "Actualizaciones de progreso", .notifProgressSubtitle: "Rachas y logros",
            .notifEmptyTitle: "Tus momentos acogedores aparecerán aquí",
            .notifEmptyBody: "Comienza una historia o actividad para recibir actualizaciones.",
            .notifPermissionTitle: "Activar notificaciones",
            .notifPermissionBody: "Deja que Granly te recuerde la hora del cuento y las actividades.",
            .notifPermissionButton: "Activar notificaciones",
            .notifStoryTitle: "Hora del cuento",
            .notifStoryBody: "Es la hora del cuento. Sigamos donde lo dejaste.",
            .notifStoryBody2: "Esta noche te espera un cuento acogedor.",
            .notifActivityTitle: "Buenos días",
            .notifActivityBody: "Prueba una actividad de gratitud de 5 minutos hoy.",
            .notifActivityBody2: "Construyamos fortaleza emocional con la actividad de hoy.",
            .notifStreakTitle: "¡Sigue así!",
            .notifStreakBody: "¡3 días de cuentos seguidos — la abuela está muy orgullosa!",
            .notifDisabledTitle: "Notificaciones desactivadas",
            .notifDisabledBody: "Habilítalas en Ajustes de iOS → Granly.",
            .notifSettingsButton: "Ajustes",

            // Avatar & Player
            .currentPreview: "Vista previa actual",
            .themedIcons: "Iconos temáticos",
            .resetToDefault: "Restablecer a la abuela por defecto",
            .changeProfilePicture: "Cambiar foto de perfil",
            .chooseFromGallery: "Elegir de la galería",
            .sleepTimer: "Temporizador de apagado",
            .playing: "Reproduciendo",
            .paused: "En pausa"
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
            .resetAllData: "Réinitialiser toutes les données", .storiesRead: "Histoires lues",
            .renameGrandma: "Renommer Grand-mère", .shareMessage: "Découvrez Granly ! C'est l'application de contes la plus adorable au monde.",

            .resetDataQuestion: "Réinitialiser les Données?",
            .resetDataMessage: "L'historique, les favoris et les paramètres seront effacés. Ceci est irréversible.",
            .resetDataConfirm: "Réinitialiser", .rateMessage: "Évaluer Granly",
            .thankYouForLove: "Merci pour votre amour!",

            .makeover: "Transformation", .hair: "Cheveux", .glasses: "Lunettes", .outfit: "Tenue",
            .pattern: "Motif", .accessories: "Accesorios", .hats: "Chapeaux",
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
            .missionBody2: "Nous créons des histoires, de la sagesse et des conversations douces qui ressemblent à un câlin de quelqu'un qui a vécu, aimé et appris. Chaque fonctionnalité de Granly est conçue avec soin, comme Grand-mère prépare sa recette préférée — lentement, avec amour et toujours pour vous.",
            .missionBody3: "Notre espoir est simple : que Granly vous aide à vous sentir un peu moins seul, un peu plus ancré et un peu plus proche de la sagesse qui a porté les générations en avant.",
            .rateAppStore: "Noter sur l'App Store", .privacyPolicy: "Politique de Confidentialité",
            .termsOfService: "Conditions d'Utilisation", .designedWithCare: "Conçu et Développé avec Soin",
            .copyright: "© 2026 Granly App", .websiteLabel: "Site Web",

            // Legal pages – French
            .privacyDataWeCollect: "Données que Nous Ne Collectons Pas",
            .privacyDataWeCollectBody: "Granly est entièrement hors ligne. Nous ne collectons, ne transmettons ni ne stockons aucune information personnelle sur des serveurs externes. Toutes les données que vous créez — souvenirs, personnalisations, préférences — ne vivent que sur votre appareil et ne sont jamais partagées.",
            .privacyHowWeUse: "Comment Vos Données Sont Utilisées",
            .privacyHowWeUseBody: "Toute information stockée par Granly (comme le nom de grand-mère, l'avatar choisi, la préférence de mode sombre, ou les histoires préférées) est utilisée uniquement pour personnaliser votre expérience dans l'application. Elle n'est jamais vendue, louée ou partagée avec des tiers.",
            .privacyChildren: "Protection de la Vie Privée des Enfants",
            .privacyChildrenBody: "Granly est conçu pour être sûr pour tous les âges. Comme nous ne collectons aucune donnée personnelle, il n'y a rien à mal utiliser. Si vous avez des préoccupations concernant l'utilisation de l'application par un enfant, n'hésitez pas à nous contacter.",
            .privacyStorage: "Stockage et Suppression des Données",
            .privacyStorageBody: "Vos données sont stockées localement sur votre appareil via le stockage sécurisé d'Apple. Vous pouvez supprimer toutes les données à tout moment en utilisant 'Réinitialiser Tout' dans votre Profil, ou en désinstallant l'application.",
            .privacyContact: "Nous Contacter",
            .privacyContactBody: "Si vous avez des questions, préoccupations ou demandes concernant cette Politique de Confidentialité, nous serions ravis de vous entendre. Vous pouvez nous contacter à :",

            .termsAcceptance: "Acceptation des Conditions",
            .termsAcceptanceBody: "En téléchargeant et en utilisant Granly, vous acceptez ces Conditions d'Utilisation. Si vous n'êtes pas d'accord, veuillez ne pas utiliser l'application. Ces conditions peuvent être mises à jour de temps à autre et la dernière version sera toujours disponible dans l'application.",
            .termsUse: "Utilisation de l'Application",
            .termsUseBody: "Granly est destiné à un usage personnel et non commercial. Vous acceptez d'utiliser l'application de manière respectueuse et légale. Vous ne devez pas tenter de procéder à une rétro-ingénierie, de copier ou de reproduire une partie de l'application sans autorisation écrite.",
            .termsIP: "Propriété Intellectuelle",
            .termsIPBody: "Toutes les histoires, illustrations, personnages (y compris Granly la grand-mère), animations et contenus écrits dans l'application sont la propriété intellectuelle de Granly App © 2026. Tous droits réservés.",
            .termsDisclaimer: "Avertissement",
            .termsDisclaimerBody: "Granly est fourni 'tel quel', sans garantie d'aucune sorte. Bien que nous nous efforcions d'offrir une expérience réconfortante et fiable, nous ne garantissons pas que l'application sera exempte d'erreurs. Granly n'est pas un substitut à un soutien professionnel en santé mentale.",
            .termsChanges: "Modifications des Conditions",
            .termsChangesBody: "Nous pouvons mettre à jour ces Conditions d'Utilisation pour refléter les changements de l'application ou de la loi. Nous vous informerons des changements importants via une notification dans l'application. Votre utilisation continue de Granly après tout changement constitue votre acceptation.",
            .termsContact: "Nous Contacter",
            .termsContactBody: "Pour toute question sur ces Conditions d'Utilisation, contactez-nous à :",

            .legalLastUpdated: "Dernière mise à jour : Février 2026",

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
            .home: "Accueil",

            .savedMemoriesTitle: "Souvenirs Enregistrés", .storiesSavedCount: "%d histoires enregistrées", .noMemoriesBody: "Quand grand-mère te raconte une histoire que tu aimes,\ntouche le cœur pour la sauvegarder ici pour toujours.",
            .termsIntroBody: "Ces conditions régissent votre utilisation de Granly. Prenez un instant pour les lire — elles sont écrites avec autant de chaleur et de soin que tout le reste dans cette application.",
            .privacyIntroBody: "Chez Granly, votre vie privée est aussi sacrée que la recette secrète de grand-mère. Voici très exactement ce que nous faisons — et ne faisons pas — avec vos informations.",
            .stopPlaybackAfter: "Arrêter la lecture audio après...", .timer5Min: "5 Minutes", .timer15Min: "15 Minutes", .timer30Min: "30 Minutes", .turnOffTimer: "Éteindre le minuteur", .shareStory: "Partager l'histoire", .stopPlayback: "Arrêter la lecture",
            .stepNoOfTotal: "Étape %d sur %d", .step: "%d étapes", .currentStep: "Étape actuelle", .back: "Retour", .nextStep: "Étape suivante", .completeLabel: "Terminer", .activityCompleteTitle: "Activité terminée !", .activityCompleteBody: "Vous avez terminé toutes les %d étapes de %@. Bien joué.", .tryAgain: "Réessayer", .activityComplete: "Activité Terminée", .activityFinishedBody: "%@ terminée.\nBien joué — Grand-mère est fière de toi.", .wonderful: "Formidable",

            // NOTIFICATIONS (French)
            .notificationsSection: "Notifications", .notifications: "Notifications", .reminderTime: "Heure du rappel",
            .storyReminder: "Rappel d'histoire", .notifStorySubtitle: "Rappel du soir pour les histoires du coucher",
            .activityReminder: "Rappel d'activité", .notifActivitySubtitle: "Rappel du matin pour les activités réconfortantes",
            .progressUpdates: "Mises à jour de progression", .notifProgressSubtitle: "Séries et jalons",
            .notifEmptyTitle: "Vos moments douillets apparaîtront ici",
            .notifEmptyBody: "Commencez une histoire ou une activité pour recevoir des mises à jour.",
            .notifPermissionTitle: "Activer les notifications",
            .notifPermissionBody: "Laissez Granly vous rappeler l'heure des histoires et des activités.",
            .notifPermissionButton: "Activer les notifications",
            .notifStoryTitle: "L'heure de l'histoire",
            .notifStoryBody: "C'est l'heure de l'histoire! Continuons où vous en étiez.",
            .notifStoryBody2: "Une histoire réconfortante vous attend ce soir.",
            .notifActivityTitle: "Bonjour",
            .notifActivityBody: "Essayez une activité de gratitude de 5 minutes aujourd'hui.",
            .notifActivityBody2: "Construisons la force émotionnelle avec l'activité d'aujourd'hui.",
            .notifStreakTitle: "Continuez!",
            .notifStreakBody: "3 jours d'histoires de suite — Grand-mère est si fière!",
            .notifDisabledTitle: "Notifications désactivées",
            .notifDisabledBody: "Activez-les dans les Réglages iOS → Granly.",
            .notifSettingsButton: "Réglages",

            // Avatar & Player
            .currentPreview: "Aperçu actuel",
            .themedIcons: "Icônes thématiques",
            .resetToDefault: "Réinitialiser à la grand-mère par défaut",
            .changeProfilePicture: "Modifier la photo de profil",
            .chooseFromGallery: "Choisir dans la galerie",
            .sleepTimer: "Minuteur de sommeil",
            .playing: "Lecture en cours",
            .paused: "En pause"
        ],


        // ─────────────────────────── MANDARIN (zh-CN) ───────────────────────────
        .mandarin: [
            .appName: "格兰利",
            .cancel: "取消", .save: "保存", .ok: "确定", .done: "完成",
            .skip: "跳过", .reset: "重置", .close: "关闭",
            .continueAction: "继续", .getStarted: "开始",
            .seeAll: "查看全部", .of: "/", .comingSoon: "敬请期待",
            .version: "版本",

            .onboarding1Title: "欢迎来到 格兰利",
            .onboarding1Description: "一个充满温馨故事和奶奶智慧的舒适角落。",
            .onboarding2Title: "适合各种心情的故事",
            .onboarding2Description: "开心、难过、还是只需要一个拥抱？格兰利 都有适合你的故事。",
            .onboarding3Title: "每日智慧",
            .onboarding3Description: "用温柔的建议和永恒的人生哲理开始你的一天。",
            .onboarding4Title: "永远在这里陪伴你",
            .onboarding4Description: "一个让你感到被爱、支持和理解的安全空间。",

            .chooseLanguage: "选择您的语言",
            .chooseLanguageSubtitle: "选择一种语言，开始您的 格兰利 之旅",

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
            .aboutGrantly: "关于 格兰利", .viewOnboarding: "查看引导",
            .rateGrantly: "评价 格兰利", .shareWithFriends: "分享给朋友",
            .resetAllData: "重置所有数据", .storiesRead: "阅读的故事",
            .renameGrandma: "重命名奶奶", .shareMessage: "来看看格兰利吧！这是有史以来最温馨的故事应用。",

            .resetDataQuestion: "重置数据?",
            .resetDataMessage: "这将清除您的阅读历史、收藏库和个性化设置。此操作无法撤销。",
            .resetDataConfirm: "重置", .rateMessage: "评价格兰利",
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

            .aboutGranly: "关于格兰利", .ourMission: "我们的使命",
            .missionBody: "格兰利的诞生源于一个简单的愿望：将温暖、安慰和永恒的故事魔力带入您的日常生活。",
            .missionBody2: "我们创作故事、智慧和温柔的对话，感觉就像一个曾经生活、爱过和学习过的人给你的拥抱。格兰利中的每个功能都是精心打造的，就像奶奶烤她最爱的食谱一样——慢慢地、充满爱意地，永远为了你。",
            .missionBody3: "我们的希望很简单：让格兰利帮助您感到少一点孤独，多一点踏实，更接近那些让一代又一代人前进的智慧。",
            .rateAppStore: "在应用商店评分", .privacyPolicy: "隐私政策",
            .termsOfService: "服务条款", .designedWithCare: "用心设计与开发",
            .copyright: "© 2026 格兰利应用", .websiteLabel: "网站",

            // Legal pages – Mandarin
            .privacyDataWeCollect: "我们不收集的数据",
            .privacyDataWeCollectBody: "格兰利完全在离线状态下运行。我们不会在外部服务器上收集、传输或存储任何个人信息。您创建的所有数据——回忆、个性化设置、偏好——只保存在您的设备上，从不共享。",
            .privacyHowWeUse: "您的数据如何使用",
            .privacyHowWeUseBody: "格兰利存储的任何信息（如奶奶的名字、选择的头像、深色模式偏好或最喜欢的故事）仅用于在应用内个性化您的体验。这些信息永远不会被出售、出租或与任何第三方共享。",
            .privacyChildren: "儿童隐私",
            .privacyChildrenBody: "格兰利专为所有年龄段的用户设计。因为我们不收集任何个人数据，所以没有任何可被滥用的信息。如果您对孩子使用此应用程序有任何疑虑，请随时联系我们。",
            .privacyStorage: "数据存储与删除",
            .privacyStorageBody: "您的数据通过Apple安全的本地存储机制存储在您的设备上。您可以随时通过个人资料中的'重置所有数据'选项，或卸载应用程序来删除所有数据。",
            .privacyContact: "联系我们",
            .privacyContactBody: "如果您对本隐私政策有任何问题、疑虑或请求，我们很乐意听取您的意见。您可以通过以下方式联系我们",

            .termsAcceptance: "条款接受",
            .termsAcceptanceBody: "通过下载和使用格兰利，您同意这些服务条款。如果您不同意这些条款的任何部分，请不要使用该应用程序。这些条款可能会不时更新，最新版本将始终在应用程序内提供。",
            .termsUse: "应用程序的使用",
            .termsUseBody: "格兰利仅供个人和非商业用途。您同意以尊重和合法的方式使用该应用程序。未经书面许可，您不得尝试对应用程序的任何部分进行逆向工程、复制或再现。",
            .termsIP: "知识产权",
            .termsIPBody: "应用程序中的所有故事、艺术作品、角色（包括格兰利奶奶）、动画和书面内容均为格兰利应用程序 © 2026的知识产权。保留所有权利。",
            .termsDisclaimer: "免责声明",
            .termsDisclaimerBody: "格兰利按原样提供，不提供任何形式的保证。虽然我们努力提供舒适可靠的体验，但我们不保证应用程序不会出现错误或中断。格兰利不能替代专业的心理健康支持。",
            .termsChanges: "条款变更",
            .termsChangesBody: "我们可能会偶尔更新这些服务条款，以反映应用程序或适用法律的变化。我们将通过应用内通知告知您重大变更。您在任何变更后继续使用格兰利，即表示您接受新条款。",
            .termsContact: "联系我们",
            .termsContactBody: "如有关于这些服务条款的任何问题，请联系我们",

            .legalLastUpdated: "最后更新：2026年2月",

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
            .home: "首页",

            .savedMemoriesTitle: "已保存的记忆", .storiesSavedCount: "%d 个故事已保存", .noMemoriesBody: "当奶奶给你讲了一个你喜欢的故事时，\n点击心形图标永远保存在这里。",
            .termsIntroBody: "这些条款规定了您对的使用。花点时间阅读它们吧——它们在编写时融入了应用各处相同的温暖与关怀。",
            .privacyIntroBody: "在格兰利，您的隐私像奶奶的秘方一样神圣。这是关于我们对您信息的做法——以及绝不做的。",
            .stopPlaybackAfter: "此后停止音频播放...", .timer5Min: "5 分钟", .timer15Min: "15 分钟", .timer30Min: "30 分钟", .turnOffTimer: "关闭定时器", .shareStory: "分享故事", .stopPlayback: "停止播放",
            .stepNoOfTotal: "步骤 %d / %d", .step: "%d 步", .currentStep: "当前步骤", .back: "返回", .nextStep: "下一步", .completeLabel: "完成", .activityCompleteTitle: "活动完成！", .activityCompleteBody: "您已完成 %@ 的所有 %d 个步骤。做得好。", .tryAgain: "再试一次", .activityComplete: "活动完成", .activityFinishedBody: "活动 %@ 结束。\n做得好——奶奶为你感到骄傲。", .wonderful: "太棒了",

            // NOTIFICATIONS (Mandarin)
            .notificationsSection: "通知", .notifications: "通知", .reminderTime: "提醒时间",
            .storyReminder: "故事提醒", .notifStorySubtitle: "睡前故事的晚间提示",
            .activityReminder: "活动提醒", .notifActivitySubtitle: "温馨活动的早晨提示",
            .progressUpdates: "进度更新", .notifProgressSubtitle: "连续记录和里程碑",
            .notifEmptyTitle: "您的温馨时刻将会出现在这里",
            .notifEmptyBody: "开始一个故事或活动以接收更新。",
            .notifPermissionTitle: "允许通知",
            .notifPermissionBody: "让 Granly 提醒您讲故事时间和温馨活动。",
            .notifPermissionButton: "启用通知",
            .notifStoryTitle: "故事时间",
            .notifStoryBody: "今天的故事已经准备好了",
            .notifStoryBody2: "和孩子一起度过温暖时光。",
            .notifActivityTitle: "早上好",
            .notifActivityBody: "今天尝试一个5分钟的感恩活动。",
            .notifActivityBody2: "用今天的活动建立情感力量。",
            .notifStreakTitle: "继续加油！",
            .notifStreakBody: "连续3天讲故事 — 奶奶为您感到非常骄傲！",
            .notifDisabledTitle: "通知已禁用",
            .notifDisabledBody: "在 iOS 设置 → Granly 中启用它们。",
            .notifSettingsButton: "设置",

            // Avatar & Player
            .currentPreview: "当前预览",
            .themedIcons: "主题图标",
            .resetToDefault: "重置为默认奶奶",
            .changeProfilePicture: "更改资料图片",
            .chooseFromGallery: "从相册中选择",
            .sleepTimer: "睡眠阶段定时器",
            .playing: "正在播放",
            .paused: "已暂停"

        ],
    ]
}
