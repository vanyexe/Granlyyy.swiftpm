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

    // MARK: Story
    case tellingFrom, readMin, shuffle, story, loading

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

    // MARK: Memory Box
    case memories, addMemory, noMemoriesYet

    // MARK: Ask Grandma
    case askGrandma, typeYourFeeling, sendMessage

    // MARK: Historical Stories
    case historicalStories, inspiredBy, readStory

    // MARK: Recipes
    // MARK: Recipes
    case recipes, prepTime, ingredients, steps, difficulty, grandmasKitchen, comfortFoodSubtitle, instructions

    // MARK: Universal Quotes
    case universalWisdom, timelessTruthsSubtitle, simpleMeaning, grandmaSaysTitle

    // MARK: Memory Box
    case grandmasMemoryBox, emptyMemoryBox, emptyMemoryBoxHint, savedStories, savedRecipes, savedQuotes

    // MARK: Home View
    case dailyQuoteText
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

            .tellingFrom: "TELLING FROM", .readMin: "min read",
            .shuffle: "Shuffle", .story: "Story", .loading: "Loading...",

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

            .dailyQuoteText: "\"Keep your face always toward the sunshine and shadows will fall behind you.\""
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

            .tellingFrom: "यह कहानी है", .readMin: "मिनट पढ़ें",
            .shuffle: "बदलें", .story: "कहानी", .loading: "लोड हो रहा है...",

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

            .memories: "यादें", .addMemory: "याद जोड़ें", .noMemoriesYet: "अभी तक कोई याद नहीं।",
            .askGrandma: "दादी से पूछें", .typeYourFeeling: "आप क्या महसूस कर रहे हैं...",
            .sendMessage: "भेजें",
            .historicalStories: "ऐतिहासिक कहानियाँ", .inspiredBy: "से प्रेरित",
            .readStory: "कहानी पढ़ें",
            .recipes: "व्यंजन", .prepTime: "तैयारी का समय", .ingredients: "सामग्री",
            .steps: "चरण", .difficulty: "कठिनाई", .grandmasKitchen: "दादी की रसोई",
            .comfortFoodSubtitle: "आत्मा के लिए सुकून का खाना।", .instructions: "निर्देश",

            .universalWisdom: "सार्वभौमिक ज्ञान", .timelessTruthsSubtitle: "कालातीत सत्य जो हम सभी को जोड़ते हैं।",
            .simpleMeaning: "सरल अर्थ", .grandmaSaysTitle: "दादी कहती हैं...",

            .grandmasMemoryBox: "दादी का मेमोरी बॉक्स", .emptyMemoryBox: "आपका मेमोरी बॉक्स खाली है।",
            .emptyMemoryBoxHint: "अपनी पसंदीदा कहानियों और विचारों को यहां सुरक्षित रखने के लिए उनके दिल के आइकन पर टैप करें।",
            .savedStories: "सहेजी गई कहानियाँ", .savedRecipes: "सहेजे गए व्यंजन", .savedQuotes: "सहेजे गए विचार",

            .dailyQuoteText: "\"अपना चेहरा हमेशा धूप की ओर रखें और परछाइयाँ आपके पीछे पड़ेंगी।\""
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

            .tellingFrom: "CONTANDO DESDE", .readMin: "min de lectura",
            .shuffle: "Aleatorio", .story: "Historia", .loading: "Cargando...",

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

            .memories: "Recuerdos", .addMemory: "Añadir recuerdo", .noMemoriesYet: "Aún no hay recuerdos.",
            .askGrandma: "Pregúntale a la abuela", .typeYourFeeling: "Escribe cómo te sientes...",
            .sendMessage: "Enviar",
            .historicalStories: "Historias históricas", .inspiredBy: "Inspirado en",
            .readStory: "Leer historia",
            .recipes: "Recetas", .prepTime: "Tiempo de prep.", .ingredients: "Ingredientes",
            .steps: "Pasos", .difficulty: "Dificultad", .grandmasKitchen: "La Cocina de la Abuela",
            .comfortFoodSubtitle: "Comida reconfortante para el alma.", .instructions: "Instrucciones",

            .universalWisdom: "Sabiduría Universal", .timelessTruthsSubtitle: "Verdades eternas que nos conectan a todos.",
            .simpleMeaning: "Significado Simple", .grandmaSaysTitle: "La Abuela Dice...",

            .grandmasMemoryBox: "La Caja de Recuerdos de la Abuela", .emptyMemoryBox: "Tu Caja de Recuerdos está vacía.",
            .emptyMemoryBoxHint: "Toca el ícono del corazón en tus historias y citas favoritas para guardarlas aquí.",
            .savedStories: "Historias Guardadas", .savedRecipes: "Recetas Guardadas", .savedQuotes: "Citas Guardadas",

            .dailyQuoteText: "\"Mantén siempre tu rostro hacia la luz del sol y las sombras caerán detrás de ti.\""
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

            .tellingFrom: "RACONTÉ DEPUIS", .readMin: "min de lecture",
            .shuffle: "Mélanger", .story: "Histoire", .loading: "Chargement...",

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

            .memories: "Souvenirs", .addMemory: "Ajouter un Souvenir", .noMemoriesYet: "Pas encore de souvenirs.",
            .askGrandma: "Demandez à Grand-mère", .typeYourFeeling: "Comment vous sentez-vous...",
            .sendMessage: "Envoyer",
            .historicalStories: "Histoires Historiques", .inspiredBy: "Inspiré de",
            .readStory: "Lire l'Histoire",
            .recipes: "Recettes", .prepTime: "Temps de Préparation", .ingredients: "Ingrédients",
            .steps: "Étapes", .difficulty: "Difficulté", .grandmasKitchen: "La Cuisine de Grand-mère",
            .comfortFoodSubtitle: "Une cuisine réconfortante pour l'âme.", .instructions: "Instructions",

            .universalWisdom: "Sagesse Universelle", .timelessTruthsSubtitle: "Des vérités intemporelles qui nous relient tous.",
            .simpleMeaning: "Signification Simple", .grandmaSaysTitle: "Grand-mère Dit...",

            .grandmasMemoryBox: "La Boîte à Souvenirs de Grand-mère", .emptyMemoryBox: "Votre Boîte à Souvenirs est vide.",
            .emptyMemoryBoxHint: "Appuyez sur l'icône en forme de cœur de vos histoires et citations préférées pour les conserver ici en toute sécurité.",
            .savedStories: "Histoires Enregistrées", .savedRecipes: "Recettes Enregistrées", .savedQuotes: "Citations Enregistrées",

            .dailyQuoteText: "\"Gardez toujours votre visage tourné vers le soleil et les ombres tomberont derrière vous.\""
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

            .tellingFrom: "倾听源自", .readMin: "分钟阅读",
            .shuffle: "随机", .story: "故事", .loading: "加载中...",

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

            .dailyQuoteText: "\"将你的脸永远朝向阳光，阴影就会落在你的身后。\""
        ],
    ]
}
