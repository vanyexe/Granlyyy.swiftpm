import SwiftUI

struct CozyActivitiesView: View {
    @EnvironmentObject var lang: LanguageManager
    private var activities: [CozyActivity] { 
        CozyActivityData.activities(for: lang.selectedLanguage) 
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.themeBackground.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        // Header
                        VStack(alignment: .leading, spacing: 10) {
                            Text(L10n.t(.cozyActivities))
                                .font(.granlyTitle)
                                .foregroundStyle(Color.themeText)
                            
                            Text(L10n.t(.cozyActivitiesSubtitle))
                                .font(.granlyHeadline)
                                .foregroundStyle(Color.themeRose)
                        }
                        .padding(.horizontal)
                        .padding(.top, 12)
                        
                        // Activities Grid
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], spacing: 16) {
                            ForEach(activities) { activity in
                                NavigationLink(destination: CozyActivityDetailView(activity: activity)) {
                                    CozyActivityCard(activity: activity)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 40)
                }
            }
        }
    }
}

struct CozyActivityCard: View {
    let activity: CozyActivity
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(activity.color.opacity(0.14))
                    .frame(width: 54, height: 54)
                
                Image(systemName: activity.iconName)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundStyle(activity.color)
            }
            .padding(.top, 16)
            
            VStack(spacing: 4) {
                Text(activity.title)
                    .font(.granlyBodyBold)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.themeText)
                    .lineLimit(1)
                
                HStack(spacing: 4) {
                    Image(systemName: "clock")
                        .font(.system(size: 10))
                    Text(activity.duration)
                        .font(.system(size: 10, weight: .medium))
                }
                .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 18)
        }
        .frame(maxWidth: .infinity)
        .background(Color.themeCard)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.04), radius: 8, x: 0, y: 4)
    }
}

struct CozyActivityDetailView: View {
    let activity: CozyActivity
    @Environment(\.dismiss) private var dismiss
    @State private var appear = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Hero Section
                ZStack(alignment: .bottomLeading) {
                    LinearGradient(
                        colors: [activity.color, activity.color.opacity(0.7)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(height: 220)
                    .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                    .padding(.horizontal)
                    
                    // Floating icon
                    Image(systemName: activity.iconName)
                        .font(.system(size: 80, weight: .bold))
                        .foregroundStyle(.white.opacity(0.9))
                        .shadow(color: .black.opacity(0.15), radius: 10, y: 5)
                        .padding(.horizontal, 40)
                        .padding(.bottom, 30)
                }
                .padding(.top, 10)
                
                VStack(alignment: .leading, spacing: 24) {
                    // Title section
                    VStack(alignment: .leading, spacing: 8) {
                        Text(activity.title)
                            .font(.granlyTitle)
                            .foregroundStyle(Color.themeText)
                        
                        HStack(spacing: 12) {
                            Label(activity.category, systemImage: "tag.fill")
                            Label(activity.duration, systemImage: "clock.fill")
                        }
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(activity.color)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(activity.color.opacity(0.12), in: Capsule())
                    }
                    
                    // Grandma's Quote
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "quote.opening")
                                .font(.granlyTitle2)
                                .foregroundStyle(activity.color)
                            Text(L10n.t(.grandmasHeart))
                                .font(.granlyHeadline)
                                .foregroundStyle(Color.themeText)
                        }
                        
                        Text(activity.grandmaTip)
                            .font(.body.italic())
                            .lineSpacing(6)
                            .foregroundStyle(Color.themeText.opacity(0.85))
                            .padding(20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(activity.color.opacity(0.08))
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                    }
                    
                    // Guided steps
                    VStack(alignment: .leading, spacing: 16) {
                        Text(L10n.t(.guidedMoment))
                            .font(.granlyTitle2)
                            .foregroundStyle(Color.themeText)
                        
                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(Array(activity.steps.enumerated()), id: \.offset) { index, step in
                                HStack(alignment: .top, spacing: 16) {
                                    Text("\(index + 1)")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundStyle(.white)
                                        .frame(width: 28, height: 28)
                                        .background(activity.color)
                                        .clipShape(Circle())
                                    
                                    Text(step)
                                        .font(.granlyBody)
                                        .lineSpacing(4)
                                        .foregroundStyle(Color.themeText)
                                }
                                .offset(y: appear ? 0 : 20)
                                .opacity(appear ? 1 : 0)
                                .animation(.spring(response: 0.5, dampingFraction: 0.75).delay(Double(index) * 0.1), value: appear)
                            }
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.themeCard)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
                .padding(.horizontal)
                .padding(.top, 24)
                .padding(.bottom, 40)
            }
        }
        .background(Color.themeBackground.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { /* Toggle calming music if assets were present */ }) {
                    Image(systemName: "music.note")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(activity.color)
                        .frame(width: 36, height: 36)
                        .background(activity.color.opacity(0.12), in: Circle())
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color.themeText)
                        .frame(width: 36, height: 36)
                        .background(Color.themeCard, in: Circle())
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear { appear = true }
    }
}
