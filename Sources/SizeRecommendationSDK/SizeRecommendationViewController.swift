//
//  SizeRecommendationView.swift
//  SizeRecommendationSDK
//
//  Created by ManojKumar Maurya (MSAZone) on 04/09/25.
//

import SwiftUI

/// A SwiftUI view that recommends a clothing size based on user-provided height and weight.
public struct SizeRecommendationView: View {
    
    // MARK: - State Properties
    
    /// User input for height in centimeters (string for TextField binding).
    @State private var height: String = ""
    
    /// User input for weight in kilograms (string for TextField binding).
    @State private var weight: String = ""
    
    /// Stores the calculated size result.
    @State private var recommendedSize: Size? = nil
    
    /// Controls the visibility of the custom popup card.
    @State private var showPopup: Bool = false
    
    /// Controls the visibility of validation error alerts.
    @State private var showAlert: Bool = false
    
    /// Stores the message displayed in the alert.
    @State private var alertMessage: String = ""
    
    /// Focus state for managing keyboard dismissal.
    @FocusState private var focusedField: Field?
    
    // MARK: - Init
    
    public init() {}
    
    // MARK: - Body
    
    public var body: some View {
        ZStack {
            
            // Main Content
            VStack(spacing: 24) {
                
                // Title
                Text("Find Your Perfect Fit")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                // Height Input Field
                inputField(
                    title: "Height (cm)",
                    placeholder: "e.g. 170",
                    text: $height,
                    focused: .height
                )
                
                // Weight Input Field
                inputField(
                    title: "Weight (kg)",
                    placeholder: "e.g. 65",
                    text: $weight,
                    focused: .weight
                )
                
                // Action Button
                Button(action: {
                    calculateSize()
                    hideKeyboard()
                }) {
                    Text("Get Size Recommendation")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .semibold))
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                }
                
                Spacer()
            }
            .padding()
            .toolbar {
                // Toolbar with "Done" button to dismiss keyboard
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") { hideKeyboard() }
                }
            }
            .alert(isPresented: $showAlert) {
                // Alert for invalid inputs
                Alert(
                    title: Text("Invalid Input"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            
            // MARK: - Popup Overlay
            if showPopup, let size = recommendedSize {
                // Dimmed background
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation { showPopup = false }
                    }
                
                // Popup Card
                popupResultCard(for: size)
                    .transition(.scale.combined(with: .opacity))
                    .zIndex(1)
            }
        }
    }
    
    // MARK: - UI Helpers
    
    /// Creates a reusable styled input field.
    private func inputField(title: String, placeholder: String, text: Binding<String>, focused: Field) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            TextField(placeholder, text: text)
                .keyboardType(.decimalPad)
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.4)))
                .focused($focusedField, equals: focused)
        }
    }
    
    /// Creates a custom popup card displaying the recommended size.
    private func popupResultCard(for size: Size) -> some View {
        VStack(spacing: 20) {
            
            Text("Your Recommended Size: \(size.rawValue)")
                .font(.headline)
                .foregroundColor(.green)
            
            Text("Based on your info, size \(size.rawValue) is recommended.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            Button("OK") {
                withAnimation { showPopup = false }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 10)
        .padding(.horizontal, 40)
    }
    
    // MARK: - Logic
    
    /// Validates input, calculates BMI, and determines recommended size.
    private func calculateSize() {
        guard let h = Double(height), let w = Double(weight) else {
            alertMessage = "Please enter valid numeric values for height and weight."
            showAlert = true
            return
        }
        
        guard h > 50, h < 250 else {
            alertMessage = "Height should be between 50 cm and 250 cm."
            showAlert = true
            return
        }
        
        guard w > 20, w < 300 else {
            alertMessage = "Weight should be between 20 kg and 300 kg."
            showAlert = true
            return
        }
        
        // Calculate size
        let size = SizeCalculator.calculateSize(height: h, weight: w)
        recommendedSize = size
        
        withAnimation {
            showPopup = true
        }
    }
    
    /// Hides the keyboard by resetting focus.
    private func hideKeyboard() {
        focusedField = nil
    }
    
    // MARK: - Supporting Types
    
    /// Enum for identifying which field is currently focused.
    private enum Field {
        case height, weight
    }
}

