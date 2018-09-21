//
//  FieldType.swift
//  kintone-ios-sdk
//
//  Created by y001112 on 2018/09/05.
//  Copyright © 2018年 Cybozu. All rights reserved.
//

import Foundation

public enum FieldType: String, Codable {
    case CALC
    case GROUP
    case FILE
    case TIME
    case DATE
    case LINK
    case NUMBER
    case SUBTABLE
    case DATETIME
    case DROP_DOWN
    case MULTI_SELECT
    case RADIO_BUTTON
    case CHECK_BOX
    case USER_SELECT
    case ORGANIZATION_SELECT
    case GROUP_SELECT
    case REFERENCE_TABLE
    case MULTI_LINE_TEXT
    case MODIFIER
    case RICH_TEXT
    case SINGLE_LINE_TEXT
    case RECORD_NUMBER
    case CREATOR
    case CREATED_TIME
    case UPDATED_TIME
    case STATUS
    case STATUS_ASSIGNEE
    case CATEGORY
    case __ID__
    case __REVISION__
}
