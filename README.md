# Usage Instructions

1. Build & Run
* Clone the repository.
* Open the Xcode project.
* Ensure Background Modes is enabled with "Uses Bluetooth LE accessories" checked (Signing & Capabilities -> Background Modes -> Uses Bluetooth LE accessories).
* Run the app on a real device (BLE is not available on the Simulator).
  
2. Permissions
* The app will prompt for Bluetooth permissions automatically if not granted.
* If permissions are denied, the app cannot request them again; they must be enabled manually via the device settings. (This is an iOS restriction.)
* The app will remind the user to turn on Bluetooth if it is off.
  
3. Scanning Devices
* Bluetooth must be enabled in the device settings. For privacy reasons, Apple restricts apps from turning Bluetooth on or off themselves, as this could compromise user location privacy.
* Tap the Scan button to discover nearby devices.
* Discovered devices will appear in the list.
  
4. Connecting Devices
* Tap a device in the list to connect.
* The device will connect using BLE technology.
* The app will maintain the connection in the background and attempt to reconnect automatically if disconnected.
* When Bluetooth is turned on and the app is in the background, it will attempt to reconnect to the last used device.

# Video
https://streamable.com/8q26rf

# Screenshots
![IMG_7686](https://github.com/user-attachments/assets/1a7e0cbc-26df-4cbf-beae-e06e247211d1)
![IMG_7687](https://github.com/user-attachments/assets/f34dba65-4a5c-4818-ad64-f86223f1339d)
![IMG_7688](https://github.com/user-attachments/assets/faa14417-33f9-4dcc-9c2e-18df438248b1)
![IMG_7689](https://github.com/user-attachments/assets/9ac45d8d-f3d9-48ca-ab28-9249dc2d7eca)
![IMG_7690](https://github.com/user-attachments/assets/8ef687c8-b502-4fb4-95a0-3dd378950cea)
![IMG_7691](https://github.com/user-attachments/assets/0b047118-2d9b-40db-a022-6d0c2b98a2e5)
