import axios from 'axios';
import PropTypes from 'prop-types';
import React from 'react';
import Header from './Header';
import Issue from './Issue';
import IssueList from './IssueList';
import PropsRoute from './PropsRoute';

class IssueEditor extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      issues: null,
    };
  }

  componentDidMount() {
    axios
      .get('/api/v1/issues.json')
      .then(response => this.setState({ issues: response.data }))
      .catch((error) => {
        console.log(error);
      });
  }

  render() {
    const { issues } = this.state;
    if (issues === null) return null;

    const { match } = this.props;
    const issueId = match.params.id;
    const issue = issues.find(i => i.id === Number(issueId));

    return (
      <div>
        <Header />
        <IssueList issues={issues} />
        <PropsRoute path="/issues/:id" component={Issue} issue={issue} />
      </div>
    );
  }
}

IssueEditor.propTypes = {
  match: PropTypes.shape(),
};

IssueEditor.defaultProps = {
  match: undefined,
};
export default IssueEditor;