/** @jsx React.DOM */

const React = require('react');
const Chart = require('chart.js');

const TwoWayPlot = React.createClass({
  componentDidMount() {
    const context = this.refs['two-way-plot-canvas']
      .getDOMNode()
      .getContext('2d');

    new Chart(context).Line({
      labels: ['first', 'second'],
      datasets: [
        {
          label: 'low',
          fillColor: 'transparent',
          strokeColor: 'red',
          data: [-5, 15]
        },
        {
          label: 'high',
          fillColor: 'transparent',
          strokeColor: 'blue',
          data: [10, 0]
        }
      ]
    });
  },

  render() {
    return(
      <div className="TwoWayPlot col-sm-6">
        <h4>Line Plot</h4>
        <canvas ref="two-way-plot-canvas" />
      </div>
    );
  }
});

module.exports = TwoWayPlot;
