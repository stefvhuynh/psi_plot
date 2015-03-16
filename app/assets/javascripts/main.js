/** @jsx React.DOM */

var React = require('react');
var Router = require('react-router');
var { DefaultRoute, Link, Route, RouteHandler } = Router;
var Header = require('./components/Header');
var Project = require('./components/Project');

var PsiPlot = React.createClass({
  render() {
    return(
      <div className="PsiPlot container">
        <Header />
        <RouteHandler />
      </div>
    );
  }
});

var routes = (
  <Route name="psi-plot" path="/" handler={ PsiPlot }>
    <Route name="project" handler={ Project } />
  </Route>
);

Router.run(routes, Handler => {
  React.render(<Handler />, document.getElementById('content'));
});

window.React = React;
