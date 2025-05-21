import Cocoa

class CreateVolumeDialog: NSWindow {
  var nameField: NSTextField!
  var volumeField: NSTextField!
  var foldersField: NSTextField!

  init(parentWindow: NSWindow) {
    super.init(
      contentRect: NSRect(x: 0, y: 0, width: 400, height: 0),
      styleMask: [.titled, .closable, .resizable],
      backing: .buffered,
      defer: false
    )
    self.title = "Create Volume"

    // Centrar el diálogo en la ventana principal
    if let parentFrame = parentWindow.screen?.visibleFrame {
      let x = parentFrame.origin.x + (parentFrame.width - self.frame.width) / 2
      let y = parentFrame.origin.y + (parentFrame.height - self.frame.height) / 2
      self.setFrameOrigin(NSPoint(x: x, y: y))
    }

    // Crear un grid view para las etiquetas y campos de texto
    let gridView = NSGridView()
    gridView.translatesAutoresizingMaskIntoConstraints = false
    gridView.rowSpacing = 10
    gridView.columnSpacing = 10

    // Primera fila
    let nameLabel = NSTextField(labelWithString: "Name:")
    nameLabel.alignment = .right
    nameField = NSTextField()
    gridView.addRow(with: [nameLabel, nameField])

    // Segunda fila
    let volumeLabel = NSTextField(labelWithString: "Volume:")
    volumeLabel.alignment = .right
    volumeField = NSTextField()
    let volumeButton = NSButton(
      title: "Volume ", target: self, action: #selector(volumeButtonPressed))
    gridView.addRow(with: [volumeLabel, volumeField, volumeButton])

    // Tercera fila
    let foldersLabel = NSTextField(labelWithString: "Folders:")
    foldersLabel.alignment = .right
    foldersField = NSTextField()
    let foldersButton = NSButton(
      title: "Folders", target: self, action: #selector(foldersButtonPressed))
    gridView.addRow(with: [foldersLabel, foldersField, foldersButton])

    // Botones
    let okButton = NSButton(title: "OK", target: self, action: #selector(okButtonPressed))
    let cancelButton = NSButton(
      title: "Cancel", target: self, action: #selector(cancelButtonPressed))
    let buttonStack = NSStackView(views: [okButton, cancelButton])
    buttonStack.orientation = .horizontal
    buttonStack.spacing = 10
    buttonStack.alignment = .centerY
    buttonStack.distribution = .equalSpacing

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

  func chooseDirectory(multi: Bool) -> String? {
    let dialog = NSOpenPanel()
    dialog.title = "Choose a Volume"
    dialog.showsResizeIndicator = true
    dialog.showsHiddenFiles = false
    dialog.canChooseFiles = false
    dialog.canChooseDirectories = true
    if multi {
      dialog.allowsMultipleSelection = true
    }

    if dialog.runModal() == .OK {
      if let result = dialog.url {
        if multi {
          return result.lastPathComponent
        } else {
          return result.path
        }
      }
    }
    return nil
  }

  func cleanTextFields() {
    nameField.stringValue = ""
    volumeField.stringValue = ""
    foldersField.stringValue = ""
  }

  // Manejar la tecla Escape para cerrar el diálogo
  override func performKeyEquivalent(with event: NSEvent) -> Bool {
    if event.type == .keyDown && event.keyCode == 53 {
      self.cancelButtonPressed()
      return true
    }
    return super.performKeyEquivalent(with: event)
  }

  @objc func volumeButtonPressed() {
    if let result = chooseDirectory(multi: false) {
      volumeField.stringValue = result
    }
  }

  @objc func foldersButtonPressed() {
    if let result = chooseDirectory(multi: true) {
      let value = foldersField.stringValue + result + ", "
      foldersField.stringValue = value
    }
  }

  @objc func okButtonPressed() {
    let name = nameField.stringValue
    let volume = volumeField.stringValue
    let folders = foldersField.stringValue

    print("OK button name: \(name)")
    print("OK button volume: \(volume)")
    print("OK button folders: \(folders)")

    cleanTextFields()
    NSApp.stopModal()
    self.orderOut(nil)
  }

  @objc func cancelButtonPressed() {
    print("Cancel button pressed")

    cleanTextFields()
    NSApp.stopModal()
    self.orderOut(nil)
  }
}
