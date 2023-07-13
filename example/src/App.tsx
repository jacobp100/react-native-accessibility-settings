import * as React from 'react';

import { StyleSheet, View, Text } from 'react-native';
import { useAccessibilitySettings } from 'react-native-accessibility-settings';

export default function App() {
  const accessibilitySettings = useAccessibilitySettings();

  return (
    <View style={styles.container}>
      {Object.entries(accessibilitySettings)
        .sort((a, b) => a[0].localeCompare(b[0]))
        .map(([key, value]) => (
          <Text key={key}>
            {key}: {value ? '✅' : '❌'}
          </Text>
        ))}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    alignItems: 'flex-start',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
