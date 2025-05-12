import CoreBluetooth

struct Device: Identifiable, Hashable {
    let id: UUID
    let name: String
    let peripheral: CBPeripheral
    
    init(peripheral: CBPeripheral) {
        self.id = peripheral.identifier
        self.name = peripheral.name ?? "Unknown device"
        self.peripheral = peripheral
    }
}
