import AppKit

switch NSAppearance.currentDrawing().name {
case .aqua, .vibrantLight:
    print("light")
case .darkAqua, .vibrantDark:
    print("dark")
default:
    print("unknown")
}
