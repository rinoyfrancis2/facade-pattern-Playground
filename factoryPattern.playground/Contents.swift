import UIKit

protocol UIView {}
class UITextField: UIView {}
class UISwitch: UIView {}
class UIButton: UIView {}
class UILabel: UIView {}
class UIImageView: UIView {}

class DisneyTextField: UITextField {}
class DisneySwitch: UISwitch {}
class DisneyButton: UIButton {}
class DisneyLabel: UILabel {}
class DisneyImageView: UIImageView {}

enum ComponentType{
    case textfield
    case `switch`
    case button
    case label
    case image
}


protocol ComponentFactory {
    func createView(component : ComponentType) -> UIView
}


class DisneyComponentFactory : ComponentFactory {
    func createView(component: ComponentType) -> UIView {
        switch component {
                case .textfield:
                    print("DisneyTextField created")
                    return DisneyTextField()
                case .switch:
                    print("DisneySwitch created")
                    return DisneySwitch()
                case .button:
                    print("DisneyButton created")
                    return DisneyButton()
                case .label:
                    print("DisneyLabel created")
                    return DisneyLabel()
                case .image:
                    print("DisneyImageView created")
                    return DisneyImageView()
                }
    }
}


let dd = DisneyComponentFactory()
dd.createView(component: .button)
