#!/usr/bin/env node
'use strict';

var fs = require('fs');
var path = require('path');

try {
    const screenPath = path.join(__dirname, '..', 'src', 'screens');
    const iosPath = path.join(__dirname, '..', 'ios', 'BrownFieldExample', 'screens.json');
    fs.readdir(screenPath, function(err, items) {
        let screens = {}
        //'screens' : screenConfigs
        let addProperties = (item, properties, lastFile) => {
            screens[item]['properties'] = properties
            if (lastFile) {
                console.log('Screens config file is', screens);
                fs.writeFileSync(iosPath, JSON.stringify(screens), 'utf8');
            }
        }
        items = items.filter(item => item !== 'NotFoundScreen');
        if (items && items.length > 0) {
            items.forEach( (item, index) => {
                console.log('Index is ', index)
                console.log(item);
                screens[item] = {};
                screens[item]['name'] = item;
                const configPath = path.join(__dirname, '..', 'src', 'screens', item, 'config.json');
                fs.readFile(configPath, 'utf8', function (err, data) {
                    if (err) {
                      return console.log(err);
                    }
                    console.log('Adding data', data);
                    console.log('length is ', items.length);
                    addProperties(item, data, index === (items.length-1));
                  });
            });
        }
    });
} catch(error) {
    console.log('Error reading screens directory ', error);
}