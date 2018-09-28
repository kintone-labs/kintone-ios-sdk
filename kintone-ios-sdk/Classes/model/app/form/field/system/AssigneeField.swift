// Copyright (c) 2018 Cybozu, Inc.

public class AssigneeField: AbstractProcessManagementField {
    
    public init(_ code: String) {
        super.init()
        self.code = code
        self.type = FieldType.STATUS_ASSIGNEE;
    }
    
    public required init(from decoder: Decoder) throws {
         try super.init(from: decoder)
    }
}
