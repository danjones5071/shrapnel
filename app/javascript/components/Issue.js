import React from 'react';
import PropTypes from 'prop-types';

const Issue = ({ issue }) => (
  <div>
    <h2>
      {issue.id}
      {' - '}
      {issue.subject}
    </h2>
    <ul>
      <li>
        <strong>Type:</strong>
        {' '}
        {issue.issue_type}
      </li>
      <li>
        <strong>Due Date:</strong>
        {' '}
        {issue.due_date}
      </li>
      <li>
        <strong>Assignee:</strong>
        {' '}
        {issue.assignee}
      </li>
    </ul>
  </div>
);

Issue.propTypes = {
  issue: PropTypes.shape(),
};

Issue.defaultProps = {
  issue: undefined,
};

export default Issue;