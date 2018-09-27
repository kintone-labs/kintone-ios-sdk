//
//  DepartmentSelectionField.swift
//  kintone-ios-sdk
//

public class DepartmentSelectionField: AbstractMemberSelectField {
    
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.ORGANIZATION_SELECT
    }
    
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    override public func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}
