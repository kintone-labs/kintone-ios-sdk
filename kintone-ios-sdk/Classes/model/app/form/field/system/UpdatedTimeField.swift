//
//  UpdatedTimeField.swift
//  kintone-ios-sdk
//

public class UpdatedTimeField: AbstractSystemInfoField {
    
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.UPDATED_TIME
    }
    
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}
