import Cocoa

class CreateVolumeDialog: NSWindow {
    var nameField: NSTextField!
    var volumeField: NSTextField!
    var foldersField: NSTextField!
    var scanData: ScanData!
    var config: ProjectConfig!

    init(_ config: ProjectConfig, data: ScanData) {
        super.init(
            contentRect: config.windowFrames[1],
            styleMask: [.titled, .closable, .resizable],
            backing: .buffered,
            defer: false
        )
        title = "Create New Volume"
        scanData = data
        self.config = config

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
            title: "Volume ", target: self, action: #selector(volumeButtonPressed)
        )
        gridView.addRow(with: [volumeLabel, volumeField, volumeButton])

        // Tercera fila
        let foldersLabel = NSTextField(labelWithString: "Folders:")
        foldersLabel.alignment = .right
        foldersField = NSTextField()
        foldersField.stringValue = "*"
        let foldersButton = NSButton(
            title: "Folders", target: self, action: #selector(foldersButtonPressed)
        )
        gridView.addRow(with: [foldersLabel, foldersField, foldersButton])

        // Botones
        let okButton = NSButton(title: "OK", target: self, action: #selector(okButtonPressed))
        let cancelButton = NSButton(
            title: "Cancel", target: self, action: #selector(cancelButtonPressed)
        )
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
        contentView = containerView

        // Ajustar las restricciones
        NSLayoutConstraint.activate([
            gridView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            gridView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            gridView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            buttonStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
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
                    // TODO: retornar multiples folders
                    return result.lastPathComponent
                } else {
                    return result.path
                }
            }
        }
        return nil
    }

    func resetTextFields() {
        nameField.stringValue = ""
        volumeField.stringValue = ""
        foldersField.stringValue = "*"
        config.updateWindowFrame(n: 1, with: frame)
    }

    // Manejar la tecla Escape para cerrar el diálogo
    override func performKeyEquivalent(with event: NSEvent) -> Bool {
        if event.type == .keyDown, event.keyCode == 53 {
            cancelButtonPressed()
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
            let value = foldersField.stringValue
            if value == "*" {
                foldersField.stringValue = result + ", "
            } else {
                foldersField.stringValue = value + result + ", "
            }
        }
    }

    @objc func okButtonPressed() {
        let name = nameField.stringValue.trimSpaces()
        let volume = volumeField.stringValue.trimSpaces()
        let folders = foldersField.stringValue.trimSpaces()

        print("OK button name: \(name)")
        print("OK button volume: \(volume)")
        print("OK button folders: \(folders)")

        // Añade un nuevo volumen a scanData
        if !name.isEmpty && !volume.isEmpty {
            scanData.volumes.append(OneVolume(name, volume, folders))
            GlobalState.dataChanged = true
            if let mainWindow = GlobalState.mainWindow {
                mainWindow.title = "*" + mainWindow.title
            }
        } else {
            print("empty values: volume not created.")
        }

        resetTextFields()
        NSApp.stopModal()
        orderOut(nil)
    }

    @objc func cancelButtonPressed() {
        print("Cancel button pressed")

        resetTextFields()
        NSApp.stopModal()
        orderOut(nil)
    }
}
