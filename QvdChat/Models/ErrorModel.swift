
import Foundation

enum CustomError: Error {
    
    case usernameIsAlreadyTaken
    
    case enterYourName
    
    case enterYourSurname
    
    case enterUsername
    
}

extension CustomError: LocalizedError {
    
    var errorDescription: String? {
        
        switch self {
            
        case .usernameIsAlreadyTaken:
            return NSLocalizedString("Username is already taken", comment: "Username is already taken")
            
        case .enterYourName:
            return NSLocalizedString("Enter your name", comment: "Enter your name")
            
        case .enterYourSurname:
            return NSLocalizedString("Enter your surname", comment: "Enter your surname")
            
        case .enterUsername:
            return NSLocalizedString("Enter username", comment: "Enter username")
        }
        
    }
    
    
}

enum LoginTextFieldError {
    
    case accountNotFound
    
    case emptyTextField
    
    case incorrectPassword
    
    case emailIsBadlyFormatted
    
    case invalidUsername
    
    case usernameIsAlreadyTaken
    
    case unexpectedError
    
    case emailIsAlreadyInUse
    
    case passwordIsBadlyFormatted
}

enum LoginError: Error {
    
    case usernameIsNotEntered
    
    case incorrectPassword
}
