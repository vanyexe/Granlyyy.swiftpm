//
//  LoginView.swift
//  Granly
//
//  Created by student on 10/02/26.
//
import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @StateObject private var languageManager = LanguageManager()
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            Color.themeBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Half: Image
                ZStack {
                    Color.themeAccent.opacity(0.2)
                    Image("sweet_grandma_avatar")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                        .shadow(radius: 10)
                        .padding(.bottom, 20)
                }
                .frame(height: UIScreen.main.bounds.height * 0.45)
                .overlay(
                    LinearGradient(colors: [.clear, Color.themeBackground], startPoint: .center, endPoint: .bottom)
                )
                
                // Bottom Half: Controls
                VStack(spacing: 24) {
                    Text("Welcome Back")
                        .font(.custom("Baskerville-Bold", size: 36))
                        .foregroundStyle(Color.themeText)
                    
                    VStack(spacing: 16) {
                        TextField("Username", text: $username)
                            .padding()
                            .background(Color.white.opacity(0.5))
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.themeAccent.opacity(0.3), lineWidth: 1))
                        
                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color.white.opacity(0.5))
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.themeAccent.opacity(0.3), lineWidth: 1))
                        
                        // Fake Forgot Password Button
                        Button(action: {}) {
                            Text("Forgot Password?")
                                .font(.caption)
                                .foregroundColor(Color.themeText.opacity(0.6))
                        }
                        .disabled(true)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.horizontal, 32)
                    
                    // Language Selector
                    HStack {
                        Text("Language:")
                            .font(.subheadline)
                            .foregroundStyle(Color.themeText)
                        
                        Picker("Language", selection: $languageManager.selectedLanguage) {
                            Text(AppLanguage.english.displayName).tag(AppLanguage.english)
                            // Locking other languages by not listing them or disabling the picker
                            ForEach(AppLanguage.allCases.filter { $0 != .english }) { language in
                                Text(language.displayName)
                                    .tag(language)
                                    .foregroundColor(.gray) // Visually indicate locked?
                            }
                        }
                        .pickerStyle(.menu)
                        .tint(Color.themeAccent)
                        .disabled(true) // Lock the picker
                        .overlay(
                            Image(systemName: "lock.fill")
                                .font(.caption)
                                .offset(x: 20, y: -10)
                                .foregroundStyle(Color.themeText)
                            , alignment: .topTrailing
                        )
                    }
                    
                    Button(action: {
                        withAnimation {
                            isLoggedIn = true
                        }
                    }) {
                        Text("Enter Granly")
                            .font(.headline)
                            .foregroundColor(Color.themeBackground)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                (username.isEmpty || password.isEmpty) ? Color.gray : Color.themeText
                            )
                            .cornerRadius(12)
                    }
                    .disabled(username.isEmpty || password.isEmpty)
                    .padding(.horizontal, 40)
                    .padding(.top, 10)
                }
                .padding(.vertical, 30)
                
                Spacer()
            }
        }
    }
}


