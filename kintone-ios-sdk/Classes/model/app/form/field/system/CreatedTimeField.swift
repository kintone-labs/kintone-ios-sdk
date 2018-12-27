// Copyright (c) 2018 Cybozu, Inc.

open class CreatedTimeField: AbstractSystemInfoField {
    
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.CREATED_TIME
    }
    
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}
