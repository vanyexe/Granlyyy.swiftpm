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
    case recipes, prepTime, ingredients, steps, difficulty
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
            .steps: "Steps", .difficulty: "Difficulty",
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
            .steps: "चरण", .difficulty: "कठिनाई",
        ],

        // ─────────────────────────── SPANISH – fallback to English content strings ────────────────
        .spanish: [
            .appName: "Granly",
            .cancel: "Cancelar", .save: "Guardar", .ok: "Aceptar", .done: "Hecho",
            .skip: "Omitir", .reset: "Restablecer", .close: "Cerrar",
            .continueAction: "Continuar", .getStarted: "Empezar",
            .seeAll: "Ver Todo", .of: "de", .comingSoon: "Próximamente",
            .version: "Versión",

            .onboarding1Title: "Bienvenida a Granly",
            .onboarding1Description: "Tu rincón acogedor para historias entrañables y la sabiduría de la abuela.",
            .onboarding2Title: "Historias para Cada Estado",
            .onboarding2Description: "¿Feliz, triste, o solo necesitas un abrazo? Granly tiene una historia para ti.",
            .onboarding3Title: "Sabiduría Diaria",
            .onboarding3Description: "Comienza tu día con consejos gentiles y lecciones de vida atemporales.",
            .onboarding4Title: "Siempre Aquí Para Ti",
            .onboarding4Description: "Un lugar seguro para sentirte amado, apoyado y comprendido.",

            .chooseLanguage: "Elige Tu Idioma",
            .chooseLanguageSubtitle: "Selecciona un idioma para comenzar tu viaje con Granly",

            .greetingMorning: "Buenos Días,",
            .greetingAfternoon: "Buenas Tardes,",
            .greetingEvening: "Buenas Noches,",
            .myDear: "Mi Querido",

            .featuredForYou: "Destacado Para Ti",
            .howAreYouFeeling: "¿Cómo te sientes?",
            .surpriseMe: "Sorpréndeme", .favorites: "Favoritos", .dailyWisdom: "Sabiduría Diaria",
            .dailyInspiration: "Inspiración Diaria",

            .tellingFrom: "CONTANDO DESDE", .readMin: "min de lectura",
            .shuffle: "Mezclar", .story: "Historia", .loading: "Cargando...",

            .toastHehe: "¡Jeje!", .toastILoveYou: "¡Te quiero, querido!",
            .toastYoureDoing: "¡Lo estás haciendo muy bien!", .toastAlwaysHere: "Siempre aquí para ti",
            .toastOhMy: "¡Oh, qué dulce!",

            .moodHappy: "Feliz", .moodSad: "Triste", .moodAnxious: "Ansioso",
            .moodLonely: "Solo", .moodTired: "Cansado", .moodAngry: "Enojado",
            .moodGrateful: "Agradecido", .moodExcited: "Emocionado",

            .profile: "Perfil", .personal: "Personal", .preferences: "Preferencias", .support: "Soporte",
            .grandmasName: "Nombre de la Abuela", .grandmaMakeover: "Maquillaje de la Abuela",
            .language: "Idioma", .darkMode: "Modo Oscuro", .dailyReminders: "Recordatorios Diarios",
            .aboutGrantly: "Sobre Granly", .viewOnboarding: "Ver Introducción",
            .rateGrantly: "Califica Granly", .shareWithFriends: "Compartir con Amigos",
            .resetAllData: "Restablecer Todo", .storiesRead: "Historias Leídas",
            .renameGrandma: "Renombrar Abuela",
            .resetDataQuestion: "¿Restablecer Datos?",
            .resetDataMessage: "Esto borrará tu historial de lectura, historias favoritas y configuraciones. No se puede deshacer.",
            .resetDataConfirm: "Restablecer", .rateMessage: "Califica Granly",
            .thankYouForLove: "¡Gracias por tu amor!",

            .makeover: "Maquillaje", .hair: "Cabello", .glasses: "Gafas", .outfit: "Ropa",
            .pattern: "Patrón", .accessories: "Accesorios", .hats: "Sombreros",
            .earrings: "Aretes", .face: "Cara", .backgrounds: "Fondos", .filters: "Filtros",
            .wrinkleIntensity: "Intensidad de Arrugas", .greyIntensity: "Intensidad de Canas",
            .browThickness: "Grosor de Cejas", .eyelashes: "Pestañas",

            .wisdom: "Sabiduría", .takeAction: "Práctica de Hoy",
            .modernExplanation: "Significado Moderno", .grandmaAdvice: "La Abuela Dice",
            .dailyPractice: "Práctica Diaria",

            .memories: "Recuerdos", .addMemory: "Añadir Recuerdo", .noMemoriesYet: "Sin recuerdos aún.",
            .askGrandma: "Pregunta a la Abuela", .typeYourFeeling: "Escribe cómo te sientes...",
            .sendMessage: "Enviar",
            .historicalStories: "Historias Históricas", .inspiredBy: "Inspirado en",
            .readStory: "Leer Historia",
            .recipes: "Recetas", .prepTime: "Tiempo de Prep.", .ingredients: "Ingredientes",
            .steps: "Pasos", .difficulty: "Dificultad",
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
            .steps: "Étapes", .difficulty: "Difficulté",
        ],

        // ─────────────────────────── GERMAN ─────────────────────────────
        .german: [
            .appName: "Granly",
            .cancel: "Abbrechen", .save: "Speichern", .ok: "OK", .done: "Fertig",
            .skip: "Überspringen", .reset: "Zurücksetzen", .close: "Schließen",
            .continueAction: "Weiter", .getStarted: "Loslegen",
            .seeAll: "Alle Anzeigen", .of: "von", .comingSoon: "Demnächst",
            .version: "Version",

            .onboarding1Title: "Willkommen bei Granly",
            .onboarding1Description: "Deine gemütliche Ecke für herzerwärmende Geschichten und Omas Weisheit.",
            .onboarding2Title: "Geschichten für Jede Stimmung",
            .onboarding2Description: "Glücklich, traurig oder brauchst du einfach eine Umarmung? Granly hat eine Geschichte für dich.",
            .onboarding3Title: "Tägliche Weisheit",
            .onboarding3Description: "Beginne deinen Tag mit sanften Ratschlägen und zeitlosen Lebensweisheiten.",
            .onboarding4Title: "Immer Für Dich Da",
            .onboarding4Description: "Ein sicherer Ort, um sich geliebt, unterstützt und verstanden zu fühlen.",

            .chooseLanguage: "Sprache Wählen",
            .chooseLanguageSubtitle: "Wähle eine Sprache, um deine Reise mit Granly zu beginnen",

            .greetingMorning: "Guten Morgen,",
            .greetingAfternoon: "Guten Tag,",
            .greetingEvening: "Guten Abend,",
            .myDear: "Mein Liebling",

            .featuredForYou: "Für Dich Ausgewählt",
            .howAreYouFeeling: "Wie fühlst du dich?",
            .surpriseMe: "Überrasche Mich", .favorites: "Favoriten", .dailyWisdom: "Tägliche Weisheit",
            .dailyInspiration: "Tägliche Inspiration",

            .tellingFrom: "ERZÄHLT AUS", .readMin: "Min. Lesezeit",
            .shuffle: "Mischen", .story: "Geschichte", .loading: "Laden...",

            .toastHehe: "Hehe!", .toastILoveYou: "Ich liebe dich!",
            .toastYoureDoing: "Du machst das großartig!", .toastAlwaysHere: "Immer für dich da",
            .toastOhMy: "Oh mein! Wie süß",

            .moodHappy: "Glücklich", .moodSad: "Traurig", .moodAnxious: "Ängstlich",
            .moodLonely: "Einsam", .moodTired: "Müde", .moodAngry: "Wütend",
            .moodGrateful: "Dankbar", .moodExcited: "Aufgeregt",

            .profile: "Profil", .personal: "Persönlich", .preferences: "Einstellungen", .support: "Support",
            .grandmasName: "Omas Name", .grandmaMakeover: "Omas Makeover",
            .language: "Sprache", .darkMode: "Dunkelmodus", .dailyReminders: "Tägliche Erinnerungen",
            .aboutGrantly: "Über Granly", .viewOnboarding: "Einführung Anzeigen",
            .rateGrantly: "Granly Bewerten", .shareWithFriends: "Mit Freunden Teilen",
            .resetAllData: "Alle Daten Zurücksetzen", .storiesRead: "Gelesene Geschichten",
            .renameGrandma: "Oma Umbenennen",
            .resetDataQuestion: "Daten Zurücksetzen?",
            .resetDataMessage: "Verlauf, Favoriten und Einstellungen werden gelöscht. Dies kann nicht rückgängig gemacht werden.",
            .resetDataConfirm: "Zurücksetzen", .rateMessage: "Granly Bewerten",
            .thankYouForLove: "Danke für deine Liebe!",

            .makeover: "Makeover", .hair: "Haare", .glasses: "Brille", .outfit: "Outfit",
            .pattern: "Muster", .accessories: "Accessoires", .hats: "Hüte",
            .earrings: "Ohrringe", .face: "Gesicht", .backgrounds: "Hintergründe", .filters: "Filter",
            .wrinkleIntensity: "Faltenintensität", .greyIntensity: "Grauintensität",
            .browThickness: "Brauenstärke", .eyelashes: "Wimpern",

            .wisdom: "Weisheit", .takeAction: "Heutige Praxis",
            .modernExplanation: "Moderne Bedeutung", .grandmaAdvice: "Oma Sagt",
            .dailyPractice: "Tägliche Praxis",

            .memories: "Erinnerungen", .addMemory: "Erinnerung Hinzufügen", .noMemoriesYet: "Noch keine Erinnerungen.",
            .askGrandma: "Oma Fragen", .typeYourFeeling: "Wie fühlst du dich...",
            .sendMessage: "Senden",
            .historicalStories: "Historische Geschichten", .inspiredBy: "Inspiriert von",
            .readStory: "Geschichte Lesen",
            .recipes: "Rezepte", .prepTime: "Zubereitungszeit", .ingredients: "Zutaten",
            .steps: "Schritte", .difficulty: "Schwierigkeit",
        ],
    ]
}
