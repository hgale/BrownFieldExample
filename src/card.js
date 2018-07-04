'use strict';

import React from 'react';
import { Dimensions, View, StyleSheet } from 'react-native';

import colors from './colors';

// TODO make this a pure component
class Card extends React.Component {
  render() {
    return (
      <View style={[styles.container, this.props.style]}>
        {this.props.children}
      </View>
    );
  }
}

const width = Dimensions.get('window').width;
const height = Dimensions.get('window').height;

const styles = StyleSheet.create({
    container: {
      backgroundColor: colors.cardColor,
      width: (width * 0.8),
      height: (height * 0.75), 
      marginLeft: 40,
      marginRight: 40,
      borderRadius: 2,
      borderColor: '#ddd',
      borderBottomWidth: 0,
      shadowColor: '#000',
      shadowOffset: { width: 0, height: 2 },
      shadowOpacity: 0.8,
      shadowRadius: 2,
      elevation: 1,
    },
  });

export default Card;
