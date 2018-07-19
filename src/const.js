import React from 'react';

import UpsellScreenOne from './screens/UpsellScreenOne';
import UpsellScreenTwo from './screens/UpsellScreenTwo';
import UpsellScreenSales from './screens/UpsellScreenSales';
import NotFoundScreen from './screens/NotFoundScreen';

import UpsellScreenOneConfig from './screens/UpsellScreenOne/config';
import UpsellScreenTwoConfig from './screens/UpsellScreenTwo/config';
import UpsellScreenSalesConfig from './screens/UpsellScreenSales/config';

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
  UpsellScreenSales: 'UpsellScreenSales',  
  // These screens do not have a config file associated with them
  NotFoundScreen: 'NotFoundScreen',
  Query: 'Query'
}

// Add new screens addressable by experiments framework to this switch statement
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

  if (screen === screens.UpsellScreenSales) {
    selectedScreen = <UpsellScreenSales {...props} />
  }  

  return (selectedScreen);
}

export const ScreenList = () => {
  var screenOne = Object.assign({}, { 'name': screens.UpsellScreenOne, }, UpsellScreenOneConfig());
  var screenTwo = Object.assign({}, { 'name': screens.UpsellScreenTwo, }, UpsellScreenTwoConfig());
  var screenThree = Object.assign({}, { 'name': screens.UpsellScreenSales, }, UpsellScreenSalesConfig());
  return {
    'screens' :
    [
      screenOne,
      screenTwo,
      screenThree,
    ]
  }
  return
}

export const version = '0.0.1';
