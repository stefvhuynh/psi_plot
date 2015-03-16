/** @jsx React.DOM */

var React = require('react');
var PlotContainer = require('./PlotContainer');

var Project = React.createClass({
  getInitialState() {
    return { numberOfPlots: 1 };
  },

  render() {
    var plots = [];

    for (var i = 0; i < this.state.numberOfPlots; i++) {
      plots.push(<PlotContainer />);
    }

    return(
      <div className="Project">
        Project page
        { plots }

        <button className="add-plot-btn" onClick={ this._addPlot }>
          Add plot
        </button>
      </div>
    );
  },

  // Private

  _addPlot(event) {
    event.preventDefault();
    this.setState({ numberOfPlots: this.state.numberOfPlots + 1 });
  }
});

module.exports = Project;
