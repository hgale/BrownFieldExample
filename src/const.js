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
  EmitEvent: 'EmitEvent',
  PurchaseSubscription: 'PurchaseSubscription',
}

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
      !(props.screen in screens)) {
    return (<NotFoundScreen />);
  }

  const UpsellScreen = screens[props.screen].screen;
  return (<UpsellScreen {...props} />);
}

export const version = '0.0.1';
