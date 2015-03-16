/** @jsx React.DOM */

var React = require('react');
var TwoWayPlotForm = require('./TwoWayPlotForm');
var TwoWayPlot = require('./TwoWayPlot');

var PlotContainer = React.createClass({
  render() {
    return(
      <div className="PlotContainer row">
        <TwoWayPlotForm />
        <TwoWayPlot />
      </div>
    );
  }
});

module.exports = PlotContainer;
