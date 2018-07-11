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

export const screens = {
  UpsellScreenOne: 'UpsellScreenOne',
  UpsellScreenTwo: 'UpsellScreenTwo',  
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
  if (screen === screens.UpsellScreenTwo) {
    selectedScreen = <UpsellScreenTwo {...props} />
  } 

  return (selectedScreen);
}

export const ScreenList = () => {
  var screenOne = Object.assign({}, { 'name': screens.UpsellScreenOne, }, UpsellScreenOneConfig());
  // var screenTwo = Object.assign({}, { 'name': screens.UpsellScreenTwo, }, UpsellScreenTwoConfig());

  return {
    'screens' :
    [
      screenOne,
      // screenTwo,
    ]
  }
  return
}

export const version = '0.0.1';
