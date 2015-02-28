/** @jsx React.DOM */

var React = require('react');
var TwoWayPlot = require('./TwoWayPlot');

var Project = React.createClass({
  render() {
    return(
      <div className="Project">
        Project page
        <TwoWayPlot />
      </div>
    );
  }
});

module.exports = Project;
