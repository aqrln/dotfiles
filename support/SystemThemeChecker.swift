import AppKit

switch NSAppearance.current.name {
case .aqua, .vibrantLight:
    print("light")
case .darkAqua, .vibrantDark:
    print("dark")
default:
    print("unknown")
}
