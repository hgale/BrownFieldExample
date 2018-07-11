'use strict';

import PropTypes from 'prop-types';
import React from 'react';
import { Dimensions, View, StyleSheet } from 'react-native';

import colors from './colors';

class Curve extends React.Component {
  render() {
    return (
      <View style={styles.container}>
        {this.props.children}
      </View>
    );
  }
}

const width = (Dimensions.get('window').width * 1.2);

const height = Dimensions.get('window').height;
const styles = StyleSheet.create({
    container: {
        position: 'absolute',
        top:(height-280),
        width: width,
        height: 280,
        borderBottomRightRadius:0,
        borderBottomLeftRadius:0,
        borderRadius: width/2.0,
        backgroundColor: colors.darkBlue,
        alignItems: 'center',
        justifyContent: 'flex-end'
      },
  });

  Counter.propTypes = {
    incrementCounter: PropTypes.func.isRequired,
    count: PropTypes.number.isRequired,
  };
  
export default Curve
