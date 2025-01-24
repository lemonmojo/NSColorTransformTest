import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    @IBOutlet var window: NSWindow!
    @IBOutlet weak var colorWellOriginal: NSColorWell!
    @IBOutlet weak var textFieldOriginal: NSTextField!
    @IBOutlet weak var colorWellHighlighted: NSColorWell!
    @IBOutlet weak var textFieldHighlighted: NSTextField!
    @IBOutlet weak var colorWellBrightened: NSColorWell!
    @IBOutlet weak var textFieldBrightened: NSTextField!
    @IBOutlet weak var colorWellShadowed: NSColorWell!
    @IBOutlet weak var textFieldShadowed: NSTextField!
    @IBOutlet weak var colorWellHighlightColor: NSColorWell!
    @IBOutlet weak var textFieldHighlightColor: NSTextField!
    @IBOutlet weak var colorWellShadowColor: NSColorWell!
    @IBOutlet weak var textFieldShadowColor: NSTextField!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        buttonBlack_action(self)
        updateColors()
        listenToInterfaceChangesNotification()
    }
    
    func listenToInterfaceChangesNotification() {
        DistributedNotificationCenter.default.addObserver(
            self,
            selector: #selector(interfaceModeChanged),
            name: .init("AppleInterfaceThemeChangedNotification"),
            object: nil
        )
    }
    
    @objc func interfaceModeChanged() {
        updateColors()
    }
    
    @IBAction func buttonWhite_action(_ sender: Any) {
        colorWellOriginal.color = .init(red: 1, green: 1, blue: 1, alpha: 1)
        updateColors()
    }
    
    @IBAction func buttonBlack_action(_ sender: Any) {
        colorWellOriginal.color = .init(red: 0, green: 0, blue: 0, alpha: 1)
        updateColors()
    }
    
    @IBAction func buttonRed_action(_ sender: Any) {
        colorWellOriginal.color = .init(red: 1, green: 0, blue: 0, alpha: 1)
        updateColors()
    }
    
    @IBAction func colorWell_action(_ sender: Any) {
        updateColors()
    }
    
    func updateColors() {
        let level = 0.65
        
        let highlightColor = NSColor.highlightColor.usingColorSpace(.genericRGB)!
        let shadowColor = NSColor.shadowColor.usingColorSpace(.genericRGB)!
        
        let colorOriginal = colorWellOriginal.color
        let colorHiglighted = colorOriginal.highlight(withLevel: level)!
        let colorBrightened = colorOriginal.customHighlight(withLevel: level)!
        let colorShadowed = colorOriginal.shadow(withLevel: level)!
        
        textFieldOriginal.stringValue = colorOriginal.rgbString
        
        colorWellHighlighted.color = colorHiglighted
        textFieldHighlighted.stringValue = colorHiglighted.rgbString
        
        colorWellBrightened.color = colorBrightened
        textFieldBrightened.stringValue = colorBrightened.rgbString
        
        colorWellShadowed.color = colorShadowed
        textFieldShadowed.stringValue = colorShadowed.rgbString
        
        colorWellHighlightColor.color = highlightColor
        textFieldHighlightColor.stringValue = highlightColor.rgbString
        
        colorWellShadowColor.color = shadowColor
        textFieldShadowColor.stringValue = shadowColor.rgbString
    }
}

extension NSColor {
    var rgbString: String {
        "\(String(format: "%.2f", redComponent)) \(String(format: "%.2f", greenComponent)) \(String(format: "%.2f", blueComponent))"
    }
    
    func customHighlight(withLevel val: CGFloat) -> NSColor? {
        guard let rgbColor = self.usingColorSpace(.genericRGB) else {
            return nil
        }
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        rgbColor.getRed(&red,
                        green: &green,
                        blue: &blue,
                        alpha: &alpha)
        
        func normalizedVal(basedOn basis: CGFloat) -> CGFloat {
//            print("basis: \(basis)")
            
//            if basis > 0.9 {
//                return val * 0.1
//            } else if basis > 0.75 {
//                return val * 0.2
//            } else if basis > 0.5 {
//                return val * 0.3
//            } else if basis > 0.35 {
//                return val * 0.4
//            } else if basis > 0.25 {
//                return val * 0.3
//            }  else if basis > 0.15 {
//                return val * 0.2
//            } else if basis > 0.1 {
//                return val * 0.1
//            } else {
//                return val
//            }
            
            let newVal = 1.0 + val
            
//            print("newVal: \(newVal)")
            
            return newVal
        }
        
        let newVal = normalizedVal(basedOn: red + green + blue)
        
        let newColor = NSColor(red: min(red * newVal, 1.0),
                               green: min(green * newVal, 1.0),
                               blue: min(blue * newVal, 1.0),
                               alpha: alpha)
        
        return newColor
    }
    
//    func customHighlight(withLevel val: CGFloat) -> NSColor? {
//        var hue: CGFloat = 0
//        var saturation: CGFloat = 0
//        var brightness: CGFloat = 0
//        var alpha: CGFloat = 0
//        
//        getHue(&hue,
//               saturation: &saturation,
//               brightness: &brightness,
//               alpha: &alpha)
//        
//        print("Original Saturation: \(saturation)")
//        
//        let newSaturation = max(saturation * (-val), 1.0)
//        let newBrightness = max(brightness,  1.0)
//        
//        let newColor = NSColor(hue: hue,
//                               saturation: newSaturation,
//                               brightness: newBrightness,
//                               alpha: alpha)
//        
//        return newColor
//    }
}
