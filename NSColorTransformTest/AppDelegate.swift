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
        blended(withFraction: val,
                of: .white)
    }
}
