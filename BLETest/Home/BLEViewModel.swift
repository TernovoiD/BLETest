import CoreBluetooth

final class BLEViewModel: NSObject, ObservableObject {
    private var centralManager: CBCentralManager?
    @Published private var devices = Set<Device>()
    @Published var scanning: Bool = false
    
    @Published var processingDevice: Device?
    @Published var connectedDevice: Device?
    
    private var reconnectAttempts: Int = 0
    private let maxReconnectAttempts = 3
    private var targetDevice: Device?
    
    var devicesToShow: [Device] { Array(devices) }
    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .main)
    }
    
    func scanDevices() {
        guard let centralManager else { return }
        scanning = true
        devices = Set<Device>()
        centralManager.scanForPeripherals(withServices: nil, options: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            centralManager.stopScan()
            self.scanning = false
        }
    }
    
    func connect(to device: Device) {
        guard let centralManager else { return }
        targetDevice = device
        if let connectedDevice { disconnect(from: connectedDevice) }
        processingDevice = device
        centralManager.connect(device.peripheral, options: nil)
    }
    
    func disconnect(from device: Device) {
        guard let centralManager else { return }
        targetDevice = nil
        centralManager.cancelPeripheralConnection(device.peripheral)
    }
    
    private func attemptReconnection() {
        guard let centralManager,
                let targetDevice,
                reconnectAttempts < maxReconnectAttempts else { return }
        reconnectAttempts += 1
        centralManager.connect(targetDevice.peripheral, options: nil)
    }
}

extension BLEViewModel: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn { attemptReconnection() }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if peripheral.name == nil { return }
        let discoveredDevice = Device(peripheral: peripheral)
        devices.insert(discoveredDevice)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        processingDevice = nil
        let newConnection = Device(peripheral: peripheral)
        connectedDevice = newConnection
        reconnectAttempts = 0
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: (any Error)?) {
        if let error { print(error.localizedDescription) }
        connectedDevice = nil
        attemptReconnection()
    }
}
