/** @jsx React.DOM */

const React = require('react');
const TwoWayPlotForm = require('./TwoWayPlotForm');
const TwoWayPlot = require('./TwoWayPlot');

const PlotContainer = React.createClass({
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
