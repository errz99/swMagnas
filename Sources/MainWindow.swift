import Cocoa

class DrawingView: NSView {
  override func draw(_ dirtyRect: NSRect) {
    super.draw(dirtyRect)

    // Pintar el fondo de color verde
    let color = NSColor.init(red: 0.98, green: 0.90, blue: 0.85, alpha: 1.0)
    color.setFill()
    bounds.fill()
  }
}

class MainWindow: NSWindow {
  init(frame: NSRect) {
    super.init(
      contentRect: frame,
      styleMask: [.titled, .closable, .resizable, .miniaturizable],
      backing: .buffered,
      defer: false
    )

    let sep: CGFloat = 8

    // Configurar título y propiedades de la ventana
    self.title = "untitled - swMagnas"

    // Crear el StackView horizontal (fila superior)
    let topStackView = NSStackView()
    topStackView.orientation = .horizontal
    topStackView.alignment = .centerY
    topStackView.spacing = sep
    topStackView.distribution = .fillEqually

    // Agregar elementos al StackView
    let topLeftTextField = NSTextField(labelWithString: "All - Dirs - Files")
    topLeftTextField.alignment = .left
    let searchField = NSSearchField()
    searchField.alignment = .center
    let topRightTextField = NSTextField(labelWithString: "Derecha")
    topRightTextField.alignment = .right

    // Configurar dimensiones por defecto del NSSearchField
    searchField.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      searchField.widthAnchor.constraint(
        equalToConstant: searchField.intrinsicContentSize.width + 220),
      searchField.heightAnchor.constraint(
        equalToConstant: searchField.intrinsicContentSize.height),
    ])

    topStackView.addView(topLeftTextField, in: .leading)
    topStackView.addView(searchField, in: .center)
    topStackView.addView(topRightTextField, in: .trailing)

    // Crear el StackView horizontal (fila inferior)
    let bottomStackView = NSStackView()
    bottomStackView.orientation = .horizontal
    bottomStackView.alignment = .centerY
    bottomStackView.spacing = sep
    bottomStackView.distribution = .fillEqually

    // Agregar elementos al StackView
    let bottomLeftTextField = NSTextField(labelWithString: "v0.0.1-20250518")
    bottomLeftTextField.alignment = .left
    let bottomCenterTextField = NSTextField(labelWithString: "0/0")
    bottomCenterTextField.alignment = .center
    let bottomRightTextField = NSTextField(labelWithString: "on:")
    bottomRightTextField.alignment = .right

    bottomStackView.addView(bottomLeftTextField, in: .leading)
    bottomStackView.addView(bottomCenterTextField, in: .center)
    bottomStackView.addView(bottomRightTextField, in: .trailing)

    // Crear vista de dibujo
    let drawingView = DrawingView()

    // Crear el StackView vertical
    let verticalStackView = NSStackView()
    verticalStackView.orientation = .vertical
    verticalStackView.translatesAutoresizingMaskIntoConstraints = false

    // Añadir el StackView al contentView
    verticalStackView.addView(topStackView, in: .top)
    verticalStackView.addView(drawingView, in: .center)
    verticalStackView.addView(bottomStackView, in: .bottom)

    // Añadir el StackView al contentView
    self.contentView?.addSubview(verticalStackView)

    // Configurar restricciones del StackView (top)
    topStackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      topStackView.leadingAnchor.constraint(
        equalTo: self.contentView!.leadingAnchor, constant: sep),
      topStackView.trailingAnchor.constraint(
        equalTo: self.contentView!.trailingAnchor, constant: -sep),
      topStackView.topAnchor.constraint(equalTo: self.contentView!.topAnchor, constant: sep),
    ])

    // Configurar restricciones del StackView (bottom)
    bottomStackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      bottomStackView.leadingAnchor.constraint(
        equalTo: self.contentView!.leadingAnchor, constant: sep),
      bottomStackView.trailingAnchor.constraint(
        equalTo: self.contentView!.trailingAnchor, constant: -sep),
      bottomStackView.bottomAnchor.constraint(
        equalTo: self.contentView!.bottomAnchor, constant: -sep),
    ])
  }
}
