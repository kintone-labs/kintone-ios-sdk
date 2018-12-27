// Copyright (c) 2018 Cybozu, Inc.

open class CreatorField: AbstractSystemInfoField {
    
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.CREATOR
    }
    
    public required init(from decoder: Decoder) throws {
         try super.init(from: decoder)
    }
    
}
