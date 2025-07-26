import AppKit

let appearanceName: NSAppearance.Name = NSAppearance.currentDrawing().name

switch appearanceName {
case .aqua, .vibrantLight, .accessibilityHighContrastAqua, .accessibilityHighContrastVibrantLight:
    print("light")
case .darkAqua, .vibrantDark, .accessibilityHighContrastDarkAqua,
    .accessibilityHighContrastVibrantDark:
    print("dark")
default:
    fatalError("unknown NSAppearance.Name variant \(appearanceName)")
}
