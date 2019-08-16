//
//  Cursor.swift
//  kintone-ios-sdk
//
//  Created by Ho Kim Cuc on 8/15/19.
//  Copyright © 2019 Cybozu. All rights reserved.
//

public class Cursor: NSObject {
    var connection: Connection?
    var parser = CursorParser()
    private let defaultGetRecordsSize = 100
    
    public init(_ connection: Connection?) {
        self.connection = connection;
    }
}

extension Cursor: RecordCursor{
}

