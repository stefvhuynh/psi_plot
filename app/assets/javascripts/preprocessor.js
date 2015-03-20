/*
 * This file preprocesses all the jsx syntax for jest tests
 */

const ReactTools = require('react-tools');

module.exports = {
  process(src, path) {
    if (path.match(/\.js$/)) {
      return ReactTools.transform(src);
    }
  }
};
