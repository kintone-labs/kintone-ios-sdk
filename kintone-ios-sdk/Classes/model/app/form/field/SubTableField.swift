//
//  SubTableField.swift
//  kintone-ios-sdk
//

public class SubTableField: Field {
    internal var fields: [String: AbstractInputField] = [String: AbstractInputField]();
   
    enum SubTableFieldCodingKeys: CodingKey {
        case fields
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
    
    public override init() {
        super.init()
        self.type = FieldType.SUBTABLE;
    }
    
    public init(_ code: String?) {
        super.init()
        self.code = code!;
        self.type = FieldType.SUBTABLE;
    }
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SubTableFieldCodingKeys.self)
        if(self.fields.count > 0){
            try container.encode(self.fields, forKey: SubTableFieldCodingKeys.fields)
        }
        try super.encode(to: encoder)
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SubTableFieldCodingKeys.self)
        var properties = [String: AbstractInputField]()
        let fields = try container.decode([String: AbstractInputField].self, forKey: SubTableFieldCodingKeys.fields)
        let nestedContainer = try container.nestedContainer(keyedBy: DynamicKeys.self, forKey: SubTableFieldCodingKeys.fields)
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
            case .FILE:
                let attachmentField = try nestedContainer.decodeIfPresent(AttachmentField.self, forKey: dynamicKey!)
                properties[key] = attachmentField
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
            default:
                break
            }
        }
        self.fields = properties
        try super.init(from: decoder)
    }
    
    public func getFields() -> [String: AbstractInputField] {
        return self.fields;
    }
    
    public func setFields(_ fields: [String: AbstractInputField]) {
        self.fields = fields;
    }
    
    public func addField(_ field: AbstractInputField?) {
        if (field == nil || field!.getCode() == "" || field!.getCode().count == 0) {
            return;
        }
        fields[field!.getCode()] = field!;
    }
    
    public func removeField(_ field: AbstractInputField?) {
        if (field == nil || field!.getCode() == "" || field!.getCode().count == 0) {
            return;
        }
        fields[field!.getCode()] = nil;
    }
}
