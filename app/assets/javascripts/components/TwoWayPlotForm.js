/** @jsx React.DOM */

const React = require('react');

const TwoWayPlotForm = React.createClass({
  render() {
    return(
      <form className="TwoWayPlotForm col-sm-6 horizontal-form">
        {
          this._createFormGroup(
            'independent-var-name-input',
            'Name of independent variable'
          )
        }

        {
          this._createFormGroup(
            'moderator-var-name-input',
            'Name of moderator variable'
          )
        }

        {
          this._createFormGroup(
            'independent-var-input',
            'Independent variable'
          )
        }

        {
          this._createFormGroup(
            'moderator-var-input',
            'Moderator variable'
          )
        }

        {
          this._createFormGroup(
            'interaction-term-input',
            'Interaction term'
          )
        }

        {
          this._createFormGroup(
            'constant-term-input',
            'Constant term'
          )
        }

        {
          this._createFormGroup(
            'independent-var-mean-input',
            'Mean of independent variable'
          )
        }

        {
          this._createFormGroup(
            'independent-var-sd-input',
            'Standard deviation of independent variable'
          )
        }

        {
          this._createFormGroup(
            'moderator-var-mean-input',
            'Mean of moderator variable'
          )
        }

        {
          this._createFormGroup(
            'moderator-var-sd-input',
            'Standard deviation of moderator variable'
          )
        }
      </form>
    );
  },

  _createFormGroup(inputId, label) {
    return(
      <div className="form-group">
        <label htmlFor={ inputId } className="col-sm-7 control-label">
          { label }
        </label>
        <div className="col-sm-5">
          <input type="text" id={ inputId } className="form-control" />
        </div>
      </div>
    )
  }
});

module.exports = TwoWayPlotForm;
