import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = BLEViewModel()
    
    var body: some View {
        NavigationView {
            devicesList
            .navigationTitle("BLE Project")
            .toolbar { scanToolbarItem }
            .overlay { if viewModel.scanning { scanningIndicator } }
        }
    }
    
    private func connect(_ device: Device) {
        withAnimation { viewModel.connect(to: device) }
    }
    
    private func scanDevices() {
        withAnimation { viewModel.scanDevices() }
    }
}

#Preview {
    HomeView()
        .environmentObject(BLEViewModel())
}

private extension HomeView {
    var scanToolbarItem: some ToolbarContent {
        ToolbarItem {
            Button("Scan", action: scanDevices)
                .font(.headline)

        }
    }
    
    var scanningIndicator: some View {
        ProgressView()
            .frame(maxWidth: 100, maxHeight: 100)
            .scaleEffect(2)
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 25))
    }
    
    func row(for device: Device) -> some View {
        HStack {
            Image(systemName: device == viewModel.connectedDevice ? "checkmark" : "personalhotspot.circle.fill")
                .foregroundStyle(device == viewModel.connectedDevice ? .blue : .gray)
            Text(device.name)
            Spacer()
            if device == viewModel.processingDevice {
                ProgressView()
            }
        }
        .font(.title3)
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .onTapGesture { connect(device) }
    }
    
    @ViewBuilder
    var devicesList: some View {
        if viewModel.devicesToShow.isEmpty {
            Text("Press scan to search bluetooth devices...")
        } else {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
                    ForEach(viewModel.devicesToShow) { device in
                        row(for: device)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
