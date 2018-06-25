import PropTypes from 'prop-types';
import React from 'react';

import EventBridge, {
  // enhanceForEventsSupport,
  // enhanceForEventsSupportDecorator,
  enhanceForEventsSupportEnhanced,
} from 'react-native-event-bridge';


import { AppRegistry, StyleSheet, Text, View, TouchableOpacity } from 'react-native';

class BrownFieldExample extends React.Component {

  static contextTypes = {
    rootTag: PropTypes.number,
  };

  dismissScreen = () => {
    EventBridge.emitEvent(this, 'DismissScreen');    
  }

  // Add and remove as event listener
  componentDidMount() {
    console.log("componentDidMount hit");
    this._eventSubscription = EventBridge.addEventListener(
      this,
      (name, info) => {
        console.log(
          `Received event from native event: '${name}' with info: ${JSON.stringify(
            info
          )}`
        );
      }
    );

  }
  componentWillUnmount() {
    if (this._eventSubscription) {
      this._eventSubscription.remove();
    }
  }
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.highScoresTitle}>Hello React Native!</Text>
        <TouchableOpacity onPress={this.dismissScreen}>
          <Text style={styles.text}>Tap to dismiss </Text>
        </TouchableOpacity>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#FFFFFF',
  },
  text: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },  
  highScoresTitle: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  scores: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

// Module name
AppRegistry.registerComponent('BrownFieldExample', () => BrownFieldExample);