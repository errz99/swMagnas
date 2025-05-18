import Cocoa

class MainWindow: NSWindow {
  init(frame: NSRect) {
    // Configuración de la ventana
    super.init(
      contentRect: frame,
      styleMask: [.titled, .closable, .resizable, .miniaturizable],
      backing: .buffered,
      defer: false
    )

    self.title = "Mi Proyecto macOS"

    // Crear el botón
    let button = NSButton(title: "Haz clic aquí", target: self, action: #selector(buttonClicked))
    button.translatesAutoresizingMaskIntoConstraints = false  // Habilitar Auto Layout
    self.contentView?.addSubview(button)

    // Configurar restricciones para mantener el botón centrado
    NSLayoutConstraint.activate([
      button.centerXAnchor.constraint(equalTo: self.contentView!.centerXAnchor),
      button.centerYAnchor.constraint(equalTo: self.contentView!.centerYAnchor),
    ])
  }

  @objc func buttonClicked() {
    print("¡Botón presionado!")
  }
}
