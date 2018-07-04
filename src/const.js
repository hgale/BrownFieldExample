import React from 'react';

import UpsellScreenOne from './screens/UpsellScreenOne';
import NotFoundScreen from './screens/NotFoundScreen';

import UpsellScreenOneConfig from './screens/UpsellScreenOne/config';

export const AppEvents = {
  DismissScreen: 'DismissScreen',
  ListScreens: 'ListScreens',
  EmitEvent: 'EmitEvent',
  PurchaseSubscription: 'PurchaseSubscription',
}

export const screens = {
  UpsellScreenOne: 'UpsellScreenOne',
  // These screens do not have a config file associated with them
  NotFoundScreen: 'NotFoundScreen',
  Query: 'Query'
}

// Add new screens addressable by Switchboard to this switch statement
export const getScreen = (props) => {
  console.log('getScreen hit with ', props);
  
  const { screen } = props;

  let selectedScreen = <NotFoundScreen {...props} />
  if (screen === screens.UpsellScreenOne) {
    selectedScreen = <UpsellScreenOne {...props} />
  }

  return (selectedScreen);
}

export const ScreenList = () => {
  var screenOne = Object.assign({}, { 'name': screens.UpsellScreenOne, }, UpsellScreenOneConfig());

  return {
    'screens' :
    [
      screenOne,
    ]
  }
  return
}

export const version = '0.0.1';
