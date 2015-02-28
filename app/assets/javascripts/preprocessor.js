/*
 * This file preprocesses all the jsx syntax for jest tests
 */

var ReactTools = require('react-tools');

module.exports = {
  process: function(src, path) {
    if (path.match(/\.js$/)) {
      return ReactTools.transform(src);
    }
  }
};
