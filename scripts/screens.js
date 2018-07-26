#!/usr/bin/env node
'use strict';

var fs = require('fs');
var path = require('path');

console.log('Attempting to build list of screens from src/screens');

try {
    const screenPath = path.join(__dirname, '..', 'src', 'screens');
    const iosPath = path.join(__dirname, '..', 'ios', 'BrownFieldExample', 'screens.json');
    fs.readdir(screenPath, function(err, items) {
        let screens = []
        let addProperties = (config, properties, lastFile) => {
            config['properties'] = JSON.parse(properties)
            screens.push(config)
            if (lastFile) {
                fs.writeFileSync(iosPath, JSON.stringify({'screens':screens}), 'utf8');
                console.log('New screens.json generated.');
                
            }
        }
        items = items.filter(item => item !== 'NotFoundScreen');
        if (items && items.length > 0) {
            items.forEach( (item, index) => {
                let config = {}
                config['name'] = item;
                const configPath = path.join(__dirname, '..', 'src', 'screens', item, 'config.json');
                fs.readFile(configPath, 'utf8', function (err, data) {
                    if (err) {
                      return console.log(err);
                    }
                    addProperties(config, data, index === (items.length-1));
                  });
            });
        }
    });
} catch(error) {
    console.log('Error reading screens directory ', error);
}