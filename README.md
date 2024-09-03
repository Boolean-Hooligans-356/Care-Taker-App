
# The Care Taker App

## Overview

The Care Taker Mobile App is designed to improve patient management and health monitoring through a suite of useful features. 
It includes:

- **SOS Feature**: Enables users to send an emergency alert with their location to selected contacts.
- **Medication Reminder**: Helps users set and manage medication reminders to ensure timely doses.
- **Medical Assistant AI**: Provides users with accurate and reliable information about medications and medical conditions.

## Features

### 1. SOS Feature

The SOS feature allows users to quickly send an alert in emergency situations. Key functionalities include:

- **Emergency Contacts**: Users can add emergency contacts and manage settings for calls and SMS.
- **Location Tracking**: Uses GPS to include location coordinates in the alert message.
- **Distress Signal**: Activates when the phone is shaken, sending an SMS and optionally calling the first contact on the list.

**Libraries Used**: `geolocator`, `sensors_plus`, `permission_handler`

**Main Components**: `SOSPage` widget

### 2. Medication Reminder

The Medication Reminder feature assists users in managing their medication schedules. Key functionalities include:

- **Reminder Scheduling**: Users can enter medication details and set reminders for specific times and dates.
- **Notification Handling**: Sends notifications to remind users to take their medication.
- **Reminder Management**: Allows users to add or remove reminders and view a list of scheduled reminders.

**Libraries Used**: `flutter_local_notifications`

**Main Components**: `MedicationReminder` class, `MedicPage` class

### 3. AI Assistant

The AI Assistant module provides users with information about medications and medical conditions. Key functionalities include:

- **Chat Interface**: Users interact with a chatbot to request information.
- **Text Generation API**: Uses NLP to generate responses based on user queries.
- **Knowledge Database**: Queries a database of medical knowledge for accurate information.

**Main Components**: Chat screen interface, text generation API integration

## Working Principle

1. **SOS Feature**:
   - Users can activate the SOS feature by shaking the phone.
   - An alert message containing location coordinates is sent to selected contacts.
   - Optionally, the app can make a call to the first contact.

2. **Medication Reminder**:
   - Users input medication details and set reminders.
   - Notifications are sent to remind users to take their medication.
   - Users can manage reminders by adding or removing them.

3. **AI Assistant**:
   - Users enter keywords or search terms related to medications.
   - The app queries the medical knowledge database and returns relevant information.
   - Responses are displayed on the chat screen for user interaction.

## Installation

To get started with the Care Taker App, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/Boolean-Hooligans-356/Care-Taker-App.git
   ```
2. Navigate to the project directory:
   ```bash
   cd Care-Taker-App
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Contributing

Contributions are welcome! If you have suggestions or improvements, please fork the repository and submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.




