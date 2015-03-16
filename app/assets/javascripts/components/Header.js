/** @jsx React.DOM */

var React = require('react');
var Link = require('react-router').Link;

var Header = React.createClass({
  render() {
    return(
      <nav className="navbar navbar-default navbar-fixed-top">
        <div className="container">
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
              <li><Link to="project">Create a project</Link></li>
              <li><Link to="psi-plot">Another place</Link></li>
            </ul>
          </div>
        </div>
      </nav>
    );
  }
});

module.exports = Header;
