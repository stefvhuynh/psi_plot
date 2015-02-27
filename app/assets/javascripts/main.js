/** @jsx React.DOM */

var React = require('react');
var Router = require('react-router');
var { DefaultRoute, Link, Route, RouteHandler } = Router;

var PsiPlot = React.createClass({
  render() {
    return(
      <div className="PsiPlot container">
        <nav className="navbar navbar-default navbar-fixed-top">
          <div className="container-fluid">
            <div className="navbar-header">
              <button type="button" className="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#navbar-collapse">
                <span className="icon-bar" />
                <span className="icon-bar" />
                <span className="icon-bar" />
              </button>
              <Link to="psi-plot" className="navbar-brand">PsiPlot</Link>
            </div>

            <div className="collapse navbar-collapse" id="navbar-collapse">
              <ul className="nav navbar-nav">
                <li><Link to="psi-plot">One place</Link></li>
                <li><Link to="psi-plot">Another place</Link></li>
              </ul>
            </div>
          </div>
        </nav>

        <RouteHandler />
      </div>
    );
  }
});

var routes =
  <Route name="psi-plot" path="/" handler={ PsiPlot }>
  </Route>;

Router.run(routes, Handler => {
  React.render(<Handler />, document.getElementById('content'));
});

window.React = React;
