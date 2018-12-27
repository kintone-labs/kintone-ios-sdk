// Copyright (c) 2018 Cybozu, Inc.

open class RecordNumberField: AbstractSystemInfoField {

    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.RECORD_NUMBER
    }
    
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    
}
