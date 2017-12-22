//
//  ValidationHelper.swift
//  saltyrtc-client-swift
//
//  Created by cherrywoods on 27.09.17.
//  Copyright © 2017 dadada. All rights reserved.
//

/**
 Validates a messagepack-str-format-family-formated string value containing a type name
 
 Parameter formatedValue: The deserialized value
 Parameter expectedType: The expected type name
 
 Returns: The validated and casted type string
 
 Throws: ValidationErrors:
 - .invalidValue, if formatedValue is not a non-nil String
 - .wrongType, if the casted given value is not equal to expectedType
 */
public func validateType(formatedValue value: Any?, expectedType expected: String) throws -> String {
    
    guard let type = value as? String else {
        throw ValidationError.invalidValue(requiredType: "String")
    }
    guard type == expected else {
        throw ValidationError.wrongType(requiredType: expected)
    }
    
    return type
    
}

/**
 Validates a messagepack-array-format-family-formated array. The type to validate against is supplied over generics
 If you want to allow nil values in the array, use an Optional as type-variable.
 
 Parameter formatedValue: The deserialized value
 Parameter T: The type, the elements of the array should have (validation fails, if the elements do not conform to this type). If you liked to allow nil values inside the array, also express this over this variable.
 
 Returns: The validated and casted array
 
 Throws: A ValidationError.invalidValue, if formatedValue is not a non-nil [T] (note that only the array may not be nil, if you allow it, any T in [T] might be nil)
 */
public func validateTypedArray<T>(formatedValue value: Any?) throws -> [T] {
    
    guard let array = value as? [T] else {
        throw ValidationError.invalidValue(requiredType: "[T]") // TODO: this is certainly problemetic, because actually it tells nothing about the error
    }
    
    // if nil is allowed is handled over the type variable
    
    return array
    
}

/**
 Validates (fixed-length) messagepack-bin-format-family-formated byte arrays.
 
 Parameter formatedValue: The deserialized value
 Parameter expectedLength: The expected length of the byte array
 
 Returns: The validated and casted byte array
 
 Throws: ValidationErrors:
 - .invalidValue, if formatedValue is not a non-nil byte array
 - .invalidLengthOfValue, if the type casted formated value has not the expected length you specified by the expedtedLength parameter
 */
public func validateByteArray(formatedValue value: Any?, expectedLength length: Int) throws -> [UInt8] {
    
    guard let bytes = value as? [UInt8] else {
        throw ValidationError.invalidValue(requiredType: "[UInt8]")
    }
    guard bytes.count == length else {
        throw ValidationError.invalidLengthOfValue(requiredLength: length, actualLength: bytes.count)
    }
    
    return bytes
    
}

/**
 Validates a messagepack-str-format-family-formated string
 
 Parameter formatedValue: The deserialized value
 
 Returns: The validated and casted string
 
 Throws: A ValidationError.invalidValue, if formatedValue is not a non-nil String
 */
public func validateString(formatedValue value: Any?) throws -> String {
    
    guard let string = value as? String else {
        throw ValidationError.invalidValue(requiredType: "String")
    }
    
    return string
    
}

// TODO: check wether this method is realy needed
/*
/**
 Validates a messagepack-map-format-family-formated dictionary of strings as keys and values of any type
 
 Parameter formatedValue: The deserialized value
 
 Returns: The validated and casted dictionary
 
 Throws: A ValidationError.invalidValue, if formatedValue is not a non-nil [String:Any]
 */
public func validateDictionaryOfStringsAndAnys(formatedValue value: Any?) throws -> [String : Any] {
    
    guard let dict = value as? [String : Any] else {
        throw ValidationError.invalidValue(requiredType: "[String:Any]")
    }
    
    return dict
    
}
*/

/**
 Validates a messagepack-map-format-family-formated dictionary of strings as keys and nested dictionarys of type [AnyHashable : Any]?
 
 Parameter formatedValue: The deserialized value
 
 Returns: The validated and casted dictionary
 
 Throws: A ValidationError.invalidValue, if formatedValue is not a non-nil [String:[AnyHashable:Any]?]
 */
public func validateDictionaryOfStringsAndDictionarys(formatedValue value: Any?) throws -> [String : [AnyHashable : Any]?] {
    
    guard let dict = value as? [String : [AnyHashable : Any]?] else {
        throw ValidationError.invalidValue(requiredType: "[String : [AnyHashable : Any]?]")
    }
    
    return dict
    
}

/**
 Validates a messagepack-int-format-family-formated close code
 
 Parameter formatedValue: The deserialized value
 Parameter dropResponder: Specifies the set of valid close codes (CloseCode.closeCodesDropResponder or CloseCodes.closeCodesAll)
 
 Returns: The validated and casted error code
 
 Throws: ValidationErrors:
 - .invalidValue, if formatedValue is not a non-nil Int
 - .invalidCloseCode, if the casted formatedValue is not a valid error code
 */
public func validateCloseCode(formatedValue value: Any?, dropResponder: Bool) throws -> Int {
    
    guard let number = value as? Int else {
        throw ValidationError.invalidValue(requiredType: "Int")
    }
    
    let codes: [CloseCode.Code] = dropResponder ? CloseCode.closeCodesDropResponder : CloseCode.closeCodesAll
    
    for code in codes {
        if code.rawValue == number {
            return number
        }
    }
    
    throw ValidationError.invalidCloseCode(code: number)
    
}
