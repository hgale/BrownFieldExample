import PropTypes from 'prop-types';
import React from 'react';

import EventBridge from 'react-native-event-bridge';

import { getScreen, AppEvents } from './src/const';

import { AppRegistry } from 'react-native';

console.disableYellowBox = true

class EntryPoint extends React.Component {

  static contextTypes = {
    rootTag: PropTypes.number,
  };

  componentDidMount() {
    // Listen for events sent from the native side of the React Native Bridge
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
    const screen = getScreen(this.props)
    return (screen);
  }
}

// Module name
AppRegistry.registerComponent('BrownFieldExample', () => EntryPoint);