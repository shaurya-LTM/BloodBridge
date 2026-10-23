
import Foundation
import SwiftData

@Model
final class DonorProfile {
    @Attribute(.unique) var id: UUID

    var fullName: String
    var email: String
    var dateOfBirth: Date
    var gender: String
    var phone: String
    var address: String
    var bloodGroup: String
    var isAvailable: Bool
    var createdAt: Date

    init(
        fullName: String,
        email: String,
        dateOfBirth: Date,
        gender: String,
        phone: String,
        address: String,
        bloodGroup: String,
        isAvailable: Bool = true
    ) {
        self.id = UUID()
        self.fullName = fullName
        self.email = email
        self.dateOfBirth = dateOfBirth
        self.gender = gender
        self.phone = phone
        self.address = address
        self.bloodGroup = bloodGroup
        self.isAvailable = isAvailable
        self.createdAt = .now
    }
}
