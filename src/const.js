import React from 'react';

import UpsellScreenOne from './screens/UpsellScreenOne';
import UpsellScreenTwo from './screens/UpsellScreenTwo';
import NotFoundScreen from './screens/NotFoundScreen';

var UpsellScreenOneConfig = require('./screens/UpsellScreenOne/config.json');
var UpsellScreenTwoConfig = require('./screens/UpsellScreenTwo/config.json');

// All native events supported by this bundle
export const AppEvents = {
  DismissScreen: 'DismissScreen',
  PurchaseItem: 'PurchaseItem',
  ListScreens: 'ListScreens',
  EmitEvent: 'EmitEvent',
  PurchaseSubscription: 'PurchaseSubscription',
}

// This is only used when querying for screens, it has no UI component
const QueryScreen = 'Query'

// List of all screens that can be displayed 
screens = {
  UpsellScreenOne: {
    screen: UpsellScreenOne,
    config: UpsellScreenOneConfig
  },
  UpsellScreenTwo: {
    screen: UpsellScreenTwo,
    config: UpsellScreenTwoConfig
  },
};

/**
 * get screen
 * @param {Object} props - contains name of screen to instantiate and default props to use.
 */
export const getScreen = (props) => {
  if (!(props instanceof Object) || 
      !('screen' in props) ||
      (props.screen == QueryScreen) ||
      !(props.screen in screens)) {
    return (<NotFoundScreen />);
  }

  const UpsellScreen = screens[props.screen].screen;
  return (<UpsellScreen {...props} />);
}

export const ScreenList = () => {
  let screenConfigs = []
  for (var key in screens) {
    var screen = Object.assign({}, { 'name': key, }, screens[key].config);
    screenConfigs.push(screen);
  }
  return {
    'screens' : screenConfigs
  }
}

export const version = '0.0.1';
