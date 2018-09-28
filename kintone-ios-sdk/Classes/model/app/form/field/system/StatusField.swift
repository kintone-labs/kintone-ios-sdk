// Copyright (c) 2018 Cybozu, Inc.

public class StatusField: AbstractProcessManagementField {

    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.STATUS
    }
    
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}
