// Copyright (c) 2018 Cybozu, Inc.

open class FormFields: NSObject, Codable {
    private var app: String?
    private var revision: String?
    private var properties: [String: Field]?
    
    public override init() {
        app = nil
        revision = nil
        properties = [String: Field]()
    }
    
    enum CodingKeys: CodingKey {
        case app
        case revision
        case properties
    }
    
    struct DynamicKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        init?(intValue: Int) {
            self.intValue = intValue
            stringValue = "\(intValue)"
        }
        static func key(named name: String) -> DynamicKeys? {
            return DynamicKeys(stringValue: name)
        }
    }
    
    public init(_ app: String?, _ properties: [String: Field]?, _ revision: String?) {
        super.init()
        self.app = app;
        self.revision = revision;
        self.properties = properties;
    }
    
    open func getApp() -> Int? {
        return Int(self.app!)
    }
   
    open func setApp(_ app: String?) {
        return self.app = app
    }
    
    open func getRevision() -> Int? {
        return  Int(self.revision!)
    }
    
    open func setRevision(_ revision: String? ) {
        self.revision = revision
    }
    
    open func getProperties() -> [String: Field]? {
        return self.properties
    }
    
    open func setProperties(_ properties: [String: Field]?) {
        self.properties = properties
    }
    
    required public init(from decoder: Decoder) throws {
        super.init()
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.setApp(try container.decodeIfPresent(String.self, forKey: .app))
            self.setRevision(try container.decodeIfPresent(String.self, forKey: .revision))
            var properties = [String: Field]()
            
            let fields = try container.decode([String: Field].self, forKey: .properties)
            let nestedContainer = try container.nestedContainer(keyedBy: DynamicKeys.self, forKey:FormFields.CodingKeys.properties)
            for (key, field) in fields {
                let dynamicKey = DynamicKeys.key(named: key)
                switch field.getType()! {
                case .SINGLE_LINE_TEXT:
                    do {
                        let singleLine = try nestedContainer.decodeIfPresent(SingleLineTextField.self, forKey: dynamicKey!)
                        properties[key] = singleLine
                    } catch {
                        let lookupField = try nestedContainer.decodeIfPresent(LookupField.self, forKey: dynamicKey!)
                        properties[key] = lookupField
                    }
                    break
                case .MULTI_LINE_TEXT:
                    let multiLine = try nestedContainer.decodeIfPresent(MultiLineTextField.self, forKey: dynamicKey!)
                    properties[key] = multiLine
                    break
                case .RICH_TEXT:
                    let richTextField = try nestedContainer.decodeIfPresent(RichTextField.self, forKey: dynamicKey!)
                    properties[key] = richTextField
                    break
                case .DROP_DOWN:
                    let dropDown = try nestedContainer.decodeIfPresent(DropDownField.self, forKey: dynamicKey!)
                    properties[key] = dropDown
                    break
                case .MULTI_SELECT:
                    let multiSelect = try nestedContainer.decodeIfPresent(MultipleSelectField.self, forKey: dynamicKey!)
                    properties[key] = multiSelect
                    break
                case .RADIO_BUTTON:
                    let radioButton = try nestedContainer.decodeIfPresent(RadioButtonField.self, forKey: dynamicKey!)
                    properties[key] = radioButton
                    break
                case .CHECK_BOX:
                    let checkBox = try nestedContainer.decodeIfPresent(CheckboxField.self, forKey: dynamicKey!)
                    properties[key] = checkBox
                    break
                case .CALC:
                    let calculatField = try nestedContainer.decodeIfPresent(CalculatedField.self, forKey: dynamicKey!)
                    properties[key] = calculatField
                    break
                case .LINK:
                    let linkField = try nestedContainer.decodeIfPresent(LinkField.self, forKey: dynamicKey!)
                    properties[key] = linkField
                    break
                case .NUMBER:
                    do {
                        let numberField = try nestedContainer.decodeIfPresent(NumberField.self, forKey: dynamicKey!)
                        properties[key] = numberField
                    } catch {
                        let lookupField = try nestedContainer.decodeIfPresent(LookupField.self, forKey: dynamicKey!)
                        properties[key] = lookupField
                        break
                    }
                    break
                case .TIME:
                    let timeField = try nestedContainer.decodeIfPresent(TimeField.self, forKey: dynamicKey!)
                    properties[key] = timeField
                    break
                case .DATE:
                    let dateField = try nestedContainer.decodeIfPresent(DateField.self, forKey: dynamicKey!)
                    properties[key] = dateField
                    break
                case .DATETIME:
                    let dateTimeField = try nestedContainer.decodeIfPresent(DateTimeField.self, forKey: dynamicKey!)
                    properties[key] = dateTimeField
                    break
                case .GROUP:
                    let groupField = try nestedContainer.decodeIfPresent(FieldGroup.self, forKey: dynamicKey!)
                    properties[key] = groupField
                    break
                case .FILE:
                    let attachmentField = try nestedContainer.decodeIfPresent(AttachmentField.self, forKey: dynamicKey!)
                    properties[key] = attachmentField
                    break
                case .SUBTABLE:
                    let dynamicKey = DynamicKeys.key(named: key)
                    let subtableField = try nestedContainer.decodeIfPresent(SubTableField.self, forKey: dynamicKey!)
                    properties[key] = subtableField
                    break
                case .USER_SELECT:
                    let userSelectField = try nestedContainer.decodeIfPresent(UserSelectionField.self, forKey: dynamicKey!)
                    properties[key] = userSelectField
                    break
                case .ORGANIZATION_SELECT:
                    let organizationSelectField = try nestedContainer.decodeIfPresent(DepartmentSelectionField.self, forKey: dynamicKey!)
                    properties[key] = organizationSelectField
                    break
                case .GROUP_SELECT:
                    let groupSelectField = try nestedContainer.decodeIfPresent(GroupSelectionField.self, forKey: dynamicKey!)
                    properties[key] = groupSelectField
                    break
                case .REFERENCE_TABLE:
                    let relatedRecordField = try nestedContainer.decodeIfPresent(RelatedRecordsField.self, forKey: dynamicKey!)
                    properties[key] = relatedRecordField
                    break
                case .MODIFIER:
                    let modifierField = try nestedContainer.decodeIfPresent(ModifierField.self, forKey: dynamicKey!)
                    properties[key] = modifierField
                    break
                case .RECORD_NUMBER:
                    let recordNumber = try nestedContainer.decodeIfPresent(RecordNumberField.self, forKey: dynamicKey!)
                    properties[key] = recordNumber
                    break
                case .CREATOR:
                    let creatorField = try nestedContainer.decodeIfPresent(CreatorField.self, forKey: dynamicKey!)
                    properties[key] = creatorField
                    break
                case .CREATED_TIME:
                    let createdTime = try nestedContainer.decodeIfPresent(CreatedTimeField.self, forKey: dynamicKey!)
                    properties[key] = createdTime
                    break
                case .UPDATED_TIME:
                    let updatedTime = try nestedContainer.decodeIfPresent(UpdatedTimeField.self, forKey: dynamicKey!)
                    properties[key] = updatedTime
                    break
                case .STATUS:
                    let statusField = try nestedContainer.decodeIfPresent(StatusField.self, forKey: dynamicKey!)
                    properties[key] = statusField
                    break
                case .STATUS_ASSIGNEE:
                    let statusAssigneeField = try nestedContainer.decodeIfPresent(AssigneeField.self, forKey: dynamicKey!)
                    properties[key] = statusAssigneeField
                    break
                case .CATEGORY:
                    let category = try nestedContainer.decodeIfPresent(CategoryField.self, forKey: dynamicKey!)
                    properties[key] = category
                    break
                default:
                    throw KintoneAPIException("Invalid Field Type")
                }
            }
            self.setProperties(properties)
        } catch {
            throw KintoneAPIException("Parse error")
        }
    }
}
