import Cocoa

class CreateVolumeDialog: NSWindow {
  init() {
    super.init(
      contentRect: NSRect(x: 0, y: 0, width: 400, height: 200),
      styleMask: [.titled, .closable, .resizable],
      backing: .buffered,
      defer: false
    )
    self.title = "Create Volume"
    self.center()

    // Crear un grid view para las etiquetas y campos de texto
    let gridView = NSGridView()
    gridView.translatesAutoresizingMaskIntoConstraints = false
    gridView.rowSpacing = 10
    gridView.columnSpacing = 10

    // Primera fila
    let label1 = NSTextField(labelWithString: "Field 1:")
    label1.alignment = .right
    let textField1 = NSTextField()
    gridView.addRow(with: [label1, textField1])

    // Segunda fila
    let label2 = NSTextField(labelWithString: "Field 2:")
    label2.alignment = .right
    let textField2 = NSTextField()
    gridView.addRow(with: [label2, textField2])

    // Tercera fila
    let label3 = NSTextField(labelWithString: "Field 3:")
    label3.alignment = .right
    let textField3 = NSTextField()
    gridView.addRow(with: [label3, textField3])

    // Botones
    let okButton = NSButton(title: "OK", target: self, action: #selector(okButtonPressed))
    let cancelButton = NSButton(
      title: "Cancel", target: self, action: #selector(cancelButtonPressed))
    let buttonStack = NSStackView(views: [okButton, cancelButton])
    buttonStack.orientation = .horizontal
    buttonStack.spacing = 10
    buttonStack.alignment = .centerX

    // Contenedor principal
    let containerView = NSStackView(views: [gridView, buttonStack])
    containerView.orientation = .vertical
    containerView.spacing = 20
    containerView.alignment = .centerX
    containerView.translatesAutoresizingMaskIntoConstraints = false

    // Añadir el contenedor a la ventana
    self.contentView = containerView

    // Ajustar las restricciones
    NSLayoutConstraint.activate([
      gridView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
      gridView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
      containerView.leadingAnchor.constraint(
        equalTo: self.contentView!.leadingAnchor, constant: 20),
      containerView.trailingAnchor.constraint(
        equalTo: self.contentView!.trailingAnchor, constant: -20),
      containerView.topAnchor.constraint(equalTo: self.contentView!.topAnchor, constant: 20),
      containerView.bottomAnchor.constraint(equalTo: self.contentView!.bottomAnchor, constant: -20),
    ])
  }

  @objc func okButtonPressed() {
    print("OK button pressed")
    NSApp.stopModal()
  }

  @objc func cancelButtonPressed() {
    print("Cancel button pressed")
    NSApp.stopModal()
  }
}
