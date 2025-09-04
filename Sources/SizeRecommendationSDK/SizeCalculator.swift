//
//  SizeCalculator.swift
//  SizeRecommendationSDK
//
//  Created by ManojKumar Maurya (MSAZone) on 04/09/25.
//


import Foundation

/// Represents available clothing sizes.
public enum Size: String, CaseIterable {
    case XXS, XS, S, M, L, XL, XXL, XXXL
}

/// A utility for calculating and recommending sizes based on height and weight.
public struct SizeCalculator {
    
    // MARK: - Public Methods
    
    /// Calculates the recommended size based on a user's height and weight.
    ///
    /// The calculation is based on the Body Mass Index (BMI) formula:
    /// ```
    /// BMI = weight / (height in meters)^2
    /// ```
    ///
    /// - Parameters:
    ///   - height: Height in centimeters (must be > 0).
    ///   - weight: Weight in kilograms (must be > 0).
    /// - Returns: The recommended `Size` based on BMI ranges.
    public static func calculateSize(height: Double, weight: Double) -> Size {
        // Convert height from cm → meters
        let heightInMeters = height / 100.0
        let bmi = weight / pow(heightInMeters, 2)
        
        // Map BMI ranges to sizes
        switch bmi {
        case ..<16.0: return .XXS
        case 16.0..<18.5: return .XS
        case 18.5..<22.0: return .S
        case 22.0..<25.0: return .M
        case 25.0..<28.0: return .L
        case 28.0..<32.0: return .XL
        case 32.0..<37.0: return .XXL
        default: return .XXXL
        }
    }
}
