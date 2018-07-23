import React from 'react';

import UpsellScreenOne from './screens/UpsellScreenOne';
import UpsellScreenTwo from './screens/UpsellScreenTwo';
import NotFoundScreen from './screens/NotFoundScreen';

import UpsellScreenOneConfig from './screens/UpsellScreenOne/config';
import UpsellScreenTwoConfig from './screens/UpsellScreenTwo/config';

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
  UpsellScreenOne: UpsellScreenOne,
  UpsellScreenTwo: UpsellScreenTwo
};

/**
 * get screen
 * @param {Object} props - contains name of screen to instantiate and default props
 * to use when doing it
 */
export const getScreen = (props) => {
  if (!(props instanceof Object) || 
      !('screen' in props) ||
      (props.screen == QueryScreen) ||
      !(props.screen in screens)) {
    console.log('Screen not found');
    return (<NotFoundScreen />);
  }

  const UpsellScreen = screens[props.screen];
  return (<UpsellScreen {...props} />);
}

export const ScreenList = () => {
  // Figure out how to dynamically generate this
  var screenOne = Object.assign({}, { 'name': 'UpsellScreenOne', }, UpsellScreenOneConfig());
  var screenTwo = Object.assign({}, { 'name': 'UpsellScreenTwo', }, UpsellScreenTwoConfig());

  return {
    'screens' :
    [
      screenOne,
      screenTwo,
    ]
  }
  return
}

export const version = '0.0.1';
