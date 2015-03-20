/** @jsx React.DOM */

const React = require('react');
const Router = require('react-router');
const { DefaultRoute, Link, Route, RouteHandler } = Router;
const Header = require('./components/Header');
const Project = require('./components/Project');

const PsiPlot = React.createClass({
  render() {
    return(
      <div className="PsiPlot container">
        <Header />
        <RouteHandler />
      </div>
    );
  }
});

const routes = (
  <Route name="psi-plot" path="/" handler={ PsiPlot }>
    <Route name="project" handler={ Project } />
  </Route>
);

Router.run(routes, Handler => {
  React.render(<Handler />, document.getElementById('content'));
});

window.React = React;
