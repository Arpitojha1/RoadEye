# RoadEye — Smart Highway Infrastructure Visualizer

**RoadEye** is an offline-capable, field-friendly dashboard designed for **site engineers and NHAI project teams** to inspect and visualize road condition data gathered from **Network Survey Vehicles (NSVs)**.

It supports **structured Excel parsing**, **chainage-to-GPS mapping**, and a sleek **dashboard + map UI** — all optimized for low-connectivity environments.

---

## Current Features

  **Excel-to-JSON parsing support** (for NSV condition data)  
  **Dashboard view** with severity scores and segment metadata  
  **Interactive map view** with color-coded GPS markers  
  **Expandable tiles** to inspect roughness, rutting, cracking, and more  
  **Offline-first** support (assets, map tiles preloaded where possible)  
  **Simple UI** with responsive layout for mobile + tablet

---

## In Development

  Video player integration (for synced NSV footage)  
  Timestamp-based video jumping (based on distress segments)  
  Real-time GPS overlays and live inspection routes  
  Severity heatmaps and filtering  
  Structure support for culverts, VUPs, SVUPs (Excel-based)

> ⚠These are WIP and may not be fully functional in current prototype build.

---

## Tech Stack

- **Flutter** (UI + data visualization)
- `flutter_map` for OpenStreetMap rendering  
- `flutter_map_marker_popup` for interactive markers  
- `video_player` for native video playback (planned)  
- **Python** backend for Excel → JSON preprocessing (external)

---

## Folder Structure (lib/)
screens/
├── dashboard_screen.dart
├── map_screen.dart
├── video_player_screen.dart # WIP
widgets/
├── severity_tile.dart
services/
├── shared_data.dart
models/
├── distress_data.dart
utils/
├── severity_colors.dart

## Screenshots

Dashboard Screen :- 
![image](https://github.com/user-attachments/assets/36191aef-084d-4da4-a215-8d38480445f1)
Upload Screen :- 
![image](https://github.com/user-attachments/assets/60faac53-d2e1-4ed6-99a0-211e1dfc216c)
Map Screen :- 
![image](https://github.com/user-attachments/assets/a489e6cf-dd6c-4036-91ed-7224428fa53f)
Map Screen with interactive markers :- 
![image](https://github.com/user-attachments/assets/98d8f275-6e11-472f-be70-8ef44da4dc03)
Video Screen :-
![image](https://github.com/user-attachments/assets/e6d54179-0da2-4d41-b042-c722c4d63551)

---
## How to run remotely 



## Remote Monitoring (Online Support)

While RoadEye is currently an offline-first prototype, it is designed with a future-ready architecture for **real-time remote road inspection**. Here's how the online version will work:

### Field Inspector Workflow
- Uploads road condition data (`.json`) periodically from the site
- Optionally records and uploads synchronized video chunks
- Location and severity data are transmitted live using GPS + mobile network

### Remote Dashboard Workflow
- Authorized users (NHAI engineers, consultants) can:
  - View live road condition updates on the dashboard and map
  - Tap on map markers or dashboard tiles to inspect real-time metrics
  - Watch synced video footage uploaded from the field

### Cloud-Based Architecture (Planned)
| Component | Role |
|----------|------|
| **Flutter App** | Used by field inspector to record/upload data |
| **Firebase / FastAPI Backend** | Accepts JSON/video uploads & handles auth |
| **Realtime Database (e.g., Firestore)** | Stores distress data with timestamps |
| **Cloud Storage (e.g., Firebase Storage / AWS S3)** | Stores road videos in chunks |
| **Web/Mobile Dashboard** | Viewers access live map + dashboard interface remotely |

> ⚠️ This is part of future scope and will be implemented after core offline features are stable.


## Contributors

- [Siddhee Mhatre](https://github.com/Sid-bit-08) — 
- [Arpit Ojha](https://github.com/Arpitojha1) — 
- [Ishanya Tripathi](https://github.com/ishanyatripathi) — 

---

## License

MIT License — free to use, modify, and redistribute.

---

## Disclaimer

> This is a **hackathon prototype** and still evolving.  
> Not all listed features are production-ready (yet 😉).
