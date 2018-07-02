RN_DIR=./

react-native-developer-mode:
	cd '$(RN_DIR)/node_modules/react-native'; npm run start — — root $(RN_DIR)

react-native-bundle: 
	cd $(RN_DIR); react-native bundle --dev false --platform ios --entry-file index.js --bundle-output ./ios/BrownFieldExample/main.jsbundle --assets-dest ./	