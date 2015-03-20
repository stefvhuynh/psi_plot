/** @jsx React.DOM */

const React = require('react');
const PlotContainer = require('./PlotContainer');

const Project = React.createClass({
  getInitialState() {
    return { numberOfPlots: 1 };
  },

  render() {
    let plots = [];

    for (let i = 0; i < this.state.numberOfPlots; i++) {
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
