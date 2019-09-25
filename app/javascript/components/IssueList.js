import React from 'react';
import PropTypes from 'prop-types';

class IssueList extends React.Component {
  renderIssues() {
    const { issues } = this.props;
    issues.sort(
      (a, b) => new Date(a.id) - new Date(b.id),
    );

    return issues.map(issue => (
      <li key={issue.id}>
        {issue.subject}
      </li>
    ));
  }

  render() {
    return (
      <section>
        <h2>Issues</h2>
        <ul>{this.renderIssues()}</ul>
      </section>
    );
  }
}

IssueList.propTypes = {
  issues: PropTypes.arrayOf(PropTypes.object),
};

IssueList.defaultProps = {
  issues: [],
};

export default IssueList;