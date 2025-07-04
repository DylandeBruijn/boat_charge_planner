# Boat Charge Planner

A Flutter mobile application for planning boat charging based on the Carbon Intensity API.

## Project Overview

This app helps users plan when to charge their boats by displaying:

- An interactive map focused on the UK
- Carbon intensity data for today
- Predicted carbon intensity for optimal charging times

## Implementation Steps

### Phase 1: Project Setup & Dependencies

1. **Add required dependencies to `pubspec.yaml`:**

   - `google_maps_flutter` - for displaying the map
   - `http` - for API calls to get carbon intensity data

2. **Configure platform-specific settings:**
   - Android: Add Google Maps API key to `android/app/src/main/AndroidManifest.xml`
   - iOS: Add location permissions to `ios/Runner/Info.plist`

### Phase 2: Core Map Implementation

3. **Create the main map screen:**

   - Replace the default counter app with a map-focused interface
   - Set initial camera position to UK (approximately 54.0, -2.0)
   - Implement pan and zoom functionality

4. **Add map interaction handling:**
   - Implement long press detection on the map
   - Add pin placement functionality when user long presses

### Phase 3: Carbon Intensity Data Integration

5. **Research and integrate Carbon Intensity API:**

   - Create data models for carbon intensity information
   - Implement API service class for fetching data

6. **Create carbon intensity display:**
   - Design an element that shows current carbon intensity
   - Display the intensity value with appropriate units (gCO2/kWh)

### Phase 4: UI/UX Polish

7. **Enhance the user interface:**

   - Add proper app title and branding
   - Implement loading states for API calls
   - Add error handling for failed API requests

8. **Potential additional features:**
    - Implement pin management (remove pins, list all pins)
    - Add search functionality for specific UK locations
    - Include a legend or help section explaining carbon intensity values
    - Style the map pins and information displays
    - Turn data fetching into Stream to get data in the background
    - Add caching (LocalStorage) of pins
    - Fix scrolling issues on web
    - Add offline functionality
    - Cluster pins when they overlap

### Phase 6: Testing & Debugging

9. **Test the application:**

    - Test on both Android and iOS simulators
    - Verify map interactions work correctly
    - Test API integration and error handling

10. **Prepare for demo:**
    - Practice using VS Code debugger and toolchain
